
%include "asm_io.inc"

segment .bss
	Array	resd	10

segment .data
	input_msg	db	"Enter an integer: ", 0
        list_msg        db      "List:    ",0


segment .text
        global  asm_main

asm_main:
	enter	0,0			; setup
	pusha				; setup

	; Get integers
	mov	ecx, 10
	mov	esi, Array
input_loop:
	mov	eax, input_msg
	call	print_string
	call	read_int
	mov	[esi], eax
	add	esi, 4
	loop	input_loop
	
	; Print message
	mov	eax, list_msg
	call	print_string

	; Call function printArray
	push	dword 10
	push	Array
	call	printArray
	add	esp, 8

	popa				; cleanup
	mov	eax, 0			; cleanup
	leave				; cleanup
	ret				; cleanup

%include "hw8_functions.asm"

