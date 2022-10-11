open Tyxml.Html

let f ~title:page_title ~body:page_body =
  html
    ~a:[a_lang "en"]
    (head
       (title (txt page_title))
       [
         meta ~a:[a_charset "utf-8"] ();
         meta
           ~a:
             [
               a_name "viewport";
               a_content "width=device-width, initial-scale=1, shrink-to-fit=no";
             ]
           ();
         link ~rel:[`Icon] ~href:"/static/vijay.jpg" ();
         link
           ~rel:[`Stylesheet]
           ~href:
             "https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
           ~a:
             [
               a_integrity
                 "sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk";
               a_crossorigin `Anonymous;
             ]
           ();
       ]
    )
    (body page_body)
