include inout.asm
.model small, c
.486
.stack 100h
; convert to Binary

.data
    msg db 'Enter an integer: $'
    input db 17,?, 17 dup(0)
    nl db 13, 10, '$'
    output_msg db 'in Binary: $'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 09h
    lea dx, msg
    int 21h

    mov ah, 0Ah
    lea dx, input
    int 21h

    mov cx, 16
    mov si, offset input+2 
    mov al, [si]
    sub al, '0'
    mov bl, al

convert_loop:
    mov dl, '0'
    test bl, 1
    jz zero_bit
    mov dl, '1'
zero_bit:
    mov [si], dl
    inc si
    shr bl, 1
    loop convert_loop

    lea dx, nl
    mov ah, 09h
    int 21h
    lea dx, output_msg
    mov ah, 09h
    int 21h
    lea dx, input+2 
    mov ah, 09h
    int 21h

    mov ah, 4ch
    int 21h
main endp
end main