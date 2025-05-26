; Equation.asm  This program outputs Equation using the foormula A = (B*3+6)/X+D)
; Adhiti Venkatesh
; Challenges - Had to do it increments
; 		1. harded coded values, 
;		2. replaced with variables, 
;		3. output result with quotient and Remainder
;		4. Put in error checking - divide by zero and jump conditions.
; Time spent - 15 hours
;
; Revision History
;
; 6/17 - AV - Initial Version
; 6/18 - AV - Prompt for getting variables.
; 6/19 - AV - output with quotient and Remainder.
; 6/20 - AV - Error checking - divide by zero; and jump conditions.
; 6/21 - AV - Debugging Changes and Documentation.


INCLUDE PCMAC.INC
	name    Equation
	.model 	small
	.stack  100
	.data

	B	DW	?
	X	DW	?
	D	DW	?
	A	DW	?	; Quotient
	R	DW	?	; Remainder
	PROMPT DB  0ah,0dh,"Program outputs equation for formula A = (B*3+6)/(X+D).$"
	PROMPTB DB  0ah,0dh,"Type in value for B: $"
	PROMPTX DB  0ah,0dh,"Type in value for X: $"
	PROMPTD DB  0ah,0dh,"Type in value for D: $"
	ERRMSG	DB	0ah,0dh,"Error..Denominator (X+D) is zero. Exiting. $"
	resmes  db	0ah,0dh,"Output of the formula is: $"
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
	
	lea dx, PROMPTB
	mov	ah, 9		;dos fn to output string up to $
	int	21h	
	call GetDec		; ax = user entered value for variable B
	mov B, ax		;  B = ax

	lea dx, PROMPTX
	mov	ah, 9		;dos fn to output string up to $
	int	21h	
	call GetDec		; ax = user entered value for variable X
	mov X, ax		;  X = ax

	lea dx, PROMPTD
	mov	ah, 9		;dos fn to output string up to $
	int	21h		
	call GetDec		; ax = user entered value for variable D
	mov D, ax		;  D = ax
	
	;Error check if divide by zero
	add ax, X		; ax = X+D
	cmp	ax, 0		; X+D is zero
	JZ  Error		; If ax = 0 then jump to lable Error - Divide by zero label
	
 	mov	ax, 3		; Move 3 to ax
	mov	bx,	B		; Move B to bx
	imul bx	 		; ax = B*3
	add	ax, 6		; ax = B*3+6
	mov	bx, X		; bx = X
	add	bx, D		; bx = X+D
	cwd;
	idiv bx
	mov A, ax		; Quotient
	mov	R, dx		; Remainder
	
	lea dx, resmes
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
	
	JMP done
	
Error:
	lea dx, ERRMSG	; if divide by zero error then print error.
	mov	ah, 9		;dos fn to output string up to $
	int	21h	

	
done:	
	mov	al, 0		; return code of 0
	mov ah, 4ch		; exit back to dos
	int 	21h
	
	_EXIT 0;
	
EQN	ENDP
	end	EQN