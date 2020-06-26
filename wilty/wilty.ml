open Helpers
open Tyxml.Html

let content =
  Template.f
    ~title:"Would I Lie to You?"
    ~body:[
      div ~a:[a_class ["container"]] [
        div ~a:[
          a_class ["row"; "justify-content-center"];
          a_id "app";
        ] []
      ];
      script
        ~a:[a_src "./app.js"]
        (txt "")
    ]
