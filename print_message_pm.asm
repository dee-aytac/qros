bits 32
VIDEO_MEMORY equ 0xb8000 ; start of the video memory 
WHITE_ON_BLACK equ 0x0f ; character attributes encoding

print_message_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_loop_pm:
    mov al, [ebx]
    mov ah, WHITE_ON_BLACK
    
    cmp al, 0
    je print_pm_done

    mov [edx], ax 
    add ebx, 1
    add edx, 2
    jmp print_loop_pm

print_pm_done:
    popa 
    ret