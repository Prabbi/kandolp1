module Page.Quiz exposing (..)
import Browser
import Browser.Navigation as Nav
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Session exposing (Session)
import Page.Calculator.Calculatormodel as Calculator exposing (..)
import Tuple exposing (..)
import Page.Quiz.Quizmodel as Quizmodel exposing (..)
import Page.Quiz.Quizupdate as Quizupdate exposing (update)
import Page.Quiz.Quizview as Quizview exposing (..)
import Page.Quiz.Quizmessage as Quizmessage exposing (..)
import Styles.Styles exposing (..)
import Page.Calculator.Calculatorview as Calculator exposing(..)

--View of questions
quiz model = Html.map QuizMsg (Quizview.viewquestionandvalidation model.quiz)
--quiz1 model = Quizview.quizquestionview model
calculator model = Html.map QuizMsg (Quizview.listcalculators model.quiz)

--This converts to type QuizMsg
type Msg = QuizMsg Quizmessage.Msg

--This converts to type QuizMsg
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = case msg of QuizMsg quizmsg -> ({ model | quiz = first (Quizupdate.update quizmsg model.quiz)}, Cmd.none)



-- This shows the of the quiz and the calculator which is a helper
view : Model -> { title : String, content : Html Msg }
view model =
    { title = Quizmodel.quizTitle
    , content =
        div fixposition3
            [
            div [] [text pageBody], quiz model, calculator model]
    }

--This holds the attributes from the quizmodel
type alias Model =
    { session : Session
    , quiz : Quizmodel.Model
      }

init : Session -> ( Model, Cmd Msg )
init session =
    ( { session = session
      , quiz = first (Quizmodel.init session) -- first, allows to ignore Cmd message
      }
  , Cmd.none
  )

subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none

toSession : Model -> Session
toSession model = model.session
