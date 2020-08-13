module Page.Quiz.Quizmodel exposing (..)
import Array exposing (..)
import Dict exposing (..)
import Page.Calculator.Calculatormodel as Calculator exposing (..)
import Page.Calculator.Calculatormessage exposing (..)
import Session exposing (Session)
import Tuple exposing (..)


type alias Model =
    { session : Session
    , calculator : Calculator.Model
    , anwsersinputs : Dict Int String
    , next : Int
    , questions : Dict Int String
    , anwsers : Dict Int String
    }


init : Session -> ( Model, Cmd Msg )
init session =
    ( { session = session
      , calculator = first (Calculator.init session)
      , anwsersinputs = Dict.fromList <| List.map (\i -> (i, ("") )) (List.range 1 5)
      , next = 1
      , questions = Dict.fromList
          [ ( 1, "Convert the following 11 IEEE floating bit '11010010000' into its decimal equivalent" ) --212
          , ( 2, "Convert -5.75 to binary" ) -- -101.11
          , ( 3, "Convert 16.75 to binary" ) -- 10000.11
          , ( 4, "Convert the following 11 IEEE floating bit '01010001100' into its decimal equivalent" )
          , ( 5, "Convert the following 11 IEEE floating bit '11110000110' into its decimal equivalent" )
          ]
      , anwsers =
          Dict.fromList
              [ ( 1, "-10" )
              , ( 2, "-101.11" )
              , ( 3, "10000.11" )
              , ( 4, "9.5" )
              , ( 5, "-140" )
              ]
      }
    , Cmd.none
    )


quizTitle =
    "Quiz"


pageBody =
    ""


toSession : Model -> Session
toSession model =
    model.session
