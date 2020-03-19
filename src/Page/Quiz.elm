module Page.Quiz exposing (..)
import Bootstrap.Button as Button
import Bootstrap.Form as Form
import Bootstrap.Form.Checkbox as Checkbox
import Bootstrap.Form.Fieldset as Fieldset
import Bootstrap.Form.Input as Input
import Bootstrap.Form.Radio as Radio
import Bootstrap.Form.Select as Select
import Bootstrap.Form.Textarea as Textarea
import Browser
import Browser.Navigation as Nav
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Session exposing (Session)
import Array
import Page.CalculateIEEEFloatingPointToDecimal as Calculator exposing (..)

listquestions =
    Array.fromList
        [ "Convert 0 1000 001 to decimal number"
        , "Convert 1 1101 010 to decimal number"
        , "Is the floating point number positive / negative when the sign bit is 1?"
        , "Convert -4.9 into a binary number"
        , "Convert 0 1000 001 to a decimal number"
        ]
listanwsers = Array.fromList ["1" , "2", "3", "4", "5"]

viewhello model = Calculator.viewExponentIncrement model

--listofanwsers model = Array.fromList [(model.question1), (model.question2)]

listofanwsers model = Dict.fromList [(model.question1, model.question1), (model.question2, model.question2)]


sumanwsers model = [(anwser1 model) + (anwser2 model) + (anwser3 model) + (anwser4 model) + (anwser5 model)]

anwser1 model = if model.question1 == (Array.get 1 listanwsers) then 1 else 0
anwser2 model = if model.question2 == (Array.get 2 listanwsers) then 1 else 0
anwser3 model = if model.question3 == (Array.get 3 listanwsers) then 1 else 0
anwser4 model = if model.question4 == (Array.get 4 listanwsers) then 1 else 0
anwser5 model = if model.question5 == (Array.get 5 listanwsers) then 1 else 0


msToString mv = Maybe.withDefault "" mv
ts x = String.fromInt(x)

thecurrentquestion x =  div [] [text ((ts(x+1)) ++ ". " ++ msToString(Array.get x listquestions))]

-- This allows the user to click 'next' to go to the next question
nextButton model = div (buttonStyle ("540px") ("100px")) [ button [ onClick Next , style "height" "100px", style "width" "100px", style "background-color" "#3399ff", style "color" "white"] [ text "Next ► " ] ]
previousbutton model = div (buttonStyle ("830px") ("190px")) [button [ onClick Previous, style "height" "100px", style "width" "100px", style "background-color" "#3399ff", style "color" "white" ] [ text "<◄ Previous" ]]

hellomodelhello model = div (questionStyle ("-50px") ("500px") ("100px")) [text ("Total Correct = ")]
something model = div [] [(nextButton model) , (viewQuestion model) , (viewValidation1 model) ,(previousbutton model)]
buttonsomething model = div (buttonStyle ("540px") ("100px")) [button [onClick ButtonSomething, style "height" "100px", style "width" "100px", style "background-color" "#3399ff", style "color" "white" ] [text "Return to Questions"]]
buttomsomethinghello model = div [] [ (buttonsomething model), div [style "width" "200px", style "margin-left" "292px",style "margin-top" "250px", style "font-size" "50px"] [text ""]]
quizquestionview model = if model.next == 5 then (buttomsomethinghello model) else (something model)

q1input model = viewInput "string" "Write anwser here..." model.question1 Question1
q2input model = viewInput "string" "Write anwser here..." model.question2 Question2
q3input model = viewInput "string" "Write anwser here..." model.question3 Question3
q4input model = viewInput "string" "Write anwser here..." model.question4 Question4
q5input model = viewInput "string" "Write anwser here..." model.question5 Question5
--textstylemantissa a y = [style "font-weight" "bold", style "font-size" "20px", style "color" y, style "border-style" "inset", style "background" a,  style "font-family" "sansation", style "position" "relative", style "top" "250px", style "left" "300px", style "width" "900px"]
--nextButton model = div (buttonStyle ("630px")) [ button [ onClick Next ] [ text "Next Question" ] ]
---------------------------------- STYLES --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
positiveinfinity = [style "color" "red", style "font-size" "20px", style "font-weight" "bold", style "font-family" "sansation", style "position" "fixed", style "top" "50%", style "left" "860px", style "width" "900px", style "height" "100px"]
textstyle1 x y = [style "font-weight" "bold", style "font-family" "sansation", style "position" "absolute", style "top" x, style "left" y]
buttonStyle x y = [style "position" "fixed", style "bottom""100px" , style "color" "black" , style "right" x ]
questionStyle y x a = [style "font-weight" "bold", style "position" "fixed" , style "bottom" y , style "width" "400px" , style "height" "400px" , style "height" a , style "right" x, style "font-size" "30px" ]
questionStyle1 y x a = [style "font-weight" "bold", style "position" "fixed",style "bottom" y , style "height" a , style "right" x, style "font-size" "30px" ]
buttonStyle2 = [style "height" "100px", style "width" "100px", style "background-color" "#3399ff", style "color" "white"]
------------------------------------------- view -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- This will display the next question input depending on what question input the user is on
viewValidation1 : Model -> Html Msg
viewValidation1 model =
   div (questionStyle1 ("100px") ("700px") ("200px")) [
    if model.next == 1 then q1input model
    else if model.next == 2 then q2input model
    else if model.next == 3 then q3input model
    else if model.next == 4 then q4input model
    else if model.next == 5 then q5input model
    else q1input model]

-- This will display the next question depending on what question the user is on
viewQuestion model =
    div (questionStyle ("220px") ("530px") ("200px"))
        [ if model.next == 1 then thecurrentquestion 0
          else if model.next == 2 then thecurrentquestion 1
          else if model.next == 3 then thecurrentquestion 2
          else if model.next == 4 then thecurrentquestion 3
          else if model.next == 5 then thecurrentquestion 4
          else thecurrentquestion 1 ]

viewquestionandvalidation model = div [] [viewValidation1 model, viewQuestion model]


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



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ButtonSomething -> ( { model | next = 1}, Cmd.none)

        Todo ->
            ( model, Cmd.none )

        Question1 question1 ->
            ( { model | question1 = question1 }, Cmd.none )

        Question2 question2 ->
            ( { model | question2 = question2 }, Cmd.none )

        Question3 question3 ->
            ( { model | question3 = question3 }, Cmd.none )

        Question4 question4 ->
            ( { model | question4 = question4 }, Cmd.none )

        Question5 question5 ->
            ( { model | question5 = question5 }, Cmd.none )

        Next ->
            ( { model
                | next =
                    if model.next < 5 then
                        model.next + 1

                    else
                        1

              }
            , Cmd.none
            )

        Previous ->
              ( { model | next = if model.next > 1 && model.next < 6 then model.next - 1 else 1 -- Match pattern


              }, Cmd.none )




view : Model -> { title : String, content : Html Msg }
view model =

    { title = model.pageTitle
    , content =
        div [ class "container" ]
            [ h2 pagestyle [ text model.pageTitle ]
            , div [] [ text model.pageBody, quizquestionview model ]]
    }

pagestyle = [style "font-weight" "bold", style "font-weight" "bold", style "left" "150px", style "text-decoration" "underline", style "top" "-20px", style "position" "absolute", style "border" "none", style "color" "Black" , style "width" "100%", style "text-align" "center" ,style "font-size" "38px"  ]
type alias Model =
    { session : Session
    , pageTitle : String
    , pageBody : String
    , question1 : String
    , question2 : String
    , question3 : String
    , question4 : String
    , question5 : String
    , next : Int
    , backtoquestionview : Bool
      , sign : Int
      , exponent : Dict Int Int
      , mantissa : Dict Int Int

      }

init : Session -> ( Model, Cmd Msg )
init session =
    ( { session = session
      , pageTitle = "Quiz"
      , pageBody = ""
      , question1 = ""
      , question2 = ""
      , question3 = ""
      , question4 = ""
      , question5 = ""
      , next = 1
      , backtoquestionview = False
           , sign = 0 -- The sign bit is initially equal to 0
          , exponent = Dict.fromList <| List.map (\i -> ( i, 0 )) (List.range 0 4) --This is making a dictionary for the mantissa bits
          , mantissa = Dict.fromList <| List.map (\i -> ( i, 0 )) (List.range 0 6)
      }
  , Cmd.none
  )

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg = input [ type_ t, placeholder p, value v, onInput toMsg ] []

subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none

toSession : Model -> Session
toSession model = model.session
