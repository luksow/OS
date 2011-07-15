run: kernel
	qemu -kernel ./bin/kernel.bin

prepare:
	mkdir -p bin

loader: prepare
	nasm -f elf -o ./bin/loader.o loader.asm

kernel: loader main.c
	nasm gdt.asm -f elf32 -o ./bin/gdt_asm.o
	gcc -o ./bin/gdt.o -c gdt.c -m32 -nostdlib -nostartfiles -nodefaultlibs
	gcc -o ./bin/vga.o -c vga.c -m32 -nostdlib -nostartfiles -nodefaultlibs
	gcc -o ./bin/main.o -c main.c -m32 -nostdlib -nostartfiles -nodefaultlibs
	ld -melf_i386 -T linker.ld -o ./bin/kernel.bin ./bin/loader.o ./bin/main.o ./bin/vga.o ./bin/gdt.o ./bin/gdt_asm.o

clean:
	rm -rf ./bin/*
