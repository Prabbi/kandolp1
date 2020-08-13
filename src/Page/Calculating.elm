module Page.Calculating exposing (..)
import Browser exposing (UrlRequest)
import Browser.Navigation as Navigation
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Session exposing (Session)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, s, top)
import Page.Calculator.Calculatormodel as Calculatormodel exposing (..)
import Page.Calculator.Calculatorview as Calculatorview exposing (..)
import Page.Calculator.Calculatormessage as Calculatormessage exposing (..)
import Page.Calculator.Calculatorupdate as Calculatorupdate exposing (update)
import Tuple exposing (..)
import Styles.Styles exposing (..)
import Page.Quiz.Quizmodel exposing (..)
import Page.Quiz.Quizupdate exposing (update)

calculator6 model = Html.map CalculatorMsg (Calculatorview.finalcalculatormodel model.calcualtor)

--This converts to type QuizMsg
type Msg = CalculatorMsg Calculatormessage.Msg

--This converts to type QuizMsg
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = case msg of CalculatorMsg calculatormsg -> ({ model | calcualtor = first (Calculatorupdate.update calculatormsg model.calcualtor)}, Cmd.none)

-- This shows the of the quiz and the calculator which is a helper
view : Model -> { title : String, content : Html Msg }
view model =
    { title = pageTitle1

    , content =
        div fixposition4
            [ Styles.Styles.hi
            , h2 (pagestyle "235px" )[ text model.calcualtor.calculatorTitle ]
            , div [] [text pageBody], calculator6 model]
    }

--This holds the attributes from the quizmodel
type alias Model =
    { session : Session
    , calcualtor : Calculatormodel.Model
      }

init : Session -> ( Model, Cmd Msg )
init session =
    ( { session = session
       ,calcualtor= first (Calculatormodel.init session) -- first, allows to ignore Cmd message
      }
  , Cmd.none
  )

subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none

toSession : Model -> Session
toSession model = model.session
