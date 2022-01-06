#include "low_level.h"
#include "../drivers/screen.h"
#include "system.h"

void main() {
    screen_init();
    clear_screen();
    print("Kernel fully loaded and working!");
    idt_install();
    isrs_install();
}
