SYS_READ equ 3
SYS_WRITE equ 4
SYS_EXIT equ 1
EXIT equ 0
STDIN equ 2
STDOUT equ 1

section .data
	msg1 db '1st number?',10
	msg2 db '2nd number?',10
	msg1len equ $-msg1
	msg2len 
