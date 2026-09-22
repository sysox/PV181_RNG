#include<stdio.h>
#include<stdlib.h>
#include <fcntl.h>
#include <unistd.h>

int main(){
	int fd = open("/dev/urandom", O_RDONLY | O_NONBLOCK);
	unsigned char *rnd_bytes_pointer = (unsigned char*)malloc(40); 

	read(fd, rnd_bytes_pointer, 40);
	unsigned int *int_pointer = (unsigned int *)rnd_bytes_pointer; 
	for(int i = 0; i < 10; i++){
			printf("%u ", *int_pointer);
			int_pointer++; 
	}
	return 0;
}
