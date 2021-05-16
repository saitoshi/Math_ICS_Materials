; This simple program simply adds to 32-bit integers together
; and stores the results bac in memory

%include "asm_io.inc"

segment .data
	msg1    db      "Enter an integer: ", 0
 	msg2    db      "Binary representation: ", 0
 	msg3    db      "Semantic: ", 0
 	msg4    db      "YNGR/IPHN/HULU/SWRS count: ", 0
 	msg5    db      "*/ANDR/*/STRK count: ", 0
 	codes   db      "YNGR", 0, "OLDR", 0, "ANDR", 0, "IPHN", 0, "NFLX", 0, "HULU", 0, "SWRS", 0, "STRK", 0
 	four_spaces db  "    ",0
segment .bss
	input	resd  1     ; only 4 bytes!
segment .text
	global asm_main


asm_main:
	enter	0,0
	pusha
	; question 1 bitwise
	mov eax, msg1 ; mov eax to msg1
	call print_string ; prin the string associated to msg1
	call read_int ; read the user input interger
	mov [input], eax ; store the user input of integer
	mov eax, msg2 ; mov eax to point to message 2
	call print_string ; print the string associated to msg2
	mov ebx, [input]
	mov ecx , 020h
	mov edx, 004h

bit_conversion:
	shl ebx, 1 ; shift ebx to the left 1
	setc al ; if there is a carry set al
	movzx eax, al ; extend al to eax
	call print_int ; call print_int
	dec edx ; edx = edx - 1
	cmp edx, 0 ; compare edx with zero
	jg bitGet ; if greater then go to bitGet
	mov edx, 004h ; set edx as 040h
	mov eax, 020h ; mov eax as 020h (space)
	call print_char ; call print char

bitGet:
	loop bit_conversion
	call print_nl

close_program:
	call	print_nl	; print a new line
	popa
	mov	eax, 0
	leave
	ret
