module Recipe exposing (decoder, view)

import Color exposing (rgb)
import Element exposing (centerX, centerY, el, layout, text)
import Element.Background as Background
import Element.Region as Region
import Html exposing (Html)
import Json.Decode


decoder : Json.Decode.Decoder Info
decoder =
    Json.Decode.map2 Info
        (Json.Decode.field "name" Json.Decode.string)
        (Json.Decode.field "url" Json.Decode.string)


type alias Info =
    { name : String
    , url : String
    }


view : Info -> Html msg
view { name } =
    layout [ Region.mainContent, Background.color <| rgb 149 175 186 ] <|
        el [ centerY, centerX ] <|
            text name
