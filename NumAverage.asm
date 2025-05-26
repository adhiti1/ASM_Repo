; NumAverage.asm  This program outputs average of numbers
; Adhiti Venkatesh
; Challenges - Had to do it increments
; 		1. harded coded values, 
;		2. replaced with variables, 
;		3. output result with quotient and Remainder

; Time spent - 12 hours
;
; Revision History
;
; 6/24 - AV - Initial Version
; 6/24 - AV - Prompt for getting variables.
; 6/25 - AV - output with quotient and Remainder.
; 6/25 - AV - Debugging changes and Documentation



INCLUDE PCMAC.INC
	name    NumAverage
	.model 	small
	.stack  100
	.data

	inpNum	DW	?	; input number
	counter	DW	0	; counter to keep track of number of user inputs
	Total	DW	0	; running total
	A		DW	?	; quotient
	R		DW	?	; Remainder
	PROMPT DB  0ah,0dh,"Program calculates average of input numbers. Enter q to exit. $"
	PROMPTNum DB  0ah,0dh,"Enter a number: $"

	resmes  db	0ah,0dh,"The average of your numbers is: $"
	result1  db 0ah,0dh, "Quotient is ",?,"$"
	result2	db "Remainder is ",?,"$"	
	.code 
	EXTRN PutDec : NEAR, GetDec : NEAR
EQN PROC
	
	mov	ax, @data
	mov	ds, ax
	lea dx, PROMPT	; initial prompt
	mov	ah, 9		;dos fn to output string up to $
	int	21h
	
AGAIN:				; loop until user hits a non numeric data
	lea dx, PROMPTNum
	mov	ah, 9		;dos fn to output string up to $
	int	21h	

	call GetDec		; ax = user entered value 
	mov inpNum, ax		;  inpNum = ax
	cmp ax, 0		; alphabet
	JE	EXIT
	

CALC:
	mov	ax, inpNum	; move inpNum to ax
	add	ax, Total	; ax = inpNum + Total
	mov	Total, ax	; Total = inpNum + Total
	mov	ax,	counter	; ax = counter
	inc	ax			;  increment ax by 1
	mov	counter, ax	; counter = ax (basically incrementing counter)
	JMP	AGAIN		; loop back again


EXIT:	
	
	mov ax, Total		; Move total to ax
	mov	bx, counter		; move counter to bx
	cwd
	idiv bx				; divide
	mov A, ax		; Quotient
	mov	R, dx		; Remainder
	
	lea dx, resmes	; output statement
	mov	ah, 9		;dos fn to output string up to $
	int	21h	

	lea dx, result1	; Result prompt
	mov	ah, 9		;dos fn to output string up to $
	int	21h	

	mov ax, A		; Move Quotient to register to print
	call PutDec
	_putch 13,10
	
	lea dx, result2	; print reminder prompt
	mov	ah, 9		;dos fn to output string up to $
	int	21h		
	mov ax, R		; move reminder to ax to print

	call PutDec
	_putch 13,10	
	mov	ah, 9		;dos fn to output string up to $
	
	
done:	
	mov	al, 0		; return code of 0
	mov ah, 4ch		; exit back to dos
	int 	21h
	
	_EXIT 0;
	
EQN	ENDP
	end	EQN