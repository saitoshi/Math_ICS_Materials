; Solution for Programming Assignment #7

%include "asm_io.inc"

segment .data
        input_msg       db      "Enter an integer: ", 0
	msg_output      db	"The number of unique values is: ",0
        list_msg        db      "List:    ",0
        mod_10_msg      db      "sum(A[i] % 10): ",0
        is_even_msg      db      "sum(A[i] is even):   ",0

segment .bss
	Array	resd	10

segment .text
        global  asm_main
	

asm_main:
	enter	0,0			; setup
	pusha				; setup

	; Get integers
        mov     ecx, 10
        mov     esi, Array
input_loop:
        mov     eax, input_msg
        call    print_string
        call    read_int
        mov     [esi], eax
        add     esi, 4
        loop    input_loop

	; Call function printArray
	mov	eax, list_msg
	call	print_string
	push	dword 10
	push	Array
	call	printArray
	add	esp, 8

	; call function transformedsum with mod_10
	mov	eax, mod_10_msg
	call	print_string
	push	mod_10
	push	dword 10
	push	Array
	call	transformedSum
	add	esp, 12
	call	print_int
	call	print_nl

	; call function transformedsum with is_even
	mov	eax, is_even_msg
	call	print_string
	push	is_even
	push	dword 10
	push	Array
	call	transformedSum
	add	esp, 12
	call	print_int
	call	print_nl

	popa				; cleanup
	mov	eax, 0			; cleanup
	leave				; cleanup
	ret				; cleanup


mod_10:
	push	ebp
	mov	ebp, esp
	push	ecx
	push	edx
	mov	edx, 0
	mov	eax, [ebp+8]
	mov	ecx, 10
	idiv	ecx
	mov	eax, edx
	pop	edx
	pop	ecx
	pop	ebp
	ret

is_even:
	push	ebp
	mov	ebp, esp
	push	ebx
	mov	eax, 0
	mov	ebx, [ebp+8]
	shr	ebx, 1
	adc	eax, 0 
	neg	eax
	inc	eax
	pop	ebx
	pop	ebp
	ret
		

%include "hw8_functions.asm"
