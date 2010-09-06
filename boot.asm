[ORG 0x7C00]			; here is where our code will be loaded by BIOS
[BITS 16]

bootloader:
	cli			; turn off maskable interrupts, we don't need them now
	hlt			; halt CPU
	jmp	bootloader	; this should not happen, but.. ;)

times 510-($-$$) db 0		; fill rest with zeros
dw 0xAA55			; bootloader indicator, used by BIOS
