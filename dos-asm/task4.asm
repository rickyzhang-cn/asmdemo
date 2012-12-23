stack	segment stack 'stack'
	dw 32 dup(0)
stack	ends
data	segment
BUF1	DB 'Plese input N(0000H-FFFFH):$'
BUF2	DB 6,0,6 DUP(0)
BUF3	DB 6 DUP(0),'$'
BUF4	DB 0AH,0DH,'The output:$'
data	ends
code	segment
start	proc far
		assume ss:stack, cs:code, ds:data
		push ds
		sub ax,ax
		push ax
		mov ax,data
		mov ds,ax
		MOV DX,OFFSET BUF1
		MOV AH,9
		INT 21H
		MOV DX,OFFSET BUF2
		MOV AH,10
		INT 21H
		MOV DL,BUF2[1]
		MOV DH,0
		MOV AX,0
		MOV SI,0
		MOV BX,0
AGAIN:	SHL BX,4
		MOV AL,BUF2[SI+2]
		INC SI
		SUB AL,30H
		CMP AL,0AH
		JB NOSUB7
		SUB AL,7
NOSUB7:	OR BX,AX
		CMP SI,DX
		JNZ AGAIN
		MOV DX,OFFSET BUF4
		MOV AH,9
		INT 21H
		MOV AX,BX
		MOV CX,10
		MOV DI,5
		MOV DX,0
AGAIN2:	DIV CX
		ADD DL,30H
		MOV BUF3[DI],DL
		DEC DI
		MOV DX,0
		TEST AX,AX
		JNZ AGAIN2
		MOV DX,OFFSET BUF3
		MOV AH,9
		INT 21H
		ret
start	endp
code	ends
		end start