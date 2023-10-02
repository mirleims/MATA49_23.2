; ATIVIDADE PRÁTICA 2 - QUESTÃO 1
; MAURICIO - 222217118
; JULIO CESAR - 222115783
; TALITA 222216218

section .data
    letra_prompt db "Letra??? ", 0
    nome_prompt db "Palavra??? ", 0
    ler_nome_fmt db "%s", 0
    saida_fmt db "primeira: %c", 0ah, "ultima: %c", 0ah, 0
    achou_msg db "achou", 0
    nao_achou_msg db "não achou", 0
    ler_letra_fmt db " %c", 0

section .bss
    _letra resb 1
    _palavra resb 100

section .text
    global main
    extern scanf
    extern printf
    extern fflush
    extern stdout
main:
    push rbp
    
    mov rbp, rsp

    mov rdi, letra_prompt
    call printf
    mov rdi, [stdout]
    call fflush
    mov rdi, ler_letra_fmt
    mov rsi, _letra
    call scanf
    mov rdi, nome_prompt
    call printf
    mov rdi, [stdout]
    call fflush
    mov rdi, ler_nome_fmt
    mov rsi, _palavra
    call scanf
    mov rsi, [_palavra]
    mov rax, _palavra

encontrar_ultima_letra:
    inc rax
    cmp byte [rax], 0
    jne encontrar_ultima_letra
    
    mov rdx, [rax-1]
    mov rdi, saida_fmt
    call printf

    mov rax, _palavra-1
    mov bl, byte [_letra]

procurar_letra:
    inc rax
    cmp byte [rax], 0
    je nao_encontrado
    cmp byte [rax], bl
    jne procurar_letra

encontrado:
    mov rdi,  achou_msg
    mov rsi, [_letra]
    mov rdx, _palavra
    call printf
    jmp retorno

nao_encontrado:
    mov rdi,  nao_achou_msg
    mov rsi, [_letra]
    mov rdx, _palavra
    call printf

retorno:
    leave
    ret


;clear && nasm -f elf64 main.asm && gcc main.o -o main -no-pie && ./main


