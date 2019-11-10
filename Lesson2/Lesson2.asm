.model small

.data
value1 dw 0ffffh
value2 dw 0003h
value3 dw 7fffh
value4 dw 8123h

.stack

.code
main proc
    mov ax, @data
    mov ds, ax
    mov ax, 0
    add ax, value1
    add ax, value1
    add ax, value2
    add ax, value3
    add ax, value4
    ; print the value of ax
    mov bx, ax
    mov ax, 0200h

    mov dx, bx
    mov cl, 0ch
    shr dx, cl
    add dx, 30h
    int 21h

    mov dx, bx
    mov cl, 04h
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    add dx, 30h
    int 21h

    mov dx, bx
    mov cl, 08h
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    add dx, 30h
    int 21h

    mov dx, bx
    mov cl, 0ch
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    add dx, 30h
    int 21h
    ;
    mov ax, 4c00h
    int 21h
main endp
end main