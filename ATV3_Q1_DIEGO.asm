section .data
  msgAltura1 db 'Altura 1: '
  lenMsgAltura1 equ $-msgAltura1
  msgAltura2 db 'Altura 2: '
  lenMsgAltura2 equ $-msgAltura2
  msgAltura3 db 'Altura 3: '
  lenMsgAltura3 equ $-msgAltura3
  msgAltura4 db 'Altura 4: '
  lenMsgAltura4 equ $-msgAltura4
  fmt db "%lf", 0
  qtdAlturas dq 4.0

section .bss
  altura1 resq 1
  altura2 resq 1
  altura3 resq 1
  altura4 resq 1

section .text
  global main
  extern printf
  extern scanf

main:
  push rbp
  mov rbp, rsp

  ; Escrever altura1
  mov rax, 1
  mov rdi, 1
  mov rsi, msgAltura1
  mov rdx, lenMsgAltura1
  syscall

  ; Ler altura1
  mov rdi, fmt
  mov rsi, altura1
  call scanf

  ; Escrever altura2
  mov rax, 1
  mov rdi, 1
  mov rsi, msgAltura2
  mov rdx, lenMsgAltura2
  syscall

  ; Ler altura2
  mov rdi, fmt
  mov rsi, altura2
  call scanf

  ; Escrever altura3
  mov rax, 1
  mov rdi, 1
  mov rsi, msgAltura3
  mov rdx, lenMsgAltura3
  syscall

  ; Ler altura3
  mov rdi, fmt
  mov rsi, altura3
  call scanf

  ; Escrever altura4
  mov rax, 1
  mov rdi, 1
  mov rsi, msgAltura4
  mov rdx, lenMsgAltura4
  syscall

  ; Ler altura4
  mov rdi, fmt
  mov rsi, altura4
  call scanf

  ; Calcular a média das alturas
  movq xmm0, [altura1]
  movq xmm1, [altura2]
  movq xmm2, [altura3]
  movq xmm3, [altura4]
  addsd xmm0, xmm1
  addsd xmm0, xmm2
  addsd xmm0, xmm3
  divsd xmm0, [qtdAlturas]

  ; Imprimir a média das alturas
  mov rdi, fmt
  call printf

  leave
  ret
