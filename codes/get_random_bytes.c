#include <linux/module.h>	/* Needed by all modules */
#include <linux/random.h> // Needed for 

int init_module(void)
{
	printk(KERN_INFO "Hello world 1.\n");

	/* 
	 * A non 0 return means init_module failed; module can't be loaded. 
	 */
	
	unsigned char rnd_bytes_pointer[40]; 
	get_random_bytes(rnd_bytes_pointer, 40); 
	for(int i = 0; i < 40; i++){
			printk("%x", rnd_bytes_pointer[i]);
	}
	printf("\n");
	return 0;
}

void cleanup_module(void)
{
	printk(KERN_INFO "Generated successfully.\n");
}

