module Page.Quiz.Quizmessage exposing (..)
import Page.Calculator.Calculatormessage as Calculator exposing (..)


type Msg
    = Todo
    | Question1 String
    | Question2 String
    | Question3 String
    | Question4 String
    | Question5 String
    | Next
    | Previous
    | ButtonSomething
    | CalculatorMsg Calculator.Msg
