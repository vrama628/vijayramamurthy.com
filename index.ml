open Helpers
open Tyxml.Html

let intro_row =
  div ~a:[a_class ["row"; "my-3"]] [
    div ~a:[a_class ["col"; "text-center"]] [
      h1 ~a:[a_class ["display-1"]] [
        txt "Hi! I'm Vijay.";
      ]
    ]
  ]

let info name content =
  div ~a:[a_class ["my-3"]] (
    h1 [txt name] ::
    content
  )

let work_info =
  info "Work" [
    txt "I worked on ";
    a ~a:[a_href "https://flow.org/"] [txt "Flow"];
    txt " starting in July 2019 and chose to leave in January 2022 to take a few months off.";
    br ();
    txt "I plan to shift my focus to startup companies when I resume working.";
  ]

let papers_info =
  let paper name links source =
    div ~a:[a_class ["my-1"]] [
      div (
        txt (Printf.sprintf "\"%s\"" name) :: (
          List.map (fun (text, href) -> [
            txt " (";
            a ~a:[a_href href] [txt text];
            txt ")"
          ]) links
          |> List.flatten
        )
      );
      div ~a:[a_class ["text-right"; "font-weight-light"]] [
        txt  source
      ];
    ]
  in
  info "Papers" [
    paper
      "Program Equivalence for Assisted Grading of Functional Programs"
      [
        ("pdf", "static/oopsla-2020.pdf");
        ("extended version", "https://arxiv.org/pdf/2010.08051.pdf")
      ]
      "Published in OOPSLA 2020";
    paper
      "Zeus: Algorithmic Program Equivalence"
      [("pdf", "static/senior-thesis.pdf")]
      "Senior Honors Thesis, 2019"
  ]

let links_info =
  info "Links" [
    p [a ~a:[a_href "https://github.com/vrama628"] [txt "GitHub"]]
  ]

let info_row =
  div ~a:[a_class ["row"; "my-3"; "justify-content-center"]] [
    div ~a:[a_class["col-md-8"]] [
      work_info;
      papers_info;
      links_info;
    ]
  ]

let content = Template.f ~title:"Vijay Ramamurthy"
  ~body:[
    div ~a:[a_class ["container"]] [
      intro_row;
      info_row;
    ]
  ]
