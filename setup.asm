[ORG 0x7E00]			; here is where our code will be loaded
[BITS 16]

check_a20:			; check if A20 is not enabled, it's all about comparing 0xFFFF:0x7E0E with 0xAA55 - for wrapping memory
	mov	ax, 0xFFFF
	mov	es, ax
	mov	di, 0x7E0E
	mov	al, byte[es:di]
	cmp	al, 0x55	; comparing with 0x55 (first part)
	jne	enter_pmode	; if first byte is not wrapping around then second of course too
	; now we have to check if it not happened by chance
	mov	al, 0x69	; therefore we will set first byte and check results
	mov	byte[es:di], al	; load new value
	mov	bl, byte[0x7DFE]	; load old value
	cmp	bl, 0x69
	jne	enter_pmode

enable_a20:			; let's enable A20 line first, we'll use only basic methods
	; first, try enabling it via BIOS
	mov	ax, 0x2401
	int	0x15
	jnc	enter_pmode

	; then try conventional way - keyboard controller
	call	wait_a20
	mov	al, 0xD1 	; proper value
	out	0x64, al 	; proper port
	call	wait_a20 	; wait
	mov	al, 0xDF	; proper value
	out	0x60, al	; proper port
	call	wait_a20	; wait
	jmp	enter_pmode	; not so safe assumption that we enabled A20 line...


wait_a20:			; waits for keyboard controller to finish
	in	al, 0x64
	test	al, 2
	jnz	wait_a20
	ret

enter_pmode:
	cli
	lgdt 	[gdt_desc]
	mov 	eax, cr0
	or 	eax, 1
	mov 	cr0, eax
	jmp 	0x8:clear_pipe	; do the far jump, to clear instruction pipe

gdt:
gdt_null:
	dq	0		; it's just null..
gdt_code:
	dw 	0xFFFF		; limit (4GB)
	dw	0		; base (0)
	db	0		; base (still 0)
	db	10011010b	; [present][privilege level][privilege level][code segment][code segment][conforming][readable][access]
	db	11001111b	; [granularity][32 bit size bit][reserved][no use][limit][limit][limit][limit]
	db 	0		; base again
gdt_data:
   	dw	0xFFFF		; it's just same as above
   	dw	0		; it's just same as above
	db	0		; it's just same as above
	db	10010010b	; [present][privilege level][privilege level][data segment][data segment][expand direction][writeable][access]
	db 	11001111b	; it's just same as above
	db 	0		; it's just same as above
gdt_end:

gdt_desc:
   	dw 	gdt_end - gdt	; it's size
   	dd	gdt		; and location

[BITS 32]
clear_pipe:
	mov	ax, 0x10	; GDT address of data segment
	mov	ds, ax		; set data segment register
	mov	ss, ax		; set stack segment register
	mov	esp, 0x9000	; set stack
	mov	ebp, esp	; set bracket pointer
	jmp	0x7F00		; jump to code
	times 256-($-$$) db 0	; fill rest with zeros for alignment
