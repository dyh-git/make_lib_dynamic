#include <stdio.h>

extern void funB(void);

void funA(void)
{
	funB();
	printf("funAxxxxxxx.\n");
}

void funA_one(void)
{
	printf("funA_one.\n");
}
