SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN  equ 0
STDOUT equ 1
section .data
msg1 db "enter a digit",0xA,0xD
len1 equ $- msg1

msg2 db "The factorial is:"
len2 equ $- msg2
section .bss
num1 resb 2
res resb 1
section .text
global _start
_start:
mov eax,SYS_WRITE
mov ebx,STDOUT
mov ecx, msg1
mov edx, len1
int 0x80
mov eax, SYS_READ
mov ebx,STDIN
mov ecx,num1
mov edx,2
int 0x80
mov eax,SYS_WRITE
mov ebx, STDOUT
mov ecx,msg2
mov edx,len2
int 0x80

mov ebx,[num1]
sub ebx,'0'
call fact1
add ax,'0'
mov [res],ax

mov eax,4
mov ebx,1
mov ecx,res
mov edx,1
int 0x80

mov eax,1
xor ebx,ebx
int 0x80

fact1:
cmp bl,1
jg docal
mov ax,1
ret

docal:
dec bl
call fact1
inc bl
mul bl
ret


exit:
mov eax,SYS_EXIT
xor ebx,ebx
int 0x80
