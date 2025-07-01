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
| Lte 
| Gte 
| And 
| Or 

val showOp : op -> string