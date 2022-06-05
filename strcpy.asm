bits    64
default rel

global  main

extern  printf
extern  scanf

section .data
    	inpfor  db "%s", 0
    	outfor  db "%s", 0xA, 0
    	adrfor  db "address: %X", 0xA,0

section .bss
    	input 	resb 1024
    	output 	resb 1024

section .text
    main:
		;stack offset    	
		sub     rsp, 8

		;get input
		lea     rdi, [inpfor]
		lea 	rsi, [input]
		mov 	rax, 0
		call    scanf wrt ..plt
			
		;print its address (only for demo)
		lea 	rdi, [adrfor]
		lea		rsi, input
		mov 	rax, 0
		call 	printf wrt ..plt

		;copy string
		lea 	rsi, [input]
		lea 	rdi, [output]
		mov 	rcx, 1024
		cld
		rep 	movsb
		
		;print output
		lea 	rdi, [outfor]
		lea		rsi, [output]
		mov 	rax, 0
		call 	printf wrt ..plt
		
		;print its address (only for demo)
		lea 	rdi, [adrfor]
		lea		rsi, output
		mov 	rax, 0
		call 	printf wrt ..plt

		;remove offset, return
		add		rsp, 8
		sub 	rax, rax
		ret
