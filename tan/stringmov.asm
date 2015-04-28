section .data
  msg db "SHe loves you Tanmay",0
  msglen equ $-msg
section .bss
  msgcpy resb 50
section .text
  global _start
_start:
  mov eax,04h
  mov ebx,01h
  mov ecx,msg
  mov edx,msgcpy
  int 80h
  mov ecx,msglen
  mov esi,msg
  mov edi,msgcpy
loophere:
  lodsb
  or al, 20h
  stosb
  loop loophere
  cld
  rep movsb
  mov eax,04h
  mov ebx,01h
  mov ecx,msgcpy
  mov edx,50
  int 80h

  mov eax,01h
  int 80h
