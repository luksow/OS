run: kernel
	qemu -kernel ./bin/kernel.bin

prepare:
	mkdir -p bin

loader: prepare
	nasm -f elf -o ./bin/loader.o loader.asm


kernel: loader main.c
	gcc -o ./bin/vga.o -c vga.c -m32 -nostdlib -nostartfiles -nodefaultlibs
	gcc -o ./bin/main.o -c main.c -m32 -nostdlib -nostartfiles -nodefaultlibs
	ld -melf_i386 -T linker.ld -o ./bin/kernel.bin ./bin/loader.o ./bin/main.o ./bin/vga.o

clean:
	rm -rf ./bin/*
