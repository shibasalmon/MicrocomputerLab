.model small

.data
    array dw 0001h, 0020h, 0300h, 4000h
    lengthof_array = ($-array)/2
.stack

.code
main proc
    mov ax, @data
    mov ds, ax
    mov ax, offset array
    push ax
    mov ax, lengthof_array
    push ax
    call sum
    call print
    mov ax, 4c00h
    int 21h
main endp

sum proc
    mov ax, 00h
    mov bp, sp
    mov bx, [bp+4]
    mov cx, [bp+2]
    add_all:
        add ax, [bx]
        add bx, 02h
    loop add_all
    ret 4
sum endp

print proc
    mov cx, 04h
    mov bx, 00h
    print_single_number:
        push ax
        push cx
        mov dx, ax
        mov cl, bl
        shl dx, cl
        mov cl, 0ch
        shr dx, cl
        add dx, 30h
        add bx, 04h
        mov ax, 0200h
        int 21h
        pop cx
        pop ax
    loop print_single_number
    ret
print endp

end main