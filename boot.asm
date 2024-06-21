; boot.asm
[org 0x7c00]

mov [BOOT_DRIVE], dl

mov bp, 0x8000
mov sp, bp

mov bx, 0x7e00
mov dh, 1
mov dl, [BOOT_DRIVE]
call disk_load

jmp 0x7e00

%include "disk_load.asm"

BOOT_DRIVE: db 0

times 510 - ($ - $$) db 0
dw 0xaa55