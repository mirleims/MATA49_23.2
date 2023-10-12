global main
extern printf
extern scanf

section .bss
    anos resb 3
    meses resb 4
    dias resb 6

section .data
    mensagemFormatInt db "%d", 0
    mensagemAnos db "Insira os anos anos:", 10, 0    
    mensagemMeses db "Insira os meses:", 10, 0    
    mensagemDias db "Insira os dias:", 10, 0    
    mensagemTotalDias db "Idade em dias: %d dias", 10, 0
    
section .text
main:
    push rbp
    mov rbp, rsp

    mov rdi, mensagemAnos
    call printf
    
    mov rdi, mensagemFormatInt
    mov rsi, anos
    call scanf
    
    mov rbx, [anos]
    
    mov rdi, mensagemMeses
    call printf
    
    mov rdi, mensagemFormatInt
    mov rsi, meses
    call scanf
    
    mov r8, [meses]
    
    mov rdi, mensagemDias
    call printf
    
    mov rdi, mensagemFormatInt
    mov rsi, dias
    call scanf
    
    mov rax, 365
    mul rbx
    mov rbx, rax
    
    mov rax, 30
    mul r8
    
    add rax, rbx
    add rax, [dias]
    
    mov rdi, mensagemTotalDias
    mov rsi, rax
    call printf
    
    leave
    ret