let codegen_prefix = "\n
format ELF64 executable 3
\n 
macro print description,number\n
{\n
   display description\n
   value=number\n
   pos=1000\n
   repeat 4\n
      \tdigit=value/pos\n
      \tvalue=value-(digit*pos)\n
      \tpos=pos/10\n
      \tdisplay ('0'+digit)\n
   end repeat\n
   display $d,$a\n
}\n 
\nsegment readable writeable
\nbuffer rb 20
\nnewline db 10\n

"
let codegen_main = "\nsegment readable executable\nentry main \nmain: \n\n"

let codegen_suffix =
  "\n\
  \    mov rax, 60        ; syscall exit\n\
  \    xor rdi, 0       \n\
  \    syscall\n"
