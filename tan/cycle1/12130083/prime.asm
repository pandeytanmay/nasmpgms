;Tanmay Kumar Pandey
;12130083
;
;
section .data
	msg1: db'Input the no',10
	len1: equ $-msg1
	msg2: db' It is not a prime',10
	len2: equ $-msg2
	msg3: db'prime',10
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

	jmp prime

	mov eax,1
	mov ebx,0
	int 80h

readdata:
	mov eax,3
	mov ebx,0
	mov ecx,ip1
	mov edx,1
	int 80h

	mov ecx,[ip1]
	cmp ecx,10
	je stopread
	sub ecx,30h
	mov ebx,10
	mov eax,esi
	mul ebx
	add eax,ecx
	mov esi,eax
	jmp readdata

stopread:ret

prime: 
  xor ecx,ecx      
  xor edx,edx     
  mov eax,[num1] 
  mov ebx,eax
  mov esi,eax 
  cmp ebx,0001
  je disp1
  mov ebx,eax
  cmp ebx,0002
  je disp2    
loop2:
  mov eax,esi
  dec ebx
  div ebx
          
  cmp edx,0000    
  je loop1
  xor edx,edx      
  cmp ebx,0002
  jne loop2
  mov ecx,0001
loop1:  
  cmp ecx,0000
  je disp1
disp2:
  mov eax,4
  mov ebx,1
  mov ecx,msg3
  mov edx,len3
  int 80h
  jmp exit
disp1:
  mov eax,4
  mov ebx,1
  mov ecx,msg2
  mov edx,len2
  int 80h
  
exit:
	mov eax,1
	mov ebx,0
	int 80h


