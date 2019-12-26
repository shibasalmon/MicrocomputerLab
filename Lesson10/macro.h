PrintChar macro chr  ;輸出字元
          mov ah,02h
          mov dl,chr
          int 21h
          endm

PrintStr macro string ;輸出字串
         mov ah,09h
         mov dx,offset string
         int 21h
         endm

GetChar macro         ;等待輸入
        mov ah,10h
        int 16h
        endm

SetMode macro mode    ;設定顯示模式
        mov ah,00h
        mov al,mode
        int 10h
        endm

SetColor macro color  ;設定背景色
         mov ah,0bh 
         mov bh,00h
         mov bl,color  
         int 10h
         endm

WrPixel macro col,row,color  ;寫入像點
push ax
push bx
push cx
push dx
        mov ah,0ch
        mov bh,00h
        mov al,color
        mov cx,col
        mov dx,row
        int 10h
pop dx
pop cx
pop bx
pop ax
        endm