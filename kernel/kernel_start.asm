[bits 32]

[extern main]
call main 
jmp $

; NOTE - using underscores will lead to an error when compiling to elf
; Service Routines (ISRs) 
global isr0
global isr1
global isr2
global isr3 
global isr4 
global isr5 
global isr6 
global isr7 
global isr8
global isr9
global isr10
global isr11
global isr12
global isr13 
global isr14
global isr15
global isr16
global isr17
global isr18
global isr19
global isr20
global isr21 
global isr22 
global isr23 
global isr24
global isr25
global isr26 
global isr27
global isr28 
global isr29
global isr30
global isr31

; 00: Divide By Zero Exception
isr0:
    cli
    push byte 0 ; A normal ISR stub that pops a dummy error code to keep a
                ; uniform stack frame
    push byte 0
    jmp isr_common_stub

; 01: Debug Exception
isr1:
    cli
    push byte 0
    push byte 1
    jmp isr_common_stub

; 02: NULL Interrupt
isr2:
    cli
    push byte 0
    push byte 2
    jmp isr_common_stub

; 03: Breakpoint
isr3:
    cli
    push byte 0
    push byte 3
    jmp isr_common_stub

; 04: INTO-detected overflow
isr4:
    cli
    push byte 0
    push byte 4
    jmp isr_common_stub

; 05: Bound range exception 
isr5:
    cli
    push byte 0
    push byte 5
    jmp isr_common_stub

; 06: Invalid opcode
isr6:
    cli
    push byte 0
    push byte 6
    jmp isr_common_stub

; 07: Device not avaible
isr7:
    cli
    push byte 0
    push byte 7
    jmp isr_common_stub

; 08: Double Fault Exception (With Error Code!)
isr8:
    cli
    push byte 8 ; Note that we DON'T push a value on the stack in this one!
                ; It pushes one already! Use this type of stub for exceptions
                ; that pop error codes!
    jmp isr_common_stub

; 09: Coproccessor segment overrun (reserved)
isr9:
    cli
    push byte 0
    push byte 9
    jmp isr_common_stub

; 10: Invalid task state segment 
isr10:
    cli
    push byte 10
    jmp isr_common_stub

; 11: Segment not present
isr11:
    cli
    push byte 11
    jmp isr_common_stub

; 12: Stack fault 
isr12:
    cli
    push byte 12
    jmp isr_common_stub

; 13: General protection
isr13:
    cli
    push byte 13
    jmp isr_common_stub

; 14: Page Fault 
isr14:
    cli
    push byte 14
    jmp isr_common_stub

; 15: Intel reserved, don't use!
isr15:
    cli
    push byte 0
    push byte 15
    jmp isr_common_stub

; 16: Floating point error
isr16:
    cli
    push byte 0
    push byte 16
    jmp isr_common_stub

; 17: Aligment check
isr17:
    cli
    push byte 0
    push byte 17
    jmp isr_common_stub

; 18: Machine check
isr18:
    cli
    push byte 0
    push byte 18
    jmp isr_common_stub

; 19-31 are reserved for Intel, don't use!
isr19:
    cli
    push byte 0
    push byte 19
    jmp isr_common_stub

isr20:
    cli
    push byte 0
    push byte 20
    jmp isr_common_stub

isr21:
    cli
    push byte 0
    push byte 21
    jmp isr_common_stub

isr22:
    cli
    push byte 0
    push byte 22
    jmp isr_common_stub

isr23:
    cli
    push byte 0
    push byte 23
    jmp isr_common_stub

isr24:
    cli
    push byte 0
    push byte 24
    jmp isr_common_stub

isr25:
    cli
    push byte 0
    push byte 25
    jmp isr_common_stub

isr26:
    cli
    push byte 0
    push byte 26
    jmp isr_common_stub

isr27:
    cli
    push byte 0
    push byte 27
    jmp isr_common_stub

isr28:
    cli
    push byte 0
    push byte 28
    jmp isr_common_stub

isr29:
    cli
    push byte 0
    push byte 29
    jmp isr_common_stub

isr30:
    cli
    push byte 0
    push byte 30
    jmp isr_common_stub

isr31:
    cli
    push byte 0
    push byte 31
    jmp isr_common_stub


extern fault_handler
isr_common_stub:
    pusha
    push ds
    push es
    push fs
    push gs
    mov ax, 0x10 ; Load the Kernel Data Segment descriptor!
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov eax, esp ; Push us the stack
    push eax
    mov eax, fault_handler
    call eax ; A special call, preserves the 'eip' register
    pop eax
    pop gs
    pop fs
    pop es
    pop ds
    popa
    add esp, 8 ; Cleans up the pushed error code and pushed ISR number
    iret ; pops 5 things at once: CS, EIP, EFLAGS, SS, and ESP!

global irq0
global irq1
global irq2
global irq3
global irq4
global irq5
global irq6
global irq7
global irq8
global irq9
global irq10
global irq11
global irq12
global irq13
global irq14
global irq15

; 32: IRQ0
irq0:
    cli
    push byte 0    ; Note that these don't push an error code on the stack:
                   ; We need to push a dummy error code
    push byte 32
    jmp irq_common_stub

; 33: IRQ1
irq1:
    cli
    push byte 0    ; Note that these don't push an error code on the stack:
                   ; We need to push a dummy error code
    push byte 33
    jmp irq_common_stub

; 34: IRQ2
irq2:
    cli
    push byte 0    ; Note that these don't push an error code on the stack:
                   ; We need to push a dummy error code
    push byte 34
    jmp irq_common_stub

; 35: IRQ3
irq3:
    cli
    push byte 0    ; Note that these don't push an error code on the stack:
                   ; We need to push a dummy error code
    push byte 35
    jmp irq_common_stub

; 36: IRQ4
irq4:
    cli
    push byte 0    ; Note that these don't push an error code on the stack:
                   ; We need to push a dummy error code
    push byte 36
    jmp irq_common_stub

; 37: IRQ5
irq5:
    cli
    push byte 0    ; Note that these don't push an error code on the stack:
                   ; We need to push a dummy error code
    push byte 37
    jmp irq_common_stub

; 38: IRQ6
irq6:
    cli
    push byte 0    ; Note that these don't push an error code on the stack:
                   ; We need to push a dummy error code
    push byte 38
    jmp irq_common_stub

; 39: IRQ7
irq7:
    cli
    push byte 0    ; Note that these don't push an error code on the stack:
                   ; We need to push a dummy error code
    push byte 39
    jmp irq_common_stub

; 40: IRQ8
irq8:
    cli
    push byte 0    ; Note that these don't push an error code on the stack:
                   ; We need to push a dummy error code
    push byte 40
    jmp irq_common_stub

; 41: IRQ9
irq9:
    cli
    push byte 0    ; Note that these don't push an error code on the stack:
                   ; We need to push a dummy error code
    push byte 41
    jmp irq_common_stub

; 42: IRQ10
irq10:
    cli
    push byte 0    ; Note that these don't push an error code on the stack:
                   ; We need to push a dummy error code
    push byte 42
    jmp irq_common_stub

; 43: IRQ11
irq11:
    cli
    push byte 0    ; Note that these don't push an error code on the stack:
                   ; We need to push a dummy error code
    push byte 43
    jmp irq_common_stub

; 44: IRQ12
irq12:
    cli
    push byte 0    ; Note that these don't push an error code on the stack:
                   ; We need to push a dummy error code
    push byte 44
    jmp irq_common_stub

; 45: IRQ13
irq13:
    cli
    push byte 0    ; Note that these don't push an error code on the stack:
                   ; We need to push a dummy error code
    push byte 45
    jmp irq_common_stub

; 46: IRQ14
irq14:
    cli
    push byte 0    ; Note that these don't push an error code on the stack:
                   ; We need to push a dummy error code
    push byte 46
    jmp irq_common_stub

; 47: IRQ15
irq15:
    cli
    push byte 0
    push byte 47
    jmp irq_common_stub


extern irq_handler

; This is a stub that we have created for IRQ based ISRs. This calls
; '_irq_handler' in our C code. We need to create this in an 'irq.c'

irq_common_stub:
    pusha
    push ds
    push es
    push fs
    push gs
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov eax, esp
    push eax
    mov eax, irq_handler
    call eax
    pop eax
    pop gs
    pop fs
    pop es
    pop ds
    popa
    add esp, 8
    iret