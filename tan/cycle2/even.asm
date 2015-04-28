data:
section .data
msg1: db 'Enter the no',10
len1: equ $-msg1
msg2: db 'Even',10
len2: equ $-msg2
msg3 db 'Odd',10
len3 equ $-msg3
num: dd 0

section .bss
ip1: resb 1

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


jmp even

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

even :
mov eax,[num]
test eax,01h		;ANDs the register with data and modifies the flag but does not change the value of eax
jz yes
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h
jmp exit

yes:
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h

exit:
mov eax,1
mov ebx,0
int 80h
