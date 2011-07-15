#include "gdt.h"

#define GDT_LEN 5

static gdt_descr_t gdt[GDT_LEN];
static gdt_ptr_t gdt_ptr;

void gdt_init()
{
	gdt_set_desc(&gdt[0], 0, 0, 0, 0);                // null
	gdt_set_desc(&gdt[1], 0, 0xFFFFFFFF, 0x9A, 0xCF); // ring0 code
	gdt_set_desc(&gdt[2], 0, 0xFFFFFFFF, 0x92, 0xCF); // ring0 data
	gdt_set_desc(&gdt[3], 0, 0xFFFFFFFF, 0xFA, 0xCF); // ring3 code
	gdt_set_desc(&gdt[4], 0, 0xFFFFFFFF, 0xF2, 0xCF); // ring3 data

	gdt_ptr.base = (u32int) &gdt;
	gdt_ptr.limit = sizeof(gdt_descr_t) * GDT_LEN - 1;

	gdt_set(&gdt_ptr);
}

static void gdt_set_desc(gdt_descr_t* descr, u32int base, u32int limit, u8int access, u8int granularity)
{
	descr->base_low = (base & 0xFFFF);
	descr->base_middle = (base >> 16) & 0xFF;
	descr->base_high = (base >> 24) & 0xFF;
	descr->limit_low = (limit & 0xFFFF);
	descr->granularity = ((limit >> 16) & 0x0F) | (granularity & 0xF0);
	descr->access = access;
}
