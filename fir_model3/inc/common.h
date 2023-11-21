#ifndef COMMON_H
#define COMMON_H

#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <stdfix.h>

#if defined(__CCC)

#include <stdfix.h>

#define FRACT_NUM(x) (x##r)
#define LONG_FRACT_NUM(x) (x##lr)
#define ACCUM_NUM(x) (x##lk)

#define FRACT_NUM_HEX(x) (x##r)

#define FRACT_TO_INT_BIT_CONV(x) (bitsr(x))
#define INT_TO_FRACT_BIT_CONV(x) (rbits(x))

#define long_accum long accum
#define long_fract long fract

#define MINUS4DB FRACT_NUM(0x50c335d4)
#define MINUS12DB FRACT_NUM(0.251109)

#define PROCESSING_ASM

#endif

#define BLOCK_SIZE 16
#define MAX_NUM_CHANNEL 8

#define THRESHOLD FRACT_NUM(0.999999)

typedef fract DSPfract;
typedef long_accum DSPaccum;
typedef int DSPint;

#define n_coeff 31

#define LEFT_CH 0
#define RIGHT_CH 1

#define LS_CH 0
#define L_CH 1
#define C_CH 2
#define R_CH 3
#define RS_CH 4
#define LFE_CH 5

DSPfract fir_circular(__memY DSPfract* input, DSPfract* history, unsigned int* p_state);
DSPfract saturation(DSPfract input);
void processing(__memY DSPfract pInbuf[MAX_NUM_CHANNEL][BLOCK_SIZE], __memY DSPfract pOutbuf[MAX_NUM_CHANNEL][BLOCK_SIZE]);

#endif
