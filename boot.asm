[ORG 0x7C00]			; here is where our code will be loaded by BIOS
[BITS 16]

bootloader:
	mov	ax, 0x0000
	mov	ds, ax		; round way to do that...
	mov	si, msg

	mov	ah, 0x0E	; mode -> teletype (advance and scroll)
	mov	bh, 0x00	; page number
	mov	bl, 0x07	; colors

.next_char:		
	lodsb		
	or	al, al		; letter here
	jz	.continue
	int	0x10		; BIOS video interrupt
	jmp	.next_char

.continue:
	mov	si, read_pocket
	mov	ah, 0x42	; extension
	mov	dl, 0x80	; drive number (0x80 should be drive #0)
	int	0x13
	cli			; turn off maskable interrupts, we don't need them now
	hlt
.halt:	jmp	.halt
	
msg:	
	db	'Hello from bootloader!', 13, 10, 0
read_pocket:
	db	0x10		; size of pocket
	db	0		; const 0
	dw	1		; number of sectors to transfer
	dw	0x7E00, 0x0000	; address to write
	dd	1		; LBA
	dd	0		; upper LBA 

times 510-($-$$) db 0		; fill rest with zeros
dw 0xAA55			; bootloader indicator, used by BIOS
