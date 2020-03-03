#include <omp.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
	#pragma omp parallel
	{
		printf("I am running a generic code segment with OpenMP\n");
	}

	return 0;
}
