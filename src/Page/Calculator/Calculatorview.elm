module Page.Calculator.Calculatorview exposing (..)
import Page.Calculator.Calculatormodel exposing (..)
import Browser.Navigation as Navigation
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Styles.Styles exposing (..)
import Page.Calculator.Calculatormessage as Calculator exposing (..)
import String exposing (..)





--This makes a new list of the keys in the dictinoaries of the exponent and mantisssa
--This is needed in order to work out the exponent and mantissa numbers
exponentlistrange model = List.reverse(Dict.keys model.exponent) -- This is in the reverese order as that is how the exponent is worked out
mantissalistrange model =  (Dict.keys model.mantissa)


--This is checking whether the values in the dictionary are greater than 0 if so we get their powers otherwise the value will remain as 0 in this model
ifstatement model l = (if Maybe.withDefault (0) (Dict.get (l) model.exponent) > 0 then 2 ^ (l) else 0)
ifstatement2 model l = (if Maybe.withDefault (0) (Dict.get (l) model.mantissa) > 0 then 2 ^ (-l) else 0) --l (-l) since the mantissa multiples negative

--The ifstatement models gets the powers of the exponents/mantissa bits , and this is then mapped against the keys in the exponent/mantissa range
powersexponent1 model = List.map (\l -> (ifstatement model l)) (exponentlistrange model)
powersofmantissa1 model = List.map (\l -> (ifstatement2 model l)) ((mantissalistrange model))

--This puts a + and then an equal signs at the end to show the adding of numbers
toJoinPlusEqual lst = div [] [text (String.join " + " (List.map String.fromInt(lst)) ++ " = ")]

--This gets the powers of the exponents
sumexponent model = List.sum((powersexponent1 model))
--This shows the powers of the exponents added for the view
stringsumexponent model = toJoinPlusEqual ((powersexponent1 model))

--This gets the powers of the mantissa
summantissa model = List.sum((powersofmantissa1 model))
--This shows the powers of the mantissa added for the view
stringsummantissa  model = toJoinPlusEqual (powersofmantissa1 model)

--This then provides the view showing how the calculation is carried out for the exponent
viewingexponentp model = List.map (\l -> (  " ( " ++ String.fromInt(Maybe.withDefault (0) (Dict.get (l) model.exponent)) ++ " * 2 ^ " ++ String.fromInt(l) ++ ")" )) (exponentlistrange model)

--This then provides the view showing how the calculation is carried out for the mantissa
viewingmantissap model = List.map (\l -> (" ( " ++ String.fromInt(Maybe.withDefault (0) (Dict.get (l) model.mantissa)) ++ " * 2 ^ -" ++ String.fromInt(l) ++ ")")) (mantissalistrange model)

toJoin model x = div [] [text (String.join " + " (x) ++ " = ")]
--This puts the list string from the viewingexponentp and viewingmantissap into a div[] element for the view
powersofexponent model = toJoin model ((viewingexponentp model))
powersofmantissa model = toJoin model (viewingmantissap model)

-- This displays the bits on the calculator i.e. whether the bit is 1 / 0 when the user clicks on the mantissa bits
onlicksign model = div floatingPointIncrementStyle
                    [ button (buttonstyle1 IncrementSign "40px" "40px" "#3399ff")  [ text (String.fromInt (model.sign)) ]
                    , div [style "font-weight" "bold"] [ text (String.fromInt (model.sign)) ]
                    , div [] [ text " " ]
                    ]
-- This increments the corresponding bit number in the sign
viewSignIncrement model = div (textstyle1 ("145px") ("520px" )) [onlicksign model]

--This is going to increment the vales of the bits in the exponent through a mapping the list exponentlistrange so this will show each button in the view
viewExponentIncrement  model = div (textstyle1 ("145px") ("620px" )) (List.map (\l ->  div floatingPointIncrementStyle [
                        button (buttonstyle1 (IncrementExponent l) "40px" "40px" "#6600ff") [ text (String.fromInt(l+1)) ]
                        , div [style "font-weight" "bold"] [ text (String.fromInt (Maybe.withDefault 0 (Dict.get l model.exponent))) ]
                        , div [] [ text " " ]
                        ]) ((exponentlistrange model)))
--This is going to increment the vales of the bits in the mantissa through a mapping the list mantissalistrange so this will show each button in the view
viewMantissaIncrement model = div (textstyle1 ("145px") ("830px" )) (List.map (\l ->  div floatingPointIncrementStyle [
                        button (buttonstyle1 (IncrementMantissa l) "40px" "40px" "#ff66cc") [ text (String.fromInt(l)) ]
                        , div [style "font-weight" "bold"] [ text (String.fromInt (Maybe.withDefault 0 (Dict.get l model.mantissa))) ]
                        , div [] [ text " " ]
                        ]) (mantissalistrange model))

--This makes values the dictionary of exponents and mantissa's into a list - allowing the sum to be retrieved
exponentlist model = Dict.values model.exponent
mantissalist model = Dict.values model.mantissa

--String.fromInt
s x = String.fromInt(x)

--This gets the length of the exponent list
explist1 model = (List.length(exponentlist model))
mantissalist1 model = (List.length(mantissalist model))

--This is getting the value needed to work out the exponent , this number is taken away from the exbias
eB model = (2 ^ (explist1 model - 1)) - 1

--Through getting the sum we are able to determine whether the IEEE Floating point number is Nan, Positive Infinity, Negative Infinity.....
checkifnan model = if (List.sum (exponentlist model) == (explist1 model)) && (List.sum (mantissalist model) > 0) then True else False
checkifpositiveinfinity model =  if (model.sign == 0) && (List.sum (exponentlist model) == (explist1 model)) && (checkifnan model == False) then True else False
checkifnegativeinfinity model = if (model.sign == 1) && (List.sum (exponentlist model) == (explist1 model)) then True else False
checkdenormalised model = if (model.sign == 1 || model.sign == 0) && (List.sum(exponentlist model)) == 0 && (List.sum(mantissalist model)) > 0 then True else False
checkifzeronegative model = if (model.sign == 0) && (List.sum(exponentlist model)) == 0 && (List.sum(mantissalist model)) == 0 then True else False
checkifzeropositive model = if (model.sign == 1) && (List.sum(exponentlist model)) == 0 && (List.sum(mantissalist model)) == 0 then True else False

--This is mapping each element into a div [] element
toDiv lst = div [] (List.map (\l -> div [style "float" "left"] [ text (String.fromInt(l)) ]) lst)

--This is now getting each value from the dictionary and putting it inside of a div [] element
floatingpointstring model = toDiv (signmantissaexponentlist model)
exponentstring model = toDiv (List.reverse(exponentlist model))
mantissastring model = toDiv (mantissalist model)

--This is a list of the sign, exponent and mantissa bits all concatenated together
signmantissaexponentlist model = [model.sign] ++ (List.reverse(exponentlist model)) ++ (mantissalist model)

-- This will disply either Nan, Positive Infinity, Negative Infinity - explanation
-- What it displays depends on the condiitons for example checkifnan - This checks if all bits in the floating point are 0
-- When they are all equal to 0, then this displays "NAN", else it will display an explanation on how to convert it into an IEEE Floating point number
errorview x =  div [style "position" "relative",style "height" "100%", style "left" "165px"] [div (abordercolor ("red") ("200px")) [text x]]

nanview = errorview "NAN - Why is that?"
positiveinfinity = errorview "Positive Infinity - Why is that?"
negativeinfinity = errorview "Negative Infinity - Why is that?"
denormlised = errorview "Denormalized - Why is that?"
zeropositive = errorview "Zero positive- Why is that?"
zeronegative = errorview "Zero negative - Why is that?"

--These provide an explation on how to carry out the conversions on the page
-- TO CHANGE THE HEIGHT OF THIS AT ANY POINT REFER TO THE 'fixposition' style element in STYLES - This is put into the Calculting page
fpexplanation model =
   div (textstylebackground ("linear-gradient(to bottom, #33ccff 0%, #000066 150%)") ("white")) [
   fl [text " The bits : "] , floatingpointstring model, sp, sp
   ,div [] [text "The 1st bit is the sign bit , the next 4 bits give the exponent and the last 6 bits give the mantissa."]]

explanationoffloatingmodel model =
     div (textstylebackground ("linear-gradient(to bottom right, #9966ff 0%, #000066 150%)") ("white")) [
     fl [text "1. Working out Exponent : "], sp, sp
     ,fl [text "Lets first decode the exponent which is :"], exponentstring model, sp, sp
     ,powersofexponent model , sp,  stringsumexponent model , sp,  div [] [text ("exponentBias (eB) = " ++ String.fromInt(sumexponent model))], sp
     , div [] [text (" This is not yet the exponent.  If eB was the exponent, we would not be able to have numbers with a negative exponent.  To allow for negative exponents, the eB is shifted by subtracting " ++ String.fromInt(eB model))], sp
     , div [] [text ("' " ++ String.fromInt(eB model) ++ " ' " ++ " was determined with the formular : (2^(number of bits in exponent - 1)) - 1")], sp
     , div [] [text ("(2 ^ (" ++ String.fromInt(explist1 model) ++ " - 1)) - 1 = " ++ (String.fromInt(eB model)) ) ], sp
     , div [] [text "Now we can work out the final exponent "], sp
     -- , div [] [text ("(2 ^ (" ++ String.fromInt(explist1 model) ++ " - 1)) - 1)")]
     , div [] [text ("Exponent Number (e) = " ++ (String.fromInt(sumexponent model)) ++  " - 7 = " ++ if (sumexponent model) > 0 then (String.fromInt((sumexponent model) - (eB model))) else "")], sp
     , div [style "font-style" "italic"] [text "(Note that the extreme values e = 0 and e = 15 have a special meaning and would not be translated like this.)"]
     ]

expmantisaafp model =
     div (textstylebackground ("linear-gradient(to bottom, #ff99ff 0%, #000066 150%)") ("white"))[
      fl [text "2. Working out Mantissa: "], sp, sp
    , fl [text " Now let us work out the mantissa :"], mantissastring model, sp, sp
     , powersofmantissa model, sp, stringsummantissa model, sp, div [] [text ("Mantissa Number (m) = " ++ (if (summantissa model) > 0 then String.fromInt((summantissa model)) else (String.fromInt(summantissa model))))], sp
     ]

finalfp model =
     div (textstylebackground ("white") ("black")) [
      fl [text "3. Working out number : "], sp, sp
    , div [style "float" "left"] [text "We can now decode the meaning of the whole floating-point number"], sp, sp
    , div [] [text ("The sign bit (s) '" ++  String.fromInt(model.sign) ++ ( if (model.sign) > 0 then ("' gives a negative number" ) else ("' gives a positive number"))) ], sp
    , div [] [text ("(-1 ^ s) * (1 + m) * (2^e) = ")], sp
    , div [style "font-style" "italic"] [ text "(Notice that the number '1+m' is always between 1 and 2)"], sp
    , div [] [text (" (-1 ^ " ++ String.fromInt(model.sign) ++ ") * ( 1 + " ++  String.fromInt(summantissa model) ++ ") * (2 ^ " ++   (if (sumexponent model) > 0 then (String.fromInt((sumexponent model) - 7) ++ ")) ="  ) else String.fromInt(sumexponent model) ++ ") = "))], sp
    , div [] [text (if (summantissa model) == 0 && (sumexponent model) == 0 then "" else (String.fromInt((-1 ^ model.sign) * (1 + (summantissa model)) * (2 ^ (if (sumexponent model) > 0 then ((sumexponent model) - 7) else (sumexponent model))))))

    ]
  ]

--This is a image for home page
image = imageStyle "homecalculating.jpg" "330px" "#3399ff" "-120px" "150px" "150px"
abuttonexplanation = imageStyle "abuttonclickyo.gif" "1080px" "#e6f7ff" "43px" "50px" "50px"

--This provides an outlined box of what is the sign, exponent and mantissa for the calculator buttons view
signview model = div (textstyle1 "120px" "650px" )  [text "Sign"]
exponentview model =div (textstyle1 "120px" "790px")    [text "Exponent"]
mantissaview model = div (textstyle1 "120px" "1030px") [text "Mantissa"]
signexponentmantissaview model = div [style "position" "absolute" , style "top" "0px", style "left" "-85px"] [signview model, exponentview model, mantissaview model]

-- This stores the explanations as well as the image
explanationoffloatingpoint1 model = div [style "height" "1350px", style "top" "-50px", style "margin-left" "400px", style "position" "relative"] [fpexplanation model, explanationoffloatingmodel model, expmantisaafp model, finalfp model ]


-- This is checking whether the entered bits are either nan, positive infinity, negative checkifnegativeinfinity
-- When those special values do occur their corresponding views will appear in the view
-- Otherwise the explanation on how to carry out the conversions will appear in view
explanationoffloatingpoint model = div [] [if checkifnan model then (nanview)
                                           else if checkifpositiveinfinity model then (positiveinfinity)
                                           else if checkifnegativeinfinity model then (negativeinfinity)
                                           else if checkdenormalised model then (denormlised)
                                           else if checkifzeronegative model then (zeropositive)
                                           else if checkifzeropositive model then (zeronegative)
                                           else explanationoffloatingpoint1 model ]



flipbitsexplanation model = div [style "position" "relative", style "top" "60px", style "right" "-560px", style "font-size" "15px"] [ div [style "font-weight" "bold"] [text "Hint :"]
                             , div [style "display" "inline-block"] [text "Clicking the buttons will change the bits and provide an explanation for the conversion"]]


--This is holding the calculator lists - Since this always needs to be displayed this is placed in a seperate model
finalcalculatormodel model = div [style "position" "relative", style "margin-left" "-160px", style "margin-top" "120px"][image, abuttonexplanation, flipbitsexplanation model, explanationoffloatingpoint model, signexponentmantissaview model, viewSignIncrement model, viewExponentIncrement model, viewMantissaIncrement model]
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Quiz Page
specialvalmsg = div (textstyle1 "205px" "730px" ) [text "The bits entered eqaute to a special value"]
pinkbackground = div [style "background-color" "pink" , style "height" "100%", style "width" "100%", style "position" "fixed" , style "left" "640px"] [text ""]


clueexplanation model = div [] [if checkifnan model
                                   || checkifpositiveinfinity model
                                   || checkifnegativeinfinity model
                                   || checkdenormalised model
                                   || checkifzeronegative model
                                   || checkifzeropositive model then specialvalmsg
                               else clueexplanation1 model ]

--This is for the Help Calculator on the Quiz Page --This provides a partial explanation of how to convert IEEE Floating points to a number - This is for the quizview
clueexplanation1 model =
    div (textstyle1 "205px" "730px" ) [
    fl [text "1. Floating point bits : "], floatingpointstring model, sp, sp
    ,div [] [text ("2. The sign ' " ++ String.fromInt(model.sign) ++ " ' determines whether the number is going to be positive / negative")]
    ,sp
    ,div [] [text ("3. Convert the exponent into a number")]
    ,sp
    ,li [style "left" "15px", style "position" "relative"] [text ("The eB is ' " ++ (String.fromInt(sumexponent model)) ++ " '")], sp
    ,li [style "left" "15px", style "position" "relative"] [text " What is the eB and how do you work out the exponent from it?" ]
    ,sp
    ,div [] [text ("4. Continue the same method with the mantissa (obviously there is no eB for this")]
    ,sp
    ,div [] [text ("5. The formular to get the IEEE Floating point representation to its decimal equivalent is as follows: " )] ,
    sp, li [style "left" "15px", style "position" "relative"] [text "(-1 ^ s) * (1 + m) * (2^e) = "]]


--= if checkifnan model == True then fixposition5 else fixposition5
--fixposition5 model = [style "position" "absolute",style "z-index" "-900", style "width" "99%", style "height" "1400px", style "overflow-x" "hidden", style "overflow-y" "hidden"]
