; You can change the including library to switch between base-10 or base-16 ;
include io10.h
;include io16.h
include GCD.h

.model small

.data
    num1 dw 0000h
    num2 dw 0000h
    gcd_result dw 0000h
    lcm_result dw 0000h
    msg db 'Input two numbers: $'

.stack 100h
    
.code
main proc
    mov ax, @data
    mov ds, ax

    mov ax, 0900h
    lea dx, msg
    int 21h

    inputNum num1, num2 ;input two numbers
    GCD num1, num2, gcd_result ;find the gcd
    outputGCD gcd_result ;print gcd

;;; compute the lcm
    mov ax, 0200h
    mov dl, 0ah
    int 21h

    mov ax, num1
    mov bx, num2
    mul bl

    mov dx, 00h
    mov bx, gcd_result
    div bx
    mov lcm_result, ax
    and lcm_result, 00ffh
;;; compute the lcm

    outputLCM lcm_result ;print lcm

    mov ax, 4c00h
    int 21h
main endp
end main