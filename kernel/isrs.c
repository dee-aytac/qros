#include "system.h"
#include "../drivers/screen.h"

extern void isr0();
extern void isr1();
extern void isr2();
extern void isr3();
extern void isr4();
extern void isr5();
extern void isr6();
extern void isr7();
extern void isr8();
extern void isr9();
extern void isr10();
extern void isr11();
extern void isr12();
extern void isr13();
extern void isr14();
extern void isr15();
extern void isr16();
extern void isr17();
extern void isr18();
extern void isr19();
extern void isr20();
extern void isr21();
extern void isr22();
extern void isr23();
extern void isr24();
extern void isr25();
extern void isr26();
extern void isr27();
extern void isr28();
extern void isr29();
extern void isr30();
extern void isr31();

unsigned char *exception_messages[] =
{
"Division By Zero",                         // 0
"Debug",                                    // 1
"Non Maskable Interrupt",                   // 2
"Breakpoint",                               // 3
"INTO-detected overflow",                   // 4
"Bound range exception",                    // 5
"Invalid opcode",                           // 6
"Device not avaible",                       // 7
"Double fault",                             // 8
"Coproccesor segment overrun (reserved)",   // 9
"Invalid task state segment",               // 10
"Segment not present",                      // 11
"Stack fault",                              // 12
"General proection",                        // 13
"Page fault",                               // 14
"(Intel reserved, do not use)",             // 15
"Floating point error",                     // 16
"Aligment check",                           // 17
"Machine check",                            // 18
"Reserved",                                 // 19
"Reserved",                                 // 20
"Reserved",                                 // 21
"Reserved",                                 // 22
"Reserved",                                 // 23
"Reserved",                                 // 24
"Reserved",                                 // 25
"Reserved",                                 // 26
"Reserved",                                 // 27
"Reserved",                                 // 28
"Reserved",                                 // 29
"Reserved",                                 // 30
"Reserved",                                 // 31
};

void isrs_install() {
	idt_set_gate(0, (unsigned)isr0, 0x08, 0x8E);
	idt_set_gate(1, (unsigned)isr1, 0x08, 0x8E);
	idt_set_gate(2, (unsigned)isr2, 0x08, 0x8E);
	idt_set_gate(3, (unsigned)isr3, 0x08, 0x8E);
	idt_set_gate(4, (unsigned)isr4, 0x08, 0x8E);
	idt_set_gate(5, (unsigned)isr5, 0x08, 0x8E);
	idt_set_gate(6, (unsigned)isr6, 0x08, 0x8E);
	idt_set_gate(7, (unsigned)isr7, 0x08, 0x8E);
	idt_set_gate(8, (unsigned)isr8, 0x08, 0x8E);
	idt_set_gate(9, (unsigned)isr9, 0x08, 0x8E);
	idt_set_gate(10, (unsigned)isr10, 0x08, 0x8E);
	idt_set_gate(11, (unsigned)isr11, 0x08, 0x8E);
	idt_set_gate(12, (unsigned)isr12, 0x08, 0x8E);
	idt_set_gate(13, (unsigned)isr13, 0x08, 0x8E);
	idt_set_gate(14, (unsigned)isr14, 0x08, 0x8E);
	idt_set_gate(15, (unsigned)isr15, 0x08, 0x8E);
	idt_set_gate(16, (unsigned)isr16, 0x08, 0x8E);
	idt_set_gate(17, (unsigned)isr17, 0x08, 0x8E);
	idt_set_gate(18, (unsigned)isr18, 0x08, 0x8E);
	idt_set_gate(19, (unsigned)isr19, 0x08, 0x8E);
	idt_set_gate(20, (unsigned)isr20, 0x08, 0x8E);
	idt_set_gate(21, (unsigned)isr21, 0x08, 0x8E);
	idt_set_gate(22, (unsigned)isr22, 0x08, 0x8E);
	idt_set_gate(23, (unsigned)isr23, 0x08, 0x8E);
	idt_set_gate(24, (unsigned)isr24, 0x08, 0x8E);
	idt_set_gate(25, (unsigned)isr25, 0x08, 0x8E);
	idt_set_gate(26, (unsigned)isr26, 0x08, 0x8E);
	idt_set_gate(27, (unsigned)isr27, 0x08, 0x8E);
	idt_set_gate(28, (unsigned)isr28, 0x08, 0x8E);
	idt_set_gate(29, (unsigned)isr29, 0x08, 0x8E);
	idt_set_gate(30, (unsigned)isr30, 0x08, 0x8E);
	idt_set_gate(31, (unsigned)isr31, 0x08, 0x8E);
}

void fault_handler(struct regs *r) {
	if (r->int_no < 32) {
		print(exception_messages[r->int_no]);
		print(" - Exception. System Halted!\n");
		for (;;)
			;
	}
}