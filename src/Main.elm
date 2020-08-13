module Main exposing (main)
import Session exposing (Session)
import Browser exposing (Document)
import Browser.Navigation as Nav
import Html exposing (..)
import Json.Decode as Decode exposing (Value)
import Page exposing (Page)
import Page.Quiz as Quiz
import Page.NotFound.Blank as Blank
import Page.Introduction as Introduction
import Page.Calculating as Calculating
import Page.NotFound.NotFound as NotFound
import Route exposing (Route)
import Session exposing (Session)
import Task
import Url exposing (Url)

type Model
    = Redirect Session
    | NotFound Session
    | Introduction Introduction.Model
    | Quiz Quiz.Model
    | Calculating Calculating.Model


init : Value -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey =
    changeRouteTo (Route.fromUrl url)
        (Redirect (Session.fromViewer navKey))



-- VIEW


view : Model -> Document Msg
view model =
    let
        viewPage page toMsg config =
            let
                { title, body } =
                    Page.view page config
            in
            { title = title
            , body = List.map (Html.map toMsg) body
            }
    in
    case model of
        Redirect _ ->
            viewPage Page.Other (\_ -> Ignored) Blank.view

        NotFound _ ->
            viewPage Page.Other (\_ -> Ignored) NotFound.view

        Introduction introduction ->
            viewPage Page.Introduction GotIntroductionIntoIEEEFloatingPointNumbersMsg (Introduction.view introduction)

        Quiz quiz ->
            viewPage Page.Quiz GotQuizMsg (Quiz.view quiz)

        Calculating calculating ->
            viewPage Page.Calculating GotCalculateIEEEFloatingPointToDecimalMsg (Calculating.view calculating)

-- UPDATE

type Msg
    = Ignored
    | ChangedRoute (Maybe Route)
    | ChangedUrl Url
    | ClickedLink Browser.UrlRequest
    | GotIntroductionIntoIEEEFloatingPointNumbersMsg Introduction.Msg
    | GotQuizMsg Quiz.Msg
    | GotCalculateIEEEFloatingPointToDecimalMsg Calculating.Msg



toSession : Model -> Session
toSession page =
    case page of
        Redirect session ->
            session

        NotFound session ->
            session

        Introduction introduction ->
            Introduction.toSession introduction

        Quiz quiz ->
            Quiz.toSession quiz

        Calculating calculating ->
            Calculating.toSession calculating


changeRouteTo : Maybe Route -> Model -> ( Model, Cmd Msg )
changeRouteTo maybeRoute model =
    let
        session =
            toSession model
    in
    case maybeRoute of
        Nothing ->
            ( NotFound session, Cmd.none )

        Just Route.Root ->
            ( model, Route.replaceUrl (Session.navKey session) Route.Introduction )

        Just Route.Introduction ->
            Introduction.init session
                |> updateWith Introduction GotIntroductionIntoIEEEFloatingPointNumbersMsg model

        Just Route.Quiz ->
            Quiz.init session
                |> updateWith Quiz GotQuizMsg model

        Just Route.Calculating ->
            Calculating.init session
                |> updateWith Calculating GotCalculateIEEEFloatingPointToDecimalMsg model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( Ignored, _ ) ->
            ( model, Cmd.none )

        ( ClickedLink urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    case url.fragment of
                        Nothing ->
                            -- If we got a link that didn't include a fragment,
                            -- it's from one of those (href "") attributes that
                            -- we have to include to make the RealWorld CSS work.
                            --
                            -- In an application doing path routing instead of
                            -- fragment-based routing, this entire
                            -- `case url.fragment of` expression this comment
                            -- is inside would be unnecessary.
                            ( model, Cmd.none )

                        Just _ ->
                            ( model
                            , Nav.pushUrl (Session.navKey (toSession model)) (Url.toString url)
                            )

                Browser.External href ->
                    ( model
                    , Nav.load href
                    )

        ( ChangedUrl url, _ ) ->
            changeRouteTo (Route.fromUrl url) model

        ( ChangedRoute route, _ ) ->
            changeRouteTo route model

        ( GotIntroductionIntoIEEEFloatingPointNumbersMsg subMsg, Introduction introduction ) ->
            Introduction.update subMsg introduction
                |> updateWith Introduction GotIntroductionIntoIEEEFloatingPointNumbersMsg model

        ( GotQuizMsg subMsg, Quiz quiz ) ->
            Quiz.update subMsg quiz
                |> updateWith Quiz GotQuizMsg model

        ( GotCalculateIEEEFloatingPointToDecimalMsg subMsg, Calculating calculating ) ->
            Calculating.update subMsg calculating
                |> updateWith Calculating GotCalculateIEEEFloatingPointToDecimalMsg model

        ( _, _ ) ->
            -- Disregard messages that arrived for the wrong page.
            ( model, Cmd.none )


updateWith : (subModel -> Model) -> (subMsg -> Msg) -> Model -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg model ( subModel, subCmd ) =
    ( toModel subModel
    , Cmd.map toMsg subCmd
    )



-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        NotFound _ ->
            Sub.none

        Redirect _ ->
            Sub.none

        Introduction introduction ->
            Sub.map GotIntroductionIntoIEEEFloatingPointNumbersMsg (Introduction.subscriptions introduction)

        Quiz quiz ->
            Sub.map GotQuizMsg (Quiz.subscriptions quiz)

        Calculating calculating ->
            Sub.map GotCalculateIEEEFloatingPointToDecimalMsg (Calculating.subscriptions calculating)



-- MAIN
main : Program Value Model Msg
main =
    Browser.application
        { init = init -- init gets the current Url from the browsers navigation bar. This allows you to show different things depending on the Url.
        , onUrlChange = ChangedUrl --When someone clicks a link, like <a href="/home">Home</a>, it is intercepted as a UrlRequest. So instead of loading new HTML with all the downsides, onUrlRequest creates a message for your update where you can decide exactly what to do next. You can save scroll position, persist data, change the URL yourself, etc.
        , onUrlRequest = ClickedLink
        , subscriptions = subscriptions
        , update = update
        , view = view
        }
