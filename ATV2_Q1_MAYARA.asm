; Atividade prática 2 - questão 1
; Aluna: Mayara Rodrigues
; N° matricula - 22221717
bits 64

global  _start

section   .data
    prompt1: db "Digite uma palavra:",10
    lenp1: equ $-prompt1

    prompt2: db "Digite uma letra:",10
    lenp2: equ $-prompt2

    f1: db "Letra inserida encontrada", 0
    lenf1: equ $-f1

    f2: db "Letra inserida nao encontrada", 0
    lenf2: equ $-f2

    space: db " ",0
    
    var1: db 0
section .bss
  palavra resb 100
  letra resb 1
  l1 resb 1
  lx resb 1
section .text
_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt1
    mov rdx, lenp1
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, palavra
    mov rdx, 100
    syscall
    
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt2
    mov rdx, lenp2
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, letra
    mov rdx, 1
    syscall


op1:
  mov rbx, [palavra]
  mov [l1], rbx
  mov rdi, 0
  mov al, [letra]
  jmp op2
op2:
  cmp byte[palavra+rdi], 0
  je done
  cmp byte[palavra+rdi], al
  je letra_encontrada
  inc rdi
  jmp op2
letra_encontrada:
  mov byte[var1], 1
  inc rdi
  jmp lp1
lp1:
  cmp byte[palavra+rdi], 0
  je done
  inc rdi
  jmp lp1

done:
  dec rdi
  dec rdi
  mov rsi, [palavra+rdi]
  mov [lx], rsi
  
  
  mov rax, 1
  mov rdi, 1
  mov rsi, l1
  mov rdx, 1
  syscall

  mov rax, 1
  mov rdi, 1
  mov rsi, space
  mov rdx, 1
  syscall
  
  mov rax, 1
  mov rdi, 1
  mov rsi, lx
  mov rdx, 1
  syscall

  mov rax, 1
  mov rdi, 1
  mov rsi, space
  mov rdx, 1
  syscall
  
  cmp byte[var1], 0
  
  jne encontrado
  je n_encontrado
encontrado:
  mov       rax, 1
  mov       rdi, 1
  mov       rsi, f1
  mov       rdx, lenf1
  syscall
  jmp end
n_encontrado:
  mov       rax, 1
  mov       rdi, 1
  mov       rsi, f2
  mov       rdx, lenf2
  syscall
  jmp end
end:
  mov       rax, 60
  xor       rdi, rdi
  syscall
