#include "common.h"

extern DSPfract history[2][n_coeff];
extern unsigned int pState[2];
extern unsigned int* pStateL;
extern unsigned int* pStateR;
extern DSPint outputMode;
extern DSPaccum out[MAX_NUM_CHANNEL];
extern DSPfract coeffs[n_coeff];
extern DSPfract gain;


#ifdef PROCESSING_ASM
extern DSPfract fir_circular(__memY DSPfract* input, DSPfract* history, unsigned int* p_state);
#else
DSPfract fir_circular(__memY DSPfract* input, DSPfract* history, unsigned int* p_state)
{

    DSPint i;
    unsigned int state;
    DSPaccum ret_val;
    state = *p_state;               /* copy the filter's state to a local */

    /* store input at the beginning of the delay line */
    history[state] = *input;
    if (++state >= n_coeff)
    {         /* incr state and check for wrap */
        state = 0;
    }

    /* calc FIR and shift data */
    ret_val = FRACT_NUM(0);
    for (i = n_coeff - 1; i >= 0; i--)
    {
        ret_val += coeffs[i] * history[state];

        if (++state >= n_coeff) /* incr state and check for wrap */
        {
            state = 0;
        }
    }

    *p_state = state;               /* return new state to caller */

    return ret_val;
}
#endif

DSPfract saturation(DSPfract input)
{
    DSPaccum inValue = input;

    if (inValue > (DSPaccum)THRESHOLD)
    {
        return THRESHOLD;
    }
    else if (inValue < (DSPaccum)-THRESHOLD)
    {
        return -THRESHOLD;
    }

    return input;
}

#ifdef PROCESSING_ASM
extern void processing(__memY DSPfract pInbuf[MAX_NUM_CHANNEL][BLOCK_SIZE], __memY DSPfract pOutbuf[MAX_NUM_CHANNEL][BLOCK_SIZE]);
#else
void processing(__memY DSPfract pInbuf[MAX_NUM_CHANNEL][BLOCK_SIZE], __memY DSPfract pOutbuf[MAX_NUM_CHANNEL][BLOCK_SIZE])
{
	DSPint j;
    // In samples
    __memY DSPfract* ptrInL = pInbuf[LEFT_CH];
    __memY DSPfract* ptrInR = pInbuf[RIGHT_CH];

    // Out pointers
    __memY DSPfract* ptrOutLS = pOutbuf[LS_CH];
    __memY DSPfract* ptrOutL = pOutbuf[L_CH];
    __memY DSPfract* ptrOutC = pOutbuf[C_CH];
    __memY DSPfract* ptrOutR = pOutbuf[R_CH];
    __memY DSPfract* ptrOutRS = pOutbuf[RS_CH];
    __memY DSPfract* ptrOutLFE = pOutbuf[LFE_CH];

    DSPaccum accumL;
    DSPaccum accumR;
    for (j = 0; j < BLOCK_SIZE; j++)
    {

    	accumL = *ptrInL * gain;
    	accumR = *ptrInR * gain;

    	// L
    	*ptrOutL = accumL;

    	//R
    	*ptrOutR = accumR;

		if (outputMode == 0)
		{
            //C
            accumL = accumL + accumR;
            *ptrOutC = accumL;
            *ptrOutC = saturation(*ptrOutC);

            // Ls channel
            *ptrOutLS = fir_circular(ptrOutL, history[LEFT_CH], &pState[LEFT_CH]);

            // Rs channel
            *ptrOutRS = fir_circular(ptrOutR, history[RIGHT_CH], &pState[RIGHT_CH]);

            // LFE channel
            accumL = *ptrOutLS;
            accumR = *ptrOutRS;
            accumL = accumL + accumR;
            *ptrOutLFE = accumL;
            *ptrOutLFE = saturation(*ptrOutLFE);

            ptrOutLS++;
            ptrOutRS++;
            ptrOutC++;
            ptrOutLFE++;
        }

		if (outputMode == 1)
		{
            // Ls channel
            *ptrOutLS = fir_circular(ptrOutL, history[LEFT_CH], &pState[LEFT_CH]);

            // Rs channel
            *ptrOutRS = fir_circular(ptrOutR, history[RIGHT_CH], &pState[RIGHT_CH]);

            ptrOutLS++;
            ptrOutRS++;
        }

        ptrInL++;
        ptrInR++;

        ptrOutL++;
        ptrOutR++;

    }
}
#endif

