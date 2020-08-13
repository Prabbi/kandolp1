module Page exposing (Page(..), view)
import Browser exposing (Document)
import Html exposing (Html, a, button, div, footer, i, img, li, nav, p, span, text, ul)
import Html.Attributes exposing (class, classList, href, style)
import Html.Events exposing (onClick)
import Route exposing (Route)
import Styles.Styles exposing (..)


type Page
    = Other
    | Introduction
    | Quiz
    | Calculating


view : Page -> { title : String, content : Html msg } -> Document msg
view page { title, content } =
    { title = title
    , body =
        [ viewHeader page
        , content
        ]
    }


viewHeader : Page -> Html msgz
viewHeader page =
    nav navbarstyle
        [ div []
            [ p (navbarposition "35px")
                [ a
                    [ if page == Introduction then
                        style "color" "white"

                      else
                        style "color" "black"
                    , Route.href Route.Introduction
                    ]
                    [ text "  Introduction" ]
                ]
            , p (navbarposition "100px")
                [ a
                    [ if page == Calculating then
                        style "color" "white"

                      else
                        style "color" "black"
                    , Route.href Route.Calculating
                    ]
                    [ text "Calculator" ]
                ]
            , p (navbarposition "160px")
                [ a
                    [ if page == Quiz then
                        style "color" "white"

                      else
                        style "color" "black"
                    , class "nav navbar-nav pull-xs-right"
                    , Route.href Route.Quiz
                    ]
                    [ text " Quiz" ]
                ]
            , home
            , calculator
            , quiz
            , astonuniversitylogo
            ]
        ]


home = div [] [imageStyle "home.png" "0px" "#80bfff" "60px" "30px" "30px"]
calculator = div [] [imageStyle "calculator.png" "0px" "#80bfff" "170px" "30px" "30px"]
quiz = div [] [imageStyle "quiz.png" "0px" "#80bfff" "280px" "30px" "30px"]

astonuniversitylogo = div [] [imageStyle "astonuniversitylogo.jpg" "3px" "white" "3px" "80px" "25px" ]




isActive : Page -> Route -> Bool
isActive page route =
    case ( page, route ) of
        ( Introduction, Route.Introduction ) ->
            True

        ( Quiz, Route.Quiz ) ->
            True

        ( Calculating, Route.Calculating ) ->
            True

        _ ->
            False
