stack	segment stack 'stack'
	dw 32 dup(0)
stack	ends
data	segment
BUF1	DB 'Please input a number:$'
BUF2	DB ' 0$ 1$ 4$ 9$16$25$36$49$64$81$'
BUF3	DB 0AH,0DH,'The result is:$'
data 	ends
code 	segment
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
		MOV AH,1
		INT 21H
		AND AL,0FH
		MOV CL,3
		MUL CL
		ADD AL,OFFSET BUF2
		MOV AH,0
		PUSH AX
		MOV DX,OFFSET BUF3
		MOV AH,9
		INT 21H
		POP AX
		MOV DX,AX
		MOV AH,9
		INT 21H
		ret
start 	endp
code	ends
		end start