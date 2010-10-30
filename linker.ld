OUTPUT_FORMAT("binary")
OUTPUT_ARCH ("i386")
ENTRY (main)

SECTIONS
{
	. = 0x7F00;
	.text : { *(.text) }
	.data : { *(.data) }
	.bss : { *(.bss) }
	.rodata : { *(.rodata) }
}

