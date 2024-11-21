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
    mov word[ss:0x02], ax
    mov ax, div_zero_handler
    mov word[ss:0x00], ax
    mov ax, 0
    div ax
    jmp $
div_zero_handler:
    mov si, div_zero_message
    call print
    iret

print:
    mov bx, 0
.loop:
    lodsb

    cmp al, 0
    je  .done

    call print_char
    jmp .loop
.done:
    ret

print_char:
    mov ah,0eh

    int 0x10

    ret

div_zero_message: db 'Divide by zero error,',0
message: db 'Hello World', 0
isr_message: db 'Interrupt Happen', 0

times 510-($-$$) db 0

dw 0xAA55
