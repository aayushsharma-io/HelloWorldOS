# Makefile
all: boot.bin kernel.bin os.iso

boot.bin: boot.asm disk_load.asm
	nasm -f bin boot.asm -o boot.bin

kernel.bin: kernel.asm
	nasm -f bin kernel.asm -o kernel.bin

os.iso: boot.bin kernel.bin
	mkdir -p iso/boot/grub
	cp boot.bin iso/boot/
	cp kernel.bin iso/boot/
	echo "menuentry 'Hello World OS' {" > iso/boot/grub/grub.cfg
	echo "  multiboot /boot/boot.bin" >> iso/boot/grub/grub.cfg
	echo "  module /boot/kernel.bin" >> iso/boot/grub/grub.cfg
	echo "}" >> iso/boot/grub/grub.cfg
	grub-mkrescue -o os.iso iso

clean:
	rm -rf iso boot.bin kernel.bin os.iso