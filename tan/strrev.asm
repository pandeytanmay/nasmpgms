section .data
  msg db "Enter string",10
  msglen equ $-msg
section .bss
  input resb 30
  length resd 1
section .text
  global _start
_start:
  mov eax,4
  mov ebx,1
  mov ecx,msg
  mov edx,msglen
  int 80h
top1:
  mov eax,3
  mov ebx,0h
  mov ecx,input
  mov edx,30h
  int 80h
top:
	mov esi,0h
  len:
    movzx eax ,byte[input+esi]
	  add dword[length],1
	    inc esi
		  cmp eax,10
		  inside:
		    jne len
			 ; sub dword[length],1
  

  mov esi,input
 mov edi,input 
  mov ecx,[length]
loophere:
  lodsb
  cmp al,20h
  je next
  xor al,20h
  next:
  stosb
  loop loophere
sub byte[length],1

  mov eax,4h
  mov ebx,1h
  mov ecx,input
  
  mov edx,[length]
  int 80h
 mov eax,1
 int 80h
