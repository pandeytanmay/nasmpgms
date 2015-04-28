
section .text
 
startnew:
 
mov ecx,newline
mov edx,1
mov eax,4
mov ebx,1
int 0x80
ret
 
convert:
mov ecx,[inp]
mov bl,10
mov al,cl
sub al,30h
 
cmp ch,10
je converted
mul bl
sub ch,30h
add al,ch
converted:
mov byte[inp],al
ret
 
takeinput:
mov ecx,msgele
mov edx,lmsgele
mov eax,4
mov ebx,1
int 0x80
 
tinput:
 
mov ecx,inp
mov edx,3
mov eax,3
mov ebx,0
int 0x80
 
 
call convert
 
ret
 
global _start
_start:
 
mov ecx,noele
mov edx,lnoele
mov eax,4
mov ebx,1
int 0x80
 
call tinput
 
mov al,byte[inp]
mov byte[n],al
 
mov ebx,0
mov bl,[n]
mov edx,0
taking:
push dx
call takeinput
mov al,byte[inp]
mov edx,0
pop dx
mov byte[input+edx],al
add dx,1
mov bl,[n]
cmp dl,bl
jne taking
 
mov edx,0
sort:
mov bl,byte[input+eax]
mov cl,byte[input+eax+1]
cmp bl,cl
jg dontswap
mov byte[input+eax+1],bl
mov byte[input+eax],cl
dontswap:
add eax,1
mov bl,byte[n]
sub bl,1
cmp al,bl
jne sort
mov eax,0
add edx,1
mov bl,byte[n]
add bl,1
cmp dl,bl
jne sort
 
call startnew
 
mov ecx,sortmsg1
mov edx,lsortmsg1
mov eax,4
mov ebx,1
int 0x80
 
mov edx,0
mov esi,0
 
output:
 
push 29h
mov ebx,0
mov bl,byte[input+esi]
mov ax,bx
mov ebx,0
mov bl,10
break:
mov edx,0
div bx
add dl,30h
push dx
cmp al,0
jne break
 
mov edx,0
pop dx
 
prints:
 
mov byte[printdata],dl
 
mov ecx,printdata
mov edx,1
mov eax,4
mov ebx,1
int 0x80
 
mov edx,0
pop dx
cmp dl,29h
jne prints


mov ecx,space
mov edx,1
mov eax,4
mov ebx,1
int 0x80
 
 
add esi,1
mov ebx,0
mov bl,byte[n]

 
call startnew
call startnew
cmp esi,02
jne output
 
mov eax,1
mov ebx,0
int 0x80
 
section .bss
input resb 100
 
section .data
inp dd 30h
temp db 30h
space db 32
newline db 10
n db 30h
printdata db 30h
noele db "Number of elements?",32
lnoele equ $-noele
msgele db "Enter element :",32
lmsgele equ $-msgele
sortmsg1 db " The largest and second largest elements are ",10
lsortmsg1 equ $-sortmsg1
