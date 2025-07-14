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



let asm_word n =
  " \tdb " ^ n ^ ", 0\n"
  |> add_string code

let asm_bool b =
  let v = if b then "1" else "0" in
  "    mov rax, " ^ v ^ "\n    push rax\n"
  |> add_string code


let asm_binop op =
  "    pop rbx\n" ^
  "    pop rax\n" ^
  (op_instructions op) ^
  "    push rax\n"
  |> add_string code

let asm_load_var name n =
  name ^ ": dq " ^ (Int64.to_string n) ^ "\n"
  |> add_string code

let asm_print_rax =
  "    ; Aquí pondrías la rutina para convertir rax a string y llamar a syscall write\n"
  |> add_string code



let asm_fundef n = "code"

let codegenx86_main exp =
  asm_fundef "main"

let rec codegenx86 = function
| [] -> None
(* | FunDef{id="main"; args; rettyp; body; retval} -> codegenx86_main body *)

let compile prog =
  reset code;
  add_string code codegen_prefix;
  add_string code codegen_main;
  (* codegenx86 prog; *)
  add_string code codegen_suffix;
  output_buffer stdout code;
  "" 
