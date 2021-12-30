; nasm boot_sector.asm -f bin -o boot.bin
;bits 16
[org 0x7c00]

; set the stack 
mov bp, 0x9000
mov sp, bp 

mov bx, MSG_REAL_MODE
call print_message

call switch_to_pm

jmp $ 

%include "print_message.asm"
%include "disk_load.asm"
%include "gdt.asm"
%include "print_message_pm.asm"
%include "switch_to_pm.asm"

BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_message_pm
    
    jmp $



MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Successfully landed in 32-bit Protected Mode", 0

; boot sector 
times 510 - ( $ - $$) db 0 ; First 512 will be the boot sector, this helps us to fill the other 510 bytes with 0s
dw 0xaa55 ; BIOS boot block number, will be presented as 55 AA because of endianness
; If the BIOS sees that last two bytes are equal to x55aa, it jumps to 0x7c00 

times 256 dw 0xdada
times 256 dw 0xface
