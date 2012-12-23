stack	segment stack 'stack'
	dw 32 dup(0)
stack	ends
data	segment 
BUF1	DB 'Plese input N(00H-FFH):$'
BUF2	DB 0AH,0DH,'N','=','$'
BUF3	DB 7,0,7 DUP(0)
BUF4	DB 11 DUP(0)
BUF5	DB 4 DUP(0)
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
		MOV DX,OFFSET BUF3
		MOV AH,10
		INT 21H
		MOV DX,OFFSET BUF2
		MOV AH,9
		INT 21H
		MOV BUF3[4],'H'
		MOV BUF3[5],'='
		MOV BUF3[6],'$'
		MOV DX,OFFSET BUF3+2
		MOV AH,9
		INT 21H
		MOV AX,WORD PTR BUF3[2]
		SUB AX,3030H
		CMP AL,0AH
		JB LNSUB7
		SUB AL,7
LNSUB7:	CMP AH,0AH
		JB HNSUB7
		SUB AH,7
HNSUB7:	MOV CL,4
		SHL AL,CL
		OR AL,AH
		MOV DL,AL		;save al in the dl to use in the next step
		MOV DH,0
		PUSH DX
		MOV CX,8
		MOV BX,0
AGAIN:	MOV AH,0
		SHL AX,1
		ADD AH,30H
		MOV BUF4[BX],AH
		INC BX
		LOOP AGAIN
		MOV BUF4[BX],'B'
		MOV BUF4[BX+1],'='
		MOV BUF4[BX+2],'$'
		MOV DX,OFFSET BUF4
		MOV AH,9
		INT 21H
		POP DX
		MOV AL,DL
		MOV AH,0
		MOV CL,10
		MOV BX,2
AGAIN2:	DIV CL
		MOV CH,AH
		ADD AH,30H
		MOV BUF5[BX],AH
		DEC BX
		MOV AH,0
		TEST AL,AL
		JNZ AGAIN2
		MOV BUF5[3],'$'
		MOV DX,OFFSET BUF5
		MOV AH,9
		INT 21H
		ret
start	endp
code	ends
		end start
	