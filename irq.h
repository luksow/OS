struct idt_entry_struct
{
	u16int base_low; //first 16 bits for 
	u16int kss;
	u8int always0;
	u8int flags;
	u16int base_high
	} __attribute__((packed))
