;  MYBox.asm  This program outputs special assignment 2 done output
; Adhiti Venkatesh
; Challenges - debugging code. Started small with one line of output, multiple variables and then single variable.
; Time spent - 12 hours
;
; Revision History
;
; 6/3 - AV - Initial Version
; 6/4 - AV - Multiple variable and debug.
; 6/5 - AV - Changes to single variable.
; 6/6 - AV - Debugging Changes to single variable.


	name    MYBox
	.model 	small
	.stack  100
	.data
Msg		db	5 DUP ('*')," Assembly Programming ",5 DUP	('*'),0ah,0dh
		db	'*',30 DUP (' '),'*',0ah,0dh
		db	'*',30 DUP (' '),'*',0ah,0dh
		db	'*',5 DUP (' '),"Assignment 2 is done!",4 DUP(' '),'*',0ah,0dh
		db	'*',30 DUP (' '),'*',0ah,0dh
		db	'*',30 DUP (' '),'*',0ah,0dh
		db	32 DUP('*'),"$"
	.code 
start:	
 	mov	ax, @data
	mov	ds, ax
	lea	dx,	Msg
	mov	ah, 9		;dos fn to output string up to $
	int	21h
	mov	al, 0		; return code of 0
	mov ah, 4ch		; exit back to dos
	int 	21h
	end	start