let parse_or_error lexbuf =
  Parser.root Lexer.token lexbuf |> Result.ok
