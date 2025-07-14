type t = Bool | Word | Byte | ByteString

let to_string = function
  | Bool -> "bool"
  | Word -> "word"
  | Byte -> "byte"
  | ByteString -> "bytestring"
