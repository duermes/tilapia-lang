open Ast
open Template
open Buffer

let code = create 50
let data_declr = create 50


let op_instructions = function
  | Plus -> "\tadd rax, rbx\n"
  | Minus -> "\tsub rax, rbx\n"
  | Times -> "\timul rax, rbx \n"
  | Divide ->  "\txor rdx, rdx\n" ^ "\tidiv rbx\n"
  | Mod     -> "\txor rdx, rdx\n" ^ "\txidiv rbx\n" ^ "\txmov rax, rdx\n"  (* rdx has module *)
  | Eq      -> "\tcmp rax, rbx\n" ^ "\txsete al\n" ^ "\txmovzx rax, al\n"           (* rax = (rax == rbx) ? 1 : 0 *)
  | GT      -> "\tcmp rax, rbx\n" ^ "\txsetg al\n" ^ "\txmovzx rax, al\n"           (* rax = (rax > rbx) ? 1 : 0 *)
  | LT      -> "\tcmp rax, rbx\n" ^ "\txsetl al\n" ^ "\txmovzx rax, al\n"           (* rax = (rax < rbx) ? 1 : 0 *)
  | NEq     -> "\tcmp rax, rbx\n" ^ "\txsetne al\n" ^ "\txmovzx rax, al\n"          (* rax = (rax != rbx) ? 1 : 0 *)
  | GEq     -> "\tcmp rax, rbx\n" ^ "\txsetge al\n" ^ "\txmovzx rax, al\n"          (* rax = (rax >= rbx) ? 1 : 0 *)
  | LEq     -> "\tcmp rax, rbx\n" ^ "\txsetle al\n" ^ "\txmovzx rax, al\n"          (* rax = (rax <= rbx) ? 1 : 0 *)
  | LAnd     -> "\tand rax, rbx\n"
  | LOr      -> "\tor rax, rbx\n"


let codegenx86_print _ =
  "\tmov rax, 1\n \tmov rdi, 1"
  |> add_string code

let print_string n =
  "\tmov rsi, "^ n ^ "\n\tmov rdx, " ^ n ^ "_len\n\tsyscall\n"
  |> add_string code

(*Numbers are printed during assembly*)
let print_word n = 
  "\t print \" \", "^ n ^ "\n"
  |> add_string code

(*constant build*)
let asm_word name n =
  "\t" ^ name ^ ": dq " ^ n ^ "\n"
  |> add_string data_declr

let asm_bool name n =
  let v = if n then "1" else "0" in
  "\t"^ name ^ ": dq " ^ v ^ "\n"
  |> add_string data_declr

let asm_bytestring name n =
  "\t" ^ name ^ ": db " ^ n ^ ", 10\n" 
  ^ "\t"^ name ^"_len = $ -" ^ n
  |> add_string data_declr


(*Push to rax var to use*)
let asm_push_var name =
"\tmov rax, [" ^ name ^ "]\n\tpush rax\n"
|> add_string code
let asm_op op =
  "    pop rbx\n" ^ "    pop rax\n" ^ op_instructions op ^ "    push rax\n"
  |> add_string code






let codegenx86_expr expr =
match expr with
| Literal (Word n) ->
    add_string code ("\tmov rax, " ^ Int64.to_string n ^ "\n")
| _ -> () 


let codegenx86_func (FunDef { id; args; body; retval; _ }) =
  add_string code ("; funcion: " ^ id ^ "\n");
  codegenx86_args args;
  Array.iter codegenx86_stmt body;
  (match retval with Some e -> codegenx86_expr e | None -> ());
  add_string code ("; fin funcion: " ^ id ^ "\n")


(*toplevel*)
let codegenx86_prog prog =
  let found_main = ref false in
  Array.iter (function
    | FunDef f when f.id = "main" ->
        found_main := true
    | FunDef f->
        codegenx86_func f
  ) prog;
  if not !found_main then
    failwith "Codegenx86 requires a 'main' function."

let compile prog =
  reset code;
  reset data_declr;
  add_string code codegen_prefix;
  output_buffer stdout data_declr;
  add_string code codegen_main;
  codegenx86_prog prog;
  add_string code codegen_suffix;
  output_buffer stdout code;
  ""
