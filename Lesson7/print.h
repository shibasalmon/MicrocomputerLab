pChar macro char
    push ax
    push dx
    mov dl, char
    mov ax, 0200h
    int 21h
    pop dx
    pop ax
endm

pString macro string
    push ax
    push dx
    mov dx, offset string
    mov ax, 0900h
    int 21h
    pop dx
    pop ax
endm