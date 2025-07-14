{
open Lexing
open Parser
}

let bool = "true" | "false"

let uint = ['0'-'9']
let int = '-'? uint

let id = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule token = parse
| '{' { LBRACE }
| '}' { RBRACE }
| '(' { LPAREN }
| ')' { RPAREN }

| ',' { COMMA }
| ':' { COLON }
| ';' { SEMICOLON }

| "->" { ARROW }

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

| "fish" { FUNC }
| "til" { LET }

| bool as b { LIT_BOOL (Bool.of_string b) }
| int as i { LIT_WORD (Int.of_string i) }

| id as ident { ID ident }
