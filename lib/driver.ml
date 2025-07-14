let parse_or_error lexbuf =
  try Parser.root Lexer.token lexbuf |> Result.ok with
  | Lexer.LexError msg -> "Lexing error: " ^ msg |> Result.error
  | Parser.Error ->
      let pos = Lexing.lexeme_start_p lexbuf in
      let col = pos.pos_cnum - pos.pos_bol in
      Printf.sprintf "Syntax error in line %d, column %d: %s" pos.pos_lnum col
        (Lexing.lexeme lexbuf)
      |> Result.error
