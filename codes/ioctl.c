#include <linux/random.h>
#include <sys/ioctl.h>
#include<stdio.h>
#include <fcntl.h>

int main(){
	unsigned char rnd_bytes_pointer[40]; 
	int fd = open("/dev/urandom", O_RDONLY | O_NONBLOCK);
	int entropy_count;
	ioctl(fd, RNDGETENTCNT, &entropy_count);
	
	printf("%d \n", entropy_count);
	return 0;
}

