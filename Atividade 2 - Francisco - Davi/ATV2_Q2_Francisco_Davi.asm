; ATIVIDADE PRÁTICA 2 - QUESTÃO 2
; NOME Davi Azevedo - 221215984
; NOME Francisco Carvalho - 222118878

section .data
    askAge db "Informe sua idade em anos, meses e dias", 10, 0
    outputFormat db "Sua idade em dias é %d.", 10, 0
    inputFormat db "%d %d %d",0
    
section .bss
  dias resq 1
  meses resq 1
  anos resq 1

section .text
global main
extern printf, scanf

main:
    push rbp
    mov rbp, rsp

    askForAge:
      mov rdi, askAge
      call printf

    getAge:
      mov rdi, inputFormat
      mov rsi, anos
      mov rdx, meses
      mov rcx, dias
      call scanf

    convertAge:
      mov r8, 365
      mov rax, [anos]
      mul r8
      add [dias], rax
  
      mov r10, 30
      mov rax, [meses]
      mul r10
      add [dias], rax

    printConvetedAge:
      mov rdi, outputFormat
      mov rsi, [dias]
      call printf
    
    leave
    ret