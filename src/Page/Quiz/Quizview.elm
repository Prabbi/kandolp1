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
import String exposing (..)
import Char exposing (isDigit, isUpper, isLower, isAlphaNum)
import Regex
--This provides an outlined box of what is the sign, exponent and mantissa for the calculator buttons view
signview model = div (textstyle1 "120px" "736px" )  [text "Sign"]
exponentview model =div (textstyle1 "120px" "840px")    [text "Exponent"]
mantissaview model = div (textstyle1 "120px" "1060px") [text "Mantissa"]
signexponentmantissaview model = div [style "position" "relative", style "left" "70px"] [signview model, exponentview model, mantissaview model]
--Next Button
nextButton model = div (buttonStyle "-735px" "-350px") [ button (buttonstyle1 Next "235px" "210px" "#3399ff") [ text "Next ►" ] ]
-- Previous Button
previousbutton model = div (buttonStyle "-490px" "-350px") [button (buttonstyle1 Previous "235px" "215px" "#3399ff") [ text "◄ Previous" ]]
--The button for 'Return to Questions'
buttonsomething model = div (buttonStyle "-472px" "-495px") [button (buttonstyle1 ButtonSomething "100px" "300px" "#3399ff" ) [text "◄ Return"]]
--This repositions the button for 'Return to Questions'
returnbutton model = div [] [buttonsomething model, div returnbuttonstyle [text ""]]
-- View of things needed for the quiz page i.e. next button, view input for the questions, previous button as well as the question you are on
viewofquestions model = div [style "position" "relative" , style "left" "-20px"] [bluebackground, (signexponentmantissaview model), quizTitle, (calculatorTitle), (nextButton model) , (viewQuestion model) , (viewQuestionInputs model) ,(previousbutton model), (showillegal model) ]
--Summary of anwsers
viewofsummary model = div [] [bluebackground, summmaryTitle, (returnbutton model), (imageview model), (quizmarks1 model), (viewsumanwsers model)]
--This is getting the size of anwsersinput dictionary
inputsize model = Dict.size model.anwsersinputs + 1
-- Once question 5 is reached, the return button is shown, otherwise the viewofquestions are shown
quizquestionview model = if model.next == inputsize model then viewofsummary model else viewofquestions model

--This is a regex expression ensuring that the user only types in the right characters into the text
pattern = "[[[\"abcedefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_'\",#~|`!£$%^&*()¬``'=~ @+/?!;:/<>~@:{}[[]"
maybeRegex = Regex.fromString pattern
regex = Maybe.withDefault Regex.never maybeRegex
--String.replace here for "" and ]

--This ensures that the user cannot enter a anwseer which is greater than 10 characters
anslengthcheck2 q = if length q > 10 then ((slice 0 10 q))  else if length q == 0 then "" else q

--This is getting the anwsers inputted by the user and at the same time ensuring they are entering the correct characters through the regex expression
getanwsersinputs model x = anslengthcheck2 (Regex.replace regex (\_ -> "") (default "Nothing" (Dict.get x model.anwsersinputs)))
--This gets the questions i.e. the questions which have been set in the dictionary 'questions'
getquestion model x = (default "" (Dict.get x model.questions))
--This gets the anwsers i.e. the anwsers which have been set in the dictionary 'anwsers'
getanwsers model x = (default "Nothing" (Dict.get x model.anwsers))
--This is checking whether they have put in the correct anwsers i.e. questions 1 is equal to anwsers 1 then 1 is put into the dictionary at position 1
heckanwsers model x = if (getanwsersinputs model  x) == (getanwsers model x) then 1 else 0
--This is going to provide a thing of what they have gotten right and what they have gotten wrong
anwsersright model = Dict.fromList <| List.map (\i -> (i, (heckanwsers model i))) (List.range 0 (Dict.size model.questions))

--This gets the sum of answer
sumanwsers model = List.sum (Dict.values (anwsersright model))
---This is for the results summary page
--This is going to provide a view of the total number of questions the user has gotten right
numCorrect model x t = div (abordercolor x t)  [text ((String.fromInt(sumanwsers model)) ++ ("/") ++ String.fromInt(Dict.size model.questions) ++ ": Correct Answers")]

-- I wanted to have a different border depending on the amount of anwsers the user had gotten right, therefore this is providing a check and adding different border colors to the view
viewsumanwsers model = if (model.next == (inputsize model))
                                then (if (sumanwsers model == 1) then (numCorrect model ("red") ("-380px"))
                                else if (sumanwsers model ==  3 || sumanwsers model == 2) || sumanwsers model == 4  then (numCorrect model ("orange") ("-380px"))
                      else if (sumanwsers model == (Dict.size model.anwsers)) then (numCorrect model ("green") ("-380px")) else (numCorrect model ("red") ("-380px"))) else div [] [text ""]
--This provides a string of 'well done' / "is wrong" depending on whether the user has gotten the question right, the functions heckanwsers is use to find out whether they are right
isright model x = if (default x (Dict.get x (anwsersright model))) == 1
                 then table [ style "top" "300px", style "width" "900px", style "position" "relative"] [ th [style "top" "5px", style "left" "-420px", style "color" "green", style "font-size" "15px", style "position" "absolute", style "width" "900px"] [text (" ✓ Correct Q" ++ String.fromInt(x) ++ ". ")]
                , td [style "color" "green", style "top" "0px", style "top" "5px", style "left" "-190px", style "height" "30px",style "width" "300px", style "position" "relative"] [text (getquestion model x)]
                , td [style "width" "300px", style "color" "green",style "position" "relative", style "left" "-192px", style "top" "10px"] [text ("Your answer = " ++ (getanwsersinputs model x))]]

                 else table [ style "top" "300px", style "width" "900px", style "position" "relative"] [ th [style "left" "-420px", style "color" "red", style "font-size" "15px", style "position" "absolute", style "width" "900px"] [text (" ✗ Incorrect Q" ++ String.fromInt(x) ++ ". ")]
                , td [style "background-color" "#e6e6e6", style "top" "5px", style "left" "-50px", style "height" "30px",style "width" "300px", style "position" "relative"] [text  (getquestion model x )]
                , td [style "width" "300px", style "position" "relative", style "left" "-45px", style "top" "10px"] [text ("Your answer = " ++ (anslengthcheck(getanwsersinputs model x)))]
                , td [style "background-color" "#e6e6e6", style "width" "100px", style "left" "780px", style "height" "30px", style "position" "fixed"] [text (" Correct Anwser = " ++ (getanwsers model x))]]

--If the anwser entered by the user is empty then N/A should be shown in the table of anwsers
anslengthcheck q = if length q > 10 then ((slice 0 10 q))  else if length q == 0 then "N/A" else q

--This is going to provide a thing of what they have gotten right and what they have gotten wrong
quizmarks1 model = div quizmarkstyle [ div [style "left" "-30px", style "top" "-60px", style "position" "relative"]
                                      (List.map (\l -> (isright model l)) (List.range 1 (Dict.size model.anwsersinputs )))]

--This provides a default since functional programming pure, always requires something i.e. if nothing then string
msToString mv = default "Nothing" mv
--This converts whatever into a string
ts x = String.fromInt(x)
--This shorterns Maybe.withDefault
default x = Maybe.withDefault x

--If the user enteres in incorrect characters they are notified with a red box and a explanation which tells them they are trying to enter in illegal characters
illegalcolor model x = if Regex.contains regex (default "" (Dict.get x model.anwsersinputs)) then "20px solid red"  else "20px solid #3399ff"

showillegal model = div [style "font-size" "15px", style "left" "178px", style "top" "330px", style "position" "fixed", style "font-weight" "bold", style "color" "red"] (
                      if Regex.contains regex (default "" (Dict.get model.next model.anwsersinputs)) then [text "You are trying to enter illegal characters, numbers only"]
                      else [text ""])

--This holds a dictionary of all the different gifs that I want to display in accordance to the amount questions the user has gotten right
imagedictionary = Dict.fromList [(1, (imageStyle1 "1anwser.gif" "1000px" "red" "-90px" "300px" "300px")),
                                 (2, (imageStyle1 "2anwser.gif" "1000px" "orange" "-90px" "300px" "300px")),
                                 (3, (imageStyle1 "3anwser.gif" "1000px" "orange" "-90px" "300px" "300px")),
                                 (4, (imageStyle1 "4anwser.gif" "1000px" "orange" "-90px" "300px" "300px")),
                                 (5, (imageStyle1 "5anwser.gif" "1000px" "green" "-90px" "300px" "300px"))]
--A dictionary needs a default image, therefore I've stored image1 as the default
image1 = imageStyle1 "1anwser.gif" "1000px" "red" "-90px" "300px" "300px"
--This displays a particular gif depending on the amount of anwsers the user has goten right
imageview model = default image1 (Dict.get (sumanwsers model) imagedictionary)


--This gives the inputs for the questions - i.e. this is a textbox which allows the user to write in their anwwsners
qinput model x y = div (viewinputstyle (illegalcolor model x)) [viewInput "string" "Write answer here..." (getanwsersinputs model x ) y]
--This is the default for elm , since if there is an error this will always be shown
q1input model = qinput model 1 Question1

--This stores the inputs into a dictionary to easily be added to and retrived from
qinputs model = Dict.fromList [(1, (qinput model 1 Question1)),
                               (2, (qinput model 2 Question2)),
                               (3, (qinput model 3 Question3)),
                               (4, (qinput model 4 Question4)),
                               (5, (qinput model 5 Question5))
                               ]

--This shows the current input box
viewQuestionInputs : Model -> Html Msg
viewQuestionInputs model =
   div (questionStyle "-250px" "-539.5px" "0px") [
    default (q1input model) (Dict.get model.next (qinputs model))]

-- This will display the model.next question depending on what question the user is on
--This gets the current question
thecurrentquestion model x =  div [] [text ((ts(x)) ++ ". " ++ msToString(Dict.get x model.questions))]
viewQuestion model =
    div (questionStyle "-180px" "-310px" "0px") [
         thecurrentquestion model (model.next)]


calculatorTitle = h2 (pagestyle "480px") [text "A Helpa Calculator"]
quizTitle = h2 (pagestyle "20px") [text "Quiz"]
summmaryTitle = h2 (pagestyle "270px") [text "Summary of Results!"]
helpa = p [style "position" "relative", style "left" "710px", style "top" "120px"] [text "Click the buttons to recieve clues for working out"]
--This stores all the different views which is then called in the Quiz page
viewquestionandvalidation model = div [style "border-width" "3px", style "top" "-20px", style "height" "597px", style "top" "0px", style "border-color" "black", style "width" "726px", style "position" "relative" , style "margin-left" "-100px"] [quizquestionview model]
pinkbackground = div [ style "margin-top" "-100px", style "border-left" "1px dashed",style "background-color" "pink" , style "height" "120%", style "width" "100%", style "position" "fixed" , style "left" "640px"] [text ""]
bluebackground = div [style "margin-top" "-100px", style "background-color" "#e6f7ff" , style "height" "120%", style "width" "100%", style "position" "fixed" , style "left" "0px"] [text ""]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--CALCULATOR
--This displays a calculator from the calculator model
viewexponent model = div [style "left" "110px", style "position" "relative"] [Html.map CalculatorMsg (Calculator.viewExponentIncrement model.calculator)]
viewsign model = div [style "left" "150px", style "position" "relative"] [Html.map CalculatorMsg (Calculator.viewSignIncrement model.calculator)]
viewmantissa model = div [style "left" "90px" , style "position" "relative"][ Html.map CalculatorMsg (Calculator.viewMantissaIncrement model.calculator)]
viewingcalculator model = div [style "position" "relative" , style "top" "-30px"] [viewexponent model, viewsign model, viewmantissa model]
viewsomething model = div [style "height" "100%", style "left" "-10px", style "position" "relative", style "width" "1230px"] [Html.map CalculatorMsg (Calculator.clueexplanation model.calculator)]
--helloerror model = Calculator.helloerror2

listcalcualtors1 model = div [style "top" "-610px", style "margin-left" "-30px", style "position" "relative"] [pinkbackground, calculatorTitle,helpa, (viewsomething model), viewingcalculator model ]
listcalculators model = if (model.next /= (inputsize model)) then (listcalcualtors1 model) else div [] [ div [] [text " "]]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg = input [ type_ t, placeholder p, value v, onInput toMsg ] []
