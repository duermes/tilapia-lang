{
    open Lexing
    open Parser
    exception SyntaxError of string
}


let byte = 
let ubyte =
let word = 
let bytestring = 
let id = 

rule token = parse 
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



