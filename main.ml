type page = {
  content : Html_types.html Tyxml_html.elt;
  path : string;
  has_js : bool;
}

(* CONSTANTS / WEBSITE LAYOUT *)

let output_directory = "vrama628.github.io"
let repo_url = "https://github.com/vrama628/vijayramamurthy.me"
let build_path = "_build/default"

let pages : page list = [
  {
    content = Index.content;
    path = "";
    has_js = false;
  };
  {
    content = Wilty.content;
    path = "wilty";
    has_js = true;
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

let doesn't_start_with_dot str =
  String.index_opt str '.' <> Some 0

let () =
  let open Printf in
  printf "Deleting old contents of `%s`\n" output_directory;
  let () =
    assert (Sys.file_exists output_directory && Sys.is_directory output_directory);
    FileUtil.ls output_directory
    |> List.filter (fun file -> FilePath.basename file |> doesn't_start_with_dot)
    |> FileUtil.rm ~recurse:true;
  in
  printf "Writing CNAME and README.md\n";
  let () =
    write_string_to_file (in_output "CNAME") "vijayramamurthy.me";
    write_string_to_file (in_output "README.md") (String.concat "\n" [
      "This website was generated automatically.";
      "Don't make changes to this website directly.";
      sprintf "To work on this website, visit %s" repo_url;
    ])
  in
  printf "Generating pages\n";
  List.iter (fun {content; path; has_js} ->
    let output_path = in_output path in
    FileUtil.mkdir ~parent:true output_path; 
    write_html_to_file (Filename.concat output_path "index.html") content;
    if has_js then
      let built_js =
        Filename.concat
          (Filename.concat build_path path)
          "app.bc.js"; 
      in
      let output_js = Filename.concat output_path "app.js" in
      FileUtil.cp [built_js] output_js
  ) pages;
  printf "SUCCESS! website written to %s\n" output_directory
