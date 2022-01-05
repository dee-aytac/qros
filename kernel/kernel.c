#include "low_level.h"
#include "../drivers/screen.h"
#include "idt.h"

void main() {
    screen_init();
    clear_screen();
    print("Kernel fully loaded and working!");
    idt_install();
}
