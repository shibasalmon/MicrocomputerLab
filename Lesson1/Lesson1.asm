.model small

.data
mes db '===================', 0ah, 0dh, 'My ID is M123456789', 0ah, 0dh, '===================$'

.stack 100h

.code
main proc
    mov ax, @data
    mov ds, ax
    mov dx, offset mes
    mov ax, 0900h
    int 21h
    mov ax, 4c00h
    int 21h
main endp
end main
