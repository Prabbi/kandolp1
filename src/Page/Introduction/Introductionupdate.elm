module Page.Introduction.Introductionupdate exposing (..)
import Page.Introduction.Introductionmessage exposing (..)
import Page.Introduction.Introductionmodel exposing (..)



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Show1 ->
            ( { model
                | style1 = True
              }
            , Cmd.none
            )

        Hide1 ->
            ( { model
                | style1 = False
              }
            , Cmd.none
            )
        Show2 ->
            ( { model
                | style2 = True
              }
            , Cmd.none
            )

        Hide2 ->
            ( { model
                | style2 = False
              }
            , Cmd.none
            )

        Show3 ->
            ( { model
                | style3 = True
              }
            , Cmd.none
            )

        Hide3 ->
            ( { model
                | style3 = False
              }
            , Cmd.none
            )
