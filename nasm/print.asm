section .data
  msg db "Hi love",10
  msglen equ $-msg
section .bss
  
section .text
  global _start
_start:
  mov eax,4
  mov ebx,1
  mov ecx,msg
  mov edx,msglen
  int 80h

  mov eax,1
  mov ebx,0
  int 80h

