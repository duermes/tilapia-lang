format ELF64 executable 3  ; valid exec for Linux x86_64
segment readable writeable
    number1: dq 2
    number2: dq 5
    bool1: dq 1
    bool2: dq 0
<<<<<<< HEAD
    string: db "Hola", 0
=======
>>>>>>> main

segment readable executable ; defines a segment that is readable and executable

entry main   ; entry point of the program

main:
    mov     rax, [number1]
    mov     rbx, [number2]
    add     rax, rbx

    mov     rdi, rax

    mov rax, 60        ; syscall exit
    xor rdi, 0       
    syscall

