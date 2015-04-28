;Tanmay Kumar Pandey
;12130083
;
;
section .data
	msg1: db 'Input first no',10
	len1: equ $-msg1                       
	msg2: db 'Input second no',10
	len2: equ $-msg2
	msg3: db 'Sum is',10
	len3: equ $-msg3
	num1: dd 0
	num2: dd 0

section .bss
	ip1: resb 1
	disp: resb 1
	sum: resd 1

section .text
	global _start
_start:

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h

	mov esi,[num1] 
	call readdata
	mov [num1],esi

	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,len2
	int 80h

	mov esi,0
	call readdata
	mov [num2],esi
	jmp sum1

readdata:
	mov eax,3
	mov ebx,0
	mov ecx,ip1
	mov edx,1
	int 80h

	mov ecx,[ip1]
	cmp ecx,10    		;check if end of input(line feed)
	je stopread
	sub ecx,30h			;same as sub ecx,'0'
	mov ebx,10      	;to obtain the number by multiplying digit by 10    
	mov eax,esi			;esi is destination
	mul ebx
	add eax,ecx
	mov esi,eax
	jmp readdata
  stopread: ret

sum1:	
	mov eax,[num1]
	add eax,[num2]
	mov [sum],eax

	xor ecx,ecx
	mov eax,[sum]

continue: 
	xor edx,edx
	mov ebx,10
	div ebx
	add edx,30h
	push edx
	inc ecx
	cmp eax,0
	je display
	jmp continue

display:
	
	
display1:
	pop edx
	mov [disp],edx
	push ecx
	mov eax,4
	mov ebx,1
	mov ecx,disp
	mov edx,1
	int 80h
	pop ecx
	loop display1

mov eax,1
mov ebx,0
int 80h
