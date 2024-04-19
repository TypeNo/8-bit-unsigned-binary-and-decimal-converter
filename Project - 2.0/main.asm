TITLE PROJECT(main.asm)
INCLUDE Irvine32.inc
INCLUDE Macros.inc
.data
Menu0 BYTE ">>> Please select the conversion type:", 0
Menu1 BYTE " 1. Binary to Decimal", 0
Menu2 BYTE " 2. Decimal to Binary", 0
Menu3 BYTE " 3. Exit", 0
Menu4 BYTE "---------------------------------------", 0
MenuChoice BYTE "Enter your choice: ", 0
Choice BYTE ?
MenuInputBTD BYTE "Please Enter 8-bit binary digits (e.g., 11110000) : ", 0
InputBTD DWORD ?
AnsBTD DWORD ?
MenuOutputBTD BYTE "The decimal integer of ", 0
MenuOutputBTDa BYTE "b is ", 0
MenuOutputBTDb BYTE "d", 0
MenuInputDTB BYTE "Please Enter a decimal integer less than 256: ", 0
InputDTB SWORD ?
AnsDTB DWORD ?
MenuOutputDTB BYTE "The binary of ", 0
MenuOutputDTBa BYTE "d is ", 0
MenuOutputDTBb BYTE "b", 0
EndStr BYTE "Bye.", 0
Error BYTE "Please follow the instruction to input valid value"
InputBTD1 DWORD ?


.code
main PROC
JMP HERE
E2 :
MOV EDX, OFFSET Error
call WriteString
CALL CRLF
CALL CRLF
JMP HERE

HERE:
call MENU



;Comparasion Choice

CMP Choice, 1
JE BTD
CMP Choice, 2
JE DTB
CMP Choice, 3
JE EOP

;Binary to Decimal Section
BTD:
MOV EDX, OFFSET MenuInputBTD
call WriteString
call ReadInt
MOV InputBTD1,0
MOV InputBTD, EAX

CMP EAX, 100000000
JAE E2
MOV ECX,8

DTH:
MOV EDX,0
MOV EAX, InputBTD
CMP ECX, 8
JE DTH1
CMP ECX, 7
JE DTH2
CMP ECX, 6
JE DTH3
CMP ECX, 5
JE DTH4
CMP ECX, 4
JE DTH5
CMP ECX, 3
JE DTH6
CMP ECX, 2
JE DTH7
CMP ECX, 1
JE DTH8
DTHR1 :
LOOP DTH

DTH1 :
MOV EBX,10000000
DIV EBX
MOV EDX,0
MOV EBX,10
DIV EBX
SHL EDX,28
ADD InputBTD1,EDX
JMP DTHR1
DTH2 :
MOV EBX, 1000000
DIV EBX
MOV EDX, 0
MOV EBX, 10
DIV EBX
SHL EDX, 24
ADD InputBTD1, EDX
JMP DTHR1
DTH3 :
MOV EBX, 100000
DIV EBX
MOV EDX, 0
MOV EBX, 10
DIV EBX
SHL EDX, 20
ADD InputBTD1, EDX
JMP DTHR1
DTH4 :
MOV EBX, 10000
DIV EBX
MOV EDX, 0
MOV EBX, 10
DIV EBX
SHL EDX, 16
ADD InputBTD1, EDX
JMP DTHR1
DTH5 :
MOV EBX, 1000
DIV EBX
MOV EDX, 0
MOV EBX, 10
DIV EBX
SHL EDX, 12
ADD InputBTD1, EDX
JMP DTHR1
DTH6 :
MOV EBX, 100
DIV EBX
MOV EDX, 0
MOV EBX, 10
DIV EBX
SHL EDX, 8
ADD InputBTD1, EDX
JMP DTHR1
DTH7 :
MOV EBX, 10
DIV EBX
MOV EDX, 0
MOV EBX, 10
DIV EBX
SHL EDX, 4
ADD InputBTD1, EDX
JMP DTHR1
DTH8 :
MOV EBX, 1
DIV EBX
MOV EDX, 0
MOV EBX, 10
DIV EBX
ADD InputBTD1, EDX

MOV ECX,8
MOV EDX,0

E1:
MOV EAX,InputBTD1
CMP ECX,8
JE E11
CMP ECX,7
JE E12
CMP ECX,6
JE E13
CMP ECX,5
JE E14
CMP ECX,4
JE E15
CMP ECX,3
JE E16
CMP ECX,2
JE E17
CMP ECX,1
JE E18
R1:
LOOP E1


E11:
SHR EAX,28
AND EAX,1111b
CMP EAX,1
JA E2
JMP R1
E12:
SHR EAX,24
AND EAX,1111b
CMP EAX,1
JA E2
JMP R1
E13:
SHR EAX,20
AND EAX, 1111b
CMP EAX,1
JA E2
JMP R1
E14:
SHR EAX,16
AND EAX, 1111b
CMP EAX,1
JA E2
JMP R1
E15:
SHR EAX,12
AND EAX, 1111b
CMP EAX,1
JA E2
JMP R1
E16:
SHR EAX,8
AND EAX, 1111b
CMP EAX,1
JA E2
JMP R1
E17:
SHR EAX,4
AND EAX, 1111b
CMP EAX,1
JA E2
JMP R1
E18:
AND EAX, 1111b
CMP EAX,1
JA E2


CAL:
call CalBTD
MOV EDX, OFFSET MenuOutputBTD
call WriteString
MOV EAX, InputBTD1
call WriteHex
MOV EDX, OFFSET MenuOutputBTDa
call WriteString
MOV EAX, AnsBTD
call WriteDec
MOV EDX, OFFSET MenuOutputBTDb
call WriteString
call Crlf
call Crlf
JMP HERE

;Decimal To Binary Section
DTB:
MOV EDX, OFFSET MenuInputDTB
call WriteString
call ReadInt
MOV InputDTB, AX
CMP AX,255
JA E2
MOV EDX, OFFSET MenuOutputDTB
call WriteString
MOV AX, InputDTB
call WriteDec
call CalDTB
MOV EDX, OFFSET MenuOutputDTBa
call WriteString
MOV EAX, AnsDTB
call WriteHex
MOV EDX, OFFSET MenuOutputDTBb
call WriteString
call Crlf
call Crlf
JMP HERE

EOP:
MOV EDX, OFFSET EndStr
call WriteString

exit
main ENDP

;---------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------------------------


;Menu
MENU PROC
MOV EDX, OFFSET Menu0
call WriteString
call Crlf
MOV EDX, OFFSET Menu1
call WriteString
call Crlf
MOV EDX, OFFSET Menu2
call WriteString
call Crlf
MOV EDX, OFFSET Menu3
call WriteString
call Crlf
MOV EDX, OFFSET Menu4
call WriteString
call Crlf
MOV EDX, OFFSET MenuChoice
call WriteString
call ReadDec
MOV Choice, AL

ret
MENU ENDP

;---------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------------------------

CalBTD PROC
MOV AnsBTD, 0
TEST InputBTD1, 10000000h
JNZ L1
LB1 :
TEST InputBTD1, 1000000h
JNZ L2
LB2 :
TEST InputBTD1, 100000h
JNZ L3
LB3 :
TEST InputBTD1, 10000h
JNZ L4
LB4 :
TEST InputBTD1, 1000h
JNZ L5
LB5 :
TEST InputBTD1, 100h
JNZ L6
LB6 :
TEST InputBTD1, 10h
JNZ L7
LB7 :
TEST InputBTD1, 1h
JNZ L8
LB8:
JMP L9

L1 :
ADD AnsBTD, 128d
JMP LB1
L2 :
ADD AnsBTD, 64d
JMP LB2
L3 :
ADD AnsBTD, 32d
JMP LB3
L4 :
ADD AnsBTD, 16d
JMP LB4
L5 :
ADD AnsBTD, 8d
JMP LB5
L6 :
ADD AnsBTD, 4d
JMP LB6
L7 :
ADD AnsBTD, 2d
JMP LB7
L8 :
ADD AnsBTD, 1d
JMP LB8
L9:
ret
CalBTD ENDP

;---------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------------------------

CalDTB PROC
MOV AnsDTB, 0
CMP InputDTB, 128d
JGE LC1
LD1 :
CMP InputDTB, 64d
JGE LC2
LD2 :
CMP InputDTB, 32d
JGE LC3
LD3 :
CMP InputDTB, 16d
JGE LC4
LD4 :
CMP InputDTB, 8d
JGE LC5
LD5 :
CMP InputDTB, 4d
JGE LC6
LD6 :
CMP InputDTB, 2d
JGE LC7
LD7 :
CMP InputDTB, 1d
JGE LC8
LD8 :
JMP LC9

LC1 :
ADD AnsDTB, 10000000h
SUB InputDTB, 128d
JMP LD1
LC2 :
ADD AnsDTB, 1000000h
SUB InputDTB, 64d
JMP LD2
LC3 :
Add AnsDTB, 100000h
SUB InputDTB, 32d
JMP LD3
LC4 :
Add AnsDTB, 10000h
SUB InputDTB, 16d
JMP LD4
LC5 :
Add AnsDTB, 1000h
SUB InputDTB, 8d
JMP LD5
LC6 :
Add AnsDTB, 100h
SUB InputDTB, 4d
JMP LD6
LC7 :
Add AnsDTB, 10h
SUB InputDTB, 2d
JMP LD7
LC8 :
Add AnsDTB, 1h
SUB InputDTB, 1d
JMP LD8
LC9:
ret
CalDTB ENDP

END main