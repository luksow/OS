#ifndef __ASM_H_
#define __ASM_H_

inline void hlt()
{
	asm volatile("hlt");
}

#endif
