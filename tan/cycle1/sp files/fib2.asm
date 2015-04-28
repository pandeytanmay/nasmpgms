%include "asm_io.inc"

segment .data
            output db "Enter number to calculate fibonacci number",0

segment .bss
            userInput      resd    1

segment .text
            global asm_main

asm_main:
           




DoIt:
         enter 0,0
         pusha
         move ecx, [ebp+8]
         ecx, 0
         jl return

         dec ecx
         push ecx
         call DoIt
         pop ecx
         mov eax, [ebp+8]
         call print_int
         mov eax, space
         call print_string

return:
         popa
         leave
         return




