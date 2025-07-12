{
    open Lexing
    open Parser
    exception SyntaxError of string
}


(*let byte = 
let ubyte =  *)
let uint = ['0'-'9']+
let int = '-'? uint
(* let c_delimiter = ["'"] 
let c_content = [^ ''']* *)

let white = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"

let str_delimiter = ['"']
let str_content = [^ '"']*

let id = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule token = parse  
| id { ID (Lexing.lexeme lexbuf) }     
(*Literals*)
(*| bytestring { LBYT {Lexing.lexeme lexbuf} }*)
| str_delimiter { DOUBLE_QUOTE }
| str_content as s { LBYTESTRING (Lexing.lexeme lexbuf) }    (*Returns the complete matched re*)
(* | c_delimiter { QUOTE }
| c_content as s {  } *)
| int as s { LWORD  ( int_of_string (Lexing.lexeme lexbuf)) }

| [' ' '\t']+ { read lexbuf }
| newline { read lexbuf }

(*Data Type Token WE ARE JUST USING AT FIRST WORD AND BYTESTRING*)
(* | "byte" { BYTE }
| "ubyte" { UBYTE } *)
| "word" { WORD }
(* | "uword" { UWORD } *)
| "bytestring" { BYTESTRING }

(*Binary Operators*)
| '+' { PLUS }
| '-' { MINUS }
| '*' { TIMES }
| '/' { DIVIDE }
| '%' { MOD }
| "<<" { LSHIFT }
| ">>" { RSHIFT }
| '<' { LT }
| '>' { GT }
| "==" { EQ }
| "!=" { NEQ }
| "<=" { LEQ }
| ">=" { GEQ }
| "&&" { AND }
| "||" { OR } 

| '=' { ASG }
| ':' { COLON }
| ';' { SEMICOLON }
| '"' { DOUBLE_QUOTE }
| '(' { LPAREN }
| ')' { RPAREN }
| '{' { LBRACE }
| '}' { RBRACE }
| ',' { COMMA }

(*Reserved Symbols*)
| "til" { TYPE }
| "fish" { FUNC }
| "if" { IF }
| "else" { ELSE }
| "while" { WHILE }
| "do" { DO }
| "for" { FOR }
| "</3" { BREAK }
| "->" { ARROW }



