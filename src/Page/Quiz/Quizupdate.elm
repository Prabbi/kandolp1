
module Page.Quiz.Quizupdate exposing (..)
import Dict exposing (..)
import Page.Calculator.Calculatorupdate as Calculator exposing (..)
import Page.Quiz.Quizmodel exposing (..)
import Page.Quiz.Quizmessage exposing (..)
import Tuple exposing (..)
import String exposing (..)


--Dict.map (\k v -> (k, v * 100)) <| Dict.fromList [(1,1),(2,4),(3,9)]
--List.foldr (\tag carry -> Dict.insert tag 0 carry) Dict.empty

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CalculatorMsg calculaltormsg ->
            ( { model | calculator = first (Calculator.update calculaltormsg model.calculator)}, Cmd.none)

        ButtonSomething ->
            ( { model | next = 1
                      , anwsersinputs = Dict.map (\key value -> "" ) (model.anwsersinputs)}, Cmd.none )
        Todo ->
            ( model, Cmd.none )

        Question1 q1 ->
            ( { model | anwsersinputs =  dictinsert model 1 q1 }, Cmd.none )

        Question2 q2 ->
            ( { model | anwsersinputs = dictinsert model 2 q2 }, Cmd.none)

        Question3 q3 ->
            ( { model | anwsersinputs = dictinsert model 3 q3 }, Cmd.none )

        Question4 q4 ->
            ( { model | anwsersinputs = dictinsert model 4 q4 }, Cmd.none )

        Question5 q5 ->
            ( { model | anwsersinputs = dictinsert model 5 q5 }, Cmd.none )

        Next ->
            ( { model
                | next =
                    if model.next <= Dict.size model.anwsersinputs then
                        model.next + 1

                    else
                        1
              }
            , Cmd.none
            )

        Previous ->
            ( { model
                | next =
                    if model.next > 1 && model.next < Dict.size model.anwsersinputs then
                        model.next - 1

                    else
                        1
                  -- Match pattern
              }
            , Cmd.none
            )


--This makes it easier to insert a value into the dictionary anwsersinputs


dictinsert model x a =
    Dict.insert x a model.anwsersinputs
