char hello[] = "Hello from kernel!";

int main(void* mbd, unsigned int magic)
{
	int count = 0;
	int i = 0;
	unsigned char *videoram = (unsigned char *) 0xB8000; /* 0xB0000 for monochrome monitors */

	if ( magic != 0x2BADB002 )
	{
		/* something went wrong.. */
		while(1); /* .. so hang! :) */
	}

	/* clear screen */
	for(i=0; i<16000; ++i)
	{
		videoram[count++] = 'A';
		videoram[count++] = 0x00; /* print black 'A' on black background */
	}

	/* print string */
	i = 0;
	count = 0;
	while(hello[i] != '\0')
	{
		videoram[count++] = hello[i++];
		videoram[count++] = 0x07; /* grey letters on black background */
	}

	while(1); /* just spin */

	return 0;
}
