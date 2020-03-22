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
    , questioninputs : Dict Int String
    , next : Int
    }


init : Session -> ( Model, Cmd Msg )
init session =
    ( { session = session
      , calculator = first (Calculator.init session)
      , questioninputs = Dict.fromList [ ( 1, "" ), ( 2, "" ), ( 3, "" ), ( 4, "" ), ( 5, "" ), ( 6, "" ) ]
      , next = 1
      }
    , Cmd.none
    )


pageTitle =
    "Quiz"


pageBody =
    ""


anwsers =
    Dict.fromList
        [ ( 1, "1" )
        , ( 2, "2" )
        , ( 3, "3" )
        , ( 4, "4" )
        , ( 5, "5" )
        ]


questions =
    Dict.fromList
        [ ( 1, "Convert 0 1000 001 to decimal number" )
        , ( 2, "Convert 1 1101 010 to decimal number" )
        , ( 3, "Is the floating point number positive / negative when the sign bit is 1?" )
        , ( 4, "Convert -4.9 into a binary number" )
        , ( 5, "Convert 0 1000 001 to a decimal number" )
        ]


toSession : Model -> Session
toSession model =
    model.session
