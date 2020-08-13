module Page.Introduction.Introductionupdate exposing (..)
import Page.Introduction.Introductionmessage exposing (..)
import Page.Introduction.Introductionmodel exposing (..)



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Show1 ->
            ( { model
                | stylesign = True
              }
            , Cmd.none
            )

        Hide1 ->
            ( { model
                | stylesign = False
              }
            , Cmd.none
            )
        Show2 ->
            ( { model
                | stylemantissa = True
              }
            , Cmd.none
            )

        Hide2 ->
            ( { model
                | stylemantissa = False
              }
            , Cmd.none
            )

        Show3 ->
            ( { model
                | styleexponent = True
              }
            , Cmd.none
            )

        Hide3 ->
            ( { model
                | styleexponent = False
              }
            , Cmd.none
            )
