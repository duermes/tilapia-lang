type op =
| Plus
| Minus
| Times
| Mod 
| LeftShift
| RightShift
| Lt  
| Gt  
| Eq
| Neq 
| Lte (*Less than or equal <=*)
| Gte (*Greater than or equal >=*)
| And 
| Or 


let showOp op = 
  match op with
  | Plus -> "+"
  | Minus -> "-"
  | Times -> "*"
  | Mod -> "%"
  | LeftShift -> "<<"
  | RightShift -> ">>"
  | Lt -> "<"
  | Gt -> ">"
  | Eq -> "=="
  | Neq -> "!="
  | Lte -> "<="
  | Gte -> ">="
  | And -> "&&"
  | Or -> "||"