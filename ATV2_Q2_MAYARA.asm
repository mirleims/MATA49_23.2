section .data
  prompt db "Inserir idade em anos, meses e dias: ", 0
  fmt db "%d",0
  prompt2 db "Inserir qtd anos: ", 0
  prompt3 db "Inserir qtd meses: ", 0
  prompt4 db "Inserir qtd dias: ", 0
section .bss
  anos resb 10
  meses resb 10
  dias resb 10
  total resb 100
section .text
  global main
  extern printf
  extern scanf
  
main:
mov byte[total], 0

push rbp
mov rbp, rsp

mov rdi, prompt
mov rax, 0
call printf

mov rdi, prompt2
mov rax, 0
call printf

mov rdi, fmt
mov rsi, anos
mov rax, 0
call scanf

mov rax, [anos]
mov rbx, 365
mul rbx
add [total], rax

mov rdi, prompt3
mov rax, 0
call printf

mov rdi, fmt
mov rsi, meses
mov rax, 0
call scanf

mov rax, [meses]
mov rbx, 30
mul rbx
add [total], rax

mov rdi, prompt4
mov rax, 0
call printf

mov rdi, fmt
mov rsi, dias
mov rax, 0
call scanf

mov rcx, [dias]
add [total], rcx

mov rdi, fmt
mov rsi, [total]
mov rax, 0
call printf

leave 
ret