open Helpers
open Tyxml.Html

let instructions = [
  h3 [txt "How to play"];
  p [
    txt "In a round of ";
    a ~a:[
      a_href "https://www.youtube.com/watch?v=B94q7gUu75k";
      a_target "_blank";
    ] [txt "Would I Lie To You"];
    txt ", the person whose turn it is reads a \
    statement to the other players. \
    The other players then take some time to ask the person questions about \
    the statement until they feel they can guess whether the statement is a \
    truth or a lie about the person. \
    Everyone makes their guess, then the person whose turn it \
    is reveals whether it was a truth or a lie. \
    Everyone who guessed correctly gets a point, and the person whose turn it \
    is gets a point for each person who guessed incorrectly. \
    Players take turns until everyone has gone. \
  "];
  p [txt "\
    This app helps with picking a statement to present when it's your turn. \
    Before playing, partner up with another player. \
    Come up with at least one truth about yourself and at least one \
    lie about your partner. \
    When playing, don't participate when it's your partner's turn, since \
    you'll already know whether you partner is telling a truth or lie. \
    Type the lie(s) for your partner into the \"Lies to send\" box and click \
    \"Encode\", then send the generated lie code to your partner. \
    Type the truth(s) about yourself into the \"Truth(s) about yourself\" box. \
    When you receive a lie code from your partner, paste it into the \
    \"Lie code you received\" box. \
    When it's your turn, click the \"Would I Lie to You?\" button and the app \
    will randomly pick a truth or lie for you to present to the other players. \
    The app removes this truth/lie from the corresponding input, so if \
    you play another turn, there isn't a chance of getting a truth/lie \
    you've already gotten. \
  "]
]

let content js =
  Template.f
    ~title:"Would I Lie to You?"
    ~body:[
      div ~a:[a_class ["container"]] [
        div ~a:[a_class ["row"; "justify-content-center"]] [
          div ~a:[a_class ["col-md-8"]] ([
            h1 ~a:[a_class ["text-center"]] [txt "Would I Lie to You?"];
            div ~a:[a_id "app"] []
          ] @ instructions)
        ];
      ];
      script (cdata_script js)
    ]
