.model small

.data
    array db 12h, 11h, 99h, 28h, 70h, 16h
.stack

.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov cx, 05h
    bubbleSort:
        push cx
        mov dx, 05h
        sub dx, cx
        move:
            mov bx, 05h
            sub bx, cx
            sub bx, dx
            mov al, array[bx]
            add bx, 01h
            mov ah, array[bx]
            cmp al, ah
            jb next
            mov array[bx], al
            sub bx, 01h
            mov array[bx], ah
            next:
        loop move
        pop cx
    loop bubbleSort

    mov cx, 06h
    printArray:
        push cx
        mov dx, cx
        mov cx, 02h
        print:
            push cx
            push dx
            mov bx, 06h
            sub bx, dx
            mov dl, array[bx]

            mov ax, 04h
            sub ax, cx
            mov bx, 04h
            mul bl
            mov cx, ax
            shl dx, cl
            mov cl, 0ch
            shr dx, cl
            add dx, 30h
            mov ax, 0200h
            int 21h
            pop dx
            pop cx
        loop print

        mov ax, 0200h
        mov dl, ' '
        int 21h

        pop cx
    loop printArray
    mov ax, 4c00h
    int 21h
main endp
end main