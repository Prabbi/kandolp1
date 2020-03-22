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
    { title = title ++ " - Elm SPA"
    , body =
        [ viewHeader page
        , content
        ]
    }

viewHeader : Page -> Html msgz
viewHeader page =
    nav navbarstyle
        [ div [ class "container" ] [
             p (navbarposition "0px") [a [if (isIntroPage page) == True then style "color" "white" else style "color" "black", Route.href Route.Introduction]
                [ text "  Introduction" ]]
             ,p (navbarposition "20px") [a [if (isCalculatePage page) == True then style "color" "white" else style "color" "black" , Route.href Route.Calculating]
               [ text "Calculator" ]]
            ,p (navbarposition "40px") [a [if (isQuizPage page) == True then style "color" "white" else style "color" "black", class "nav navbar-nav pull-xs-right" , Route.href Route.Quiz]
                 [ text " Quiz" ]]
          , home
          , calculator
          , quiz
        ]
        ]

home = div [] [imageStyle "home.png" "10px" "grey" "60px" "30px" "30px"]
calculator = div [] [imageStyle "calculator.png" "10px" "grey" "170px" "30px" "30px"]
quiz = div [] [imageStyle "quiz.png" "10px" "grey" "280px" "30px" "30px"]

iconsview = div [] [home, calculator, quiz]

isIntroPage page = if page == Introduction then True else False
isQuizPage page = if page == Quiz then True else False
isCalculatePage page = if page == Calculating then True else False


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
