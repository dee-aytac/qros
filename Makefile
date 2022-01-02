all: os-image.bin

QEMU=qemu-system-i386

run:
	$(QEMU) -fda os-image.bin

os-image.bin: boot.bin kernel.bin
	cat $^ > os-image.bin

kernel.bin: kernel.o
	ld -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary

kernel.o: kernel.c
	gcc -ffreestanding -c kernel.c -o kernel.o

boot.bin: boot_sect.asm
	nasm $< -f bin -o $@

clean:
	rm *.bin *.o
