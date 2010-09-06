run: image
	qemu -hda ./bin/hda.img

bootloader: boot.asm
	nasm boot.asm -f bin -o ./bin/boot.bin

image: bootloader
	cp ./bin/boot.bin ./bin/hda.img 

clean:
	rm -rf ./bin/*
