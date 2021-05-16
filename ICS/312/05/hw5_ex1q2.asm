; This program does the questions in the exercise 1 of hw 5
; author: Shinya Saito
; class: ICS 312 Spring 2021
; date:

%include "asm_io.inc"

segment .data
	cmd		db	"Enter a string written in some language: ", 0

segment .bss
	count resd 26 ; counter array that stores 26 letters
	order resd 27 ; array to store the maximum order

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
	cmp byte al, 'Z' ; compare with 'Z'
	jle upper_index ; if it is less than or equal to go to upper_index
	jmp while ; otherwise jump back to while

; function to determine the index from lower case letters
lower_index:
	mov dx, 0 ; mov dx to 0
	mov bx, 'a' ; move bx = a
	div bx ; divide ax/bx
	movzx ebx, dl ; extend dl into ebx
	inc dword [count + ebx * 4] ; increment count[index]
	jmp while ; jump back to while

; function to determine the index from upper case letters
upper_index:
	mov dx, 0
	mov bx, 'A' ; move bx = A ; mov bx = A
	div bx ; divide ax with bx
	movzx ebx, dl ; store the remainder
	inc dword [count + ebx * 4]
	jmp while


stop_reading:
	mov ecx, 000h
	call print_nl
	jmp print_loop

print_loop:
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
	jmp question_2

; question 2 print the max to min count of letters
question_2:
	call print_nl ; print a new line
	mov ecx, 000h ; point ecx to 0 where ecx is the i in the for print_loop

store_Max:
	mov ebx, 000h ; ebx = 0
	mov edx, ebx
	mov eax, [count]

search_Max:
	inc ebx ; ebx = ebx + 1
	cmp eax, [count + ebx*4] ; compare eax with count[index]
	jns search_end ; if sf is set go to search_end
	mov eax, [count + ebx * 4] ; mov eax to count[index]
	mov edx, ebx ; mov edx = ebx

search_end:
	cmp ebx, 019h ; compare ebx with 25
	jz print_max ; if zf is set go to the print_max
	jmp search_Max ; otherwise go to search_Max

print_max:
	mov ebx, edx ; point ebx = edx
	mov eax,order ; point eax to order
	mov edx, 061h ; mov edx to a
	add edx, ebx ; edx = edx + ebx
	mov [eax+ecx], dl
	mov eax, -1 ; mov eax to -1
	mov [count + ebx*4], eax
	inc ecx
	cmp ecx 01Ah ; compare ecx with 26
	jnz store_Max ; if ZF is set go to store_Max
	mov eax, order
	call print_string
	call print_nl
	mov ebx, 000h
	jmp close_program

close_program:
	call	print_nl	; print a new line
	popa
	mov	eax, 0
	leave
	ret
