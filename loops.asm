global main
 
extern printf
 
section .data
	fmtStr: db '%i',0xA,0

section .text
	main:
	
	mov		edx, 10			; Copy 10 to edx
	looping:
	push	edx				; Save edx by pushing into stack
	
	; Load the first argument into the stack
	sub     esp, 4			; Allocate space on the stack for one 4 byte parameter
	mov     [esp], edx		; Copy eax into the address of esp

	; Load the format string into the stack
	sub     esp, 4          ; Allocate space on the stack for one 4 byte parameter
	lea     eax, [fmtStr]	; Load string into eax
	mov     [esp], eax      ; Copy eax into the address of esp

	; Call printf
	call    printf          ; Call printf(3):
							; int printf(const char *format, ...);

	; Return the stack (pointer) to it's original position (0 elements)
	add     esp, 8			; Pop the stack (There were 2 "sub esp,4")
	
	pop		edx				; Pop the stack and assign value to edx
	dec		edx				; Decrement edx by 1
	cmp		edx, 0			; Is edx equal to 0? zf is set if edx is 0
	jnz		looping			; if flag does not have zf set, go to "looping"
	ret
