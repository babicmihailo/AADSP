#include "common.h"

extern DSPfract history[2][n_coeff];
extern unsigned int pState[2];
extern ENABLE_STATE enable;
extern OUTPUT_MODE outputMode;
extern DSPfract gain;
extern DSPaccum out[MAX_NUM_CHANNEL];

DSPfract coeffs[n_coeff] = {
        FRACT_NUM(-0.00930491020808503140),
        FRACT_NUM(-0.00944040203390978520),
        FRACT_NUM(-0.00957002117828420830),
        FRACT_NUM(-0.00969329473373671360),
        FRACT_NUM(-0.00980973811652527740),
        FRACT_NUM(-0.00991885539807379170),
        FRACT_NUM(-0.01002013967501371900),
        FRACT_NUM(-0.01011307347900127600),
        FRACT_NUM(-0.01019712922744179600),
        FRACT_NUM(-0.01027176971623380500),
        FRACT_NUM(-0.01033644865559729500),
        FRACT_NUM(-0.01039061125002338000),
        FRACT_NUM(-0.01043369482332797600),
        FRACT_NUM(-0.01046512948974967800),
        FRACT_NUM(-0.01048433887197771500),
        FRACT_NUM(0.98027343068895101000),
        FRACT_NUM(-0.01048433887197771500),
        FRACT_NUM(-0.01046512948974967800),
        FRACT_NUM(-0.01043369482332797600),
        FRACT_NUM(-0.01039061125002338000),
        FRACT_NUM(-0.01033644865559729500),
        FRACT_NUM(-0.01027176971623380500),
        FRACT_NUM(-0.01019712922744179600),
        FRACT_NUM(-0.01011307347900127600),
        FRACT_NUM(-0.01002013967501371900),
        FRACT_NUM(-0.00991885539807379170),
        FRACT_NUM(-0.00980973811652527740),
        FRACT_NUM(-0.00969329473373671360),
        FRACT_NUM(-0.00957002117828420830),
        FRACT_NUM(-0.00944040203390978520),
        FRACT_NUM(-0.00930491020808503140)
};


DSPfract fir_circular(DSPfract* input, DSPfract* history, unsigned int* p_state)
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

void processing(DSPfract pInbuf[MAX_NUM_CHANNEL][BLOCK_SIZE], DSPfract pOutbuf[MAX_NUM_CHANNEL][BLOCK_SIZE])
{
    // In samples
    DSPfract* ptrInL = pInbuf[LEFT_CH];
    DSPfract* ptrInR = pInbuf[RIGHT_CH];

    // Out pointers
    DSPfract* ptrOutLS = pOutbuf[LS_CH];
    DSPfract* ptrOutL = pOutbuf[L_CH];
    DSPfract* ptrOutC = pOutbuf[C_CH];
    DSPfract* ptrOutR = pOutbuf[R_CH];
    DSPfract* ptrOutRS = pOutbuf[RS_CH];
    DSPfract* ptrOutLFE = pOutbuf[LFE_CH];

    for (DSPint j = 0; j < BLOCK_SIZE; j++)
    {
        out[L_CH] = *ptrInL * gain;
        out[R_CH] = *ptrInR * gain;

        // L channel
        *ptrOutL = out[L_CH];

        // R channel
        *ptrOutR = out[R_CH];

        if (outputMode == MOD3_2_1)
        {

            // Ls channel
            *ptrOutLS = fir_circular(ptrOutL, history[LEFT_CH], &pState[LEFT_CH]);
            out[LS_CH] = *ptrOutLS;

            // C channel
            out[C_CH] = out[L_CH] + out[R_CH];
            *ptrOutC = out[C_CH];
            *ptrOutC = saturation(*ptrOutC);

            // Rs channel
            *ptrOutRS = fir_circular(ptrOutR, history[RIGHT_CH], &pState[RIGHT_CH]);
            out[RS_CH] = *ptrOutRS;

            // LFE channel
            out[LFE_CH] = out[LS_CH] + out[RS_CH];
            *ptrOutLFE = out[LFE_CH];
            *ptrOutLFE = saturation(*ptrOutLFE);

            ptrOutLS++;
            ptrOutRS++;
            ptrOutC++;
            ptrOutLFE++;
        }
        if (outputMode == MOD2_2_0)
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