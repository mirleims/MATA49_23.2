section .data
  msgAno db 'Anos: '
  msgAnoLen equ $-msgAno
  msgMes db 'Meses: '
  msgMesLen equ $-msgMes
  msgDia db 'Dias: '
  msgDiaLen equ $-msgDia
  resposta db 'Numero de dias totais: '
  respostaLen equ $-resposta
  diasTotais dq 1

section .bss
  anos resb 1
  meses resb 1
  dias resb 1

section .text
  global _start

_start:
  ; pergunta os anos
  mov rax, 1
  mov rdi, 1
  mov rsi, msgAno
  mov rdx, msgAnoLen
  syscall

  ; le os anos
  mov rax, 0
  mov rdi, 0
  mov rsi, anos
  mov rdx, 1
  syscall

  ; Limpar o buffer de entrada
  mov rax, 0          
  mov rdi, 0          
  lea rsi, [rsp - 2]  
  mov rdx, 2          
  syscall
  
  ; pergunta os meses
  mov rax, 1
  mov rdi, 1
  mov rsi, msgMes
  mov rdx, msgMesLen
  syscall

  ; le os meses
  mov rax, 0
  mov rdi, 0
  mov rsi, meses
  mov rdx, 1
  syscall
  
  ; Limpar o buffer de entrada
  mov rax, 0       
  mov rdi, 0          
  lea rsi, [rsp - 2]  
  mov rdx, 2          
  syscall

  ; pergunta os dias
  mov rax, 1
  mov rdi, 1
  mov rsi, msgDia
  mov rdx, msgDiaLen
  syscall

  ; le os dias
  mov rax, 0
  mov rdi, 0
  mov rsi, dias
  mov rdx, 1
  syscall

  ; Limpar o buffer de entrada
  mov rax, 0          
  mov rdi, 0          
  lea rsi, [rsp - 2]  
  mov rdx, 2         
  syscall

  ; Calcula dias totais
  imul rax, rax, 365 
  imul rbx, rbx, 30  
  add rax, rbx       
  add rax, rcx       

  ; Adiciona os dias totais acumulados a diasTotais
  add rax, [diasTotais]
  mov [diasTotais], rax

  ; Escreve a mensagem de resultado
  mov rax, 1
  mov rdi, 1
  mov rsi, resposta
  mov rdx, respostaLen
  syscall

  ; Escreve o numero do resultado
  mov rax, 1
  mov rdi, 1
  mov rsi, diasTotais
  mov rdx, 1
  syscall

  ; Saída do programa
  mov rax, 60
  xor rdi, rdi
  syscall