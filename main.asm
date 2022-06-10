SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
SYS_OPEN equ 5
SYS_CLOSE equ 6
SYS_CREAT equ 8

STDIN equ 0
STDOUT equ 1
STDERR equ 2

section .data
	newLineMsg db 0xA, 0x0
	newLineLen equ $ - newLineMsg
	askInputMsg db "Enter your text (max size 1024): ", 0x0
	askInputLen equ $ - askInputMsg

section .bss
	input resb 1026
	count resb 4

section .text
	global _start

_start:
	mov r9, 0
	mov [count], r9

	mov rax, SYS_WRITE
	mov rbx, STDOUT
	mov rcx, askInputMsg
	mov rdx, askInputLen
	int 0x80

	mov rax, SYS_READ
	mov rbx, STDIN
	mov rcx, input
	mov rdx, 1026
	int 0x80

	mov r8, 0
	mov r10, 1
	loop:
	cmp byte[input+r8], 0xA
	je end
	cmp byte[input+r8], 0x0
	je end

	cmp byte[input+r8], 0x20
	je prepareNext

	cmp r10, 1
	je increment

	jmp next

	prepareNext:
	mov r10, 1
	jmp next

	increment:
	mov r9, [count]
	inc r9
	mov [count], r9

	mov r10, 0
	jmp next

	next:
	inc r8
	jmp loop

	end:
	mov r9, [count]
	add r9, 0x30
	mov [count], r9

	mov rax, SYS_WRITE
	mov rbx, STDOUT
	mov rcx, count
	mov rdx, 4
	int 0x80

	mov rax, SYS_WRITE
	mov rbx, STDOUT
	mov rcx, newLineMsg
	mov rdx, newLineLen
	int 0x80

	exit:
	mov rax, SYS_EXIT
	mov rbx, 0
	int 0x80

