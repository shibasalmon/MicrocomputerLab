.model small

.data
A dw 340dh
B dw 0005h
D dw 0ff00h
r1 dw ?
r2 dw ?

.stack

.code 
main proc
    mov ax, @data
    mov ds, ax
    mov ax, 0200h
    mov dl, 'A'
    int 21h
    mov dl, '*'
    int 21h
    mov dl, 'B'
    int 21h

    mov dl, 0ah
    int 21h
    mov dl, 0dh
    int 21h

    mov ax, A
    imul B

    mov r1, dx
    mov r2, ax
    mov ax, 0200h

    mov dx, r1
    mov cl, 00h
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    add dx, 30h
    int 21h

    mov dx, r1
    mov cl, 04h
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    add dx, 30h
    int 21h

    mov dx, r1
    mov cl, 08h
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    add dx, 30h
    int 21h

    mov dx, r1
    mov cl, 0ch
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    add dx, 30h
    int 21h

    mov dx, r2
    mov cl, 00h
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    add dx, 30h
    int 21h

    mov dx, r2
    mov cl, 04h
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    add dx, 30h
    int 21h

    mov dx, r2
    mov cl, 08h
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    add dx, 30h
    int 21h

    mov dx, r2
    mov cl, 0ch
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    add dx, 30h
    int 21h

    mov dl, 0ah
    int 21h
    mov dl, 0dh
    int 21h

    mov dx, r1
    mov ax, r2
    idiv D

    mov r1, dx
    mov ax, 0200h

    mov dx, r1
    mov cl, 00h
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    add dx, 30h
    int 21h

    mov dx, r1
    mov cl, 04h
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    add dx, 30h
    int 21h

    mov dx, r1
    mov cl, 08h
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    add dx, 30h
    int 21h

    mov dx, r1
    mov cl, 0ch
    shl dx, cl
    mov cl, 0ch
    shr dx, cl
    add dx, 30h
    int 21h

    mov ax, 4c00h
    int 21h
main endp
end main