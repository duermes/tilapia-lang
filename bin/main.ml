open Tilapia

type opmode = Full | Parse

let () =
  let usage_msg = "tilapia [-p] [-o outfile] infile" in
  let mode = ref Full in
  let outfile = ref None in
  let infile = ref None in
  let etc_arg arg = if Option.is_none !infile then infile := Some arg in
  let speclist =
    [
      ("-p", Arg.Unit (fun _ -> mode := Parse), "Print parsed program and exit");
      ( "-o",
        Arg.String (fun name -> outfile := Some name),
        "Set output file name" );
    ]
  in
  Arg.parse speclist etc_arg usage_msg;
  match !mode with
  | Parse -> (
      match
        open_in (Option.get !infile)
        |> Lexing.from_channel |> Driver.parse_or_error
      with
      | Error msg -> Printf.printf "Failed to parse with error: %s" msg; exit 1
      | Ok ast -> Printer.print_program ast |> print_string)
  | _ -> assert false
