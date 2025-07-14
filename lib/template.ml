let codegen_prefix = "\nformat ELF64 executable 3\nsegment readable writeable\n"
let codegen_main = "\nsegment readable executable\nentry main \nmain: \n\n"

let codegen_suffix =
  "\n\
  \    mov rax, 60        ; syscall exit\n\
  \    xor rdi, 0       \n\
  \    syscall\n"
