; Solution for Programming Assignment #7

%include "asm_io.inc"

segment .data
        input_msg       db      "Enter an integer: ", 0
        list_msg        db      10, "Original list: ",0
	mapreduce_msg 	db    	"  Mapped list:   ", 0
	reduced_msg	db	"  Reduced value: ", 0
	every_other_neg_message db	"Made every even index <0: ", 0
	every_other_times_2_message db	"Made every odd index 2x:  ", 0
	

segment .bss
	Array			resd	10

segment .text
        global  asm_main
	

asm_main:
	enter	0,0			; setup
	pusha				; setup


	;;
	;;  Getting the input array
	;;

        mov     ecx, 10
        mov     esi, Array
input_loop:
        mov     eax, input_msg
        call    print_string
        call    read_int
        mov     [esi], eax
        add     esi, 4
        loop    input_loop

	;;
	;; Printing the array
	;;

	mov	eax, list_msg
	call	print_string
	push	dword 10
	push	Array
	call	printArray
	add	esp, 8

	;; 
	;; Making every other number negative
	;;

	mov	ecx, 5
	mov	ebx, Array
neg_loop:
	push 	make_negative
	push	ebx
	call	transformValue
	add	esp, 8
	add	ebx, 8
	loop	neg_loop
	
	; Call function printArray
	mov	eax, every_other_neg_message
	call	print_string
	push	dword 10
	push	Array
	call	printArray
	add	esp, 8

	;; 
	;; Making every other number times 2
	;;

	mov	ecx, 5
	mov	ebx, Array
	add	ebx, 4
times_2_loop:
	push 	times_2
	push	ebx
	call	transformValue
	add	esp, 8
	add	ebx, 8
	loop	times_2_loop
	
	; Call function printArray
	mov	eax, every_other_times_2_message
	call	print_string
	push	dword 10
	push	Array
	call	printArray
	add	esp, 8
		

	popa				; cleanup
	mov	eax, 0			; cleanup
	leave				; cleanup
	ret				; cleanup


;; make_negative function

make_negative:
	push	ebp
	mov	ebp, esp

	mov	eax, [ebp+8]
	neg	eax	

	mov	esp, ebp
	pop	ebp
	ret

times_2:
	push	ebp
	mov	ebp, esp

	mov	eax, [ebp+8]
	shl	eax, 1

	mov	esp, ebp
	pop	ebp
	ret


%include "hw8_functions.asm"
