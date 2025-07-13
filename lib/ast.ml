(*Data types*)

module DType = struct
  type t =
    | Bytestring
    | Word
    (* | Uword
    | Byte
    | Ubyte  *)
    | Bool
end

module Literal = struct
  type t =
    | ByteString of string
    | Word of int64
    | UWord of int64
    | Byte of int64
    | UByte of int64
    | Bool of bool
end

(*Operators*)
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
  | RShift
  | LShift
  | And
  | Or

(*
 optionally, a variable can bebinitialized on decl (ToDo)
 *)

(* I am missing declare the data type here Dtype.t *)

type expr =
  | Operation of binop * expr * expr (*e+e*)
  | Id of string (*x*)
  | Literal of Literal.t (*7, hello*)
  | FunctionCall of string * expr list
  | Empty

type fun_param = string * DType.t

type stmt =
  | VarDecl of DType.t * string * expr option (*x*)
  | Assign of string * expr
  | If of expr list * stmt list * stmt list option (*if e {} [else| else if] *)
  | Loop
  | Expr of expr
  | Break
  | FunctionDef of string * fun_param list * expr * stmt list
  | While of expr * stmt list
  | DoWhile of expr * stmt list
  | PrintWord of Literal.t
  | PrintString of Literal.t

type program = stmt list
