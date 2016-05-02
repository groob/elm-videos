module Main exposing (..)

import Html exposing (..)
import String
import Html.App as Html
import Html.Events exposing (onClick, onInput)
import Html.Attributes
  exposing
    ( id
    , attribute
    , property
    , autofocus
    , class
    , href
    , placeholder
    , style
    , value
    , src
    , width
    , height
    )


main : Program Never
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { videos : List Video
  , selected : Video
  , query : String
  , tagFilter : String
  , speakerFilter : String
  }


type alias Video =
  { date : String
  , added : String
  , id : String
  , url : String
  , speakers : List String
  , tags : List String
  , title : String
  }


initialModel : Model
initialModel =
  { videos = videos
  , selected =
      { date = "2015-07-14"
      , added = "2016-04-29"
      , id = "oYk8CKH7OhE"
      , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
      , speakers =
          [ "Evan Czaplicki"
          ]
      , tags =
          [ "curry_on"
          , "community"
          ]
      , title = "Let's be mainstream! User focused design in Elm"
      }
  , query = ""
  , tagFilter = ""
  , speakerFilter = ""
  }


videos : List Video
videos =
  [ { date = "2014-09-21"
    , added = "2016-04-29"
    , id = "Agu6jipKfYw"
    , url = "https://www.youtube.com/watch?v=Agu6jipKfYw"
    , speakers =
        [ "Evan Czaplicki"
        ]
    , tags =
        [ "frp"
        , "strangeloop"
        ]
    , title = "Controlling Time and Space: understanding the many formulations of FRP"
    }
  , { date = "2015-07-14"
    , added = "2016-04-29"
    , id = "oYk8CKH7OhE"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers =
        [ "Evan Czaplicki"
        ]
    , tags =
        [ "curry_on"
        , "community"
        ]
    , title = "Let's be mainstream! User focused design in Elm"
    }
  , { date = "2015-11-25"
    , added = "2016-04-30"
    , id = "6EdXaWfoslc"
    , url = "https://www.youtube.com/watch?v=6EdXaWfoslc"
    , speakers =
        [ "Richard Feldman"
        ]
    , tags =
        [ "Effects"
        , "ReactiveConf"
        ]
    , title = "Effects as Data"
    }
  , { date = "2016-04-27"
    , added = "2016-05-01"
    , id = "mIwD27qqr5U"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers = [ "Tomasz Kowal" ]
    , tags = [ "LambdaDays", "2016" ]
    , title = "Tomasz Kowal - Elixir and Elm - the perfect couple (Lambda Days 2016) "
    }
  , { date = "2016-04-15"
    , added = "2016-05-01"
    , id = "zBHB9i8e3Kc"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers = [ "Richard Feldman" ]
    , tags = [ "2016" ]
    , title = "Richard Feldman - Introduction to Elm ( March 22, 2016 )"
    }
  , { date = "2016-04-05"
    , added = "2016-05-01"
    , id = "NgwQHGqIMbw"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers = []
    , tags = []
    , title = "From jQuery to Flux to Elm - Forward 4 Web Summit "
    }
  , { date = "2016-03-11"
    , added = "2016-05-01"
    , id = "XJ9ckqCMiKk"
    , url = "https://www.youtube.com/watch?v=XJ9ckqCMiKk"
    , speakers = [ "Chris McCord", "Evan Czaplicki" ]
    , tags = [ "ErlangFactory", "2016" ]
    , title = "Erlang Factory SF 2016 Keynote  Phoenix and Elm – Making the Web Functional"
    }
  , { date = "2016-02-26"
    , added = "2016-05-01"
    , id = "txxKx_I39a8"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers = [ "Jamison Dance" ]
    , tags = [ "ReactJS", "2016" ]
    , title = "React.js Conf 2016 - Jamison Dance - Rethinking All Practices: Building Applications in Elm"
    }
  , { date = "2016-02-15"
    , added = "2016-05-01"
    , id = "R121YzswY_4"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers = [ "Richard Feldman" ]
    , tags = [ "ReactiveConf", "2015" ]
    , title = "Elm Stylesheets | Richard Feldman | ReactiveConf 2015"
    }
  , { date = "2016-02-08"
    , added = "2016-05-01"
    , id = "8pPO9kM2N5I"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers = [ "Andy Balaam" ]
    , tags = []
    , title = "Elm makes me happy"
    }
  , { date = "2016-01-04"
    , added = "2016-05-01"
    , id = "B7Iwreo1ReU"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers = [ "LambdaConf", "2015" ]
    , tags = []
    , title = "LambdaConf 2015 - Shipping a Production Web App in Elm  Richard Feldman"
    }
  , { date = "2015-12-28"
    , added = "2016-05-01"
    , id = "5gazbATrPcU"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers = []
    , tags = []
    , title = "Hello Elm | An introduction to the Elm language."
    }
  , { date = "2015-11-13"
    , added = "2016-05-01"
    , id = "jrkLrm4Oh2s"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers = [ "Jesse Williamson" ]
    , tags = []
    , title = "Elm Programming Language by Jesse Williamson"
    }
  , { date = "2015-11-11"
    , added = "2016-05-01"
    , id = "ZTliDiWDV0k"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers = [ "Evan Czaplicki" ]
    , tags = []
    , title = "Elm with Evan Czaplicki"
    }
  , { date = "2015-10-18"
    , added = "2016-05-01"
    , id = "W9HDueiaIJ4"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers = [ "Richard Feldman" ]
    , tags = [ "LambdaJam" ]
    , title = "Lambda Jam 2015 - Richard Feldman - Shipping a Production Web App in Elm"
    }
  , { date = "2015-10-15"
    , added = "2016-05-01"
    , id = "vXe91J6OczU"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers = []
    , tags = []
    , title = "Introduction to Elm"
    }
  , { date = "2015-10-14"
    , added = "2016-05-01"
    , id = "MgFDZx1LmOE"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers = [ "Alan Gardner" ]
    , tags = [ "ElixirConf", "2015" ]
    , title = "ElixirConf 2015 - Phoenix with Elm by Alan Gardner"
    }
  , { date = "2015-09-27"
    , added = "2016-05-01"
    , id = "FV0DXNB94NE"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers = []
    , tags = []
    , title = "Make the Back-End Team Jealous: Elm in Production by Richard Feldman"
    }
  , { date = "2015-09-10"
    , added = "2016-05-01"
    , id = "vOddpMIdQLY"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers = []
    , tags = [ "pragstudio" ]
    , title = "Elm Signals In Action"
    }
  , { date = "2015-08-09"
    , added = "2016-05-01"
    , id = "-JlC2Q89yg4"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers = []
    , tags = []
    , title = "Climbing Into Elm"
    }
  , { date = "2015-07-09"
    , added = "2016-05-01"
    , id = "fq4l6C935Bg"
    , url = "https://www.youtube.com/watch?v=fq4l6C935Bg"
    , speakers = [ "Jivago Alves" ]
    , tags = [ "PolyConf", "2015" ]
    , title = "PolyConf 15: Building Web Apps in Elm"
    }
  , { date = "2013-11-27"
    , added = "2016-05-01"
    , id = "6PDvHveBtDQ"
    , url = "https://www.youtube.com/watch?v=oYk8CKH7OhE"
    , speakers = []
    , tags = []
    , title = "Elm Tutorial - The basics"
    }
  , { date = "2016-04-16"
    , added = "2016-05-01"
    , id = "fhMLEOr8C4U"
    , url = "https://www.youtube.com/watch?v=fhMLEOr8C4U"
    , speakers = [ "Dave Alger" ]
    , tags = [ "ui", "elm-ui" ]
    , title = "elm-ui - rock paper scissors (lizard spock)"
    }
  ]


init : ( Model, Cmd Msg )
init =
  ( initialModel, Cmd.none )



-- UPDATE


type Filter
  = Tag
  | Speaker


type Msg
  = NoOp
  | Select Video
  | Search String
  | Filter Filter String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )

    Select vid ->
      ( { model | selected = vid }, Cmd.none )

    Search query ->
      ( { model | query = query }, Cmd.none )

    Filter filterKind filter ->
      case filterKind of
        Tag ->
          ( { model | tagFilter = filter }, Cmd.none )

        Speaker ->
          ( { model | speakerFilter = filter }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW


view : Model -> Html Msg
view model =
  let
    selected =
      model.selected

    searchedVideos =
      searchFor model.query model.videos

    filteredVideos =
      filterBy model searchedVideos

    footer =
      div
        [ class "page-footer" ]
        [ text "Original idea by "
        , a [ href "https://gophervids.appspot.com" ] [ text "GopherVids" ]
        ]

    selectedID v =
      if v.id == selected.id then
        "selected"
      else
        "unselected"

    videoRow v =
      div
        [ class "video-row"
        , id <| selectedID v
        , onClick <| Select v
        ]
        [ text v.title ]

    videoList =
      List.map (videoRow) filteredVideos

    body =
      let
        speakers x =
          div
            [ class "speaker" ]
            [ div [ onClick <| Filter Speaker x ] [ text x ] ]

        tags x =
          div
            [ class "tag" ]
            [ div [ onClick <| Filter Tag x ] [ text x ] ]

        speakerList =
          List.map speakers selected.speakers

        tagList =
          List.map tags selected.tags

        selectedTag =
          if model.tagFilter /= "" then
            [ text "tag: "
            , text <| model.tagFilter ++ " "
            , button [ onClick <| Filter Tag "" ] [ text "x" ]
            ]
          else
            []

        selectedSpeaker =
          if model.speakerFilter /= "" then
            [ text "speaker: "
            , text <| model.speakerFilter ++ " "
            , button [ onClick <| Filter Speaker "" ] [ text "x" ]
            ]
          else
            []
      in
        div
          [ class "page-body" ]
          [ div
              [ class "video-player" ]
              [ h3 [] [ text selected.title ]
              , youtube selected.id
              , div
                  [ class "speaker-list" ]
                  [ div [ id "title" ] [ text "Speakers:" ]
                  , div [] speakerList
                  ]
              , div
                  [ class "tag-list" ]
                  [ div [ id "title" ] [ text "Tags:" ]
                  , div [] tagList
                  ]
              ]
          , div
              [ class "video-list-container" ]
              [ div
                  [ class "video-selection" ]
                  [ h3 [] [ text "Videos" ]
                  , div [] selectedTag
                  , div [] selectedSpeaker
                  ]
              , div [ class "video-list" ] videoList
              ]
          ]
  in
    div
      [ class "page" ]
      [ header model
      , body
      , footer
      ]


header : Model -> Html Msg
header model =
  div
    [ class "page-header" ]
    [ div
        [ class "header-section" ]
        [ div
            [ class "page-logo" ]
            [ a
                [ href "/" ]
                [ img [ src "/assets/logo.svg" ] []
                , text "Elm Videos"
                ]
            ]
        , div
            [ class "search-box" ]
            [ input [ onInput Search, placeholder "Search" ] []
            ]
        ]
    , div
        [ class "header-section" ]
        [ a
            [ href "https://github.com/groob/elm-videos/issues" ]
            [ Html.i [ class "fa fa-code-fork" ] []
            ]
        ]
    ]


youtube : String -> Html Msg
youtube id =
  div
    [ class "videowrapper" ]
    [ iframe
        [ attribute "allowfullscreen" "true"
        , width 560
        , height 315
        , src <| "https://www.youtube.com/embed/" ++ id
        ]
        []
    ]


searchFor : String -> List Video -> List Video
searchFor query videos =
  let
    queryTerms =
      String.words (String.toLower query)

    matchesQueryTerms { title, speakers, tags } =
      let
        lowerTitle =
          String.toLower title

        lowerSpeakers =
          String.toLower (toString speakers)

        lowerTags =
          String.toLower (toString tags)

        findTerm term =
          String.contains term lowerTitle
            || String.contains term lowerSpeakers
            || String.contains term lowerTags
      in
        List.all findTerm queryTerms
  in
    List.filter matchesQueryTerms videos


filterBy : Model -> List Video -> List Video
filterBy model videos =
  let
    hasTag video =
      (List.member model.tagFilter video.tags) || model.tagFilter == ""

    hasSpeaker video =
      (List.member model.speakerFilter video.speakers) || model.speakerFilter == ""

    bySpeaker =
      List.filter (hasSpeaker) videos

    byTag =
      List.filter (hasTag) bySpeaker
  in
    byTag
