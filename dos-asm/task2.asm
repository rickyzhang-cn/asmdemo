stack	segment stack 'stack'
	dw 32 dup(0)
stack	ends
data	segment
BUF1	DB 'Plesse input N(0-255):$'
BUF2	DB 7,0,5 DUP(0)
BUF3	DB 0AH,0DH,'N','=','$'
BS		DB 0 ;�洢ʵ��ֵ
BUF4	DB 10 DUP(0)  ;�洢�����ƽ��
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
		MOV DL,BUF2[1]
		MOV DH,0
		MOV SI,DX
		MOV BYTE PTR BUF2[SI+2],'='
		MOV BYTE PTR BUF2[SI+3],'$'
		MOV DX,OFFSET BUF2[2]
		MOV AH,9
		INT 21H
		MOV CH,10
		MOV SI,2
AGAIN:	MOV AL,BUF2[SI]   ;��������ֵ��ʵ��ֵ������mul 10�ķ�ʽ
		MOV AH,BUF2[SI+1]
		CMP AH,'='
		JZ ISG
		AND AL,0FH
		ADD AL,BS
		MUL CH
		MOV BS,AL  ;������mov ������add
		INC SI
		JMP AGAIN
ISG:	AND AL,0FH   ;�ǵ�����Ҫ��al and
		ADD BS,AL
        MOV AL,BS    ;���16����ֵ
		AND AL,0F0H
		SHR AL,4
		ADD AL,30H
		CMP AL,3AH
		JB NHADD7
		ADD AL,7
NHADD7: MOV DL,AL
        MOV AH,2
		INT 21H	
		MOV AL,BS
		AND AL,0FH
		ADD AL,30H
		CMP AL,3AH
		JB NLADD7
		ADD AL,7
NLADD7: MOV DL,AL
		MOV AH,2
		INT 21H
		MOV DL,'H'
		MOV AH,2
		INT 21H
		MOV DL,'='
		MOV AH,2
		INT 21H
		MOV CX,8   ;���������ֵ������ѭ��
		MOV AL,BS
		MOV BX,0
AGAIN2:	MOV AH,0
		SHL AX,1
		ADD AH,30H
		MOV BUF4[BX],AH
		INC BX
		LOOP AGAIN2
		MOV BUF4[BX],'B'
		MOV BUF4[BX+1],'$'
		MOV DX,OFFSET BUF4
		MOV AH,9
		INT 21H
		ret
start	endp
code	ends
		end start