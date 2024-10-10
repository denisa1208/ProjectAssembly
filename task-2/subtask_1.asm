; subtask 1 - qsort
section .text
    global quick_sort
    ;; no extern functions allowed
partitie:
    push ebp
    mov ebp, esp 
    xor ecx, ecx
    xor eax, eax
    xor ebx, ebx  
    xor edx, edx  
    ; low
    mov eax, [ebp + 20] 

    ; high
    mov ebx, [ebp + 16] 

    ; arr
    mov esi, [ebp + 12] 

    ; rezultatul
    mov ecx, [ebp + 8]   

    ; pivot
    mov edx, [esi + 4 * ebx] 
    mov ecx, eax
    ; i = low - 1
    dec ecx   
    push eax
    xor eax, eax
    ; j = low
    mov eax, [ebp + 20]

for:
    xor edi, edi
    ; 4 = sizeof(int)

    ; arr[j]
    mov edi, [esi + 4 * eax]
    cmp edi, edx
    jl swap
    jmp after_swap
swap:
    inc ecx
    ; arr[j] = edi
    push ebx
    xor ebx, ebx
    ; 4 = sizeof(int)
    ; arr[i] = ebx
    mov ebx, [esi + 4 * ecx]  

    push edi
    push ebx
    pop edi
    pop ebx
    ; 4 = sizeof(int)
    mov [esi + 4 * ecx], ebx
    ; 4 = sizeof(int)
    mov [esi + 4 * eax], edi
    pop ebx

after_swap:
    inc eax
    cmp eax, ebx
    jle for


    pop eax
    inc ecx
    ; swap(arr[i + 1], arr[high])
    xor edi, edi
    ; 4 = sizeof(int)
    ;arr[i + 1]
    mov edi, [esi + ecx * 4]
    xor edx, edx
    ; 4 = sizeof(int)
    mov edx, [esi + ebx * 4]
    push edi
    push edx
    pop edi
    pop edx
    ; 4 = sizeof(int)
    mov [esi + ecx * 4], edi
    ; 4 = sizeof(int)
    mov [esi + ebx * 4], edx
    leave
    ret

quick_sort:
    ;; create the new stack frame
    enter 0, 0
    pusha
    xor esi, esi
    xor eax, eax
    xor ebx, ebx

    ; vectorul
    mov esi, [ebp + 8]

    ; start = 0 sau low
    mov eax, [ebp + 12]

    ; end = n - 1 sau high
    mov ebx, [ebp + 16]

    cmp eax, ebx
    jl apel_recursiv
    jmp end


apel_recursiv:
    push eax
    push ebx
    xor ecx, ecx
    push esi
    push ecx
    call partitie
    xor edx, edx
    mov edx, ecx
    dec edx
    pop ecx
    pop esi
    pop ebx
    pop eax

    push edx
    push eax
    push esi
    call quick_sort
    ; 3 parametri => inaintez in stiva cu 3 * 4
    add esp, 12

    ; actualizez edx cu 2
    add edx, 2
    push ebx
    push edx
    push esi
    call quick_sort
    ; 3 parametri => inaintez in stiva cu 3 * 4
    add esp, 12

end:
    ;; save the preserved registers

    ;; recursive qsort implementation goes here

    ;; restore the preserved registers
    popa
    leave
    ret
