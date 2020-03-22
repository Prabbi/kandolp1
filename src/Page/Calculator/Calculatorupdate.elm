module Page.Calculator.Calculatorupdate exposing (..)
import Page.Calculator.Calculatormessage exposing (..)
import Page.Calculator.Calculatormodel exposing (..)

import Dict exposing (..)

flip bit = if bit == 1 then 0 else 1

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        IncrementExponent i ->
            ( { model
                | exponent =
                    Dict.update i (Maybe.map flip) model.exponent
              }
            , Cmd.none
            )

        IncrementMantissa i ->
            ( { model
                | mantissa =
                    Dict.update i (Maybe.map flip) model.mantissa
              }
            , Cmd.none
            )

        --9
        IncrementSign ->
            ( { model
                | sign =
                    if model.sign == 1 then
                        0

                    else
                        1
              }
            , Cmd.none
            )
