open Js_of_ocaml
open Js_of_ocaml_tyxml.Tyxml_js
(*open React
open ReactiveData*)

(* APP LOGIC *)

module Ids = struct
  let cell (r, c) = Printf.sprintf "cell-%d-%d" r c
end

let value_of_input ~id =
  let input_opt = Dom_html.getElementById_exn id |> Dom_html.CoerceTo.input in
  let value_opt = Js.Opt.map input_opt (fun input -> Js.to_string (input##.value)) in
  Js.Opt.get value_opt (fun () -> "")

let set_value_of_input ~id v =
  let input_opt = Dom_html.getElementById_exn id |> Dom_html.CoerceTo.input in
  Js.Opt.iter input_opt (fun input ->
    input##.value := Js.string v
  )

(*
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
  let num_lies, num_truths = List.length lies, List.length truths in
  if lies = [""] || truths = [""] then (
    set_wilty (Error "You must input at least one truth and at least one lie.");
  ) else (
    let i = Random.int (num_lies + num_truths) in
    if i < num_lies then (
      let (lie, remaining_lies) = pick lies i in
      set_wilty (Ok (Some (false, lie)));
      let new_lie_code =
        remaining_lies
        |> String.concat "\n"
        |> encode
      in
      set_value_of_input ~id:Ids.lieCodeInput new_lie_code
    ) else (
      let (truth, remaining_truths) = pick truths (i - num_lies) in
      set_wilty (Ok (Some (true, truth)));
      set_value_of_textarea ~id:Ids.truthsInput (String.concat "\n" remaining_truths)
    );
  );
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
      ~a:[a_label_for Ids.truthsInput]
      [txt "Truth(s) about yourself, newline-separated:"];
    textarea ~a:[
      a_id Ids.truthsInput;
      a_class ["form-control"];
      a_rows 3;
    ] (txt "");
    label
      ~a:[a_label_for Ids.lieCodeInput]
      [txt "Lie code you received:"];
    input ~a:[
      a_id Ids.lieCodeInput;
      a_class ["form-control"];
    ] ();
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
    R.Html.div ~a:[
      a_class ["bg-light"; "rounded"; "p-3"];
    ] (
      S.map (function 
        | Error msg -> [
            span ~a:[
              a_class ["text-danger"]
            ] [
              txt ("Error: " ^ msg)
            ]
          ]
        | Ok None -> []
        | Ok (Some (is_truth, stmt)) -> [
            txt (if is_truth then "Truth:" else "Lie:");
            br ();
            txt stmt
          ]
        ) wilty_s
      |> RList.from_signal
    )
  ] *)

let cell (r, c) =
  let open Html in
  input ~a:[
    a_style "width: 2em; height:2em";
    a_id (Ids.cell (r, c));
  ] ()

let square (r, c) =
  let open Html in
  div ~a:[
    a_class ["border"; "border-dark"; "d-inline-block"];
    a_style "width: calc(6em + 2px); height: calc(6em + 2px)";
  ] (List.init 9 (fun i -> cell (3*r + i/3, 3*c + i mod 3)))

let row r =
  let open Html in
  div (List.init 3 (fun c -> square (r, c)))

let board =
  let open Html in
  div ~a:[
    a_class ["d-flex"; "flex-column"; "justify-content-center"];
  ] (List.init 3 row)

let solve_handler =
  failwith "TODO"

let solve_button =
  let open Html in
  button ~a:[
    a_class ["btn"; "btn-primary"];
    a_button_type `Button;
    a_onclick solve_handler
  ] [
    txt "Solve"
  ]

let app =
  let open Html in
  form [
    board;
  ]
    

let () =
  let app_container = Dom_html.getElementById_exn "app" in
  Dom.appendChild app_container (To_dom.of_element app);
