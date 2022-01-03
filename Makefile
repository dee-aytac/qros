all: os-image.bin

QEMU=qemu-system-i386

KERNEL_SOURCES=$(wildcard kernel/*.c)
OBJS=${KERNEL_SOURCES:.c=.o}

C_FLAGS=-ffreestanding -fno-pie -m32 -g
LD_FLAGS=-melf_i386 


run:
	$(QEMU) -fda os-image.bin

os-image.bin: boot/boot.bin kernel/kernel.bin
	cat $^ > os-image.bin

kernel/kernel.bin: kernel/kernel.o $(OBJS)
	ld $(LD_FLAGS) -o kernel/kernel.bin -Ttext 0x1000 $^ --oformat binary

kernel/kernel.o: kernel/kernel.c kernel/low_level.c kernel/screen.c
	gcc $(C_FLAGS) -c $< -o $@

%.o: %.c
	gcc $(C_FLAGS) -c $< -o $@


boot/boot.bin: boot/boot_sect.asm
	nasm -i 'boot/' $< -f bin -o $@

clean:
	rm *.bin boot/*.bin kernel/*.bin kernel/*.o
