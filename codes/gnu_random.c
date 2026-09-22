//
// Created by user on 9/6/2022.
// Adapted from https://www.mscs.dal.ca/~selinger/random/
//
// Original implementation of rand, srand:
// https://sourceware.org/git/?p=glibc.git;a=blob;f=stdlib/rand.c
// https://sourceware.org/git/?p=glibc.git;a=blob;f=stdlib/random.c
// https://sourceware.org/git/?p=glibc.git;a=blob;f=stdlib/random_r.c
// struct random_data:
// https://sites.uclouvain.be/SystInfo/usr/include/stdlib.h.html

#include "gnu_random.h"
void my_initstate_r(unsigned int seed, struct my_random_data *buf){
    int32_t *state = buf->state;
    long int i;
    state[0] = seed;
    for (i=1; i<31; i++) {
        state[i] = (16807LL * state[i-1]) % 2147483647;
        if (state[i] < 0) {
            state[i] += 2147483647;
        }
    }
    buf->idx = 3; // equivalent to idx 34
    for (i=34; i<344; i++) {
        buf->state[buf->idx % 31] = buf->state[buf->idx % 31] + buf->state[(buf->idx + 28) % 31];
        buf->idx++;
    }
}
void my_random_r(struct my_random_data *buf, int32_t *result){
    buf->state[buf->idx % 31] = buf->state[buf->idx % 31] + buf->state[(buf->idx + 28) % 31];
    *result = buf->state[buf->idx % 31];
    buf->idx++;
}
void my_srand(unsigned int seed){
    my_initstate_r(seed, &unsafe_state);
}
int my_rand(){
    int32_t retval;
    my_random_r (&unsafe_state, &retval);
    return ((unsigned int) retval) >> 1;
}