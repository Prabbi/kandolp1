module Page.Calculator.Calculatormodel exposing (..)
import Dict exposing (..)
import Browser exposing (UrlRequest)
import Browser.Navigation as Navigation
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Session exposing (..)
import Html.Events exposing (..)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, s, top)
import Styles.Styles exposing (..)
import Tuple exposing (..)
import Page.Calculator.Calculatormessage exposing (..)
import String exposing (..)

-- MODEL
type alias Model =
    { session : Session
    , calculatorTitle : String
    , pageBody : String
    , sign : Int
    , exponent : Dict Int Int
    , mantissa : Dict Int Int
    }
init : Session -> ( Model, Cmd Msg )
init session =
    ( { session = session
      , calculatorTitle = "Calculator - IEEE Floating Point to Decimal Representitive"
      , pageBody = ""
       , sign = 0 -- The sign bit is initially equal to 0
      , exponent = Dict.fromList <| List.map (\i -> ( i, 0 )) (List.range 0 3) --This is making a dictionary for the mantissa bits
      , mantissa = Dict.fromList <| List.map (\i -> ( i, 0 )) (List.range 1 6) --This is making a dictionary for the exponent bits
      }
    , Cmd.none
    )

pageTitle1 = "Calculator - IEEE Floating Point to Decimal"
