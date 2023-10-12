; ATIVIDADE PRÁTICA 2 - QUESTÃO 1
; ARTUR RODRIGUES MOTA - 221216931
; ARTHUR DOS SANTOS SILVA - 222115776

section .data
    msg1 db "Escreva um nome: ", 0
    msg2 db "Escreva uma letra: ", 0
    msg_encontrou1 db "A letra ", 0 
    msg_encontrou2 db " está no nome.", 0
    msg_nao_encontrou2 db " não está no nome.", 0
    msg_primeira_letra db "Primeira letra:", 0
    msg_ultima_letra db " Última letra: ", 0

section .bss
    ultima_letra resb 1
    nome resb 15 ; Setando máximo de 15 caracteres pro nome
    letra resb 1
section .text
    global _start

_start:
; Parte responsável por escrever a primeira mensagem
    mov rax, 1  
    mov rdi, 1  
    lea rsi, [msg1] 
    mov rdx, 17  
    syscall

; Parte responsável pegar o o nome (primeiro input!)
    mov rax, 0
    mov rdi, 0  
    lea rsi, [nome] 
    mov rdx, 15 
    syscall

; Parte responsável por escrever a segunda mensagem
    mov rax, 1  
    mov rdi, 1
    lea rsi, [msg2] 
    mov rdx, 19
    syscall
    
; Parte responsável pegar a letra
    mov rax, 0  
    mov rdi, 0 
    lea rsi, [letra] 
    mov rdx, 1
    syscall
      
; Tentando verificar se a letra está no nome
    mov rsi, nome ; usando registrador rsi para armazenar nome p operação
    mov al, byte [letra] ; usando byte para armazenar a letra
    xor rcx, rcx ; zera o registrador rcx


loop_busca:
    mov bl, byte [rsi] ; move um byte do rsi pra o registrador bl
    
    cmp bl, 0 ; verifica se já verificamos todos os caracteres da string
    je nao_encontrou
    
    cmp al, bl; verifica se o caracter armazenado em bl é igual a letra
    je encontrou
    
    inc rsi; 
    
    inc rcx 
    
    cmp rcx, 15 
    je nao_encontrou 
    
    jmp loop_busca

encontrou:
    mov rax, 1  
    mov rdi, 1  
    lea rsi, [msg_encontrou1]  
    mov rdx, 8
    syscall

    mov rax, 1  
    mov rdi, 1  
    lea rsi, [letra]
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    lea rsi, [msg_encontrou2]
    mov rdx, 15 
    syscall
    
    jmp primeira_e_ultima

nao_encontrou:
    mov rax, 1  
    mov rdi, 1  
    lea rsi, [msg_encontrou1]  
    mov rdx, 8
    syscall

    mov rax, 1  
    mov rdi, 1  
    lea rsi, [letra]
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    lea rsi, [msg_nao_encontrou2]
    mov rdx, 19 
    syscall
    
    jmp primeira_e_ultima


primeira_e_ultima:
; Imprime a primeira letra do nome
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_primeira_letra
    mov rdx, 15
    syscall
    
    mov rax, 1
    mov rdi, 1
    mov rsi, nome
    mov rdx, 1
    syscall

; Imprime última letra
    mov rcx, 0
    mov rdi, nome

    .calculaTamanho:
      cmp byte [rdi + rcx], 0
      je .imprimeUltima

      inc rcx
      jmp .calculaTamanho
    .end:
      ret
    
    .imprimeUltima:
      sub rcx, 2
      mov r8, [nome + rcx]
      mov [ultima_letra], r8
      
      mov rax, 1
      mov rdi, 1
      mov rsi, msg_ultima_letra
      mov rdx, 15 
      syscall
      
      mov rax, 1
      mov rdi, 1
      lea rsi, [ultima_letra]
      mov rdx, 1
      syscall

; Parte responsável por finalizar programa
    mov rax, 60  ; syscall número 60 (sys_exit), finaliza
    xor rdi, rdi  ; código de saída 0
    syscall

;nasm q1.asm -f elf64 && ld q1.o -o q1 && ./q1