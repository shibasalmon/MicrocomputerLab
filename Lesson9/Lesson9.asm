include ./INCLUDE/Irvine16.inc
.model small

.data

.stack 100h

.code
main proc

    mov ax, @data
    mov ds, ax

    init:
        mov ah, 03h
        int 10h
        mov bl, 0fh

    L1:
        mov ah, 10h
        int 16h
        cmp al, 00h
        je CHECK_F1
        cmp al, 1bh
        je exitout

        mov ah, 09h
        mov cx, 02h
        int 10h

        mov ah, 03h
        int 10h

        mov ah, 02h
        add dl, 02h
        inc dh
        int 10h

        jmp L1
    CHECK_F1:
        cmp ah, 3bh
        jne CHECK_F2
        call CHANGE_CURSOR
        jmp L1
    CHECK_F2:
        cmp ah, 3ch
        jne CHECK_F3
        call CHANGE_BACKCOLOR
        jmp L1
    CHECK_F3:
        cmp ah, 3dh
        jne CHECK_F4
        call CHANGE_CHCOLOR
        jmp L1
    CHECK_F4:
        cmp ah, 3eh
        jne L1
        call CHANGE_INT
        jmp L1

    exitout:
        mov ax, 4c00h
        int 21h
main endp

CHANGE_CURSOR proc
    mov ah, 03h
    int 10h
    cmp ch, 00h
    jne nz_cursor
    mov ch, 10h
    nz_cursor: 
    dec ch
    mov ah, 01h
    int 10h
    ret
CHANGE_CURSOR endp

CHANGE_BACKCOLOR proc
    mov ah, 08h
    int 10h
    cmp bl, 0f0h
    jae nz_bc
    sub bl, 0f0h
    ret
    nz_bc:
    add bl, 10h
    ret
CHANGE_BACKCOLOR endp

CHANGE_CHCOLOR proc
    push dx
    mov ah, 08h
    int 10h
    mov dl, bl
    and dl, 0fh
    cmp dl, 0fh
    jne nz_cc
    mov bl, 00h
    pop dx
    ret
    nz_cc:
    inc bl
    pop dx
    ret
CHANGE_CHCOLOR endp

CHANGE_INT proc
    mov ax, 20
    call RandomRange
    ret
CHANGE_INT endp

end main