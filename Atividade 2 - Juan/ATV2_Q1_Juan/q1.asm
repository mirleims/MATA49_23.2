; ATIVIDADE PRÁTICA 2 - QUESTÃO 1
; Juan Reis - 222115770

bits 64

section .bss
    nome resb 256   
    letra resb 1  

section .data
    msg1 db "Digite o nome: ",0
    msg2 db "Digite a letra: ",0
    msg3 db "Primeira letra do nome: ",0
    msg4 db "Última letra do nome: ",0
    msg5 db "Letra encontrada no nome.",0
    msg6 db "Letra não encontrada no nome.",10,0
    quebra_linha db 10 

section .text
    global _start

_start:

    ; exibe a mensagem "Digite o nome:"
    
    mov rax, 1            ; escrita
    mov rdi, 1            ; saida padrão
    mov rsi, msg1         ; ponteiro para a mensagem
    mov rdx, 14           ; tamanho da mensagem
    syscall

    ; lê o nome da entrada padrão
    
    mov rax, 0            ; leitura
    mov rdi, 0            ; entrada padrão
    mov rsi, nome         ; Ponteiro para o buffer de nome
    mov rdx, 256          ; tamanho do nome (coloquei o máximo)
    syscall

    ; exibe a mensagem "Digite a letra:"
    
    mov rax, 1            ; escrita
    mov rsi, msg2         ; ponteiro para a mensagem
    mov rdx, 15           ; tamanho da mensagem
    syscall

    ; lê a letra da entrada padrão
    
    mov rax, 0            ; leitura
    mov rsi, letra        ; ponteiro para o buffer de letra
    mov rdx, 1            ; leitura de apenas um caractere
    syscall

    ; encontra o comprimento do nome
    
    xor r12, r12          ; inicializa contador de comprimento
.loop:
    mov al, [nome + r12]  ; carrega o próximo caractere do nome
    cmp al, 0             ; verifica se é o caractere nulo 
    je .ultima_letra      ; se for, encontrou o último caractere
    inc r12               ; incrementa o contador
    jmp .loop

.ultima_letra:
    dec r12               ; decrementa para obter o índice do último caractere
                          ; aqui eu tava me batendo um pouco, porque em algum momento eu perdia esse caractere, ai coloquei no r12

    ; exibe a primeira letra do nome
    
    mov rax, 1            ; escrita
    mov rsi, msg3         ; ponteiro para a mensagem
    mov rdx, 24           ; tamanho da mensagem
    syscall
    mov rax, 1            ; escrita
    mov rdi, 1            ; saída padrão
    mov rsi, nome         ; ponteiro para o buffer de nome
    mov rdx, 1            ; leitura de apenas um caractere
    syscall

    ; adiciona uma quebra de linha
    
    mov rax, 1            ; escrita
    mov rdi, 1            ; saída padrão
    mov rsi, quebra_linha ; ponteiro para a quebra de linha
    mov rdx, 1            ; quebra de linha
    syscall

    ; exibe a última letra do nome
    
    mov rax, 1            ; escrita
    mov rdi, 1            ; saída padrão
    mov rsi, msg4         ; ponteiro para a mensagem
    mov rdx, 23           ; tamanho da mensagem
    syscall
    mov rax, 1            ; escrita
    mov rdi, 1            ; saída padrão
    lea rsi, [nome + r12 - 1] ; ponteiro para o último caractere do nome
    mov rdx, 1            ; escreve apenas um caractere
    syscall

    ; outra quebra de linha
    
    mov rax, 1            ; escrita
    mov rdi, 1            ; saída padrão
    mov rsi, quebra_linha ; ponteiro para a quebra de linha
    mov rdx, 1            ; quebra de linha
    syscall

     ; compara a letra com todo o nome
     
    xor rsi, rsi            ; zera o rsi (contador de posição no nome)
.compare_loop:
    mov al, [nome + rsi]    ; carrega o próximo caractere do nome
    cmp al, byte [letra]    ; compara com a letra dada na leitura
    je .letra_encontrada    ; se forem iguais, a letra foi encontrada
    inc rsi                 ; incrementa o contador de posição
    cmp byte [nome + rsi], 0 ; verifica se chegamos ao final da string
    jne .compare_loop       ; se não, continua comparando
    
    ; se chegamos ao final do nome e a letra não foi encontrada
    
    mov rax, 1     ; saída padrão
    mov rsi, msg6  ; ponteiro para a mensagem "Letra não encontrada"
    mov rdx, 29    ; tamanho da mensagem
    syscall

    ; sai do programa
    
    mov rax, 60             ; 
    xor rdi, rdi            ; 
    syscall

.letra_encontrada:
    mov rax, 1              ; saída padrão
    mov rsi, msg5           ; ponteiro para a mensagem "Letra encontrada no nome."
    mov rdx, 26             ; tamanho da mensagem
    syscall

    ; sai do programa
    
    mov rax, 60             ; 
    xor rdi, rdi            ; 
    syscall