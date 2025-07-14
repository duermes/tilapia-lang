type id = string

type binop =
  | Plus
  | Minus
  | Times
  | Divide
  | Mod
  | Eq
  | GT
  | LT
  | NEq
  | GEq
  | LEq
  | LAnd
  | LOr

type expr =
  | Literal of Literal.t
  | Variable of id
  | BinOp of binop * expr * expr
  | Call of id * expr array

type stmt =
  | VarDecl of { id : id; typ : Typ.t; init : expr option }
  | Assign of id * expr
  | If of { cond : expr; blk : stmt array; tail : stmt option }
  | Ignore of expr
  | For of { cond : expr; init : expr; step : stmt; body : stmt array }
  | While of expr * stmt array
  | DoWhile of expr * stmt array
  | Break

type fun_arg = id * Typ.t

type toplevel =
  | FunDef of {
      id : id;
      args : fun_arg array;
      rettyp : Typ.t;
      body : stmt array;
      retval : expr option;
    }

type program = toplevel array
