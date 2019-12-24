include print.h
include getkey.h

.model small

.data
    mes db 'Press ESC to exit', 0ah, 0dh, '$'

.stack

.code
main proc
    mov ax, @data
    mov ds, ax

    pString mes
    L1: 
        getkey
        cmp al, 1bh
        je L2
        pChar al
        jmp L1
    L2: 
        mov ax, 4c00h
        int 21h
main endp
end main
