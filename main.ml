let output_directory = "vrama628.github.io"
let repo_url = "https://github.com/vrama628/vijayramamurthy.me"

let write_file name content =
  let out = open_out (Filename.concat output_directory name) in
  output_string out content;
  close_out out

let () =
  let open Printf in
  printf "Deleting old contents of `%s`\n" output_directory;
  let () =
    assert (Sys.file_exists output_directory && Sys.is_directory output_directory);
    let old_contents = Sys.readdir output_directory in
    Array.iter (fun old_file ->
      if String.index_opt old_file '.' <> Some 0
      then Sys.remove (Filename.concat output_directory old_file)
    ) old_contents
  in
  printf "Writing CNAME and README.md\n";
  let () =
    write_file "CNAME" "vijayramamurthy.me";
    write_file "README.md" (String.concat "\n" [
      "This website was generated automatically.";
      "Don't make changes to this website directly.";
      sprintf "To work on this website, visit %s" repo_url;
    ])
  in
  printf "Generating HTML\n";
  let () = () in
  printf "SUCCESS! website written to %s\n" output_directory
