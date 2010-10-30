char hello[] = "Hello from kernel!";

int main()
{
	int count = 0;
	int i = 0;
	unsigned char *videoram = (unsigned char *) 0xB8000; /* 0xB0000 for monochrome monitors */

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
