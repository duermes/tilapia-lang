format ELF64 executable 3  ; valid exec for Linux x86_64
segment readable writeable
    number1: dq 2
    number2: dq 5
    bool1: dq 1
    bool2: dq 0
<<<<<<< HEAD
<<<<<<< HEAD
    string: db "Hola", 0
=======
>>>>>>> main
=======
    string: db "Hola", 0
>>>>>>> 3ae93a159f6d2f26febedc26bd39e609bcdf2543

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

