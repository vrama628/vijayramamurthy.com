open Helpers
open Tyxml.Html

let content js =
  Template.f
    ~title:"Sudoku Solver"
    ~body:[
      div ~a:[a_class ["container"]] [
        div ~a:[a_class ["row"; "justify-content-center"]] [
          div ~a:[a_class ["col-md-8"]] [
            h1 ~a:[a_class ["text-center"]] [txt "Sudoku Solver"];
            div ~a:[a_id "app"] []
          ]
        ];
      ];
      script (cdata_script js)
    ]
