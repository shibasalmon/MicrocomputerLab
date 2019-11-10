.model small

.data
value dw 0ffffh, 0003h, 7fffh, 8123h
result db 4 dup(?), '$'

.stack

.code
main proc
    mov ax, @data
    mov ds, ax
    mov ax, value[0]
    add ax, value[0]
    add ax, value[2]
    add ax, value[4]
    add ax, value[6]

    mov dx, ax
    mov cl, 0ch
    shr dx, cl
    mov result[0], dl

    mov dx, ax
    mov cl, 04h
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    mov result[1], dl

    mov dx, ax
    mov cl, 08h
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    mov result[2], dl

    mov dx, ax
    mov cl, 0ch
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    mov result[3], dl
    
    add result[0], 30h
    add result[1], 30h
    add result[2], 30h
    add result[3], 30h

    mov dx, offset result
    mov ax, 0900h
    int 21h
    mov ax, 4c00h
    int 21h
main endp
end main