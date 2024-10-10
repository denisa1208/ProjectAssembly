; subtask 2 - bsearch

section .text
    global binary_search
    ;; no extern functions allowed

binary_search:
    ;; create the new stack frame
    enter 0, 0
    push ebx
    push edi
    xor eax, eax
    xor ebx, ebx
    ; low
    xor edi, edi

    ; high
    mov ebx, [ebp + 8]
    ; accesez elementul edi de la adresa [ebp + 12]
    mov edi, [ebp + 12]

    ; in ecx am vectorul
    ; in edx am elementul de cautat
    cmp ebx, edi
    jg end 
    xor eax, eax
    mov eax, edi
    sub eax, ebx
    ; impart la 2
    shr eax, 1

    ; eax = mid
    add eax, ebx
    ; 4 = sizeof(int)
    mov esi, [ecx + 4 * eax]
    cmp esi, edx
    je end
    jl act_low
    jmp act_high

act_low:
    xor ebx, ebx
    mov ebx, eax
    inc ebx
    jmp call_binary

act_high:
    xor edi, edi
    mov edi, eax
    dec edi

call_binary:
    push edi
    push ebx
    call binary_search
    pop ebx
    pop edi
    ; -1 = nu s-a gasit elementul


end:
    ; 0 = eax a ramas neschimbat
    cmp eax, 0
    jne final
    ; -1 = nu s-a gasit elementul
    mov eax, -1
final:
    push eax
    ;; restore the preserved registers
    pop eax
    pop edi
    pop ebx
    leave
    ret
