type state = { buf : Buffer.t; depth : int ref }

let empty () = { buf = Buffer.create 16; depth = ref 0 }

let rec print_expression s = function
  | Ast.Literal l -> Literal.to_string l |> Buffer.add_string s.buf
  | Ast.Variable v -> Buffer.add_string s.buf v
  | Ast.BinOp (op, e1, e2) ->
      print_expression s e1;
      Ast.string_of_binop op |> Buffer.add_string s.buf;
      print_expression s e2
  | Ast.Call (func, args) ->
      Buffer.add_string s.buf "(call ";
      Buffer.add_string s.buf func;
      args
      |> Array.iter (fun arg ->
             Buffer.add_char s.buf ' ';
             print_expression s arg);
      Buffer.add_char s.buf ')'

let print_program prog =
  let s = empty () in
  (prog
  |> Array.iter @@ function
     | Ast.FunDef { id; args; rettyp; body = _; retval } ->
         s.depth := !(s.depth) + 1;
         Printf.bprintf s.buf "(defun %s (" id;
         args
         |> Array.iter (fun (arg, typ) ->
                Printf.bprintf s.buf "(%s %s) " arg (Typ.to_string typ));
         (if Array.length args > 0 then Buffer.(length s.buf |> truncate s.buf));
         Printf.bprintf s.buf ") %s\n" (Typ.to_string rettyp);
         retval |> Option.iter (fun e -> print_expression s e);
         Printf.bprintf s.buf ")\n";
         s.depth := !(s.depth) - 1);
  Buffer.contents s.buf

let _ : Ast.program -> string = print_program
