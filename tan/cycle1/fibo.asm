section .data
	msg1 db 'Number of terms?',10
	len1 equ $-msg1
	msg2 db 'Series',10
	len2 equ $-msg2
	msg3 db ' '
	len3 equ $-msg3
	num dd 0
	n1 dd 0
	n2 dd 1

section .bss
	ip resb 1
	disp resb 1

section .text
	global _start

_start:
	 mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h

	mov esi,[num]
	call readdata
	mov [num],esi

	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,len2
	int 80h

	xor ecx,ecx
	mov eax,[n1]
	call continue
	
	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,len3
	int 80h
	
	xor ecx,ecx
	mov eax,[n2]
	call continue
	
	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,len3
	int 80h
	
	mov ecx,[num]
	dec ecx
	dec ecx
loop:
	cmp ecx,0
	je end
	mov [num],ecx
	mov eax,[n1]
	mov ebx,[n2]
	add eax,ebx
	mov [n2],eax
	mov [n1],ebx
	xor ecx,ecx 
	call continue
	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,len3
	int 80h
	
	mov ecx,[num]
	dec ecx
	cmp ecx,0
	jne loop

end :
	mov eax,1
	mov ebx,0
	int 80h

readdata:
	mov eax,3
	mov ebx,0
	mov ecx,ip
	mov edx,1
	int 80h

	mov ecx,[ip]
	cmp ecx,10
	je stop
	sub ecx,'0'
	mov eax,esi
	mov ebx,10
	mul ebx
	add eax,ecx
	mov esi,eax
	jmp readdata

stop:ret
	
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
	pop edx
	mov [disp],edx
	push ecx
	mov eax,4
	mov ebx,1
	mov ecx,disp
	mov edx,1
	int 80h
	pop ecx
	loop display
	ret
