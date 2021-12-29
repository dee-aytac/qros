; nasm boot_sector.asm -f bin -o boot.bin
;bits 16
[org 0x7c00]

; BIOS stores the boot drive in dl, to save to use it for later

mov [BOOT_DRIVE], dl

; setting the stack 
mov bp, 0x8000
mov sp, bp 

; read 2 sectors, not 5, there is an error in the book!!
mov bx, 0x9000
mov dh, 2; 
mov dl, [BOOT_DRIVE]
call disk_load

mov dx, [0x9000]
call print_hex

mov dx, [0x9000 + 512]
call print_hex
jmp $ 

%include "print_message.asm"
%include "disk_load.asm"



BOOT_DRIVE: db 0 


;msg: db "Hello world!", 0
;msg_2: db "Booting OS!", 0
times 510 - ( $ - $$) db 0 ; First 512 will be the boot sector, this helps us to fill the other 510 bytes with 0s

dw 0xaa55 ; BIOS boot block number, will be presented as 55 AA because of endianness
; If the BIOS sees that last two bytes are equal to x55aa, it jumps to 0x7c00 

times 256 dw 0xdada
times 256 dw 0xface
