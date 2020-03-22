module Page.Calculator.Calculatorview exposing (..)
import Page.Calculator.Calculatormodel exposing (..)
import Browser.Navigation as Navigation
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Styles.Styles exposing (..)
import Page.Calculator.Calculatormessage as Calculator exposing (..)

--This displays error depending on whether the user has put nan
viewexplanation model =
    if checkifpositiveinfinity model == True then
        div (whaterror) [ text "This is an error - What error is this?" ]
    else if checkifnan model == True then
        div (whaterror) [ text "This is an error - What error is this?" ]
    else if checkifnegativeinfinity model == True then
        div (whaterror) [ text "This is an error - What error is this?" ]
    else  fpexplanation model

--This provides a partial explanation of how to convert IEEE Floating points to a decimal - This is for the quizview
clueexplanation model =
    div (textstyle1 ("250px") ("750px" )) [
    fl [text "1. Floating point bits : "] , floatingpointstring model, sp, sp
    ,div [] [text ("2. The sign ' " ++ String.fromInt(model.sign) ++ " ' determines whether the decimal is going to be positive / negative")]
    ,sp
    ,div [] [text ("3. Convert the exponent into a decimal and then work out the exbias i.e. eB number")]
    ,sp
    ,div [] [text ("For example " ++ "eB =  ( ' "++ (String.fromInt(sumexponent model)) ++  " ' is the Exponent Decimal )  - 7 = ?")], sp
    ,div [] [text " What is the exbias?" ]
    ,sp
    ,div [] [text ("4. Continue the same method with the mantissa (obviously there is no exbias for this)")]
    ,sp
    ,div [] [text ("5. The formular for working out the final IEEE Floating Point decimal is as follows : " )] , sp, div [] [text "(-1 ^ s) * (m) * (2^e) = "]]

--This is a image for home page
image = imageStyle "homecalculating.jpg" "310px" "#3399ff" "20px" "200px" "200px"

--This provides an outlined box of what is the sign, exponent and mantissa
signview model = div (viewstyle ("532px") ("50px"))  [text "Sign"]
exponentview model = div (viewstyle ("310px") ("155px"))  [text "Exponent"]
mantissaview model = div (viewstyle ("15px") ("241px")) [text "Mantissasa"]
signexponentmantissaview model = div [] [signview model, exponentview model, mantissaview model]



--This is a function which allows you to get the power of 2 for a number
-- Mantissa takes two parameters, 1 for the position and one to specify what to multiply the mantissa bit by for example this may 2 ^ -1
checkexponent model x y = if Maybe.withDefault x (Dict.get x model.exponent) > 0 then 2 ^ y else 0
checkmantissa model x y = if Maybe.withDefault x (Dict.get x model.mantissa) > 0 then 2 ^ y else 0
--This is applying checkexponent to add all the exponent bits to get the final exponent number
sumexponent model = (checkexponent model 1 3) + (checkexponent model 2 2) + (checkexponent model 3 1) + (checkexponent model 4 0)
--This is applying checkmantissa to add all the mantissa bits to get the final exponent number
summantissa model = (checkmantissa model 1 -1) + (checkmantissa model  2 -2) + (checkmantissa model  3 -3) + (checkmantissa model  4 -4) + (checkmantissa model  5 -5) + (checkmantissa model  6 -6)
--This enables the viewer to see what mathematical caluclations are being applied to the exponent number and mantissa number to work it out
stringsumexponent model = div [style "font-weight" "bold" ] [text (s(checkexponent model 1 3) ++ " + " ++ s(checkexponent model 2 2) ++ " + " ++ s(checkexponent model 3 1) ++ " + " ++ s(checkexponent model 4 0) ++ " = ")]
stringsummantissa model =  div [style "font-weight" "bold"] [text (s(checkmantissa model 1 -1)  ++ " + " ++  s(checkmantissa model  2 -2)  ++ " + " ++  s(checkmantissa model  3 -3)  ++ " + " ++  s(checkmantissa model  4 -4)  ++ " + " ++  s(checkmantissa model  5 -5)  ++ " + " ++  s(checkmantissa model  6 -6) ++ " = ")]
--This makes the dictionary of exponents and mantissa's into a list - allowing the sum to be retrieved
exponentlist model = Dict.values model.exponent
mantissalist model = Dict.values model.mantissa
--String.fromInt
s x = String.fromInt(x)
--This gets the length of the exponent list
explist1 model = (List.length(exponentlist model)) - 1
--This allows the sum of a list to be retrived
sum list = list.sum()
--Through getting the sum we are able to determine whether the IEEE Floating point number is Nan, Positive Infinity, Negative Infinity
checkifnan model = if (List.sum (exponentlist model) == (explist1 model)) && (List.sum (mantissalist model) > 0) then True else False
checkifpositiveinfinity model =  if (model.sign == 0) && (List.sum (exponentlist model) == (explist1 model)) && (checkifnan model == False) then True else False
checkifnegativeinfinity model = if (model.sign == 1) && (List.sum (exponentlist model) == (explist1 model)) then True else False



--This allows the 'List String' to be converted into an html msg, so it can be seen in the view
renderList : List String -> Html msg
renderList lst = div [] (List.map (\l -> div [style "float" "left"] [ text l ]) lst)
--renderList only takes String as a parameter, therefore this converts each item into a String
renderingtostringfullfloating model = List.map (\a -> (String.fromInt(a))) (fplistremoval2 model)
renderingtostringexponent model = List.map (\a -> (String.fromInt(a))) (exponentlistremovl1 model)
renderingtostringmantissa model = List.map (\a -> (String.fromInt(a))) (mantissalistremovl1 model)
--This is a visualisation of the sign, exponent and mantissa bits
signmantissaexponentlist model = [model.sign] ++ (exponentlist model) ++ (mantissalist model)
-- This removes at a particular index in the List
removeAt index l  =
    if index < 0 then
        l
    else
        let
            head =
                List.take index l

            tail =
                List.drop index l |> List.tail
        in
            case tail of
                Nothing ->
                    l

                Just t ->
                    List.append head t
--The problem with when converting it into a list, one number bit is added to the end of the list, this allows the removal of the end bit
fplistremoval1 model = removeAt 1 (signmantissaexponentlist model)
fplistremoval2 model = removeAt 5 (fplistremoval1 model)
exponentlistremovl1 model = removeAt 0 (exponentlist model)
mantissalistremovl1 model = removeAt 0 (mantissalist model)
-- This is now putting renderingtostringfullfloating into a model, so it can be placed into the view as a html msg
floatingpointstring model = renderList(renderingtostringfullfloating model)
exponentstring model = renderList(renderingtostringexponent model)
mantissastring model =  renderList(renderingtostringmantissa model)




-- These takes the bit model function and then puts them into a text, so it can seen in the view function
-- This shows the conversion in the bits model
powersofmantissa model = div [style "font-weight" "bold"] [bitsm model 1 -6, bitsm model 2 -5, bitsm model 3 -4, bitsm model 4 -3, bitsm model 5 -2, bitsm model 6 -1]
powersofexponent model = div [style "font-weight" "bold"] [div [style "float" "left"] [bitse model 4 3 ,bitse model 3 2 ,bitse model 2 1 ,bitse model 1 0 ]]
-- This displays the bits on the calculator i.e. whether the bit is 1 / 0 when the user clicks on the mantissa bits
onlicksign model x = div floatingPointIncrementStyle [
                    button (buttonstyle1 IncrementSign "40px" "40px" "#3399ff")  [ text (String.fromInt (model.sign)) ]
                    , div [style "font-weight" "bold" ] [ text (String.fromInt (model.sign)) ]
                    , div [] [ text " " ]
                    ]
-- This displays the bits on the calculator i.e. whether the bit is 1 / 0 when the user clicks on the mantissa bits
onlickmantissa model x a = div floatingPointIncrementStyle [
                    button (buttonstyle1 (IncrementMantissa x) "40px" "40px" "#ff66cc") [ text (String.fromInt(x)) ]
                    , div [style "font-weight" "bold"] [ text (String.fromInt (Maybe.withDefault x (Dict.get x model.mantissa))) ]
                    , div [] [ text " " ]
                    ]
--onlickmantissa1 model x = div floatingPointIncrementStyle [ button [ onClick IncrementMantissa] [ text ("" ++ (String.fromInt(x))) ], div [] [text ""]]
-- This displays the bits on the calculator i.e. whether the bit is 1 / 0 when the user clicks on the exponent bits
onlickexponent model x a = div floatingPointIncrementStyle [
                      button (buttonstyle1 (IncrementExponent x) "40px" "40px" "#6600ff") [ text (String.fromInt(x)) ]
                    , div [style "font-weight" "bold"] [ text (String.fromInt (Maybe.withDefault x (Dict.get x model.exponent))) ]
                    , div [] [ text " " ]
                    ]
-- This function takes two parameters, x (position) y(what we want to multiple the position)
-- When exponent bit > 0, then it will multiply exponent by specific value i.e. for posiiton 1 it will be 2 ^ 1
-- When the exponent bit < 0, then it will multiply 0 with 2 to the power of 1
bitse model x y = div [style "float" "left"] [text ((if Maybe.withDefault x (Dict.get x model.exponent) > 0
                          then " ( 1 * 2 ^ " ++ String.fromInt(y) ++ " = " ++ String.fromInt(1 * 2 ^ y) ++ (if x == 1 then " )  = " else "  ) + ")
                          else " ( 0 * 2 ^ " ++ String.fromInt(y)  ++ (if x == 1 then " )  = " else " = 0 ) + ")))]
--This function takes two parameters, x (position) y(what we want to multiple the position)
-- When mantissa bit > 0, then it will multiple mantissa by specific value i.e. for posiiton 1 it will be 2 ^ -1
-- When the mantissa bit < 0, then it will multiply 0 with 2 to the power of -1
bitsm model x y = div [style "float" "left"] [text (if Maybe.withDefault x (Dict.get x model.mantissa) > 0
                          then " ( 1 * 2 ^ " ++ String.fromInt(y) ++ " = " ++ String.fromInt(1 * 2 ^ y) ++ (if y == -1 then ") = " else " ) + " )
                          else " ( 0 * 2 ^ " ++ String.fromInt(y)  ++ (if y == -1 then " ) = " else " = 0 ) + " ))]



hello123 model = div [] [signexponentmantissaview model, viewExponentIncrement model, viewSignIncrement model, viewMantissaIncrement model, viewexplanation model]

-- This will disply either Nan, Positive Infinity, Negative Infinity - explanation
-- What it displays depends on the condiitons for example checkifnan - This checks if all bits in the floating point are 0
-- When they are all equal to 0, then this displays "NAN", else it will display an explanation on how to convert it into an IEEE Floating point number


--This makes a space
sp = br [] [text " "]
--This puts the code on the left
fl = div [style "float" "left"]

fpexplanation model =
   div (textstylebackground ("linear-gradient(to bottom, #33ccff 0%, #000066 150%)") ("white")) [
   fl [text "1. The bits : "] , floatingpointstring model, sp, sp
   ,div [] [text "The 1st bit is the sign bit, the next 4 bits give the exponent and the last 6 bits give the mantissa."]]

explanationoffloatingmodel model =
     div (textstylebackground ("linear-gradient(to bottom right, #9966ff 0%, #000066 100%)") ("white")) [
     fl [text "1. Working out Exponent : "], sp, sp
     ,fl [text "Lets first decode the exponent which is :"], exponentstring model, sp, sp
     , powersofexponent model, sp, sp, stringsumexponent model ,  sp, div [] [text ("Exponent Number = " ++ String.fromInt(sumexponent model))], sp
     , div [] [text " This is not yet the exponent.  If eB was the exponent, we would not be able to have numbers with a negative exponent.  To allow for negative exponents, the number eB is shifted by subtracting 7:"], sp
     , div [] [text ("eB = " ++ (String.fromInt(sumexponent model)) ++  " - 7 = " ++ if (sumexponent model) > 0 then (String.fromInt((sumexponent model) - 7)) else "")], sp
     , div [style "font-style" "italic"] [text "(Note that the extreme values eB = 0 and eB = 255 have a special meaning and would not be translated like this.)"]
     ]

expmantisaafp model =
     div (textstylebackground ("linear-gradient(to bottom, #ff99ff 0%, #000066 150%)") ("white"))[
      fl [text "2. Working out Mantissa: "], sp, sp
    , fl [text " Now let us work out the mantissa :"], mantissastring model, sp, sp
     ,powersofmantissa model, sp, sp, stringsummantissa model , sp, div [] [text ("Mantissa Number = " ++ (if (summantissa model) > 0 then String.fromInt((summantissa model) + 1) else (String.fromInt(summantissa model))))], sp
     , div [style "font-style" "italic"] [ text "(Notice that the “1+” in the calculation guarantees that m is always between 1 and 2)"]
     ]

finalfp model =
     div (textstylebackground ("white") ("black")) [
      fl [text "3. Working out decimal number : "], sp, sp
    , div [style "float" "left"] [text "We can now decode the meaning of the whole floating-point number"], sp, sp
    , div [] [text ("The sign bit is " ++  String.fromInt(model.sign) ++ ( if (model.sign) > 0 then ( " which means the decimal is a negative number" ) else (" which means the decimal is a positive number"))) ], sp
    , div [] [text ("(-1 ^ s) * (1 + m) * (2^eB) = ")], sp
    , div [] [text (" (-1 ^ " ++ String.fromInt(model.sign) ++ ") * ( 1 + " ++  String.fromInt(summantissa model) ++ ") * (2 ^ " ++   (if (sumexponent model) > 0 then (String.fromInt((sumexponent model) - 7) ++ ")) ="  ) else String.fromInt(sumexponent model) ++ ") = "))], sp
    , div [] [text (if (summantissa model) == 0 && (sumexponent model) == 0 then "" else (String.fromInt((-1 ^ model.sign) * (1 + (summantissa model)) * (2 ^ (if (sumexponent model) > 0 then ((sumexponent model) - 7) else (sumexponent model))))))]
  ]



nanview = div [] [div (abordercolor ("red") ("300px")) [text "NAN - Why is that?"], div [] [image]]
positiveinfinity = div [] [div (abordercolor ("red") ("300px")) [text "Positive Infinity - Why is that?"], div [] [image]]
negativeinfinity = div [] [div (abordercolor ("red") ("300px")) [text "Negative Infinity - Why is that?"], div [] [image]]

explanationoffloatingpoint model = div [] [if (checkifnan model) == True then (nanview) else if (checkifpositiveinfinity model) == True then (positiveinfinity) else if (checkifnegativeinfinity model) == True then (positiveinfinity) else (explanationoffloatingpoint1 model) ]

explanationoffloatingpoint1 model = div [] [fpexplanation model, explanationoffloatingmodel model, expmantisaafp model, finalfp model, image]

hello12345 model = "hello"

-- This increments the corresponding bit number in the sign
viewSignIncrement model =
    div (textstyle1 ("145px") ("605px" ))
        [ onlicksign model "#3399ff"
        ]
-- This increments the corresponding bit number in the exponent
viewExponentIncrement model =
    div (textstyle1 ("145px") ("720px" ))
        [ onlickexponent model 1 "#6600ff"
        , onlickexponent model 2 "#6600ff"
        , onlickexponent model 3 "#6600ff"
        , onlickexponent model 4 "#6600ff"

        ]
--This increments the corresponding bit number in the mantissa
viewMantissaIncrement model =
    div (textstyle1 ("145px") ("930px" ))
        [ onlickmantissa model 1 "#ff66cc"
        , onlickmantissa model 2 "#ff66cc"
        , onlickmantissa model 3 "#ff66cc"
        , onlickmantissa model 4 "#ff66cc"
        , onlickmantissa model 5 "#ff66cc"
        , onlickmantissa model 6 "#ff66cc"
        ]


viewhellomodel model = [viewSignIncrement model, viewExponentIncrement model, viewMantissaIncrement model]
