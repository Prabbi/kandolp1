module Page.Introduction.Introductionmodel exposing (..)
import Page.Introduction.Introductionmessage exposing (..)

import Session exposing (Session)
type alias Model =
    { session : Session
    , style1 : Bool
    , style2 :Bool
    , style3 : Bool
    }


init : Session -> ( Model, Cmd Msg )
init session =
    ( { session = session
      , style1 = False
      , style2 = False
      , style3 = False

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
