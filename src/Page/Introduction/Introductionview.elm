module Page.Introduction.Introductionview exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Page.Introduction.Introductionmessage exposing (..)
import Page.Introduction.Introductionmodel exposing (..)
import Styles.Styles exposing (..)


hovering100 model =
    div [ style "position" "relative", style "top" "1000px" ] [ hovernumber model ]


hovernumber model =
    div (styleintro "350px" "700px" "0px" "100%" "" "")
        [ div (styleintro "200px" "80px" "270px" "100px" "border" "double")
            [ h1 [ style "text-align" "center" ] [ text "0 00000 00000000" ]
            , div
                  (makeStyle1 model.stylesign
                    ++ hello111 Show1 Hide1 "0px" "0px" "35px" "100px" "#33ccff" "border-style" "solid"
                )
                [ h1 [ style "text-align" "center", style "border-color" "bl" ]
                    [ text "" ]
                , div
                    (makeStyle1 model.stylesign
                        ++ hello111 Hide1 Hide1 "0px" "200px" "20px" "50px" "#33ccff" "" ""
                    )
                    [ h1 [ style "position" "absolute", style "top" "-100px" ]
                        [ text "Sign" ]
                    ]
                ]
            , div
                (makeStyle2 model.stylemantissa
                    ++ hello111 Show2 Hide2 "40px" "0px" "75px" "100px" "#9966ff" "border-style" "solid"
                )
                [ h1 [ style "text-align" "center" ]
                    [ text "" ]
                , div
                    (makeStyle2 model.stylemantissa
                        ++ hello111 Hide2 Hide2 "0px" "200px" "150px" "50px" "#9966ff" "" ""
                    )
                    [ h1 [ style "top" "-100px", style "position" "absolute" ]
                        [ text "Exponent" ]
                    ]
                ]
            , div
                (makeStyle3 model.styleexponent
                    ++ hello111 Show3 Hide3 "125px" "0px" "141px" "100px" "#ff99ff" "border-style" "solid"
                )
                [ h1 [] [ text "" ]
                , div
                    (makeStyle3 model.styleexponent
                        ++ [ onMouseLeave Hide3, onMouseEnter Hide3, style "position" "absolute", style "top" "300px" ]
                    )
                    [ h1 [ style "position" "relative", style "margin-top" "-180px" ]
                        [ text "Mantissa" ]
                    ]
                ]
            ]
        ]


introexplanation model =
    div (styles "top" "240px")
        [ why model
        , sp  , sp
        , p [ style "font-weight" "bold", style "font-size" "25px", style "text-align" "center" ] [ text "What are IEEE Floating Point Numbers?" ]
        , p hi1 [ text "1. Sign" ]
        , div (textstyleintro "linear-gradient(to bottom, #33ccff 0%, #000066 150%")
            [ text "The sign bit is the first bit of the binary representation. '1' implies a negative number and '0' implies a positive number" ]
        , p hi1 [ text "2. Exponent" ]
        , exponent model
        , p hi1 [ text "3. Mantissa" ]
        , mantissa model
        , p [ style "font-size" "20px", style "font-style" "italic" ] [ text "More on how to carry out the conversion explained in the next 'calculator' section..." ]
        , sp
        ]


mantissa model =
    div (textstyleintro "linear-gradient(to bottom, #ff99ff -30%, #000066 150%)")
        [ div [] [ text "We will use -3.154 as an way to consider how floating point numbers represent their mantissa:" ]
        , p [] [ text "The sign is negative '-', the mantissa is '3.154', and the exponent is '5'." ]
        , p [] [ text "The fractional portion of the mantissa is the sum of each digit multiplied by a power of 10: '.154' =  1/10 + 5/100 + 4/1000" ]
        ]


exponent model =
    div (textstyleintro "linear-gradient(to bottom right, #9966ff 0%, #000066 100%")
        [ div [] [ text "IEEE Floating Points which are 8 bits have a bias of 127. " ]
        , p [] [ text "Lets use the number 1.101 x 2^5 as an example." ]
        , p [] [ text "The exponent (5) is added to 127 and the sum (162) is stored in binary as 10100010" ]
        ]


why model =
    div []
        [ p hi1 [ text "Why?" ]
        , div [ style "font-size" "20px" ]
            [ text "Imagine you have an infinite repeating decimal e.g. 0.55555... since computers have a finite storage there is no way to store this in base 10 form. Therefore IEEE Floating Points approximate numbers so they can then be stored on a computer to precicely represent real numbers, whilst also making the number easier for humans to work with." ]
        ]


specialnumbersexplanation model =
    div (styles "top" "230px")
        [ p [ style "font-weight" "bold", style "font-size" "25px", style "text-align" "center" ] [ text "Special Values?" ]
        , p hi1 [ text "Zero" ]
        , div [ style "font-size" "20px" ]
            [ text "Zero is a special value denoted with an exponent and mantissa of 0. -0 and +0 are distinct values, though they both are equal." ]
        , sp
        , p hi1 [ text "Denormalised" ]
        , div [ style "font-size" "20px" ] [ text "If the exponent is all zeros, but the mantissa is not then the value is a denormalized number. This means this number does not have an assumed leading one before the binary point." ]
        , sp
        , p hi1 [ text "Infinity" ]
        , div [ style "font-size" "20px" ] [ text "The values +infinity and -infinity are denoted with an exponent of all ones and a mantissa of all zeros. The sign bit distinguishes between negative infinity and positive infinity. Operations with infinite values are well defined in IEEE." ]
        , sp
        , p hi1 [ text "Not a Number (NAN)" ]
        , div [ style "font-size" "20px" ] [ text "The value NAN is used to represent a value that is an error. This is represented when exponent field is all ones with a zero sign bit or a mantissa that it not 1 followed by zeros. This is a special value that might be used to denote a variable that doesn’t yet hold a value." ]
        , sp  , sp  , sp
        , div [ style "font-size" "20px" ] [ a [ href "http://duck.aston.ac.uk/konecnym/fpvis.html" ] [ text "To find out even more on how floating points work click me!" ] ]
        ]


image = imageStyle "homermeme.jpg" "173px" "#3399ff" "0px" "150px" "150px"
image2 = imageStyle "pointer.gif" "850px" "#e6f7ff" "220px" "50px" "50px"
hoverexplanation model = div [ style "position" "relative", style "top" "-1250px", style "right" "-870px", style "font-size" "20px" ]
                             [ text "Hover with your mouse" ]
sp = br [] [ text " " ]


viewingintroexplanation model = div [] [ hovering100 model,
                                        introexplanation model,
                                        specialnumbersexplanation model,
                                        image, image2, hoverexplanation model ]
