#include <stdio.h>

extern void funA(void);

int main()
{
	funA();
	printf("main.\n");

	return 0;
}
