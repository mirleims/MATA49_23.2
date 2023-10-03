; ATIVIDADE PRÁTICA 2 - QUESTÃO 1
; NOME Davi Azevedo - 221215984
; NOME Francisco Carvalho - 222118878

bits 64
section   .bss
    variable:  resb 10
    v: resb 1
   
  
    lastletter: resb 1
       
section .data
    msg1 db " sim", 0
    msg2 db " nao", 0
 

section .text

    _start:    
        mov       rax, 0
        mov       rdi, 0
        mov       rsi, variable
        mov       rdx, 10
        syscall
       
        mov       rax, 0
        mov       rdi, 0
        mov       rsi, v
        mov       rdx, 1
        syscall
       
        mov       rax, 1
        mov       rdi, 1
        mov       rsi, variable
        mov       rdx, 1
        syscall
         
percorre:
        inc r8
        mov cl, byte[variable + r8]
        cmp cl, 0
        je imprimir                
        jnz percorre            
       

imprimir:

  ; A ÚLTIMA LETRA ESTÁ NESSA POSIÇÃO
  ; EM -1 ESTÁ O 0 OU QUEBRA DE LINHA
  ; EM -2 ESTÁ O ÚLTIMO VALOR
 
        mov rcx, [variable + r8 -2]
        mov [lastletter], rcx
       
        mov rax, 1
        mov rdi, 1
        mov rsi, lastletter
        mov rdx, 1
        syscall
       

        mov al, [v]
        mov bl, [variable]
        mov rcx, rdi
        xor rdi, rdi
        cmp al, bl
        je encontrada
       
loop:
        inc rdi
        mov bl, [variable + rdi]
        cmp bl, 0
        je nao_encontrada
        cmp al, bl
        jnz loop
       

encontrada:
        mov rax, 1
        mov rdi, 1
        mov rsi, msg1
        mov rdx, 4
        syscall
        jmp fim

nao_encontrada:
        mov rax, 1
        mov rdi, 1
        mov rsi, msg2
        mov rdx, 4
        syscall
       


fim:
        mov       rax, 60
        mov       rdi, 0
        syscall
       
global  _start