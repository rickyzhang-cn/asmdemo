stack	segment stack 'stack'
	dw 32 dup(0)
stack	ends
data	segment
BUF1	DB 'Plesse input N(0-65535):$'
BUF2	DB 8,0,6 DUP(0)
BUF3	DB 0AH,0DH,'The output:$'
BS		DW 0
OUTBUF  DB 5 DUP (0)
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
		MOV DX,OFFSET BUF2
		MOV AH,10
		INT 21H
		MOV DX,OFFSET BUF3
		MOV AH,9
		INT 21H
		MOV CX,10
		MOV SI,2
AGAIN:	MOV AL,BUF2[SI]   ;计算输入值的实际值，采用mul 10的方式
		MOV BH,BUF2[SI+1]
		CMP BH,0DH
		JZ ISG
		AND AL,0FH
		MOV AH,0
		ADD AX,BS
		MUL CX
		MOV BS,AX  ;这里是mov 而不是add
		INC SI
		JMP AGAIN
ISG:	AND AX,000FH   ;记得这里要将al and
		ADD BS,AX
		MOV SI,0
		MOV CL,0
AGAIN2: MOV AX,BS		;输出16进
		ADD CL,4
		ROL AX,CL
		AND AX,000FH
		ADD AL,30H
		CMP AL,3AH
		JB NOADD7
		ADD AL,7
NOADD7: MOV OUTBUF[SI],AL
		INC SI
		CMP CX,16
		JNZ AGAIN2
		MOV OUTBUF[SI],'$'
		MOV DX,OFFSET OUTBUF
		MOV AH,9
		INT 21H
		ret
start	endp
code	ends
		end start