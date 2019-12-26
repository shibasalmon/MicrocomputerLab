include macro.h

.model small

.stack

.data
    col dw 100
    row dw 100
    pre_col dw 100
    pre_row dw 100
    color db 0ch
    h dw 40
    x_num db "x=",3 dup(' '),'$'
    y_num db "y=",3 dup(' '),'$'

.code
main proc
    mov ax, @data
    mov ds, ax

    MUS_RESET
    MUS_range_x 599, 0
    MUS_range_y 439, 0
    SET_MUS col,row
    jmp Print

    SCAN_ACTIONS:
        SCAN_MOUSE:
            MUS_GET03
            cmp bx, 1
            je LEFT_CLICK
            cmp bx, 2
            je RIGHT_CLICK
            mov col, cx
            mov row, dx
            mov di, col
            cmp di, pre_col
            jne Print
            mov di, row
            cmp di, pre_row
            jne Print
            jmp SCAN_KETBOARD
        SCAN_KETBOARD:
            mov ah, 11h
            int 16h
            jz SCAN_ACTIONS
            mov ah, 10h
            int 16h

            cmp al, 1bh
            je exit
            cmp al, 'c'
            je CHANGE_COLOR
    jmp SCAN_ACTIONS

    LEFT_CLICK:
        sub h, 10
        cmp h, 20
        jae Print
        add h, 10
        jmp Print

    RIGHT_CLICK:
        add h, 10
        cmp h, 80
        jbe Print
        sub h, 10
        jmp Print

    CHANGE_COLOR:
        inc color
        jmp Print

    Print:
        SetMode 12h
        SetColor 01h
        
        mov di, col
        mov pre_col, di
        mov di, row
        mov pre_row, di

        mov cx, h
        mov ax, h

        mov bx, col
        L1:
            mov dx, row
            sub dx, cx
            add dx, h
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

        mov di, col

    jmp SCAN_ACTIONS

    exit:
        SetMode 03h
        mov ax, 4c00h
        int 21h

main endp
end main