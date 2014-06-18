/* External functions for Modelica Noise library

   Copyright (C) 2014, Modelica Association and DLR.
*/

#ifndef MODELICANOISE_H
#define MODELICANOISE_H

#include <limits.h>
#include <math.h>

#define NOISE_LCG_MULTIPLIER (134775813)

/* NOISE_SeedReal */
/* Converts a Real variable to an Integer seed */
void NOISE_SeedReal(int local_seed, int global_seed, double real_seed, int n, int* states) {
    double x0;
    unsigned* xp;
    unsigned x1;
    unsigned x2;
    int i;

    /* Take the square root in order to remove sampling effects */
    x0 = sqrt(real_seed);
    /* Point a 32 bit integer to the double number */
    xp = (unsigned*)&x0;
    /* Interpret the first 32 bits as an integer */
    x1 = *xp;
    x2 = *xp;
    /* Advance the pointer to point to the second half of the double */
    xp++;
    /* Bit-wise XOR this information into the second integer */
    x2 ^= *xp;

    /* Use the seeds to bit-wise XOR them to the two integers */
    x1 ^= (unsigned)local_seed;
    x2 ^= (unsigned)global_seed;

    /* Fill the states vector */
    for (i = 0; i < n; i++) {
        states[i] = (i%2 == 0) ? x1 : x2;
    }
}

/* NOISE_shuffleDouble */
/* This is the basic implementation of the DIRCS random number generator */
double NOISE_shuffleDouble(double x, unsigned seed)
{
    double x0;
    unsigned* xp;
    unsigned x1;
    unsigned x2;
    unsigned xt;
    double vmax;
    double y;

    /* Take the square root in order to remove sampling effects */
    x0 = sqrt(x);
    /* Point a 32 bit integer to the double number */
    xp = (unsigned*)&x0;
    /* Interpret the first 32 bits as an integer */
    x1 = *xp;
    x2 = *xp;
    /* Advance the pointer to point to the second half of the double */
    xp++;
    /* Bit-wise XOR this information into the second integer */
    x2 ^= *xp;
    x2 ^= seed;

    /* Do single steps */
    x1 = x1*NOISE_LCG_MULTIPLIER + 1;
    x2 = x2*NOISE_LCG_MULTIPLIER + 1;

    /* Do combined steps! */
    xt = x2;
    x2 = x1*NOISE_LCG_MULTIPLIER + x2*NOISE_LCG_MULTIPLIER + 1;
    x1 = x2;

    /* Divide the integer by its maximum value */
    vmax = UINT_MAX;
    y = x2 / vmax;

    return y;
}

/* NOISE_combineSeedLCG */
/* This is used to combine two seeds */
int NOISE_combineSeedLCG(int x1, int x2) {
    int ret;
    ret = x1*NOISE_LCG_MULTIPLIER + x2*NOISE_LCG_MULTIPLIER + 1;
    ret = (((ret < 0) ? ((ret % INT_MAX) + INT_MAX) : ret) % INT_MAX);
    return ret;
}

#endif
