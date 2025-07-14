open Ast
open Template
open Buffer

let code = create 50
let stackp = ref 0
let labelp = ref 0
let exitp = ref 0
let testp = ref 0

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
  |> add_string code

let asm_bool name n =
  let v = if n then "1" else "0" in
  "\t"^ name ^ ": dq " ^ v ^ "\n"
  |> add_string code

let asm_bytestring name n =
  "\t" ^ name ^ ": db " ^ n ^ ", 10\n" 
  ^ "\t"^ name ^"_len = $ -" ^ n
  |> add_string code


let asm_binop op =
  "    pop rbx\n" ^ "    pop rax\n" ^ op_instructions op ^ "    push rax\n"
  |> add_string code
let asm_load_var name n =
  name ^ ": dq " ^ Int64.to_string n ^ "\n" |> add_string code

let asm_fundef n = "code"
let codegenx86_main exp = asm_fundef "main"
let rec codegenx86_prog = function
  | []                              -> failwith "Codegenx86 requires a 'main' function."
  | FunDef {("main", args, body)}::ys -> codegenx86_main body
  | FunDef (name, args, body)::ys   ->
    codegenx86_func name args body;
    codegenx86_prog ys


let compile prog =
  reset code;
  add_string code codegen_prefix;
  add_string code codegen_main;

  add_string code codegen_suffix;
  output_buffer stdout code;
  ""
