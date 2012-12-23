stack	segment stack 'stack'
	dw 32 dup(0)
stack	ends
data	segment
BUF1	DB 'INPUT:$'
INBUF	DB 11,0,11 DUP(0)
OUTBUF1	DB 20 DUP(0)
OUTBUF2	DB 20 DUP(0)
data	ends
code	segment
start	proc far
		assume ss:stack,cs:code,ds:data
		push ds
		sub ax,ax
		push ax
		mov ax,data
		mov ds,ax
		MOV DX,OFFSET BUF1
		MOV AH,9
		INT 21H
		MOV DX,OFFSET INBUF
		MOV AH,10
		INT 21H
		MOV BL,INBUF[1]
		MOV BH,0
		MOV SI,0
		MOV DI,0
AGAIN:	MOV DL,INBUF[DI+2]
		MOV OUTBUF1[SI],DL
		MOV OUTBUF1[SI+1],';'
		MOV DL,INBUF[BX+1]
		MOV OUTBUF2[SI],DL
		MOV OUTBUF2[SI+1],';'
		ADD SI,2
		INC DI
		DEC BX
		JNZ AGAIN
		MOV OUTBUF1[SI-1],'$'
		MOV OUTBUF2[SI-1],'$'
		MOV DL,0AH
		MOV AH,2
		INT 21H
		MOV DL,0DH
		MOV AH,2
		INT 21H
		MOV DX,OFFSET OUTBUF1
		MOV AH,9
		INT 21H
		MOV DL,0AH
		MOV AH,2
		INT 21H
		MOV DL,0DH
		MOV AH,2
		INT 21H
		MOV DX,OFFSET OUTBUF2
		MOV AH,9
		INT 21H
		ret
start	endp
code	ends
		end start