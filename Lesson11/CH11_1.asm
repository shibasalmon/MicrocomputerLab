include macro.h

.model small
.stack
.data
y_mouse db "Have mouse",10,13,"$"
n_mouse db "No mouse",10,13,"$"
Left db "Left",10,13,"$"
Right db "Right",10,13,"$"
Right_Left db "Right_Left",10,13,"$"
Two db "Two",10,13,"$"
Three db "Three",10,13,"$"
.code
main proc
	
	mov ax,@data
	mov ds,ax

	MUS_RESET ;滑鼠重置

	cmp ax,0000h ;ax=0000h 滑鼠未安裝 
	je No_mouse
	PrintStr y_mouse
	cmp bx,0002h ;bx=0002h 兩鍵式滑鼠
	jne Mouse3
	PrintStr Two
	jmp Next
Mouse3:
	cmp bx,0003h ;bx=0003h 三鍵式滑鼠
	jne Exit
	PrintStr Three
Next:
	MUS_SHOW ;顯示滑鼠游標
	
Click_mouse:
	call SCANIN ;呼叫無等待的輸入
	cmp al,1bh
	je Exit
	call delay
	MUS_GET03 ;取得滑鼠狀態及游標位置
	cmp bx,1 ;是否左鍵按下
	je Click_left
	cmp bx,2 ;是否右鍵按下
	je Click_right
	cmp bx,3 ;是否左右鍵同時按下
	je Click_left_right
	jmp Click_mouse 
Click_left:
	PrintStr Left
	jmp Click_mouse
Click_right:
	PrintStr Right
	jmp Click_mouse
Click_left_right:
	PrintStr Right_Left
	jmp Click_mouse
No_mouse:
	PrintStr n_mouse
Exit:
	MUS_HIND ;隱藏滑鼠游標
	mov ax,4c00h
	int 21h
main endp

;延遲
Delay proc
	mov cx,0000h
 L1:
	mov bp,0800h
 L2:
 	dec bp
 	cmp bp,0
	jnz L2
	loop L1
	ret
Delay endp

;無等待的輸入
SCANIN proc
	mov ah,06h
	mov dl,0ffh
	int 21h
	ret
SCANIN endp

end main

