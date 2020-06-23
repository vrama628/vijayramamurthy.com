open Helpers
open Tyxml.Html

let intro_row =
  div ~a:[a_class ["row"]] [
    div ~a:[a_class ["col text-center"]] [
      h1 ~a:[a_class ["display-1"]] [
        txt "Hi!";
        br ();
        txt "I'm Vijay.";
      ]
    ]
  ]

let social_row =
  div ~a:[a_class ["row"]] [
    div ~a:[a_class ["col text-center"]] [
      a ~a:[a_href "https://github.com/vrama628"] [
        img
          ~a:[a_style "width: 2em"]
          ~src:"/static/icon-github.svg"
          ~alt:"GitHub"
          ()
      ]
    ]
  ]

let work_row =
  let flow_link content =
    a ~a:[a_href "https://flow.org/"] content
  in
  div ~a:[a_class ["row justify-content-center mt-3"]] [
    div ~a:[a_class ["col-sm-auto text-center"]] [
      txt "I work on ";
      flow_link [txt "Flow"];
      txt ".";
      br ();
      flow_link [
        img
          ~a:[a_style "max-width: 100px"]
          ~src:"/static/flow.svg"
          ~alt:"Flow"
          ()
      ]
    ]
  ]

let content = Template.f ~title:"Vijay Ramamurthy"
  ~body:[
    div ~a:[a_class ["container"]] [
      intro_row;
      social_row;
      work_row;
    ]
  ]
