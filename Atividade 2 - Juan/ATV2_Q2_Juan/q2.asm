; ATIVIDADE PRÁTICA 2 - QUESTÃO 2
; Juan Reis - 222115770

global main
extern printf
extern scanf

section .data
    format_in db "%d", 0             
    format_out db "Sua idade total em dias é: %d", 10, 0 
    msg_anos db "Digite a sua idade em anos: ", 0    
    msg_meses db "Digite a sua idade em meses: ", 0   
    msg_dias db "Digite a sua idade em dias: ", 0    

section .bss
    anos resq 1      ; variável para armazenar os anos
    meses resq 1     ; ''     ''       ''      '' meses
    dias resq 1      ; ''     ''       ''      '' dias
    idade_dias resq 1 ; ''     ''       ''      '' a idade total em dias

section .text
    global _start

_start:

    ; pede a idade em anos
    
    mov rdi, msg_anos    ; formato em printf
    call printf          ; chamo a função para exibir a mensagem

    mov rdi, format_in   ; formato em scanf
    mov rsi, anos        ; configura o endereço da variável anos para armazenar a entrada
    call scanf           ; chamo a função para receber a idade em anos

    ; pede a idade em meses
    
    mov rdi, msg_meses   ; formato em printf
    call printf          ; chamo a função para exibir a mensagem

    mov rdi, format_in   ; formato em scanf
    mov rsi, meses       ; configura o endereço da variável meses para armazenar a entrada
    call scanf           ; chamo a função para receber a idade em meses

    ; pede a idade em dias
    
    mov rdi, msg_dias    ; formato em printf
    call printf          ; chamo a função para exibir a mensagem

    mov rdi, format_in   ; formato em scanf
    mov rsi, dias        ; configura o endereço da variável dias para armazenar a entrada
    call scanf           ; chamo a função para receber a idade em dias

    ; calculando a idade em dias
    
    mov rax, [anos]     ; carrego os anos em rax
    imul rax, 365       ; multiplico os anos por 365

    mov rcx, [meses]    ; carrego os meses em rcx
    imul rcx, 30        ; multiplico os meses por 30 

    add rax, rcx        ; carrego os dias em rax
    add rax, [dias]     ; ponho os dias adicionais

    mov [idade_dias], rax ; guardo a idade total em dias na variável apontada

    ; exibindo a idade total
    
    mov rdi, format_out  ; formato em printf
    mov rsi, [idade_dias] ; guardo a idade total em dias em rsi
    call printf          ; chamo a função para exibir a mensagem

    ; encerramento do programa
    
    mov rax, 60          ; 
    xor rdi, rdi         ; 
    syscall
