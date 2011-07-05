global loader				; set visible to linker
extern main				; main from main.c
 
; some useful macro values
FLAGS		equ	0		; this is the multiboot 'flag' field
MAGIC		equ	0x1BADB002	; 'magic number' lets bootloader find the header
CHECKSUM	equ	-(MAGIC + FLAGS); checksum required
STACKSIZE	equ	0x4000		; 16 KiB for stack
 
section .text
align 4
; setting multiboot header
multiboot_header:
	dd	MAGIC
   	dd	FLAGS
   	dd	CHECKSUM
 
loader:
	mov	esp, stack + STACKSIZE	; set up the stack
	push	eax			; pass multiboot magic number as second parameter
	push	ebx			; pass multiboot info structure as first parameter
 
	call	main			; call C code
 
section .bss
align 4
stack:
   	resb 	STACKSIZE		; reserve stack space
