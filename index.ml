open Helpers
open Tyxml.Html

let content =
  Template.f
    ~title:"Vijay"
    ~body:[h1 [txt "Hi! I'm Vijay"]]
