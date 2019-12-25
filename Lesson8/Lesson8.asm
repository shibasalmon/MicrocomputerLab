.model small

.data

.stack

.code
main proc
    mov ax, @data
    mov ds, ax

    L1:
        mov dl, 2eh
        mov ah, 02h
        int 21h
        mov cx, 32

    L2:
        push cx
        mov cx, 0ffffh

    L3:
        call CheckKeyboard
        loop L3
        pop cx
        loop L2
        jmp L1

        mov ax, 4c00h
        int 21h
main endp

CheckKeyboard proc
    push ax
    mov ah, 11h
    int 16h
    jz quit

    mov ah, 10h
    int 16h
    cmp al, 1bh
    je quit1
    cmp ah, 48h
    je UP
    cmp ah, 50h
    je DOWN
    cmp ah, 4Bh
    je LEFT
    cmp ah, 4Dh
    je RIGHT
    jmp quit

    UP:
        mov dl, 'U'
        mov ah, 02h
        int 21h
        jmp quit
    DOWN:
        mov dl, 'D'
        mov ah, 02h
        int 21h
        jmp quit
    LEFT:
        mov dl, 'L'
        mov ah, 02h
        int 21h
        jmp quit
    RIGHT:
        mov dl, 'R'
        mov ah, 02h
        int 21h
        jmp quit
    quit1:
        mov ax, 4c00h
        int 21h
    
    quit:
        pop ax
        ret
CheckKeyboard endp
end main