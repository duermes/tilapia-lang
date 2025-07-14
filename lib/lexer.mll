{
open Lexing
open Parser
<<<<<<< HEAD
=======

exception Error of string

let char_escape = function
  | 'b' -> '\b'
  | 'n' -> '\n'
  | 'r' -> '\r'
  | 't' -> '\t'
  | c -> c
>>>>>>> 9005f496f96e3b1f978829932c86af07d13f5852
}

let bool = "true" | "false"

let uint = ['0'-'9']
let int = '-'? uint

let id = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule token = parse
<<<<<<< HEAD
| '{' { LBRACE}
=======
| '{' { LBRACE }
>>>>>>> 9005f496f96e3b1f978829932c86af07d13f5852
| '}' { RBRACE }
| '(' { LPAREN }
| ')' { RPAREN }

| ',' { COMMA }
| ':' { COLON }
| ';' { SEMICOLON }

| "->" { ARROW }
<<<<<<< HEAD
=======
| "</3" { BREAK }
>>>>>>> 9005f496f96e3b1f978829932c86af07d13f5852

| "==" { EQ }
| "!=" { NEQ }
| "<=" { LEQ }
| ">=" { GEQ }
| "&&" { LAND }
| "||" { LOR }
| '+' { PLUS }
| '-' { MINUS }
| '*' { TIMES }
| '/' { DIVIDE }
| '%' { MOD }
| '<' { LT }
| '>' { GT }

| "bool" { BOOL }
| "word" { WORD }
| "bytestring" { BYTESTRING }
| "byte" { BYTE }

| "if" { IF }
| "else" { ELSE }

| "for" { FOR }
| "while" { WHILE }
| "do" { DO }

| "fish" { FUNC }
| "til" { LET }
| '\'' { lit_byte lexbuf }
| '"' { let buf = Buffer.create 16 in lit_bytestring buf lexbuf }

| bool as b { LIT_BOOL (Bool.of_string b) }
| int as i { LIT_WORD (Int.of_string i) }

| id as ident { ID ident }

| eof { EOF }

| _ as c { raise (Error (Printf.sprintf "Unexpected char: ~c" c)) }

and lit_byte = parse
| [^ '\\' '\''] as c '\'' { LIT_BYTE c }
| '\\' _ as c '\'' { LIT_BYTE (char_escape c) }
| _ { raise (Error "Invalid byte literal") }

and lit_bytestring buf = parse
| '"' { LIT_BYTESTRING (Buffer.contents buf) }
| '\\' _ as c { LIT_BYTE (char_escape c) }
| [^ '"' '\\']+ as s {
    Buffer.add_string buf s;
    lit_bytestring buf s
  }
| eof { raise (Error "Unterminated string literal") }
