ORG 0
BITS 16

start:
    cli
    mov ax, 0x7c0
    mov ds, ax
    mov es, ax
    mov ax, 0x00
    mov ss, ax
    sti 

    mov ax, 0x7c0
    mov word[ss:0x202], ax
    lea ax,[print]
    mov word[ss:0x200], ax
    lea si,[message]
    int 0x80
    jmp $

print:
    mov bx, 0
.loop:
    lodsb

    cmp al, 0
    je  .done

    call print_char
    jmp .loop
.done:
    iret

print_char:
    mov ah,0eh

    int 0x10

    ret

message: db 'Hello World', 0
isr_message: db 'Interrupt Happen', 0

times 510-($-$$) db 0

dw 0xAA55
