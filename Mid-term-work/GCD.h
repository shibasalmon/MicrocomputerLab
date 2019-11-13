GCD macro num1, num2, gcd_result
push ax
push bx
push cx
push dx
push num1
push num2
    mov cx, 0ffffh
    gcd_while:
        cmp num2, 00h
        je end_gcd
        mov ax, num1
        mov bx, num2
        mov dx, 00h
        div bx
        mov num1, bx
        mov num2, dx
    loop gcd_while
    end_gcd:
    mov dx, num1
    mov gcd_result, dx
pop num2
pop num1
pop dx
pop cx
pop bx
pop ax
endm