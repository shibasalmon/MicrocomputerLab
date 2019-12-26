include macro.h

.model small
.stack
.data
x_num db "x=",3 dup(' '),'$'
y_num db "y=",3 dup(' '),'$'
.code
main proc
	
	mov ax,@data
	mov ds,ax

	MUS_RESET ;滑鼠重置
	MUS_SHOW ;顯示滑鼠游標	

move_mouse:
	call SCANIN ;呼叫無等待輸入
	cmp al,1bh
	je Exit
	mov di,offset x_num 
	call clear ;清除x_num字串的後三個字元
	mov di,offset y_num
	call clear ;清除y_num字串的後三個字元
	MUS_GET03 ;取得滑鼠狀態及游標位置
	push dx ;dx為滑鼠y座標
	mov ax,cx ;cx為滑鼠x座標
	mov di,offset x_num 
	call tran ;x座標轉換為十進制
	pop ax
	mov di,offset y_num
	call tran ;y座標轉換為十進制
	
	SetCursor 0,0 ;設定游標位置
	PrintStr x_num
	SetCursor 1,0 ;設定游標位置
	PrintStr y_num
	jmp move_mouse
Exit:
	MUS_HIND ;隱藏滑鼠游標
	mov ax,4c00h
	int 21h

main endp

;清除字串的後三個字元
clear proc  
	mov cx,3
 L1:
	mov al,' '
	mov [di+2],al
	inc di
	loop L1
	ret
clear endp

;十六進制轉十進制
tran proc    
	mov cx,0
Hex2Dec:
	inc cx
	mov bx,10
	mov dx,0
	div bx
	push dx
	cmp ax,0
	jne Hex2Dec	
dec2Ascll:
	pop ax
	add al,30h
	mov [di+2],al
	inc di
	loop dec2Ascll
	ret			
tran endp	

;無等待的輸入
SCANIN	proc 
	mov ah,06h
	mov dl,0ffh
	int 21h
	ret
SCANIN	endp
end main


