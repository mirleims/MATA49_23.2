; ATIVIDADE PRÁTICA 2 - QUESTÃO 2
; NOME TAUANE HELOISE FIGUEIREDO OLIVEIRA - 221215985

section .bss
    idade_dias resq 1
    anos resq 1
    meses resq 1
    dias resq 1

section .text 
  global main
  extern scanf, printf 

main:
    push rbp
    mov rbp, rsp
    mov rdi, input_ano
    call printf

    mov rdi, temp
    lea rsi, [anos]
    call scanf

    mov rdi, input_mes
    call printf

    mov rdi, temp
    lea rsi, [meses]
    call scanf

    mov rdi, input_dia
    call printf

    mov rdi, temp
    lea rsi, [dias]
    call scanf

    mov rax, [anos]
    mov rbx, [meses]
    imul rax, [ano]
    imul rbx, [mes]

    add rax, rbx
    add rax, [dias]

    mov [total_dias], rax

    mov rdi, resultado
    mov rsi, [total_dias]
    call printf

    leave
    ret


section .data
    input_ano db "Quantos anos completos você tem? ", 0
    input_mes db "Quantos meses completos você tem? ", 0
    input_dia db "E quantos dias você tem? ", 0
    resultado db "A sua idade em apenas dias é %d", 10, 0

    ano dd 365
    mes dd 30

    temp db "%d", 0
