module Main exposing (..)

import Browser
import Html exposing (Html, a, div, input, fieldset, form, h1, i, label, legend, p, span, text)
import Html.Attributes exposing (class, for, href, id, placeholder, style, type_, value)
import Html.Events exposing (onClick, onInput)


type alias Model =
    { mobileNumber : String
    }


main =
    Browser.sandbox { init = { mobileNumber = "55" }, update = update, view = view }


type Msg
    = OnInputMobileNumber String


update : Msg -> Model -> Model
update msg model =
    case msg of
        OnInputMobileNumber number ->
            case String.toInt number of
                Just _ ->
                    { model | mobileNumber = number }

                Nothing ->
                    model


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Abrir usuário de whatsapp sem ter o contato na agenda" ]
        , form [ class " pure-form pure-form-stacked" ]
            [ fieldset []
                [ label [ for "mobileNumber" ]
                    [ text "WhatsAPP" ]
                , input [ class "pure-input-1", onInput OnInputMobileNumber, id "mobileNumber", placeholder "Digite o número", type_ "text", value model.mobileNumber ]
                    []
                ]
            ]
        , p [] [ text "Formato: 55xxnnnnnnnn. Exemplo: 553199999999 ", span [ style "font-weight" "bold", style "color" "red" ] [ text "Atenção: SEM O 9 EXTRA !!!" ] ]
        , div [ style "padding-left" "20%", style "padding-right" "20%" ] [ a [ style "widht" "100%", class "button-block pure-button pure-button-success button-success", href ("https://web.whatsapp.com/send?phone=" ++ model.mobileNumber ++ "&text=") ] [ i [ style "margin-right" "10px", class "fa fa-whatsapp fa-2x" ] [], text "Aperte para abrir o WhatsAPP", i [ style "margin-left" "10px", class "fa fa-whatsapp fa-2x" ] [] ] ]
        ]
