; Interpret as 64 bits code
[bits 64]
; nu uitati sa scrieti in feedback ca voiati
; assembly pe 64 de biti

section .text
global map
global reduce


map:
    ; look at these fancy registers
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    push rdx
    push rcx
    push rbx
    push rax
    ; rdi = dest
    ; rsi = source
    ; rdx = len
    ; rcx = func
    ; rbx = 0
    xor rbx, rbx
    xor rax, rax

for_loop:

    push rdi
    xor rdi, rdi
    ; 8 = sizeof(int) pt 64 de biti
    mov rdi, [rsi + 8 * rbx]
    call rcx
    pop rdi
    ; 8 = sizeof(int) pt 64 de biti
    mov [rdi + 8 * rbx], rax
    inc rbx
    cmp rbx, rdx
    jl for_loop

    pop rax
    pop rbx
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    ; sa-nceapa turneu'
    leave
    ret


; int reduce(int *dst, int *src, int n, int acc_init, int(*f)(int, int));
; int f(int acc, int curr_elem);
reduce:
    ; look at these fancy registers
    push rbp
    mov rbp, rsp
    push r10
    push r11

    ; dest
    mov r10, rdi

     ; src
    mov r11, rsi

    ; n
    push rdx 

    ; acc_init
    push rcx

    ; func
    push r8 
    push rbx
    ; in rdi punem acc si in rsi elem_curent
    mov rdi, rcx
    xor rbx, rbx

for_loopR:
    push rdx
    xor rsi, rsi
    ; 8 = sizeof(int) pe 64 biti
    mov rsi, [r11 + 8 * rbx]
    call r8
    mov rdi, rax
    inc rbx
    pop rdx
    cmp rbx, rdx
    jl for_loopR

    pop rbx
    pop r8
    pop rcx
    pop rdx
    pop r11
    mov rax, rdi
    pop r10
    leave
    ret

