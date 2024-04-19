TITLE Addand Subtract, Version 2
; This program addsand subtracts 8 and 16 bit
; unsigned integersand stores the sum in a variable
INCLUDE Irvine32.inc
.data
finalVal DWORD ?
.code
main PROC
mov eax, 10000h; start with 10000h
add eax, 40000h; add 40000h
sub eax, 20000h; subtract 20000h
mov finalVal, eax; store the result(30000h)
call DumpRegs; display the registers
exit
main ENDP
END main


