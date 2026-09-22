#include <sys/random.h>
#include<stdio.h>
#include<stdio.h>

int main(){
	unsigned char rnd_bytes_pointer[40]; 
	getrandom(rnd_bytes_pointer, 40,  GRND_RANDOM | GRND_NONBLOCK ); 
	for(int i = 0; i < 40; i++){
			printf("%x", rnd_bytes_pointer[i]);
	}
	printf("\n");
	return 0;
}

