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

; the iniital parts for question 2
question2_initial:
	mov eax, msg3 ; mov eax to point to msg3
	call print_string
	call print_nl
	mov ebx, [input]
	mov ecx, 008h

; function area for question2 printing the semantic
question_2:
	mov eax, four_spaces ; poitn eax to the four_spaces
	call print_string ; print four_spaces
	shl ebx, 1 ; shift ebx 1 to the left
	setc al ; if there is carry set al
	cmp al, 1 ; compare al to 1
	je b1_Older ; if equal then jump to b1 older
	mov eax, codes ; otherwise point eax to older
	jmp b2

b1_Older:
	mov eax, codes+5 ; point eax to Older in codes
	jmp b2 ; jump to b2

b2:
	call print_string ; print for b1
	mov eax, 020h ; point eax to 020h
	call print_char ; print the char
	shl ebx, 1 ; shift ebx to teh left 1
	setc al ; set al if there is carry
	cmp al, 1 ; compare al to 1
	je b2_IPHN ; if equal then jump to b1 older
	mov eax, codes + 10 ; otherwise point eax to older
	jmp b3

b2_IPHN:
	mov eax, codes + 15
	jmp b3

b3:
	call print_string
	mov eax, 020h ; point eax to 020h
	call print_char ; print space
	shl ebx, 1 ; shift ebx to teh left 1
	setc al ; set al if there is carry
	cmp al, 1 ; compare al to 1
	je b3_HULU ; if equal then jump to b1 older
	mov eax, codes + 20 ; otherwise point eax to older
	jmp b4

b3_HULU:
	mov eax, codes + 25 ; point eax to where codes contain HULU
	jmp b4 ; jump to b4

b4:
	call print_string
	mov eax, 020h ; point eax to 020h
	call print_char ; print space
	shl ebx, 1 ; shift ebx to teh left 1
	setc al ; set al if there is carry
	cmp al, 1 ; compare al to 1
	je b4_STRK ; if equal then jump to b1 older
	mov eax, codes + 30 ; otherwise point eax to older
	jmp q2_check ; jump to q2_check

b4_STRK:
	mov eax, codes+35 ; point eax to where codes has STRK
	jmp q2_check

q2_check:
	call print_string
	call print_nl
	dec ecx
	cmp ecx, 0
	je question3_preops ; close the program if finish
	jmp question_2

; area to do question 3
question3_preops:
  mov ebx, [input] ; store input into ebx
  mov ecx, 008h ; have ecx point to 8 as an index marker
  mov edx, 000h ; have edx point to 0 to serve as a counter
  jmp question_3 ; jump to question_3

; are to directly work on queestion 3
question_3:
  mov eax, 00Fh ; point eax to 00Fh
  and eax, ebx ; take the AND of eax and ebx
  cmp eax , 006h ; compare eax with 006h (0110b)
  jne Q3_SHIFT ; if not equal jump to
  inc edx ; increment edx

Q3_SHIFT:
  shr ebx, 4 ; shift ebx to the 4 to the right
  loop question_3
  mov eax, msg4 ; point eax to msg4
  call print_string
  mov eax, edx ; mov eax to edx
  call print_int ; print the integer
  call print_nl ; print a new line
  jmp close_program




close_program:
	call	print_nl	; print a new line
	popa
	mov	eax, 0
	leave
	ret
