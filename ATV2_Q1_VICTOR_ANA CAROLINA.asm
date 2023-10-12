;ATIVIDADE PRÁTICA 2 - QUESTÃO 1
;ANA CAROLINA BALBINO 219122154
;VICTOR MANOEL CONCEIÇÃO DE ALMEIDA - 219215657
;Q1 - Elabore um código que leia um nome e uma letra. O código deve imprimir a primeira e última letra do nome e dizer se encontrou ou não a letra no nome.

section .data
global _start
    array db "Digite um nome",10    ; Array de string
    array_len equ $ - array   ; Tamanho do array em bytes
    
    target_value db "digite uma letra",10 ; Valor a ser comparado
    tamTarget equ 17
    
    prompt db 10,"Essa letra foi encontrada no nome",0
    tamPrompt  equ $-prompt
    
    promptneg db 10,"Essa letra NAO foi encontrada no nome",0
    tamPromptneg  equ $-promptneg
        
    letra_inicio db "Essa é a primeira letra do nome:" 
    letra_final db 10,"Essa é a ultima letra do nome: "
section .bss
  ultima resb 1
section .text

compare_loop:
    ; Compara o elemento atual com o valor al
    cmp byte [rsi], al]

    ; Pula para "encontrado" caso a letra esteja presente
    je found_value      ; Se forem iguais, o valor foi encontrado

    ; Se não forem iguais, avance para o próximo elemento
    inc rsi
    loop compare_loop
    
    ; Repita o loop até o final do array

not_found_value:

    ; Valor não foi encontrado
    mov rax, 1
    mov rdi, 1
    mov rsi, promptneg
    mov rdx, tamPromptneg
    syscall
    jmp exit
    
found_value:
    ; Valor foi encontrado

    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, tamPrompt
    syscall
    jmp exit
   
print_letra_final:
    mov rax, 1
    mov rdi, 1
    mov rsi, letra_final
    mov rdx, 32
    syscall
    
    mov rax, 1
    mov rdi, 1
    mov rsi, ultima
    mov rdx, 1
    syscall
    ret

find_letra_final:
    mov r11, 0
    .loop:
      cmp byte [r8+r11], 10
      je .end
      mov rax, [r8+r11]
      mov [ultima], rax
      inc r11
      jmp .loop      
    .end:
      call print_letra_final
      ret
      
_start:

    ; Escreve a mensagem para o usuário digitar um nome
    mov rax, 1
    mov rdi, 1
    mov rsi, array
    mov rdx, array_len
    syscall

    ; Lê o nome do usuário
    mov rax, 0
    mov rdi, 0
    mov rsi, array
    mov rdx, array_len
    syscall

    ; Escreve a mensagem para o usuário digitar uma letra
    mov rax, 1
    mov rdi, 1
    mov rsi, target_value
    mov rdx, tamTarget
    syscall
    
    ; Lê a letra do usuário
    mov rax, 0
    mov rdi, 0
    mov rsi, target_value
    mov rdx, 1
    syscall
    ; Escreve a primeira letra
    mov rax, 1
    mov rdi, 1
    mov rsi, letra_inicio
    mov rdx, 33
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, array
    mov rdx, 1
    syscall

    mov r8, array
    call find_letra_final
    
    ; Inicializa os registradores para o loop de comparação
    mov rcx, array_len   ; Contador do loop (tamanho do array)
    mov rsi, array       ; Ponteiro para o início do array
    mov al, [target_value] ; Valor a ser comparado
  
  call compare_loop
  exit:
  mov rax, 60
  xor rdi, rdi
  syscall  