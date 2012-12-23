[section .data]
strHello	db	"Hello, world"
STRLEN	equ	$ - strHello

[section .text]
global main
main:
	mov edx, STRLEN
	mov ecx, strHello
	mov ebx, 1
	mov eax, 4
	int 0x80
	mov ebx, 0
	mov eax, 1
	int 0x80
