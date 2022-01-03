; https://en.wikipedia.org/wiki/INT_13H

disk_load:
    push dx ; save dx to compare if we read all the sectors successfully
    
    mov ah, 0x02 ; bios read function
    mov al, dh ; al = sectors to read 
    mov ch, 0x00 ; cylinder index
    mov dh, 0x00 ; head index
    mov cl, 0x02 ; sector index

    int 0x13 
    jc disk_error ; jumps if read failed

    pop dx 
    cmp dh, al 
    jne disk_error ; jumps if couldn't read all the sectors successfully
    ret 

disk_error:
    mov bx, DISK_ERROR_MSG 
    call print_message
    jmp $

DISK_ERROR_MSG: db "Disk read error!", 