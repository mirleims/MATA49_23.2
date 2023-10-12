section .data
  msgPergunta db 'Digite um Nome: '
  lenMsgPergunta equ $-msgPergunta
  msgPerguntaLetra db 'Digite uma Letra: '
  lenMsgPerguntaLetra equ $-msgPerguntaLetra
  msgEncontrada db 'Letra encontrada!'
  lenMsgEncontrada equ $-msgEncontrada
  msgNaoEncontrada db 'Letra nao encontrada!'
  lenMsgNaoEncontrada equ $-msgNaoEncontrada

section .bss
  nome resb 100
  lenNome equ $-nome
  letra resb 1

section .text
  global _start

_start:
  ; pergunta o nome
  mov rax, 1
  mov rdi, 1
  mov rsi, msgPergunta
  mov rdx, lenMsgPergunta
  syscall

  ; le o nome
  mov rax, 0
  mov rdi, 0
  mov rsi, nome
  mov rdx, lenNome
  syscall

  ; pergunta a letra
  mov rax, 1
  mov rdi, 1
  mov rsi, msgPerguntaLetra
  mov rdx, lenMsgPerguntaLetra
  syscall

  ; le a letra
  mov rax, 0
  mov rdi, 0
  mov rsi, letra
  mov rdx, 1
  syscall

; Início do loop para encontrar a letra
  xor rcx, rcx             ; Inicializa o contador para percorrer a string
.loop:
  
  movzx rax, byte [nome + rcx] 
  cmp al, [letra]               
  je encontrada
  inc rcx                  
  cmp byte [nome + rcx], 0 
  je nao_encontrada        
  jmp .loop                


encontrada:
  ; escrever letra encontrada
  mov rax, 1
  mov rdi, 1
  mov rsi, msgEncontrada
  mov rdx, lenMsgEncontrada
  syscall
  jmp _exit

nao_encontrada:
  ; escrever letra nao encontrada
  mov rax, 1
  mov rdi, 1
  mov rsi, msgNaoEncontrada
  mov rdx, lenMsgNaoEncontrada
  syscall

_exit:
  mov rax, 60
  xor rdi, rdi
  syscall
