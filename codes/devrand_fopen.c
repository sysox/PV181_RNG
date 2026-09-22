#include<stdio.h>
#include<stdlib.h>

int main(){
	FILE *fp = fopen("/dev/urandom", "r");
	unsigned char *rnd_bytes_pointer = (unsigned char*)malloc(40); 
	
	fread(rnd_bytes_pointer, 1, 40, fp);
	unsigned int *int_pointer = (unsigned int *)rnd_bytes_pointer; 
	for(int i = 0; i < 10; i++){
			printf("%u ", *int_pointer);
			int_pointer++; 
	}
	return 0;
}