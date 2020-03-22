module Styles.Styles exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)

viewinputstyle =
    [ style "border-style" "solid", style "border" "20px solid #3399ff", style "width" "387px", style "text-align" "center", style "margin-left" "-235px", style "position" "fixed" ]


imageStyle x y a t w h =
    img [ src ("Pictures/" ++ x), style "border-style" "solid", style "border-color" a, style "border-width" "10px", style "top" t, style "width" w, style "height" h, style "left" y, style "position" "absolute" ] [ div [] [ text "hello" ] ]

abordercolor x t = [style "font-size" "73px", style "left" "303px", style "top" t, style "position" "fixed", style "color" x, style "border-style" "solid", style "border-color" x, style "border-width" "5px"]

pagestyle1 =
    [ style "font-weight" "bold", style "font-weight" "bold", style "left" "270px", style "text-decoration" "underline", style "top" "-20px", style "position" "absolute", style "border" "none", style "color" "Black", style "width" "100%", style "text-align" "center", style "font-size" "33px" ]


pagestyle =
    [ style "font-weight" "bold", style "font-weight" "bold", style "left" "-100px", style "text-decoration" "underline", style "top" "0px", style "position" "absolute", style "border" "none", style "color" "Black", style "width" "100%", style "text-align" "center", style "font-size" "38px" ]


quizmarkstyle =
    [ style "font-weight" "bold", style "width" "500px", style "font-size" "15px", style "left" "320px", style "position" "fixed", style "top" "300px" ]


textstyle1 x y =
    [ style "font-weight" "bold", style "font-family" "sansation", style "position" "absolute", style "top" x, style "left" y ]


buttonStyle x y =
    [ style "position" "fixed", style "bottom" y, style "color" "black", style "right" x ]


questionStyle y x a =
    [ style "font-weight" "bold", style "position" "fixed", style "bottom" y, style "width" "400px", style "height" "400px", style "height" a, style "right" x, style "font-size" "30px" ]


questionStyle1 y x a =
    [ style "font-weight" "bold", style "position" "fixed", style "bottom" y, style "height" a, style "right" x, style "font-size" "30px" ]


buttonStyle2 =
    [ style "height" "100px", style "width" "100px", style "background-color" "#3399ff", style "color" "white" ]


floatingPointIncrementStyle =
    [ style "font-weight" "bold", style "left" "40px", style "top" "0px", style "position" "relative", style "border" "none", style "color" "black", style "text-align" "center", style "display" "inline-block", style "font-size" "30px" ]


textstyle x y =
    [ style "font-weight" "bold", style "font-family" "sansation", style "position" "absolute", style "top" x, style "left" y, style "width" "770px", style "height" "100px" ]


buttonstyle =
    [ style "font-weight" "bold", style "left" "40px", style "top" "0px", style "position" "relative", style "background-color" "#4CAF50", style "border" "none", style "color" "white", style "text-align" "center", style "display" "inline-block", style "font-size" "16px" ]


background =
    [ style "background-color" "hsla(120, 100%, 75%, 0.3)" ]


textstylebackground a y =
    [ style "font-weight" "bold", style "font-size" "20px", style "color" y, style "border-style" "inset", style "background" a, style "font-family" "sansation", style "position" "relative", style "top" "250px", style "left" "300px", style "width" "900px" ]


whaterror =
    [ style "font-size" "50px", style "font-weight" "bold", style "font-family" "sansation", style "position" "fixed", style "top" "50%", style "left" "50%", style "width" "900px", style "height" "100px" ]


viewstyle x a =
    [ style "border" "solid", style "font-size" "25px", style "top" "100px", style "right" x, style "position" "absolute", style "width" a, style "text-align" "center" ]


returnbuttonstyle =
    [ style "width" "200px", style "margin-left" "292px", style "margin-top" "250px", style "font-size" "50px" ]


buttonstyle1 x h w a =
    [ onClick x, style "height" h, style "width" w, style "background-color" a, style "color" "white", style "font-size" "15px" ]


navbarstyle =
    [ style "position" "fixed"
    , style "top" "0"
    , style "background-color" "grey"
    , style "color" "black"
    , style "size" "10"
    , style "padding" "20px"
    , style "height" "4000px"
    , style "width" "250px"
    , style "border" "3px solid"
    ]


navbarposition t =
    [ style "font-size" "40px", style "left" "50px", style "position" "relative", style "top" t ]
