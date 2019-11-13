include io10.h
;include io16.h
include GCD.h

.model small

.data
    num1 dw 0000h
    num2 dw 0000h
    gcd_result dw 0000h
    lcm_result dw 0000h
    t dw 0000h

.stack 100h
    
.code
main proc
    mov ax, @data
    mov ds, ax

    inputNum num1, num2
    GCD num1, num2, gcd_result
    outputGCD gcd_result

    mov ax, 0200h
    mov dl, 0ah
    int 21h

    mov ax, num1
    mov bx, num2
    mul bl

    mov bx, gcd_result
    div bl
    mov lcm_result, ax
    and lcm_result, 00ffh
    outputLCM lcm_result
    mov ax, 4c00h
    int 21h
main endp
end main