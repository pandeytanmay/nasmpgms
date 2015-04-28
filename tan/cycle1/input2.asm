section .data 		; data section
	msg db 'Please enter a number: ',10		; 10 is linefeed character
	msgLen equ $-msg								;take the message lenght in variable
	msg2 db 'You have entered: ',10
	msg2Len equ $-msg2
	
section .bss 
	num resb 8		; 8 bytes num can store
section .text		;code segment
	global _start	
_start:
	mov eax,4		;sys_write
	mov ebx,1		;file descriptor (stdout)
	mov ecx,msg
	mov edx,msgLen
	int 80h
	
	mov eax,3		;sys_read
	mov ebx,2		;file descriptor (stdin)
	mov ecx, num
	mov edx,8
	int 80h
	
	mov eax,4		;sys_write
	mov ebx,1
	mov ecx,msg2
	mov edx,msg2Len
	int 80h
	
	mov eax,4		;sys_write
	mov ebx,1
	mov ecx,num
	mov edx,8
	int 80h
	
	mov eax,1		;sys_exit
	mov ebx,0
	int 80h
	
