{
    open Lexing
    open Parser
    exception SyntaxError of string
}


let byte = 
let ubyte =
let word = 
let bytestring = 
let id = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule token = parse 
| id { ID (Lexing.lexeme lexbuf) }     

(*Binary Operators*)
| '+' { PLUS }
| '-' { MINUS }
| '*' { TIMES }
| '/' { DIVIDE }
| '%' { MOD }
| "<<" { LSHIFT }
| ">>" { RSHIFT }
| '<' { LT }
| '>' { GT}
| "==" { EQTO }
| "!=" { NOTEQTO }
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

(*Reserved Symbols*)
| "til" { TYPE }
| "fish" { FUNC }
| "if" { IF }
| "else" { ELSE }
| "while" { WHILE }
| "do" { DO }
| "for" { FOR }
| "</3" { BREAK }



