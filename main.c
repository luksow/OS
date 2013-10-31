#include "common.h"
#include "gdt.h"
#include "vga.h"
#include "asm.h"

int main(void* mbd, unsigned int magic)
{
	gdt_init();

	vga_init();
	vga_cls();

	if (magic != 0x2BADB002)
	{
		vga_puts("Multiboot error.");
		while (1)
			hlt();
	}

	vga_puts("Hello from kernel!");

	while (1)
		hlt();

	return 0;
}
