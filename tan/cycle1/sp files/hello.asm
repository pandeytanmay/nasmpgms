section .data
	msg db 'hello',10
	len equ $ - msg

section .text
	global _start:

_start:
	mov edx,len            
	mov ecx,msg            
	mov ebx,1        
	mov eax,4
	                     
	int 80h              

	mov eax,1
	mov ebx,0
	int 80h
