let parse_or_error lexbuf =
  try Parser.root Lexer.token lexbuf |> Result.ok
  with Lexer.LexError msg -> "Lexer error: " ^ msg |> Result.error
