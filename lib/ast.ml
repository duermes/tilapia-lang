(*Data types*)

module DType = struct 
  type t = 
    | Bytestring 
    | Word 
    | Uword
    | Byte 
    | Ubyte 
    | Bool 
end

module Literal = struct
  type t =
    | Bytestring of string
    | Word of int64
    | Uword of int64
    | Byte of int64
    | Ubyte of int64
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
type expr =
  | Binop of binop * expr * expr
  | Id of string
  | Literal of Literal.t
  | Function of string * expr list

type stmt =
  | VarDecl of string * expr option
  | Assign of string * expr
  | If of expr * stmt list * stmt list option
  | Loop
  | Expr of expr
  | Break

type program = stmt list
