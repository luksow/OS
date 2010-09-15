run: image
	qemu -hda ./bin/hda.img

prepare:
	mkdir -p bin

bootloader: prepare boot.asm
	nasm boot.asm -f bin -o ./bin/boot.bin

image: bootloader
	echo 'Ala ma kota' > ./bin/text
	dd if=/dev/zero of=./bin/zeros bs=1  count=500
	cat ./bin/boot.bin ./bin/text ./bin/zeros > ./bin/hda.img

clean:
	rm -rf ./bin/*
