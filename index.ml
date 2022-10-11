open Helpers
open Tyxml.Html

let intro_row =
  div
    ~a:[a_class ["row"; "my-3"]]
    [
      div
        ~a:[a_class ["col"; "text-center"]]
        [h1 ~a:[a_class ["display-1"]] [txt "Hi! I'm Vijay."]];
    ]

let info name content = div ~a:[a_class ["my-3"]] (h1 [txt name] :: content)

let work_info =
  info
    "Work"
    [
      div
        ~a:[a_class ["d-flex"; "justify-content-between"]]
        [
          div [a ~a:[a_href "https://www.osohq.com/"] [txt "Oso"]];
          div ~a:[a_class ["font-weight-light"]] [txt "2022 - current"];
        ];
      div
        ~a:[a_class ["d-flex"; "justify-content-between"]]
        [
          div
            [
              txt "Facebook/Meta on ";
              a ~a:[a_href "https://flow.org/"] [txt "Flow"];
            ];
          div ~a:[a_class ["font-weight-light"]] [txt "2019 - 2022"];
        ];
    ]

let writing_info =
  let writing name links source =
    div
      ~a:[a_class ["my-1"]]
      [
        div
          (txt (Printf.sprintf "\"%s\"" name)
          :: (List.map
                (fun (text, href) ->
                  [txt " ("; a ~a:[a_href href] [txt text]; txt ")"]
                )
                links
             |> List.flatten
             )
          );
        div ~a:[a_class ["text-right"; "font-weight-light"]] [txt source];
      ]
  in
  info
    "Writing"
    [
      writing
        "Why I don't play Pokemon"
        ["article", "https://www.osohq.com/post/why-i-dont-play-pokemon"]
        "Oso Blog, August 2022";
      writing
        "How I Implemented Type Inference for Request Validation"
        [
          ( "article",
            "https://www.osohq.com/post/type-inference-request-validation" );
        ]
        "Oso Blog, August 2022";
      writing
        "Program Equivalence for Assisted Grading of Functional Programs"
        [
          "pdf", "static/oopsla-2020.pdf";
          "extended version", "https://arxiv.org/pdf/2010.08051.pdf";
        ]
        "Published in OOPSLA 2020";
      writing
        "Zeus: Algorithmic Program Equivalence"
        ["pdf", "static/senior-thesis.pdf"]
        "Senior Honors Thesis, 2019";
    ]

let projects_info =
  info
    "Side Projects"
    [
      ul
        [
          li
            [
              a ~a:[a_href "http://dominai.io"] [txt "DominAI"];
              txt
                " A server that lets you write code to play the card game \
                 Dominion";
            ];
          li
            [
              a ~a:[a_href "/wilty"] [txt "Would I Lie to You?"];
              txt
                " An app for playing a party game based on a British game show";
            ];
        ];
    ]

let links_info =
  info "Links" [p [a ~a:[a_href "https://github.com/vrama628"] [txt "GitHub"]]]

let info_row =
  div
    ~a:[a_class ["row"; "my-3"; "justify-content-center"]]
    [
      div
        ~a:[a_class ["col-md-8"]]
        [work_info; writing_info; projects_info; links_info];
    ]

let content =
  Template.f
    ~title:"Vijay Ramamurthy"
    ~body:[div ~a:[a_class ["container"]] [intro_row; info_row]]
