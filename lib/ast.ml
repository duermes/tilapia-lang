(*Data types*)
type dtype =
  | Bytestring of string
  | Word of int64
  | Uword of int64
  | Byte of int64
  | Ubyte of int64
  | Bool of bool

(*Operators*)
type op =
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
  | RShift
  | LShift
  | And
  | Or

(*
 optionally, a variable can bebinitialized on decl (ToDo)
 *)
type expr =
  | Binop of op * expr * expr
  | Id of string
  | Literal of dtype
  | Function of string * expr list

type stmt =
  | Vardeclr of string * dtype
  | Assign of string * expr
  | If of expr * stmt list * stmt list option
  | Loop
  | Expr of expr
  | Break
