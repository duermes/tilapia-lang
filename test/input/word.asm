format ELF64 executable 3  ; valid exec for Linux x86_64

macro print description,number
{
   display description
   value=number
   pos=1000
   repeat 4
      digit=value/pos
      value=value-(digit*pos)
      pos=pos/10
      display ('0'+digit)
   end repeat
   display $d,$a
} 

segment readable writeable
msg: db 'hi', 10
num: dq 4
buffer rb 20       ; Buffer para la conversión a string
newline db 10 

msg_len = $ - msg; 


segment readable executable ; defines a segment that is readable and executable

entry main   ; entry point of the program

main:
    print " ", 12
    mov     rax, 1
    mov     rdi, 1       ; file descriptor for stdout
    mov     rsi, msg
    mov     rdx, msg_len
    syscall

    mov     rax, 60        ; syscall exit
    xor     rdi, rdi       
    syscall

