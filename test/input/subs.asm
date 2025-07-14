format ELF64 executable 3
entry main

segment readable writeable
buffer db 21 dup 0

segment readable executable
main:
    mov     rax, 20        
    mov     rbx, 42        
    sub     rax, rbx        
    mov     rcx, buffer+20 
    mov     byte [rcx], 10  
    dec     rcx            

    mov     rsi, rax      
    mov     rdx, 0
    mov     rdi, 0         

    test    rax, rax
    jns     convert
    neg     rsi            
    mov     rdi, 1        

convert:
    mov     rax, rsi
    xor     rdx, rdx
    mov     rbx, 10
    div     rbx
    add     dl, '0'
    mov     [rcx], dl
    dec     rcx
    mov     rsi, rax
    test    rax, rax
    jnz     convert

    cmp     rdi, 1
    jne     print
    mov     byte [rcx], '-'
    dec     rcx

print:
    inc     rcx           
    mov     rdx, buffer+21
    sub     rdx, rcx      
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, rcx
    syscall

    mov     rax, 60
    xor     rdi, rdi
    syscall
