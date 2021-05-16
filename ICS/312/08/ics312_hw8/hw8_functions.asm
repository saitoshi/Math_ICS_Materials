; @author Shinya Saito
; ICS 312 HW 8
; Assignment Due: April 27, 2021

;; function printArray
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
segment .data
	error_msg_printArray db	"Function printArray not implemented yet!",10,0
	comma		db		", ", 0

segment .text

; the functions for homework 8 exercise 1
; it operates the print array function
printArray:
; comment the given code
; 	mov	eax, error_msg_printArray
; 	call	print_string
	push ebp ; save the values for ebp
	mov ebp, esp ; update the values of EBP for this subprogram
	mov ecx, [ebp + 12] ; second parameter
	mov ebx, [ebp + 8] ; first parameter
	mov ecx, [ebp + 12] ; s
	dec ecx ; ecx = ecx - 1

; the loop to continue printing the list of arrays
print_loop:
	mov eax, [ebx] ; store eax with ebx
	call print_int ; print the integer
	mov eax, comma ; point eax to comma
	call print_string ; print the comma
	add ebx, 004h ; ebx = ebx + 4
	loop print_loop ; keep looping
	mov eax, [ebx]
	call print_int
	call print_nl
	mov esp, ebp
	pop ebp
	ret

;; function transformedSum
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

segment .data
	error_msg_transformedSum db "Function transformedSum not implemented yet!",10,0

segment .text

; function to calculate the sum of the array
transformedSum:
;	mov	eax, error_msg_transformedSum
;	call	print_string
	push ebp ; save the values for ebp
	mov ebp, esp ; update the values of EBP for this subprogram
	sub esp, 004h ; esp = esp - 4
	mov ebx, [ebp + 8] ; 1st param
	mov ecx, [ebp + 12] ; 2nd param
	mov dword [ebp - 4], 0 ;

; the loop portion to calculate the transformedSum
sum_start:
	push 	dword [ebx] ; push the contents of ebx
	call 	[ebp + 16] ; call
	add 	esp, 004h ; esp = esp + 4
	add 	[ebp - 4], eax ;
	add 	ebx, 004h ; ebx = ebx + 4
	loop 	sum_start ; keep looping
	mov		eax, [ebp - 4] ; mov contents of [ebp - 4] to eax
	mov 	esp, ebp
	pop 	ebp
	ret

;; function transformValue
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

segment .data
	error_msg_transformValue db "Function transformValue not implemented yet!",10,0

segment .text
; the function portion for the transformValue
transformValue:
;	mov	eax, error_msg_transformValue
;	call	print_string
	push	ebp
	mov		ebp, esp
	mov 	ebx, [ebp + 8] ; ebx = contents of the 1st param
	push	dword [ebx]
	call	[ebp + 12] ; the 2nd param
	mov 	[ebx], eax ; mov eax inside ebx
	mov 	esp, ebp
	pop 	ebp
	ret
