format ELF64 executable 3  ; valid exec for Linux x86_64


segment readable writeable
msg: db 'hi', 10
num: dq 4

msg_len = $ - msg; 


segment readable executable ; defines a segment that is readable and executable

entry main   ; entry point of the program

main:
    mov     rax, 1
    mov     rdi, 1       ; file descriptor for stdout
    mov     rsi, msg
    mov     rdx, msg_len
    syscall

    mov     rax, 60        ; syscall exit
    xor     rdi, rdi       
    syscall

