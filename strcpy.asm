bits    64
default rel

global  main

; external functions from C standard library
extern  printf
extern  scanf

section .data
    formatter      db '%s'
    newline        db '\n'

section .bss
    input          resb 64
    output         resb 64

section .text
    main:
        sub     rsp, 8

        ; get input
        lea    rdi, [formatter]
        lea    rsi, [input]
        mov    rax, 0
        call   scanf wrt ..plt
