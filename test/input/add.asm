format ELF64 ; valid exec for Linux x86_64
entry main

segment readable executable
main:
    ;int1 dq 1
    ;int2 dq 2
    mov     rax, 2
    mov     rbx, 3
    add     rax, rbx
    mov rdi, rax
    mov     rax, 60        ; syscall exit   
    syscall