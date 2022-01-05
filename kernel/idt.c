#include <stdint.h>
#include "low_level.h"

// Unlike GDT, The first entry (at zero offset) is used in the IDT.
// There are 256 interrupt vectors (0..255), so the IDT should have 256 entries, each entry corresponding to a specific interrupt vector.
// Although the IDT can contain more than 256 entries, they are ignored.

// IDT
struct idt_entry_t{
	uint16_t    isr_low;      // The lower 16 bits of the ISR's address
	uint16_t    kernel_cs;    // The GDT segment selector that the CPU will load into CS before calling the ISR
	uint8_t     reserved;     // Set to zero
	uint8_t     attributes;   // Type and attributes; see the IDT page
	uint16_t    isr_high;     // The higher 16 bits of the ISR's address
} __attribute__((packed));


// IDT Pointer
struct idt_ptr{
	uint16_t	limit;
	uint32_t	base;
} __attribute__((packed)) ;

struct idt_entry_t idt[256];
struct idt_ptr idtp;
extern void idt_load();

void idt_set_gate(unsigned char num, unsigned long base,
                  unsigned short sel, unsigned char flags)
{
    idt[num].isr_low = (base & 0xFFFF);
    idt[num].isr_high = (base >> 16);
    idt[num].kernel_cs = sel;
    idt[num].reserved = 0;
    idt[num].attributes = flags;

}

/* Installs the IDT */
void idt_install()
{
    /* Sets the special IDT pointer up, just like in 'gdt.c' */
    idtp.limit = (sizeof (struct idt_entry_t) * 256) - 1;
    idtp.base = &idt;

    /* Clear out the entire IDT, initializing it to zeros */
    memory_copy(&idt, 0, sizeof(struct idt_entry_t) * 256);

    /* Add any new ISRs to the IDT here using idt_set_gate */

    /* Points the processor's internal register to the new IDT */

    __asm__ volatile ("lidt %0" : : "m"(idtp));
}
