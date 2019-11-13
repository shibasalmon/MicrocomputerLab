inputNum macro num1, num2
push ax
push cx
push bx
push dx
    mov num1, 0000h
    mov cx, 0ffffh
    input_while1: 
    push cx
        mov ah, 00h
        int 16h
        pChar al
        cmp al, '0'
        jb not_a_number1
        cmp al, '9'
        ja not_a_number1
        a_number1:
            sub ax, '0'
            jmp assign_to_num1
        not_a_number1:
            cmp al, 'a'
            jb end_input1
            cmp al, 'f'
            ja end_input1
            sub ax, 'a'
            add ax, 0ah
        assign_to_num1:
            mov cl, 04h
            shl num1, cl
            add num1, ax
    pop cx
    loop input_while1
    end_input1:
    and num1, 00ffh

    mov num2, 0000h
    mov cx, 0ffffh
    input_while2: 
    push cx
        mov ah, 00h
        int 16h
        pChar al
        cmp al, '0'
        jb not_a_number2
        cmp al, '9'
        ja not_a_number2
        a_number2:
            sub ax, '0'
            jmp assign_to_num2
        not_a_number2:
            cmp al, 'a'
            jb end_input2
            cmp al, 'f'
            ja end_input2
            sub ax, 'a'
            add ax, 0ah
        assign_to_num2:
            mov cl, 04h
            shl num2, cl
            add num2, ax
    pop cx
    loop input_while2
    end_input2:
    and num2, 00ffh

    mov ax, 0200h
    mov dl, 0ah
    int 21h
pop dx
pop cx
pop bx
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

outputGCD macro gcd_result
push ax
push bx
push cx
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

        cmp dx, 0ah
        jae not_a_number_output_gcd
        a_number_output_gcd:
            add dx, 30h
            jmp output_num_gcd
        not_a_number_output_gcd:
            add dx, 'a'
            sub dx, 0ah
        output_num_gcd:
            int 21h
            add bx, 04h
    pop cx
    loop print_Loop_gcd
pop cx
pop bx
pop ax
endm

outputLCM macro lcm_result
push ax
push bx
push cx
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

        cmp dx, 0ah
        jae not_a_number_output_lcm
        a_number_output_lcm:
            add dx, 30h
            jmp output_num_lcm
        not_a_number_output_lcm:
            add dx, 'a'
            sub dx, 0ah
        output_num_lcm:
            int 21h
            add bx, 04h
    pop cx
    loop print_Loop_lcm
pop cx
pop bx
pop ax
endm