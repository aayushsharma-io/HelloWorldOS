; disk_load.asm
disk_load:
    pusha
    push dx

    mov ah, 0x02
    mov al, dh
    mov cl, 0x02
    mov ch, 0x00
    mov dh, 0x00

    int 0x13
    jc disk_error

    pop dx
    cmp al, dh
    jne sectors_error
    popa
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

sectors_error:
    mov bx, SECTORS_ERROR_MSG
    call print_string

DISK_ERROR_MSG: db "Disk read error!", 0
SECTORS_ERROR_MSG: db "Incorrect number of sectors read!", 0

print_string:
    pusha
    mov ah, 0x0e
.loop:
    lodsb
    test al, al
    jz .done
    int 0x10
    jmp .loop
.done:
    popa
    ret