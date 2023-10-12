; ATIVIDADE PRÁTICA 2 - QUESTÃO 2
; ARTUR RODRIGUES MOTA - 221216931
; ARTHUR DOS SANTOS SILVA - 222115776

section .data
  msg_anos db "Quantos anos você tem?", 0

  msg_meses db "Quantos meses?", 0
  
  msg_dias db "Quantos dias?", 0

  intformat db "%d", 0

  msg_final db "sua idade em dias é %d", 0

section .bss
    idade_anos resb 2 
    idade_meses resb 2 
    idade_dias resb 2

section .text
  global main
  extern printf 
  extern scanf
main:
  push rbp
  mov rbp, rsp

; imprime pergunta "quantos anos?" e lê entrada
  mov rdi, msg_anos
  call printf

  mov rdi, intformat
  mov rsi, idade_anos
  call scanf

  mov rbx, [idade_anos]
  
; imprime pergunta "quantos meses?" e lê entrada
  mov rdi, msg_meses
  call printf

  mov rdi, intformat
  mov rsi, idade_meses
  call scanf

  mov r12, [idade_meses]

; imprime pergunta "quantos dias?" e lê entrada
  mov rdi, msg_dias
  call printf

  mov rdi, intformat
  mov rsi, idade_dias
  call scanf

; operacoes de multiplicacao
; multiplica a quantidade de anos por 365 e guarda o resultado no rcx
  mov rax, 365
  mul rbx
  mov rbx, rax

; multiplica a quantidade de meses por 30 e guarda o resultado no r8
  mov rax, 30
  mul r12

; operacoes de soma
  add rax, rbx
  add rax, [idade_dias]

; imprime resultado das operacoes
  mov rdi, msg_final
  mov rsi, rax
  call printf

;encerra o programa
  leave
  ret

;nasm q2.asm -f elf64 && gcc q2.o -o q2 -no-pie && ./q2