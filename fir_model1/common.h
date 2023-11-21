#ifndef COMMON_H
#define COMMON_H

#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "WAVheader.h"

#define BLOCK_SIZE 16
#define MAX_NUM_CHANNEL 8

#define THRESHOLD 0.999999

#define n_coeff 31

#define LEFT_CH 0
#define RIGHT_CH 1

#define LS_H 0
#define RS_H 1

#define LS_CH 0
#define L_CH 1
#define C_CH 2
#define R_CH 3
#define RS_CH 4
#define LFE_CH 5

enum ENABLE_STATE { ON, OFF };
enum OUTPUT_MODE { MOD2_0_0, MOD2_2_0, MOD3_2_1 };

double saturation(double input);
double fir_circular(double* input, double* history, unsigned int* p_state);
void processing(double sampleBuffer[][BLOCK_SIZE], double outputSampleBuffer[][BLOCK_SIZE]);


#endif