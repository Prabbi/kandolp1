module Main1 exposing (Model, Msg(..), init, main, update, view)

import Browser
import Button
import NotFound
import Diagram
import Html exposing (Html, button, div, h1, map, text)
import Html.Events exposing (onClick)


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { button : Button.Model }


init : Model
init =
    { button = Button.init
    }



-- UPDATE


type Msg
    = ButtonMsg Button.Msg

update : Msg -> Model -> Model
update msg model =
    case Debug.log "update msg" msg of
        ButtonMsg buttonMsg ->
            { model | button = Button.update buttonMsg model.button }


-- VIEW


view : Model -> Html Msg
view model = div [] [text NotFound.view]
