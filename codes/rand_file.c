#include <stdio.h>
#include <math.h>
#include <time.h>
#include <stdlib.h>

int main()
{
    FILE *fp;
		int i, rnd;
    fp =fopen ("gcc.bin","wb");
    srand(time(NULL)); // or use seed based on time - replace 0 by 
  	for(i = 0; i < 10000; i++){
			rnd = rand();
			printf("%d ", rnd);
			fwrite (&rnd, sizeof(rnd), 1, fp); 
		}
    return 0;
}