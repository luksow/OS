[GLOBAL gdt_set]

gdt_set:
	mov	eax, [esp+4]	; get passed pointer
	lgdt	[eax]        	; load new GDT pointer

	mov	ax, 0x10	; load all data segment registers
	mov	ds, ax
	mov	es, ax
	mov	fs, ax
	mov	gs, ax
	mov	ss, ax
	jmp	0x08:.flush	; far jump to code segment
.flush:
	ret
