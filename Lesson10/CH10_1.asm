include macro.h

.model small
.stack
.data
string db "Press any key$"
.code
main proc
	mov ax,@data
	mov ds,ax

	SetMode 12h  ;繪圖模式
	SetColor 05h ;背景紫紅色

	mov dx,140
	mov cx,220

L1:
	cmp cx,420
	je over
	WrPixel cx,dx,0eh ;寫入像點
	inc cx
	jmp L1

over:
 	PrintStr string
	GetChar
	SetMode 03h
	mov ax,4c00h
	int 21h
main endp
end main
