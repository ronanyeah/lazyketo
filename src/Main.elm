module Main exposing (decoder, view)

import Color exposing (black, rgb)
import Element exposing (Attribute, Element, alignBottom, alignLeft, centerX, centerY, column, el, html, layout, link, mouseOver, newTabLink, padding, px, row, shrink, spacing, text, width)
import Element.Background as Background
import Element.Font as Font
import Element.Region as Region
import Html exposing (Html)
import Html.Attributes
import Json.Decode


font : Attribute msg
font =
    Font.family
        [ Font.external
            { url = "https://fonts.googleapis.com/css?family=Lato"
            , name = "Lato"
            }
        ]


decoder : Json.Decode.Decoder (List Info)
decoder =
    Json.Decode.list
        (Json.Decode.map2 Info
            (Json.Decode.field "name" Json.Decode.string)
            (Json.Decode.field "url" Json.Decode.string)
        )


type alias Info =
    { name : String
    , url : String
    }


view : List Info -> Html msg
view recipes =
    layout [ Region.mainContent, Background.color <| rgb 149 175 186 ] <|
        column
            []
            [ el [ centerY ] <|
                column [ spacing 80 ]
                    [ el [ centerX, Region.heading 1, font, Font.bold, Font.size 50, Font.color black ] <| text "Lazy Keto"
                    , recipes
                        |> List.map
                            (\{ name, url } ->
                                newTabLink
                                    []
                                    { url = "/" ++ url
                                    , label =
                                        el
                                            [ Font.size 20
                                            , Font.color Color.black
                                            , font
                                            , mouseOver [ Font.color Color.darkGreen ]
                                            ]
                                        <|
                                            text <|
                                                "- "
                                                    ++ name
                                    }
                            )
                        |> column [ width shrink, centerX ]
                    , links
                    , cornerLink
                    ]
            ]


links : Element msg
links =
    let
        faIcon str =
            el
                [ Font.color black
                , width <| px 35
                , Font.size 30
                , mouseOver [ Font.color Color.darkGreen ]
                ]
            <|
                html <|
                    Html.span [ Html.Attributes.class str ] []
    in
    row [ spacing 20 ]
        [ newTabLink [ centerX ]
            { url = "https://stackoverflow.com/users/story/4224679"
            , label = faIcon "fab fa-stack-overflow"
            }
        , link [ centerX ]
            { url = "mailto:hey@ronanmccabe.me"
            , label = faIcon "fas fa-envelope"
            }
        , newTabLink [ centerX ]
            { url = "https://www.github.com/ronanyeah"
            , label = faIcon "fab fa-github"
            }
        , newTabLink [ centerX ]
            { url = "https://www.twitter.com/ronanyeah"
            , label = faIcon "fab fa-twitter"
            }
        , newTabLink [ centerX ]
            { url = "https://uk.linkedin.com/in/ronanemccabe"
            , label = faIcon "fab fa-linkedin"
            }
        ]


cornerLink : Element msg
cornerLink =
    newTabLink
        [ alignLeft
        , alignBottom
        , padding 15
        ]
        { url =
            "https://github.com/ronanyeah/lazyketo"
        , label =
            el
                [ Font.size 20
                , Font.color Color.black
                , font
                , mouseOver [ Font.color Color.darkGreen ]
                ]
            <|
                text "&lt;script&gt;&lt;/script&gt;"
        }
