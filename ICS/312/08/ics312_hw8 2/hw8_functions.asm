;; function printArray
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

segment .data
	error_msg_printArray db	"Function printArray not implemented yet!",10,0

segment .text

printArray:
	mov	eax, error_msg_printArray
	call	print_string
	ret		


;; function transformedSum
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

segment .data
	error_msg_transformedSum db "Function transformedSum not implemented yet!",10,0

segment .text

transformedSum:
	mov	eax, error_msg_transformedSum
	call	print_string
	ret	



;; function transformValue
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

segment .data
	error_msg_transformValue db "Function transformValue not implemented yet!",10,0

segment .text

transformValue:
	mov	eax, error_msg_transformValue
	call	print_string
	ret	
