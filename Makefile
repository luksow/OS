run: image
	qemu -hda ./bin/hda.img

prepare:
	mkdir -p bin

bootloader: prepare boot.asm
	nasm boot.asm -f bin -o ./bin/boot.bin

image: bootloader
	cp ./bin/boot.bin ./bin/hda.img 

clean:
	rm -rf ./bin/*
