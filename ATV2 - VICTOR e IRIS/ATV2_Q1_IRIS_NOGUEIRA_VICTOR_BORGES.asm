bits 64

global  _start

preparePrint:
    mov       rax, 1
    mov       rdi, 1
    xor       rsi, rsi

printWord:
    mov       rax, 1
    mov       rdi, 1
    mov       rdx, 1
    syscall

findLetter:
    mov       rcx, 0
    ; usa-se o r10b por ser um registrador de 8 bits, e possibilita a comparação byte a byte
    mov       r10b, byte[r8]
    mov       rbx, msgNaoEncontrado
    mov       r15, 23
    
    .loop:
        cmp       byte [nome + rcx], r10b
        je        .found
        
        cmp       byte [nome + rcx], 0
        je        .finish

        inc       rcx
        jmp       .loop

    .found:
        mov       rbx, msgEncontrado
        mov       r15, 18

        inc       rcx
        jmp       .loop

    .finish:  
    
    ret
    leave

section .text
    _start:     
        mov       rax, 1
        mov       rdi, 1
        mov       rsi, msgNome
        mov       rdx, 16
        syscall

        mov       rax, 0
        mov       rdi, 0
        mov       rsi, nome
        syscall

        mov       r9, nome

        mov       rax, 1
        mov       rdi, 1
        mov       rsi, msgLetra
        mov       rdx, 18
        syscall

        mov       rax, 0
        mov       rdi, 0
        mov       rsi, letra
        syscall

        mov       r8, letra

        call      findLetter
        
        mov       rax, 1
        mov       rdi, 1
        mov       rsi, msgPrimeiraLetra
        mov       rdx, 24
        syscall

        mov       rax, 1
        mov       rdi, 1
        mov       rsi, nome
        mov       rdx, 1
        syscall

        ; se não tiver essas duas linhas, o código quebra
        ;mov       rsi, msgDebugFunc
        ;call      printWord

        mov       rax, 1
        mov       rdi, 1
        mov       rsi, msgUltimaLetra
        mov       rdx, 24
        syscall

        dec       rcx
        add       r9, rcx
        
        mov       rax, 1
        mov       rdi, 1
        mov       rsi, r9
        mov       rdx, 2
        syscall

        mov       rax, 1
        mov       rdi, 1
        mov       rsi, rbx
        mov       rdx, r15
        syscall
        
        mov       rax, 60
        xor       rdi, rdi
        syscall

section   .data
    msgNome:            db    "Insira um nome: ", 10
    msgLetra:           db    "Insira uma letra: ", 10
    msgNaoEncontrado:   db    10, "Letra não encontrada", 10
    msgEncontrado:      db    10, "Letra encontrada", 10
    msgPrimeiraLetra:   db    "Primeira letra do nome: ", 10
    msgUltimaLetra:     db    10, "Última letra do nome: "
    ; tamNome:    equ   $-nome
    msgDebugFunc:       db    "", 0

section   .bss
    nome:       resb    100
    letra:      resb    2