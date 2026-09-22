//
// Created by user on 9/6/2022.
//

#ifndef PV181_RANDOM_GNU_RANDOM_H
#define PV181_RANDOM_GNU_RANDOM_H

#include <stdio.h>
#include <stdint.h>

struct my_random_data{
    long int idx;
    int32_t state[31];
};

static struct my_random_data unsafe_state;
void my_initstate_r(unsigned int seed, struct my_random_data *buf);
void my_random_r(struct my_random_data *buf, int32_t *result);
void my_srand(unsigned int seed);
int my_rand(void);

#endif //PV181_RANDOM_GNU_RANDOM_H
