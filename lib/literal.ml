type t = Bool of bool | Word of int64 | Byte of char | ByteString of string

let to_string = function
  | Bool b -> string_of_bool b
  | Word w -> Int64.to_string w
  | Byte c -> String.make 1 c
  | ByteString s -> s
