module Page.Introduction exposing (Model, Msg, init, subscriptions, toSession, update, view)
import Html exposing (Html, div, h2, text)
import Html.Attributes exposing (class)
import Session exposing (Session)
import Browser exposing (UrlRequest)
import Browser.Navigation as Navigation
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, s, top)
import Dict exposing (Dict)
import Json.Encode as Encode
import Page.Introduction.Introductionmodel as Intromodel exposing(..)
import Page.Introduction.Introductionview as Introview exposing(..)
import Page.Introduction.Introductionupdate as Introupdate exposing(..)
import Page.Introduction.Introductionmessage as Intromessage exposing(..)
import Tuple exposing (..)


hi model = Html.map IntroMsg (Introview.viewinghello model.introduction)


--This converts to type QuizMsg
type Msg = IntroMsg Intromessage.Msg
--This converts to type QuizMsg
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = case msg of IntroMsg intrormsg -> ({ model | introduction = first (Introupdate.update intrormsg model.introduction)}, Cmd.none)

-- This shows the of the quiz and the calculator which is a helper
view : Model -> { title : String, content : Html Msg }
view model =
    { title = Intromodel.pageTitle
    , content =
        div [ class "container" ]
            [ h2 Introview.pagestyle [ text Intromodel.pageTitle ]
            , div [] [text Intromodel.pageBody], hi model]
    }

--This holds the attributes from the quizmodel
type alias Model =
    { session : Session
    , introduction : Intromodel.Model
      }

init : Session -> ( Model, Cmd Msg )
init session =
    ( { session = session
       ,introduction= first (Intromodel.init session) -- first, allows to ignore Cmd message
      }
  , Cmd.none
  )

subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none

toSession : Model -> Session
toSession model = model.session
