; a program to create an "encoded" string through
; a 3-character lower-case input and 4-character string

%include "asm_io.inc"

segment .data

	; our lables for output
	; first is the 3-character string
	; second is the 4-character string
	message1 db "Enter a 3-character lower-case string: ", 0
	message2 db "Enter a 4-character string: ", 0
	resultant db "The encoded string is: xxxxxxxxxx", 0


segment .bss
	three_1	resb 1 ; inputted 3-character string
	three_2	resb 1
	three_3	resb 1
	four_1	resb 1 ; inputted 4-character string
	four_2	resb 1
	four_3	resb 1
	four_4	resb 1

segment .text
	global asm_main

asm_main:
	enter 0,0
	pusha

	mov	eax, message1 ; our first requested input (3-char string)
	call	print_string

	call	read_char ; reads the first char from the input
	mov	[three_1], al ; move the first character into ebx
	inc	ebx ; increment ebx

	call	read_char ; reads the second char
	mov 	[three_2], al
	inc	ebx

	call	read_char ; the third char
	mov	[three_3], al
	call	read_char

	mov 	eax, message2 ; our second requested input (4-char string)
	call	print_string

	call	read_char ; reads the first char from input
	mov	[four_1], al
	
	call	read_char ; second char from input
	mov	[four_2], al
	
	call	read_char ; third char from input
	mov	[four_3], al

	call	read_char ; fourth char from input
	mov	[four_4], al
	call	read_char ; this will serve as a buffer

	mov	eax, resultant ; point to the output string, aka our resultant
	add 	eax, 23 ; the first character of our output

	mov 	bl, [four_4] ; storing last char of our 4-string
	mov	[eax], bl
	inc	eax ; increment eax

	mov 	bl, [three_1] ; storing first char of our 3-string
	sub	bl, 020h ; making our 3-string character uppercase
	mov 	[eax], bl 
	inc	eax ; increment eax, make sure to repeat again
	mov 	[eax], bl
	inc 	eax ; increment eax
	; continue this for the next roughly 20 lines

	mov 	bl, [four_3] ; third char, 4-string
 	mov 	[eax], bl
	inc	eax

	mov	bl, [three_2] ; second char, 3-string
	sub	bl, 020h
	mov	[eax], bl
	inc 	eax
	mov	[eax], bl
	inc	eax

	mov	bl, [four_2] ; second char, 4-string
	mov	[eax], bl
	inc	eax

	mov 	bl, [three_3] ; third char, 3-string
	sub 	bl, 020h
	mov	[eax], bl
	inc	eax
	mov	[eax], bl
	inc	eax

	mov	bl, [four_1] ; first char, 4-string
	mov	[eax], bl
	; no need to increment after this

	mov	eax, resultant ; point eax to our resultant, giving the new combined output
	call	print_string ; print the above

	call	print_nl ; print new line
	popa
	mov	eax, 0
	leave
	ret


	
	
	
