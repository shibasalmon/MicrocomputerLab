inputNum macro num1, num2 ;input two numbers
push ax
push cx
push dx
;;; input num1
    mov num1, 0000h
    mov cx, 0ffffh
    input_while1: ;input num1's loop
    push cx
        mov ah, 00h
        int 16h
        pChar al ;display input
    ;;; judge input is a number or letter?
        cmp al, '0'
        jb end_input1
        cmp al, '9'
        ja end_input1
        mov cl, 04h
        shl num1, cl
        sub ax, '0'
        add num1, ax
    ;;; judge input is a number or letter?
    pop cx
    loop input_while1
    end_input1:
    and num1, 00ffh
;;; revise to number to base-10
    mov ax, num1
    mov bl, 10h
    div bl
    mov bl, al
    mov ax, 06h
    mul bl
    sub num1, ax
;;; revise to number to base-10
;;; input num1

;;; input num2
    mov num2, 0000h
    mov cx, 0ffffh
    input_while2: ;input num2's loop
    push cx
        mov ah, 00h
        int 16h
        pChar al ;display input
    ;;; judge input is a number or letter?
        cmp al, '0'
        jb end_input2
        cmp al, '9'
        ja end_input2
        mov cl, 04h
        shl num2, cl
        sub ax, '0'
        add num2, ax
    ;;; judge input is a number or letter?
    pop cx
    loop input_while2
    end_input2:
    and num2, 00ffh
;;; revise to number to base-10
    mov ax, num2
    mov bl, 10h
    div bl
    mov bl, al
    mov ax, 06h
    mul bl
    sub num2, ax
;;; revise to number to base-10
;;; input num2

;;; new line
    mov ax, 0200h
    mov dl, 0ah
    int 21h
;;; new line
pop dx
pop cx
pop ax
endm

pChar macro char
    push ax
    push dx
    mov dl, char
    mov ax, 0200h
    int 21h
    pop dx
    pop ax
endm

outputGCD macro gcd_result ;print gcd
push ax
push bx
push cx
push gcd_result
    mov ax, gcd_result
    mov bl, 0ah
    div bl
    mov bl, al
    mov ax, 06h
    mul bl
    add gcd_result, ax

    mov ax, 0200h
    mov bx, 08h
    mov cx, 02h
    print_loop_gcd:
    push cx
        mov dx, gcd_result
        mov cl, bl
        shl dx, cl
        mov cl, 0ch
        shr dx, cl
        add dx, '0'

        int 21h
        add bx, 04h
    pop cx
    loop print_Loop_gcd
pop gcd_result
pop cx
pop bx
pop ax
endm

outputLCM macro lcm_result ;print lcm
push ax
push bx
push cx
push lcm_result
    mov ax, lcm_result
    mov bl, 0ah
    div bl
    mov bl, al
    mov ax, 06h
    mul bl
    add lcm_result, ax

    mov ax, 0200h
    mov bx, 08h
    mov cx, 02h
    print_loop_lcm:
    push cx
        mov dx, lcm_result
        mov cl, bl
        shl dx, cl
        mov cl, 0ch
        shr dx, cl
        add dx, '0'

        int 21h
        add bx, 04h
    pop cx
    loop print_Loop_lcm
pop lcm_result
pop cx
pop bx
pop ax
endm