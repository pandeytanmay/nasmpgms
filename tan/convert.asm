Ascii to hex
Hex to ascii
Hex to BCD

global hex_to_ascii  ;making the procedures global to use in other programs
global ascii_to_hex,hex_to_bcd
 
SECTION .data
  ;before calling the procedures make sure esi points to source
   ;or in some cases destination
SECTION .bss
cnt resb 2
 
SECTION .text
 
ascii_to_hex:                    ;before calling point esi to source memory
xor ebx,ebx                      ;ebx will contain the final hex number
label:                           ;esi points to ascii number in memory
 cmp byte[esi],0xA               ;check for newline
 je exit                         ;if equal done
 rol ebx,04                      ;appends zero to lsb
 mov dl,byte[esi]                ;dl=ascii value
 cmp dl,39h                      ;if lesser than 39 goto esc
 jbe esc                         ;else subtract 7
 sub dl,07h   
 esc:  
 sub dl,30h                      ;sub 30h
 add bl,dl                       ;bl=bl+dl
 inc esi                         ;get the next digit until newline
 jmp label
exit:
ret
 
hex_to_bcd:                     ;eax conatins the divisor and esi points to memory
 push '$'                       ;dummy to check for end
 xor ecx,ecx
 xor edx,edx
 mov ecx,0xA                    ;ecx=divisor
 hb:
 div ecx                        ;eax is divided by eax,quotient:eax,remainder:edx
 push edx                       ;push the remainder on stack,edx contains single digit
 xor edx,edx                    ;make edx zero
 test eax,eax                   ;check if quotient is zero
 jnz hb                         ;repeat until eax is zero
 
puup:
 pop ecx                        ;pop the last remainder
 cmp ecx,'$'                    ;check for end
 je done   
 add cl,30h                      ;remainder is between 0-9 hence add only 30h
 mov byte[esi],cl               ;esi points to result
 inc esi                         ;increment esi to next location
 jmp puup
done:
ret
 
hex_to_ascii:
                                  ;modify the count to 8 for eax
mov byte[cnt],0x4                 ;2 for al 4 for ax
                                   ;printing the hex contents of ax register
label1:
 rol ax,04                        ;get the msb first
 mov dl,al                        ;two digits are accessed using al
 and dl,0Fh                       ;get the last digit only
 cmp dl,09h                         ;if below 9 add 30h
 jbe lb1
 add dl,07h                       ;else add 37h
 lb1:
 add dl,30h
 mov byte[esi],dl                 ;esi points to memory
 inc esi
 dec byte[cnt]
 jnz label1                        ;check if count is zero
ret
 
quit:
 mov eax,1                        ;exit code
 mov ebx,0
 int 0x80
 
