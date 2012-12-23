stack	segment stack 'stack'
	dw 32 dup(0)
stack	ends
data	segment
BUF1	DB 'WAIT INTERRUPT,COUNT=0',0AH,0DH,'$'
BUF2	DB 'INTERRUPT PROCESSING,COUNT='
N		DB 0
BUF3	DB 0AH,0DH,'$'
data 	ends
code 	segment
start	proc far
		assume ss:stack,cs:code,ds:data
		push ds
		sub ax,ax
		push ax
		MOV	DX, 0E438H 			;00→E438H
	    MOV	AL,00H
	    OUT	DX,AL
	    MOV	DX, 0E439H			;1F→E439H
	    MOV	AL,1FH
	    OUT	DX,AL
	    MOV	DX, 0E43AH 			;3F→E43AH
	    MOV	AL,3FH
	    OUT	DX,AL
	    MOV	DX, 0E43BH 			;00→E43BH
	    MOV	AL,00H
	    OUT	DX,AL
		MOV AX,SEG IRQ3			;系统调用填写中断向量表 	
		MOV DS,AX
		MOV DX,OFFSET IRQ3
		MOV AX,250BH
		INT 21H
		mov ax,data
		mov ds,ax
		MOV DX,OFFSET BUF1
		MOV AH,9
		INT 21H
		IN AL,21H
		AND AL,0F7H
		OUT 21H,AL
AGAIN:	JMP $
		MOV AH,0BH
		INT 21H
		INC AL
		JNZ AGAIN
		IN AL,21H
		OR AL,08H
		OUT 21H,AL
		ret

IRQ3:	MOV DX,0E41FH
		IN AL,DX;   			;清除PCI中断标志
		MOV DX,0E43AH
		MOV AL,3FH  			;关PCI板卡中断
		OUT DX,AL
		INC N
		MOV DX,OFFSET BUF2
		MOV AH,9
		INT 21H
		MOV AL,20H				;一般中断命令结束字
		OUT 20H,AL
		POP AX
		INC AX
		INC AX
		PUSH AX
		IRET
start 	endp
code	ends
		end start