
section .data
  msg1: db "Enter string : "
  size1: equ $-msg1
  msg2: db " is pallindrome "
  size2: equ $-msg2
  msg3: db " is not pallindrome "
  size3: equ $-msg3


section .bss
  string: resb 50
  temp: resb 1
  len:  resb 1
  j: resb 1
  i: resb 1


section .text
  global _start

_start:
  
  mov eax, 4
  mov ebx, 1
  mov ecx, msg1
  mov edx, size1
  int 80h

  mov ebx, string
  mov byte[len], 0

reading:
  push ebx

  mov eax, 3
  mov ebx, 0
  mov ecx, temp
  mov edx, 1
  int 80h
  
  pop ebx
  mov al, byte[temp]
  mov byte[ebx], al
  
  inc byte[len]
  inc ebx

  ;NASM change the ascii code of enter 13 to 10
  cmp byte[temp], 10
  jne reading


endreading:
  dec ebx
  mov byte[ebx],0
  dec byte[len]




;Printing the string....
  mov eax, 4
  mov ebx, 1
  mov ecx, string
  movzx edx, byte[len]
  int 80h

  mov byte[i], 0
  mov al, byte[len]
  mov byte[j], al
  sub byte[j], 1

pal_check:
  mov eax, string
  mov ebx, string
  movzx ecx, byte[i]
  add eax, ecx
  movzx ecx, byte[j]
  add ebx, ecx
  mov cl, byte[eax]
  mov ch, byte[ebx]
  cmp cl, ch
  jne not_pal

  inc byte[i]
  dec byte[j]
  mov al, byte[i]
  mov ah, byte[j]
  cmp al,ah
  jl pal_check


  mov eax, 4
  mov ebx, 1
  mov ecx, msg2
  mov edx, size2
  int 80h
  jmp exit

not_pal:
  mov eax, 4
  mov ebx, 1
  mov ecx, msg3
  mov edx, size3
  int 80h


exit:
  mov eax, 1
  mov ebx, 0
  int 80h
