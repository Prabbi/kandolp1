module Page.Quiz.Quizupdate exposing (..)
import Dict exposing (..)
import Page.Calculator.Calculatorupdate as Calculator exposing (..)
import Page.Quiz.Quizmodel exposing (..)
import Page.Quiz.Quizmessage exposing (..)
import Tuple exposing (..)



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CalculatorMsg calculaltormsg ->
            ( { model | calculator = first (Calculator.update calculaltormsg model.calculator) }, Cmd.none )

        ButtonSomething ->
            ( { model | next = 1 }, Cmd.none )

        Todo ->
            ( model, Cmd.none )

        Question1 q1 ->
            ( { model | questioninputs = dictinsert model 1 q1 }, Cmd.none )

        Question2 q2 ->
            ( { model | questioninputs = dictinsert model 2 q2 }, Cmd.none )

        Question3 q3 ->
            ( { model | questioninputs = dictinsert model 3 q3 }, Cmd.none )

        Question4 q4 ->
            ( { model | questioninputs = dictinsert model 4 q4 }, Cmd.none )

        Question5 q5 ->
            ( { model | questioninputs = dictinsert model 5 q5 }, Cmd.none )

        Next ->
            ( { model
                | next =
                    if model.next < Dict.size model.questioninputs then
                        model.next + 1

                    else
                        1
              }
            , Cmd.none
            )

        Previous ->
            ( { model
                | next =
                    if model.next > 1 && model.next < Dict.size model.questioninputs then
                        model.next - 1

                    else
                        1
                  -- Match pattern
              }
            , Cmd.none
            )



--This makes it easier to insert a value into the dictionary questioninputs


dictinsert model x a =
    Dict.insert x a model.questioninputs
