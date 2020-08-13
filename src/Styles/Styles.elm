module Styles.Styles exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

hello111 x y l t w h c bs s = [ onMouseEnter x,
  onMouseLeave y,
     style "position" "absolute"
      , style "left" l
      , style "top" t
      , style "width" w
      , style "height" h
      , style bs s
      , style "color"  c
      ]

hi = div [style "position" "fixed", style "background-color" "#e6f7ff", style "top" "-100px", style "height" "900%", style "width" "100%"] [text ""]
-- "20px solid #3399ff

viewinputstyle x =
    [ style "border-style" "solid", style "border" x ,style "background" "#99ccff" ,style "width" "387px", style "text-align" "center", style "margin-left" "-235px", style "position" "relative" ]

textstyleintro a = [ style "background" a, style "border" "solid", style "border-color" "black", style "color" "white", style "font-weight" "bold", style "font-size" "20px" ]

hi1 =  [ style "font-weight" "bold", style "font-size" "20px" ]

imageStyle2 x y a t w h =
    img [ src ("Pictures/" ++ x), style "" " ", style "border-style" "solid", style "border-color" a, style "border-width" "10px", style "top" t, style "width" w, style "height" h, style "margin-left" y, style "position" "absolute" , style "z-index"  "900px"] [ div [] [ text "hello" ] ]

imageStyle x y a t w h =
    img [ src ("Pictures/" ++ x), style "" " ", style "border-style" "solid", style "border-color" a, style "border-width" "10px", style "top" t, style "width" w, style "height" h, style "left" y, style "position" "absolute" , style "z-index"  "900px"] [ div [] [ text "hello" ] ]

imageStyle1 x y a t w h =
    img [ src ("Pictures/" ++ x), style "border-style" "solid", style "border-color" a, style "border-width" "10px", style "top" t, style "width" w, style "height" h, style "left" y, style "position" "relative" , style "z-index"  "-900x"] [ div [] [ text "hello" ] ]

abordercolor x t = [style "width" "600px", style "font-size" "30px", style "left" "490px", style "top" t, style "position" "relative", style "color" x, style "border-color" x, style "border-width" "5px"]

pagestyle1 =
    [ style "font-weight" "bold", style "font-weight" "bold", style "left" "270px", style "text-decoration" "underline", style "top" "-20px", style "position" "absolute", style "border" "none", style "color" "Black", style "width" "100%", style "text-align" "center", style "font-size" "33px" ]


pagestyle6 =
    [style "position" "absolute", style "font-weight" "bold", style "font-weight" "bold", style "left" "-100px", style "text-decoration" "underline", style "top" "0px", style "position" "absolute", style "border" "none", style "color" "Black", style "width" "100%", style "text-align" "center", style "font-size" "38px" ]


viewsumanwsersstyle x = [style "font-size" "100px", style "left" "350px", style "top" "100px", style "position" "fixed", style "color" x]

quizmarkstyle =
    [ style "width" "500px", style "font-size" "15px", style "left" "320px", style "position" "absolute", style "top" "0px" ]


textstyle1 x y =
    [style "height" "900px", style "font-weight" "bold", style "font-family" "sansation", style "position" "absolute", style "top" x, style "left" y]

textstyle2 x y =
    [style "margin-top" "-500px", style "margin-left" "-67px", style "background-color" "pink", style "height" "900px", style "width" "900px", style "font-weight" "bold", style "font-family" "sansation", style "position" "absolute", style "top" x, style "left" y]


buttonStyle x y =
    [style "text-align" "center", style "width" "0px", style "height" "0px", style "margin-left" "-200px", style "position" "relative", style "bottom" y, style "color" "black", style "right" x ]


questionStyle y x a =
    [ style "font-weight" "bold", style "position" "relative", style "bottom" y, style "width" "400px", style "height" "400px", style "height" a, style "right" x, style "font-size" "20px" ]


questionStyle1 y x a =
    [ style "font-weight" "bold", style "position" "relative", style "bottom" y, style "height" a, style "right" x, style "font-size" "30px" ]


buttonStyle2 =
    [ style "height" "100px", style "width" "100px", style "background-color" "#3399ff", style "color" "white" ]


floatingPointIncrementStyle =
    [ style "font-weight" "bold", style "left" "40px", style "top" "0px", style "position" "relative", style "navbarposition" "none", style "color" "black", style "text-align" "center", style "display" "inline-block", style "font-size" "30px" ]


textstyle x y =
    [ style "text-align" "left", style "font-weight" "bold", style "font-family" "sansation",style "position" "absolute", style "top" x, style "left" y, style "width" "770px", style "height" "100px" ]


pagestyle x =
    [style "font-family myFirstFont" "src url(sansation_light.woff)", style "weight" "bold", style "height" "100px", style "position" "absolute", style "left" x, style "text-decoration" "underline", style "top" "0px", style "position" "absolute", style "border" "none", style "color" "Black", style "width" "1000px", style "text-align" "center", style "font-size" "30px" ]

buttonstyle =
    [ style "font-weight" "bold", style "left" "40px", style "top" "0px", style "position" "relative", style "background-color" "#4CAF50", style "border" "none", style "color" "white", style "text-align" "center", style "display" "inline-block", style "font-size" "16px" ]


background =
    [ style "background-color" "hsla(120, 100%, 75%, 0.3)" ]


textstylebackground a y =
    [style "text-align" "left", style "font-weight" "bold", style "font-size" "20px", style "color" y, style "border-style" "inset", style "background" a, style "font-family" "sansation", style "position" "relative", style "top" "250px", style "width" "900px" ]

textstylebackground1 a y =
    [ style "font-weight" "bold", style "font-size" "20px", style "color" y, style "border-style" "inset", style "background" a, style "font-family" "sansation",style "height" "900px", style "position" "relative", style "top" "250px", style "left" "300px", style "width" "900px" ]


textstylebackground2 a y =
    [ style "width" "0px", style "font-weight" "bold", style "font-size" "20px", style "color" "black", style "border-style" "inset", style "background" "white", style "font-family" "sansation",style "height" "100%", style "position" "relative", style "top" "-900px", style "right" y, style "width" a ]

whaterror =
    [ style "font-size" "50px", style "font-weight" "bold", style "font-family" "sansation", style "position" "fixed", style "top" "50%", style "left" "50%", style "width" "900px", style "height" "100px" ]


viewstyle x a =
    [style "height" "0px", style "border" "solid", style "font-size" "25px", style "top" "0px", style "right" x, style "position" "relative", style "width" a, style "text-align" "center" ]




returnbuttonstyle =
    [ style "width" "200px", style "margin-left" "292px", style "margin-top" "250px", style "font-size" "50px" ]


buttonstyle1 x h w a =
    [style "text-align" "center", style "box-shadow" "0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19)" , style "transition-duration" "0.4", onClick x, style "height" h, style "width" w, style "background-opacity" "0.2", style "background-color" a, style "color" "white", style "font-size" "30px" , style "opacity" "1"]


-- Makes a new line
sp = br [] [text " "]
-- Allows text to be on the same line
fl = div [style "float" "left"]


inputstyles x = [style "left" "900px", style "top" x , style "position" "absolute"]

navbarstyle =
    [ style "position" "fixed"
    , style "top" "10"
    , style "background-color" "#80bfff"
    , style "color" "black"
    , style "text-weight" "bold"
    , style "size" "15px"
    , style "box-shadow" "5px 10px #004d99"
    , style "padding" "20px"
    , style "height" "4000px"
    , style "width" "120px"
    , style "border-color" "white"
    , style "z-index" "900"
    ]


fixposition3 = [style "position" "absolute",style "z-index" "-900", style "width" "99%", style "height" "600px", style "overflow-x" "hidden", style "overflow-y" "hidden"]

fixposition = [style "position" "absolute",style "z-index" "-900", style "width" "99%", style "height" "1700px", style "overflow-x" "hidden", style "overflow-y" "hidden"]

fixposition4 = [style "position" "absolute",style "z-index" "-900", style "width" "99%", style "min-height" "100%", style "overflow-x" "hidden", style "overflow-y" "hidden"]

fixposition1 = [style "position" "absolute", style "width" "99%", style "height" "120px", style "z-index" "-900", style "overflow-x" "hidden", style "overflow-y" "hidden"]

navbarposition t =
    [ style "font-size" "21px", style "left" "30px", style "position" "relative", style "top" t ]


styleintro l b w h ff f = [style "position" "absolute", style "left" l , style "bottom" b , style "width" w , style "height" h, style ff f , style "background-color" "#e6f7ff"]




styles x y =   [
   style "left" "168px"
  , style "width" "1043px"
  , style "top" "350px"
  , style "text-align" "left"
  , style "border" "Black"
  , style x y
  , style "position" "relative"
  ,style "color" "Black" ]


makeStyle1 shouldShow1 =
      case shouldShow1 of
        True ->

          [
           style "opacity" "1.0"
          ]
        False ->
          [
           style "opacity" ".0"
          ]

makeStyle2 shouldShow2 =
      case shouldShow2 of
        True ->
          [
           style "opacity" "1.0"
          ]
        False ->
          [
           style "opacity" "0.0"
          ]

makeStyle3 shouldShow3 =
      case shouldShow3 of
        True ->
          [
           style "opacity" "1.0"
          ]
        False ->
          [
           style "opacity" "0.0"
          ]
