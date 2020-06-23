open Helpers
open Tyxml.Html

let content =
  Template.f
    ~title:"Would I Lie to You?"
    ~body:[
      script
        ~a:[a_src "./app.js"]
        (txt "")
    ]
