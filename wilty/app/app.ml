open Js_of_ocaml
open Js_of_ocaml_tyxml.Tyxml_js
open React

(* APP LOGIC *)

module Ids = struct
  let liesInput = "liesInput"
  let lieCodeInput = "lieCodeInput"
  let truthsInput = "truthsInput"
end

let encode = Base64.encode_string ~alphabet:Base64.uri_safe_alphabet
let decode = Base64.decode_exn ~alphabet:Base64.uri_safe_alphabet

let text_to_encode_s, set_text_to_encode = S.create ""
let encoded_text_s = S.map encode text_to_encode_s
let wilty_s, set_wilty = S.create (true, "")

let value_of_input ~id =
  let input_opt = Dom_html.getElementById_exn id |> Dom_html.CoerceTo.input in
  let value_opt = Js.Opt.map input_opt (fun input -> Js.to_string (input##.value)) in
  Js.Opt.get value_opt (fun () -> "")

let value_of_textarea ~id =
  let input_opt = Dom_html.getElementById_exn id |> Dom_html.CoerceTo.textarea in
  let value_opt = Js.Opt.map input_opt (fun input -> Js.to_string (input##.value)) in
  Js.Opt.get value_opt (fun () -> failwith id)

let encode_text_handler _ =
  set_text_to_encode (value_of_textarea ~id:Ids.liesInput);
  false

let wilty_handler _ =
  let lies =
    value_of_input ~id:Ids.lieCodeInput
    |> decode
    |> String.split_on_char '\n'
  in
  let truths =
    value_of_textarea ~id:Ids.truthsInput
    |> String.split_on_char '\n'
  in
  let lies_and_truths =
    List.map (fun l -> false, l) lies @ List.map (fun t -> true, t) truths
  in
  set_wilty (List.nth lies_and_truths (Random.int (List.length lies_and_truths)));
  false
  

(* CONTENT *)

let send_lies_app =
  let open Html in
  div ~a:[a_class ["my-3"]] [
    label
      ~a:[a_label_for Ids.liesInput]
      [txt "Lie(s) to send, newline-separated:"];
    div ~a:[a_class ["input-group"]] [
      textarea ~a:[
        a_id Ids.liesInput;
        a_class ["form-control"];
        a_rows 3;
      ] (txt "");
      div ~a:[a_class ["input-group-append"]] [
        button ~a:[
          a_class ["btn"; "btn-primary"];
          a_button_type `Button;
          a_onclick encode_text_handler;
        ] [
          txt "Encode"
        ]
      ]
    ];
    div [
      txt "Lie code to send: (click to select all)";
    ];
    div ~a:[
      a_class ["user-select-all"; "bg-light"; "rounded"; "p-3"; "overflow-auto"];
    ] [
      R.Html.txt encoded_text_s
    ];
  ]

let wilty_app =
  let open Html in
  div ~a:[a_class ["my-3"]] [
    label
      ~a:[a_label_for Ids.lieCodeInput]
      [txt "Lie code you received:"];
    input ~a:[
      a_id Ids.lieCodeInput;
      a_class ["form-control"];
    ] ();
    label
      ~a:[a_label_for Ids.truthsInput]
      [txt "Truth(s) about yourself, newline-separated:"];
    textarea ~a:[
      a_id Ids.truthsInput;
      a_class ["form-control"];
      a_rows 3;
    ] (txt "");
    div ~a:[
      a_class ["m-3"; "text-center"];
    ] [
      button ~a:[
        a_class ["btn"; "btn-primary"];
        a_button_type `Button;
        a_onclick wilty_handler;
      ] [
        txt "Would I Lie to You?"
      ];
    ];
    div [
      R.Html.txt (S.map snd wilty_s)
    ]
  ]

let app =
  let open Html in
  div ~a:[a_class ["col-md-8"]] [
    h1
      ~a:[a_class ["text-center"]]
      [txt "Would I Lie to You?"];
    form [
      send_lies_app;
      hr ();
      wilty_app;
    ]
  ]
    

let () =
  Random.self_init ();
  let app_container = Dom_html.getElementById_exn "app" in
  Dom.appendChild app_container (To_dom.of_element app);
