module Page.Quiz.Quizview exposing (..)
import Browser
import Browser.Navigation as Nav
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Session exposing (Session)
import Tuple exposing (..)
import Page.Quiz.Quizmodel exposing (..)
import Page.Quiz.Quizmessage exposing (..)
import Page.Calculator.Calculatorview as Calculator exposing (..)
import Styles.Styles exposing (..)
import Html.Events exposing (onClick, onInput)

imagedictionary = Dict.fromList [(1, image1), (2, image2), (3, image3), (4,image4), (5,image5)] --?? - whats the point

image1 = imageStyle "1anwser.gif" "900px" "red" "-225px" "300px" "150px"
image2 = imageStyle "2anwser.gif" "900px" "orange" "-225px" "300px" "150px"
image3 = imageStyle "3anwser.gif""900px""orange" "-225px" "300px" "150px"
image4 = imageStyle "4anwser.gif" "900px" "orange" "-225px" "300px" "150px"
image5 = imageStyle "5anwser.gif" "900px" "green" "-225px" "300px" "150px"
imageview model = if (sumanwsers model == 1) then image1 else if (sumanwsers model == 2) then image2 else if (sumanwsers model == 3) then image3 else if (sumanwsers model == 4) then image4 else if (sumanwsers model == 5) then image5 else image1


nextButton model = div (buttonStyle ("510px") ("5px")) [ button (buttonstyle1 Next "200px" "200px" "#3399ff") [ text "Next ►" ] ]
-- Previous Button
previousbutton model = div (buttonStyle ("735px") ("5px")) [button (buttonstyle1 Previous "200px" "200px" "#3399ff") [ text "◄ Previous" ]]
-- View of questions i.e. next button, view input for the questions, previous button as well as the question you are on
viewofquestions model = div [] [(nextButton model) , (viewQuestion model) , (viewQuestionInputs model) ,(previousbutton model)]
--The button for 'Return to Questions'
buttonsomething model = div (buttonStyle ("60px") ("10px")) [button (buttonstyle1 ButtonSomething "200px" "220px" "#3399ff" ) [text "◄ Return to Questions"]]
--This repositions the button for 'Return to Questions'
returnbutton model = div [] [ (buttonsomething model), div returnbuttonstyle [text ""]]
-- Once question 5 is reached, the return button is shown, otherwise the viewofquestions are shown
quizquestionview model = if model.next == (inputsize model) then (returnbutton model) else (viewofquestions model)
-- Once question 5 is reached then the gifs are shown
quizimageview model = if model.next ==  (inputsize model)then (imageview model) else div [] [text ""]
--This shows a border between the calculator and quiz, as long as question 5 is not reached
helloborder1 model = if model.next /= (inputsize model) then (helloborder model) else div [] [text ""]

inputsize model = Dict.size model.questioninputs

--This shows the calculation as long as question 5 is not reached
acalculator1 model = if model.next /= (inputsize model) then (acalculator model) else div [] [text ""]

--This gets the questioninputs i.e. the anwsers that the user has put in, which are stored in the dictionary 'questioninputs'
getquestioninputs model x = (Maybe.withDefault "Nothing" (Dict.get x model.questioninputs))
--This gets the questions i.e. the questions which have been set in the dictionary 'questions'
getquestion model x = (Maybe.withDefault "Nothing" (Dict.get x questions))
--This gets the anwsers i.e. the anwsers which have been set in the dictionary 'anwsers'
getanwsers model x = (Maybe.withDefault "Nothing" (Dict.get x anwsers))
--This is checking whether they have put in the correct anwsers i.e. questions 1 is equal to anwsers 1 then 1 is put into the dictionary at position 1
heckanwsers model x a = if (getquestioninputs model x) == (getanwsers model a) then 1 else 0
--This is getting the sum of all of the anwsers
sumanwsers model = (heckanwsers model 1 1) + (heckanwsers model 2 2) + (heckanwsers model 3 3) + (heckanwsers model 4 4) + (heckanwsers model 5 5)
--This is going to provide a thing of what they have gotten right and what they have gotten wrong
anwsersright model = Dict.fromList [ (1, (heckanwsers model 1 1)),
                                     (2, (heckanwsers model 2 2)),
                                     (3, (heckanwsers model 3 3)),
                                     (4, (heckanwsers model 4 4)),
                                     (5, (heckanwsers model 5 5))]


viewsumanwsersstyle x = [style "font-size" "100px", style "left" "350px", style "top" "100px", style "position" "fixed", style "color" x]

--viewsumanwsers1 model = if (model.next == 5) then div viewsumanwsersstyle "red" [text ((String.fromInt(sumanwsers model)) ++ ": Right anwsers")]
                    --   else if (model.next 3 || model.next 2) then div viewsumanwsersstyle "orange" [text ((String.fromInt(sumanwsers model)) ++ ": Right anwsers")]
  --               else if (model.next 1) then div viewsumanwsersstyle "green" [text ((String.fromInt(sumanwsers model)) ++ ": Right anwsers")]
--                        else div [] [text ""]

hii model x t= div (abordercolor x t)  [text ((String.fromInt(sumanwsers model)) ++ " / 5 : Right anwsers")]

viewsumanwsers model = if (model.next == (inputsize model)) then (if (sumanwsers model == 1) then (hii model ("red") ("100.5px"))
                                                 else if (sumanwsers model == 3 || sumanwsers model == 2) || sumanwsers model == 4  then (hii model ("orange") ("100.5px"))
                                                 else if (sumanwsers model == 5) then (hii model ("green") ("100.5px")) else (hii model ("red") ("100.5px"))) else div [] [text ""]


--This provides a string of 'well done' / "is wrong" depending on whether the user has gotten the question right, the functions heckanwsers is use to find out whether they are right
isright model x = if (Maybe.withDefault x (Dict.get x (anwsersright model)))== 1
                  then " Question " ++ String.fromInt(x) ++ ". was ' "  ++ (getquestion model x) ++ " ' - Well done , you put ' " ++ (getquestioninputs model x) ++ " ' which was right! :)"
                  else " Question " ++ String.fromInt(x) ++  ". was  ' " ++ (getquestion model x ) ++ " ' - You have put the wrong anwser, you put the following: ' " ++ (getquestioninputs model x) ++ " ' :( #dissapointed, the correct anwser was the was : "  ++ (getanwsers model x)
--This is going to provide a thing of what they have gotten right and what they have gotten wrong

quizmarks1 model = div quizmarkstyle [ div []  [text (isright model 1), sp, sp, div [] [text (isright model 2)], sp,  div [] [text (isright model 3)], sp,  div [] [text (isright model 4), sp, sp, div [] [text (isright model 5)]]]]
--This ensures that the marks are only displayed if they are on question 5
quizmarks model = if (model.next == (inputsize model)) then (quizmarks1 model) else div [] [text ""]
--This provides a default since functional programming pure, always requires something i.e. if nothing then string
msToString mv = Maybe.withDefault "Nothing" mv
--This converts whatever into a string
ts x = String.fromInt(x)
--This gives the inputs for the questions - i.e. this is a textbox which allows the user to write in their anwwsners

qinput model x y = div viewinputstyle [viewInput "string" "Write anwser here..." (getquestioninputs model x ) y]
q1input model = qinput model 1 Question1
q2input model = qinput model 2 Question2
q3input model = qinput model 3 Question3
q4input model = qinput model 4 Question4
q5input model = qinput model 5 Question5
-- This will display the next question input depending on what question input the user is on
viewQuestionInputs : Model -> Html Msg
viewQuestionInputs model =
   div (questionStyle1 ("100px") ("700px") ("200px")) [
    if model.next == 1 then q1input model
    else if model.next == 2 then q2input model
    else if model.next == 3 then q3input model
    else if model.next == 4 then q4input model
    else if model.next == 5 then q5input model
    else q1input model]
-- This will display the model.next question depending on what question the user is on
--This gets the current question
thecurrentquestion x =  div [] [text ((ts(x)) ++ ". " ++ msToString(Dict.get x questions))]
viewQuestion model =
    div (questionStyle ("220px") ("530px") ("200px"))
        [ if model.next == 1 then thecurrentquestion 1
          else if model.next == 2 then thecurrentquestion 2
          else if model.next == 3 then thecurrentquestion 3
          else if model.next == 4 then thecurrentquestion 4
          else if model.next == 5 then thecurrentquestion 5
          else thecurrentquestion 1 ]


helloborder model = div [style "border" "3px solid", style "top" "-50px", style "left" "300px", style "width" "430px", style "height" "800px", style "position" "fixed"] [text "1"]
acalculator model = div [style "font-weight" "bold",style "text-decoration" "underline",  style "font-weight" "bold", style "left" "400px", style "top" "30px", style "position" "fixed", style "border" "none", style "color" "Black" , style "width" "100%", style "text-align" "center" ,style "font-size" "38px"  ] [text "A helpa Calcultor "]




-- Makes a new line
sp = br [] [text " "]
-- Allows text to be on the same line
fl = div [style "float" "left"]


viewquestionandvalidation model = div [style "position" "relative"] [helloborder1 model, quizmarks model, quizquestionview model, quizimageview model, acalculator1 model, viewsumanwsers model]


--This displays a calculator from the calculator model
viewexponent model = div [style "left" "36px", style "position" "relative"] [Html.map CalculatorMsg (Calculator.viewExponentIncrement model.calculator)]
viewsign model = div [style "left" "86px", style "position" "relative"] [Html.map CalculatorMsg (Calculator.viewSignIncrement model.calculator)]
viewmantissa model = div [style "left" "15px" , style "position" "relative"][ Html.map CalculatorMsg (Calculator.viewMantissaIncrement model.calculator)]
viewsomething model = Html.map CalculatorMsg (Calculator.clueexplanation model.calculator)

listcalcualtors1 model = div [style "left" "0px", style "position" "relative", style "bottom" "40px"] [(viewexponent model), (viewsign model), (viewmantissa model), (viewsomething model)]
listcalculators model = if (model.next /= (inputsize model)) then (listcalcualtors1 model) else div [] [ div [] [text " "]]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg = input [ type_ t, placeholder p, value v, onInput toMsg ] []
