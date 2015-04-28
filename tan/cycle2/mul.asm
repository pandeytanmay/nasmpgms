section .data
	msg1: db 'Input no',10
	len1: equ $-msg1                       
	msg2: db 'Table is',10
	len2: equ $-msg2
	msg3: db ' '
	len3: equ $-msg3
	num1: dd 0
	
	sum: dd 0
section .bss
	ip1: resb 1
	disp: resb 1
	

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
	jmp sumproc

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

sumproc:	
	xor eax,eax
	mov edi,00h
loop1:
	add eax, [num1]
	mov [sum],eax
	xor ecx,ecx
	call continue
	; Print space
	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,len3
	int 80h
	
	mov eax,[sum]
	inc edi
	cmp edi,10
	je exit
	jmp loop1

continue: 
	xor edx,edx
	mov ebx,10
	div ebx
	add edx,30h
	push edx
	inc ecx
	cmp eax,0
	je display1
	jmp continue

	
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
	ret
exit:
mov eax,1
mov ebx,0
int 80h
