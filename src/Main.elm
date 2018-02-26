port module Main exposing (..)

import Html exposing (Html, text, div, h1, img, button, input)
import Html.Attributes exposing (src, value)
import Html.Events exposing (onInput)
import Debug exposing (log)


port windowTitle : String -> Cmd msg



---- MODEL ----


type alias Model =
    { a : Float, b : Float, result : Float }


init : ( Model, Cmd Msg )
init =
    ( { a = 2, b = 3, result = 5 }, Cmd.none )



---- UPDATE ----


type Msg
    = NewValueA String
    | NewValueB String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        value =
            \v -> Result.withDefault 0 (String.toFloat v)

        newModel =
            case msg of
                NewValueA v ->
                    let
                        _ =
                            log "AAA " (toString v)
                    in
                        { model | a = value v }

                NewValueB v ->
                    { model | b = value v }
    in
        ( { newModel | result = newModel.a + newModel.b }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput NewValueA, value (toString model.a) ] []
        , input [ onInput NewValueB, value (toString model.b) ] []
        , div [] [ text (toString model.result) ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
