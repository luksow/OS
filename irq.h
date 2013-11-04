struct idt_entry_struct
{
	u16int base_low; /* first 16 bits for adress to jump, where the interrupts fire */ 
	u16int kss; /* Kernel segment selector */
	u8int always0; /* Always zero */
	u8int flags; /* interrupt flag, more in documentation */
	u16int base_high; /* adress where to jump to */
	} __attribute__((packed)) 
typedef struct idt_entry_struct idt_entry_t;

struct idt_pointer
{
        u16int limit;
        u32int base;
}__attribute((packed))


extern void int_1;
