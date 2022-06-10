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

section .bss

section .text
	global _start

_start:
	mov rax, SYS_EXIT
	mov rbx, 0
	int 0x80
