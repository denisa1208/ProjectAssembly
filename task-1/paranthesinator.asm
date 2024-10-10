; Interpret as 32 bits code
[bits 32]

section .text
; int check_parantheses(char *str)
global check_parantheses
check_parantheses:
    push ebp
    mov ebp, esp
    pusha

    ; s-ul meu
    mov esi, [ebp + 8]

    ; parcurg sirul de caractere   
    xor eax, eax 

    ; contor paranteze []
    xor ecx, ecx

    ; contor paranteze ()
    xor edx, edx 

    ; contor paranteze {}
    xor edi, edi

while:
    xor ebx, ebx
    mov bl, byte [esi + eax]
    inc eax
    ; 91 e codul pentru [
    cmp ebx, 91
    je inc_1
    ; 93 e codul pentru ]
    cmp ebx, 93
    je dec_1
    ; 40 e codul pentru (
    cmp ebx, 40
    je inc_2
    ; 41 e codul pentru )
    cmp ebx, 41
    je dec_2
    ; 123 e codul pentru {
    cmp ebx, 123
    je inc_3
    ; 125 e codul pentru }
    cmp ebx, 125
    je dec_3
    jmp after_comapre

inc_1:
    inc ecx
    jmp after_comapre

dec_1:
    dec ecx
    jmp after_comapre

inc_2:
    inc edx
    jmp after_comapre

dec_2:
    dec edx
    jmp after_comapre

inc_3:
    inc edi
    jmp after_comapre

dec_3:
    dec edi
    jmp after_comapre



after_comapre:
    ; 0 este rezultatul
    cmp ebx, 0
    je end
    jmp while

end:
    xor eax, eax
    ; 0 e rezultatul
    cmp ecx, 0
    je comp_edx
    popa
    jmp mov1

comp_edx:
    ; 0 e rezultatul
    cmp edx, 0
    je comp_edi
    popa
    jmp mov1

comp_edi:
    ; 0 e rezultatul
    cmp edi, 0
    je after_end
    popa
    jmp mov1
    ; sa-nceapa concursul
after_end:
    popa
    xor eax, eax
    jmp after_end1

mov1:
    ; 1 e rezultatul
    mov eax, 1

after_end1:
    leave
    ret
