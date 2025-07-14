format ELF64 executable 3  ; valid exec for Linux x86_64
segment readable executable ; defines a segment that is readable and executable

entry main   ; entry point of the program

msg db 'Helloooooooooooo', 10
len equ $ - msg; to calculate how long will be the shit

main:
    mov     rax, 1
    mov     rdi, 1       ; file descriptor for stdout
    mov     rsi, msg
    mov     rdx, 13
    syscall

    mov     rax, 60        ; syscall exit
    xor     rdi, rdi       
    syscall

