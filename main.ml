type content =
  | Page of Tyxml_html.doc (* pages without js to add *)
  | App of (string -> Tyxml_html.doc) (* pages with js to add *)
type page = {
  content : content;
  path : string;
}

(* CONSTANTS / WEBSITE LAYOUT *)

let output_directory = "vrama628.github.io"
let repo_url = "https://github.com/vrama628/vijayramamurthy.com"
let build_path = "_build/default"

let pages : page list = [
  {
    content = Page Index.content;
    path = "";
  };
  {
    content = App Wilty.content;
    path = "wilty";
  };
  {
    content = App Sudoku.content;
    path = "sudoku";
  };
]

(* WEBSITE GENERATION SCRIPT *)

let in_output name =
  Filename.concat output_directory name

let write_string_to_file name content =
  let out = open_out name in
  output_string out content;
  close_out out

let write_html_to_file name content =
  let out = open_out name in
  let fmt = Format.formatter_of_out_channel out in
  Tyxml.Html.pp () fmt content;
  close_out out

let read_string_from_file name =
  let in_ = open_in name in
  let content = really_input_string in_ (in_channel_length in_) in
  close_in in_;
  content

let doesn't_start_with_dot str =
  String.index_opt str '.' <> Some 0

let () =
  let open Printf in
  printf "Deleting old contents of %s\n" output_directory;
  let () =
    assert (Sys.file_exists output_directory && Sys.is_directory output_directory);
    FileUtil.ls output_directory
    |> List.filter (fun file -> FilePath.basename file |> doesn't_start_with_dot)
    |> FileUtil.rm ~recurse:true;
  in
  printf "Writing CNAME and README.md\n";
  let () =
    write_string_to_file (in_output "CNAME") "vijayramamurthy.com";
    write_string_to_file (in_output "README.md") (String.concat "\n" [
      "This website was generated automatically.";
      "Don't make changes to this website directly.";
      sprintf "To work on this website, visit %s" repo_url;
    ])
  in
  printf "Copying over ./static\n";
  FileUtil.cp ~recurse:true ["static"] output_directory;
  printf "Generating pages\n";
  List.iter (fun {content; path} ->
    let output_path = in_output path in
    FileUtil.mkdir ~parent:true output_path; 
    let html = 
      match content with
      | Page html -> html
      | App mk_html ->
        let js_path =
          Filename.concat
            (Filename.concat build_path path)
            "app/app.bc.js"; 
        in
        let js = read_string_from_file js_path in
        mk_html js
    in
    write_html_to_file (Filename.concat output_path "index.html") html
  ) pages;
  printf "SUCCESS! website written to %s\n" output_directory
