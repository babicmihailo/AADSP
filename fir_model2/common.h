#ifndef COMMON_H
#define COMMON_H

#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "WAVheader.h"

#include "stdfix_emu.h"
#include "fixed_point_math.h"

/* DSP type definitions */
typedef short DSPshort;					/* DSP integer */
typedef unsigned short DSPushort;		/* DSP unsigned integer */
typedef int DSPint;						/* native integer */
typedef fract DSPfract;					/* DSP fixed-point fractional */
typedef long_accum DSPaccum;			/* DSP fixed-point fractional */

#define BLOCK_SIZE 16
#define MAX_NUM_CHANNEL 8

#define THRESHOLD FRACT_NUM(0.999999)


#define n_coeff 31

#define LEFT_CH 0
#define RIGHT_CH 1

#define LS_CH 0
#define L_CH 1
#define C_CH 2
#define R_CH 3
#define RS_CH 4
#define LFE_CH 5

enum ENABLE_STATE { ON, OFF };
enum OUTPUT_MODE { MOD2_0_0, MOD2_2_0, MOD3_2_1 };

DSPfract fir_circular(DSPfract* input, DSPfract* history, unsigned int* p_state);
DSPfract saturation(DSPfract input);
void processing(DSPfract pInbuf[MAX_NUM_CHANNEL][BLOCK_SIZE], DSPfract pOutbuf[MAX_NUM_CHANNEL][BLOCK_SIZE]);

#endif