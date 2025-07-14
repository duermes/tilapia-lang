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
  | RShift  -> "\tshr rax, cl\n"       (* rbx in cl *)
  | LShift  -> "\tshl rax, cl\n"       (* rbx in cl *)
  | And     -> "\tand rax, rbx\n"
  | Or      -> "\tor rax, rbx\n"






  let compile prog = 
    reset code;
    add_string code codegen_prefix;
    add_string code codegen_main;

    codegen_prog prog;
    add_string code codegen_suffix;
    output_buffer stdout code;
    ""