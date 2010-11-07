run: kernel
	qemu -kernel ./bin/kernel.bin

prepare:
	mkdir -p bin

loader: prepare
	nasm -f elf -o ./bin/loader.o loader.asm


kernel: loader main.c
	gcc -o ./bin/main.o -c main.c -m32 -nostdlib -nostartfiles -nodefaultlibs
	ld -melf_i386 -T linker.ld -o ./bin/kernel.bin ./bin/loader.o ./bin/main.o

clean:
	rm -rf ./bin/*
