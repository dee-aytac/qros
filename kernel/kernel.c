#include "low_level.h"
#include "../drivers/screen.h"
#include "system.h"

void main() {
    screen_init();
    clear_screen();
    print("Kernel fully loaded and working!\n");
    idt_install();
    isrs_install();
    irq_install();
    __asm__ __volatile__ ("sti");
    timer_install();
    keyboard_install();
}
