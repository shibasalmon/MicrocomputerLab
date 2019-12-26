include macro.h
 
.model small
.stack
.data
x dw 0
y dw 0
mus_max_h dw 439	
mus_max_v dw 599
x_num db "x=",3 dup(' '),'$'
y_num db "y=",3 dup(' '),'$'
tri_size dw 40
count dw 0
color db 06h
.code

;輸出三角形
pnt_triangle proc 
 intit_set:
	mov cx,x
	mov dx,y
	mov count,0	;計數
	mov di,1	;每列輸出幾個
 Print:
	WrPixel cx,dx,color
	inc count
	inc cx
	cmp count,di
	jb Print
 next_row:
	inc di	;下一列
	cmp di,tri_size
	ja over
	mov cx,x
	mov count,0
	inc dx
	jmp Print
 over:
	mov cx,x
	mov dx,y
	ret
pnt_triangle 	endp

;十六進制轉十進制轉ASCII
valueToASCII proc    
	mov cx,0
	mov bl,10
 Hex2Asc:
	div bl
	mov dl,ah
	add dl,30h
	push dx
	inc cx	
	mov ah,0
	cmp al,0
	jne Hex2Asc
 addSpace:
	cmp cx,3
	je keepPnt
	mov dl,' '
	push dx
	inc cx
	jmp addSpace	
 keepPnt:
	pop ax
	PrintChar al
	loop keepPnt
	ret
valueToASCII endp	

;延遲
Delay proc	
	mov  cx,2
 L1:
	push cx
	mov cx,65535
 L2:
	loop L2
	pop cx
	loop L1
	ret
Delay	endp

;無等待的輸入
SCANIN	proc 
	mov ah,06h
	mov dl,0ffh
	int 21h
	ret
SCANIN	endp

main proc
	mov ax,@data
	mov ds,ax
	
	SetMode	12h	;設定繪圖模式12h
	SetColor 01h	;設定背景色藍色

	;初始位置
	mov x,10
	mov y,10	

	MUS_RESET
	MUS_range_x mus_max_v,0	;設定滑鼠游標水平的範圍0~599	
	MUS_range_y mus_max_h,0	;設定滑鼠游標垂直的範圍0~439	
	SET_MUS x,y	;設定滑鼠游標位置
Prt_str_tri:
	SetCursor 0,0
	mov ax,x
	call valueToASCII
	SetCursor 1,0
	mov ax,y
	call valueToASCII
	call pnt_triangle
	mov bl,color
	call Delay
Rekey:
	call SCANIN
	cmp al,1bh
	je Exit
	cmp al,'c'
	jne Clear_tri
	add color,1
	mov bl,color
Clear_tri:
	mov color,00h
	call pnt_triangle
	mov color,bl
Mouse_state:
	MUS_GET03
	mov x,cx
	mov y,dx
	cmp bx,1
	je Left_click
	cmp bx,2
	je Right_click
	jmp Prt_str_tri
Left_click:
	cmp tri_size,80
	je Prt_str_tri
	add tri_size,10
	sub mus_max_v,10
	sub mus_max_h,10
	MUS_range_x mus_max_v,0	;設定滑鼠游標水平的範圍
	MUS_range_y mus_max_h,0	;設定滑鼠游標垂直的範圍
	jmp Prt_str_tri
Right_click:
	cmp tri_size,20
	je Prt_str_tri
	sub tri_size,10
	add mus_max_v,10
	add mus_max_h,10
	MUS_range_x mus_max_v,0	;設定滑鼠游標水平的範圍
	MUS_range_y mus_max_h,0	;設定滑鼠游標垂直的範圍
	jmp Prt_str_tri
Exit:
	SetMode	03h	;設定文字模式03h
	mov ax,4c00h
	int 21h
main endp
end main
