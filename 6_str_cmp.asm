;include read.inc 
;include write.inc 
;include display.inc

read macro
mov ah,01h
int 21h
endm

write macro
mov ah,02h
int 21h
endm

display macro msg
lea dx,msg
mov ah,09h
int 21h
endm

data segment 
msg1 db "Enter string1 $" 
msg2 db "Enter string2 $"
msg3 db "Strings are same $"
msg4 db "Strings are not same $"
str1 db 100h dup(?) 
str2 db 100h dup(?)
data ends  

code segment
assume cs:code,ds:data 

start:
mov ax,data 
mov ds,ax 

;read str1 
display msg1
lea si,str1
mov cx,00h

read1:
read 
mov [si],al 
inc si 
inc cx
cmp al,0dh 
jnz read1

;read str2
display msg2
lea di,str2
mov bx,00h

read2:
read 
mov [di],al 
inc di 
inc bx
cmp al,0dh 
jnz read2 

lea si,str1 
lea di,str2

cmp bx,cx 
jnz noteql

comp_loop:
mov al,[si] 
mov bl,[di] 
cmp al,bl 
jnz noteql
inc si 
inc di 
dec cx 
cmp cx,0 
jnz comp_loop

display msg3 
jmp exit

noteql:
display msg4 

exit:
mov ah,4ch
int 21h
code ends 
end start
