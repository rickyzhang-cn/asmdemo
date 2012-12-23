stack	segment stack 'stack'
	dw 32 dup(0)
stack	ends
data	segment
BUF1	DB 'Please input the string(1-254):$'
INBUF	DB 255,0,255 DUP(0)
OUTBUF	DB 255 DUP(0)
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
		MOV DL,0AH
		MOV AH,2
		INT 21H
		MOV DL,0DH
		MOV AH,2
		INT 21H
		MOV SI,0
AGAIN:  MOV DL,INBUF[BX+1]
		MOV OUTBUF[SI],DL
		MOV DL,','
		MOV OUTBUF[SI+1],DL
		ADD SI,2
		DEC BX
		JNZ AGAIN
		MOV OUTBUF[SI-1],'$'
		MOV DX,OFFSET OUTBUF
		MOV AH,9
		INT 21H
		ret
start	endp
code	ends
		end start