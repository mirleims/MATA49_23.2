;ATIVIDADE PRÁTICA 2 - QUESTÃO 2
;ANA CAROLINA BALBINO 219122154
;VICTOR MANOEL CONCEIÇÃO DE ALMEIDA - 219215657
;observação: Professora, por alguma razão (que espero que a senhora me ilumine), é necessário passar um parâmetro adiconal na compilação
;a parte do NASM é igual: nasm -f elf64 nome.asm -o nome.o
;porém na parte do linker, é necessário passar o parâmetro "-nostartfiles" no começo, ou dá segmentation fault: 
;gcc -nostartfiles -o nome nome.o -no-pie


section .data
    input db "%d %d %d", 0
    output db "%d", 10, 0
    var1 dq 0
    var2 dq 0
    var3 dq 0

section .text
    global main
    extern scanf, printf

main:
    mov rdi, input
    mov rsi, var1
    mov rdx, var2
    mov rcx, var3
    call scanf

    mov rdi, output
    mov rax, [var1]
    mov r8,365
    mul r8
    mov r9,rax
    mov r8,30
    mov rax,[var2]
    mul r8
    add rax,r9
    mov r9,[var3]
    add rax,r9
    mov rsi,rax
    call printf

    mov rax, 60        
    xor rdi, rdi       
    syscall
