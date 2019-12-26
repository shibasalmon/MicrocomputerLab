include macro.h

.model small

.stack

.data
    col dw (640/2-20)
    row dw (480/2-20)
    color db 0ch
    string db "Press any key$"
.code
main proc
    mov ax, @data
    mov ds, ax

    jmp Print

    Keyin:
        mov ah, 11h
        int 16h
        jz Keyin
        mov ah, 10h
        int 16h

        cmp al, 1bh
        je exit
        cmp al, '8'
        je UP
        cmp al, '2'
        je DOWN
        cmp al, '4'
        je LEFT
        cmp al, '6'
        je RIGHT
        cmp al, '5'
        je ChangeColor
    jmp Keyin

    UP:
        sub row, 04h
        jmp Print
    DOWN:
        add row, 04h
        jmp Print
    LEFT:
        sub col, 04h
        jmp Print
    RIGHT:
        add col, 04h
        jmp Print
    ChangeColor:
        inc color
        jmp Print

    Print:
        SetMode 12h
        SetColor 0bh
        mov cx, 40
        mov ax, 40

        mov bx, col
        L1:
            mov dx, row
            sub dx, cx
            add dx, 40
            push cx
            mov cx, ax
            L2:
                push cx
                mov cx, bx
                WrPixel cx, dx, color
                pop cx
                inc dx
            loop L2
            pop cx

            dec ax
            inc bx
        loop L1
    jmp Keyin

    
    exit:
        PrintStr string
        SetMode 03h
        mov ax, 4c00h
        int 21h
main endp
end main