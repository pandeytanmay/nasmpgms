section .data
msg1: db'input first no',10
len1: equ $-msg1
msg2: db'input second no',10
len2: equ $-msg2
msg3: db'Sum is',10
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

mov esi,[num2]
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

mov eax,1
mov ebx,0
int 80h
