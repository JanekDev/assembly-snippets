bits 	64
default rel

global  main

extern 	printf
extern 	scanf

section .data
    	prompt	db 'k, x: ', 0
    	inpfor  db '%i %lf', 0
    	resfor	db 'e^x = %f', 10, 0
    
    	i       dd 1 ;i for loop
		;series variables
    	res		dq 1.0
    	num		dq 1.0
    	denom   dq 1.0

section .bss
    	k       resd 1 ;int
    	x       resq 1 ;double

section .text
	main:
		sub 	rsp, 8
		
		;print the prompt
		lea 	rdi, [prompt]
		mov 	al, 0
		call 	printf wrt ..plt
		
		;get the input
		lea 	rdx, [x]
		lea 	rsi, [k]
		lea 	rdi, [inpfor]
		mov 	al, 0
		call 	scanf wrt ..plt
		
	calc_loop:
		;loop condition
		mov 	eax, [k]
		cmp 	eax, [i]
		jl  	calc_loop_finished
		
		;multiply denominator by i to get the next factorial
		movss   xmm2, [i]
		CVTDQ2PD xmm2, xmm2
		movlpd 	xmm3, [denom]
		mulsd  	xmm3, xmm2
		movlpd 	[denom], xmm3
		
		;increase the power of numerator
		movlpd 	xmm1, [num]
		mulsd  	xmm1, [x]
		movlpd 	[num], xmm1
		
		;calculate the whole term and add it to the result
		movlpd 	xmm4, [res]
		divsd 	xmm1, xmm3
		addsd  	xmm4, xmm1
		movlpd 	[res], xmm4
		
		;increment the loop and go back to the beginning
		mov 	rcx,[i]
		inc 	rcx
		mov 	[i], rcx
		jmp 	calc_loop

	calc_loop_finished:
		;print the result
		movlpd 	xmm0, [res]
		lea    	rdi,  [resfor]
		mov    	al, 1
		call 	printf wrt ..plt
		
		;remove offset, return
		add   	rsp, 8
		sub   	rax, rax
		ret
