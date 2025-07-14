format ELF64 executable 3  ; valid exec for Linux x86_64
segment readable executable ; defines a segment that is readable and executable

entry main   ; entry point of the program

main:
    mov rax, 60        ; syscall exit
    xor rdi, 0       
    syscall