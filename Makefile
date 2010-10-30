run: image
	qemu -hda ./bin/hda.img

prepare:
	mkdir -p bin

bootloader: prepare boot.asm
	nasm boot.asm -f bin -o ./bin/boot.bin

setup:
	nasm setup.asm -f bin -o ./bin/setup.bin

image: bootloader setup kernel
	dd if=/dev/zero of=./bin/zeros bs=1  count=512
	cat ./bin/boot.bin ./bin/setup.bin ./bin/main.bin ./bin/zeros > ./bin/hda.img

kernel: main.c
	gcc -m32 -c -o ./bin/main.o main.c
	ld -T linker.ld ./bin/main.o -o ./bin/main.bin

clean:
	rm -rf ./bin/*
