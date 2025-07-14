let codegen_prefix =
  "\n\n\
   format ELF64 executable 3\n\n\
  \ \n\
   macro print description,number\n\n\
   {\n\n\
  \   display description\n\n\
  \   value=number\n\n\
  \   pos=1000\n\n\
  \   repeat 4\n\n\
  \      \tdigit=value/pos\n\n\
  \      \tvalue=value-(digit*pos)\n\n\
  \      \tpos=pos/10\n\n\
  \      \tdisplay ('0'+digit)\n\n\
  \   end repeat\n\n\
  \   display $d,$a\n\n\
   }\n\
  \ \n\n\
   segment readable writeable\n\n\
   buffer rb 20\n\n\
   newline db 10\n\n\n"

let codegen_main = "\nsegment readable executable\nentry main \nmain: \n\n"

let codegen_suffix =
  "\n\
  \    mov rax, 60        ; syscall exit\n\
  \    xor rdi, 0       \n\
  \    syscall\n"
