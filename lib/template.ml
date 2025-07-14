let codegen_prefix =  "
format ELF64 executable 3
segment readable writeable
"

let codegen_main = "
segment readable executable
entry main 
main: 

"

let codegen_suffix = "
    mov rax, 60        ; syscall exit
    xor rdi, 0       
    syscall
"