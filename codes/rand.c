#include <stdio.h>	//printf
#include <stdlib.h>	//srand, rand
#include <time.h>		//time

int main(){
	srand(0); //(int)time(NULL)
	for(int i = 0; i < 10; i++){
			printf("%u ", rand());

	}
	return 0; 
}




