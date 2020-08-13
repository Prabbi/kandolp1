module Page.Introduction.Introductionmodel exposing (..)
import Page.Introduction.Introductionmessage exposing (..)

import Session exposing (Session)
type alias Model =
    { session : Session
    , stylesign : Bool
    , stylemantissa :Bool
    , styleexponent : Bool
    }


init : Session -> ( Model, Cmd Msg )
init session =
    ( { session = session
      , stylesign = False
      , stylemantissa = False
      , styleexponent = False

      }
    , Cmd.none
    )

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

pageTitle = "Introduction to IEEE Floating Points"
pageBody = "Whatsapp appppp"
-- EXPORT



toSession : Model -> Session
toSession model =
    model.session
