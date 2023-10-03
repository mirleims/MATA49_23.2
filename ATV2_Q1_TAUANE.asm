; ATIVIDADE PRÁTICA 2 - QUESTÃO 1
; NOME TAUANE HELOISE FIGUEIREDO OLIVEIRA - 221215985

section .bss
  frase resb 64
  letra resb 1
  ultLetra resb 8
  cade resb 1

global _start

section .text
  _start:
    ;mensagem na tela
    mov rax, 1
    mov rdi, 1
    mov rsi, pergunta_frase
    mov rdx, pergunta_frase_len
    syscall

    ;ler frase
    mov rax, 0
    mov rdi, 0
    mov rsi, frase
    mov rdx, 64
    syscall

 	  ;mensagem na tela
    mov rax, 1
    mov rdi, 1
    mov rsi, pergunta_letra
    mov rdx, pergunta_letra_len
    syscall

 	  ;ler letra
    mov rax, 0
    mov rdi, 0
    mov rsi, letra
    mov rdx, 1
    syscall

    ;imprime letra inicial
    mov rax, 1
    mov rdi, 1
    mov rsi, frase
    mov rdx, 1
    syscall

 	;comparação com a letra
  	xor rcx, rcx
    quantidade_de_caracter:
        mov al, byte [rsi + rcx]
        cmp al, 10
		lea rbx, [rsi + rcx - 1]
        je termino_da_contagem
		cmp al, byte [letra]
  		je letra_igual
        inc rcx
        jmp quantidade_de_caracter

	letra_igual:
 	mov byte [achou], 0
  	inc rcx
  	jmp quantidade_de_caracter
   
    termino_da_contagem:
	; imprime ultima letra
	mov rax, 1
    mov rdi, 1
	mov rsi, "/n"
    mov rdx, 2
 
 	mov rax, 1
    mov rdi, 1
	mov rsi, rbx
    mov rdx, 1
    syscall

 	cmp byte [achou], 0
  	je print_achou

   	print_nao_achou:
	mov rax, 1
    mov rdi, 1
    mov rsi, nao_achou
    mov rdx, nao_achou_len
    syscall
	jmp fim

 	print_achou:
  	mov rax, 1
    mov rdi, 1
    mov rsi, achou
    mov rdx, achou_len
    syscall 	

    ;finaliza o programa
	fim:
    mov rax, 60
    xor rdi, rdi
    syscall

section .data
  pergunta_frase: db "Escreva um nome qualquer "
  pergunta_frase_len equ $ - pergunta_frase
  pergunta_letra: db "Escreva uma letra qualquer "
  pergunta_letra_len equ $ - pergunta_letra
  achou: db "  A letra está no nome. "
  achou_len equ $ - achou
  nao_achou: db " A letra não está no nome."
  nao_achou_len equ $ - nao_achou

  ; nasm ATV2_Q1_TAUANE.asm -f elf64 && ld ATV2_Q1_TAUANE.o -o ATV2_Q1_TAUANE && ./ATV2_Q1_TAUANE
