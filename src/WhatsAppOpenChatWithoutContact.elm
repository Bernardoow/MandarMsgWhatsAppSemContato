module Main exposing (..)

import Browser
import Html exposing (Html, a, div, input, fieldset, form, h1, i, label, legend, p, span, text)
import Html.Attributes exposing (class, for, href, id, placeholder, style, type_, value)
import Html.Events exposing (onClick, onInput)
import Regex


type TypeDevice
    = Mobile
    | Desktop


type alias Model =
    { mobileNumber : String
    , typeDevice : TypeDevice
    }


type alias Flags =
    { userAgent : String }


init : Flags -> ( Model, Cmd Msg )
init flags =
    case Regex.fromStringWith { caseInsensitive = True, multiline = False } flags.userAgent of
        Just regex ->
            if Regex.contains regex "/Android|webOS|iPhone|iPad|iPod|Opera Mini/" then
                ( { mobileNumber = "55", typeDevice = Mobile }, Cmd.none )
            else
                ( { mobileNumber = "55", typeDevice = Desktop }, Cmd.none )

        Nothing ->
            ( { mobileNumber = "55", typeDevice = Desktop }, Cmd.none )


main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


type Msg
    = OnInputMobileNumber String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnInputMobileNumber number ->
            case String.toInt number of
                Just _ ->
                    ( { model | mobileNumber = number }, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    let
        generateWAppUrl : String
        generateWAppUrl =
            case model.typeDevice of
                Mobile ->
                    "https://api.whatsapp.com/send?phone="

                Desktop ->
                    "https://web.whatsapp.com/send?phone="
    in
        div [ class "container" ]
            [ div [ class "row" ]
                [ div [ class "col" ]
                    [ h1 [] [ text "Abrir usuário de whatsapp sem ter o contato na agenda" ]
                    ]
                ]
            , div [ class "row" ]
                [ div [ class "col" ]
                    [ form []
                        [ fieldset []
                            [ div [ class "form-group" ]
                                [ label [ for "mobileNumber" ]
                                    [ text "WhatsAPP" ]
                                , input [ class "form-control", onInput OnInputMobileNumber, id "mobileNumber", placeholder "Digite o número", type_ "text", value model.mobileNumber ]
                                    []
                                ]
                            ]
                        ]
                    ]
                ]
            , div [ class "row" ] [ div [ class "col" ] [ p [] [ text "Formato: 55xxnnnnnnnn. Exemplo: 553199999999 ", span [ style "font-weight" "bold", style "color" "red" ] [ text "Atenção: SEM O 9 EXTRA !!!" ] ] ] ]
            , div [ class "row" ] [ div [ class "col" ] [ a [ class "btn btn-success btn-block", href (generateWAppUrl ++ model.mobileNumber ++ "&text=") ] [ i [ style "margin-right" "10px", class "fa fa-whatsapp fa-2x" ] [], text "Aperte para abrir o WhatsAPP", i [ style "margin-left" "10px", class "fa fa-whatsapp fa-2x" ] [] ] ] ]
            ]
