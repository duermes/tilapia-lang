format ELF64

public main
extern printf

section '.data' writeable
    ; var def

section '.text' executable
    
main:
    mov     rax, 2
    mov     rbx, 3
    add     rax, rbx

    mov rsi, rax
    xor rax, rax
    call printf

    ; Aquí pondrías la lógica para imprimir si quieres (por ejemplo, llamar a printf)

    ret   ; main finishes with ret if files is an object .o
