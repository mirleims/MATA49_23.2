; ATIVIDADE PRÁTICA 2 - QUESTÃO 2
; MAURICIO - 222217118
; JULIO CESAR - 222115783
; TALITA 222216218
;clear && nasm -f elf64 main.asm && gcc main.o -o main -no-pie && ./main

section .data
    input_prompt db "Digite três valores (dias, mês e anos): ", 0
    output_msg db "Total em dias: %d", 10, 0
    resposta db "%d", 10, 0
    date1 db "%d", 0
    date2 db "%d", 0
    date3 db "%d", 0

section .bss
    x resq 1
    y resq 1
    z resq 1
    total resq 1

section .text
    global main
    extern printf, scanf

main:
    push rbp
    mov rbp, rsp

    ; Imprime a mensagem de solicitação
    mov rdi, input_prompt
    call printf
    mov rsi, x
    mov rdi, date1
    call scanf
    mov rsi, y
    mov rdi, date2
    call scanf
    mov rsi, z
    mov rdi, date3
    call scanf

    mov rsi, [x]
    mov rax, [y] 
    mov rbx, 30
    mul rbx 
    add rsi, rax

    mov rax, [z]
    mov rbx, 365
    mul rbx
    add rsi, rax
    
    mov rdi, resposta
    call printf
   

    ; Termina o programa
    leave
    ret
