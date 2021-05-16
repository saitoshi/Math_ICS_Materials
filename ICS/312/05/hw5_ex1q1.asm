; This program does the questions in the exercise 1 of hw 5
; author: Shinya Saito
; class: ICS 312 Spring 2021
; date:

%include "asm_io.inc"

segment .data
	cmd		db	"Enter a string written in some language: ", 0

segment .bss
	count resd 26 ; counter array that stores 26 letters

segment .text
	global     asm_main

asm_main:
	enter 0,0
	pusha

	; question 1 counter the letter inputs
	mov eax, cmd
	call print_string

; the while loop
while:
	call read_char ; read the char
	cmp byte al, 00Ah ; compare with /n
	jz stop_reading ; if zf sets then jump to stop_reading
	cmp byte al, 'a'; compare the input with 'a'
	jge next_lower ; if ge then jump to next_lower
	cmp byte al, 'A'; otherwsie compare with 'A'
	jge next_cap ; if ge then jump to next_cap
	jmp while ; jump to the top

; function to compare with z
next_lower:
	cmp byte al, 'z' ; compare with lower case z
	jle lower_index ; if less than or equal to go to lower_index
	jmp while ; back to while

; function to compare with Z
next_cap:
	cmp byte al, 'Z'
	jle upper_index
	jmp while

; function to determine the index from lower case letters
lower_index:
	mov dx, 0
	mov bx, 'a' ; move bx = a
	div bx
	movzx ebx, dl
	inc dword [count + ebx * 4]
	jmp while

; function to determine the index from upper case letters
upper_index:
	mov dx, 0
	mov bx, 'A' ; move bx = A
	div bx ; divide ax with bx
	movzx ebx, dl
	inc dword [count + ebx * 4]
	jmp while


stop_reading:
	mov ecx, 000h
	jmp print_loop

print_loop:
	call print_nl
	mov eax, 'a' ;
	add eax, ecx ; eax = eax + ecx
	call print_char;
	mov eax, 03Ah ;
	call print_char ;
	mov eax, [count + ecx*4]
	call print_int
	mov eax, 020h
	call print_char
	inc ecx
	cmp ecx, 01Ah
	jc print_loop
	jmp close_program

close_program:
	call	print_nl	; print a new line
	popa
	mov	eax, 0
	leave
	ret
