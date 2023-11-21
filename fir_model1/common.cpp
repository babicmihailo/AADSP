#include "common.h"

extern ENABLE_STATE enable;
extern OUTPUT_MODE outputMode;
extern double inputGain;

extern double history[2][n_coeff];
extern unsigned int pState[2];


double coeffs[n_coeff] = {
        -0.00930491020808503140,
        -0.00944040203390978520,
        -0.00957002117828420830,
        -0.00969329473373671360,
        -0.00980973811652527740,
        -0.00991885539807379170,
        -0.01002013967501371900,
        -0.01011307347900127600,
        -0.01019712922744179600,
        -0.01027176971623380500,
        -0.01033644865559729500,
        -0.01039061125002338000,
        -0.01043369482332797600,
        -0.01046512948974967800,
        -0.01048433887197771500,
        0.98027343068895101000,
        -0.01048433887197771500,
        -0.01046512948974967800,
        -0.01043369482332797600,
        -0.01039061125002338000,
        -0.01033644865559729500,
        -0.01027176971623380500,
        -0.01019712922744179600,
        -0.01011307347900127600,
        -0.01002013967501371900,
        -0.00991885539807379170,
        -0.00980973811652527740,
        -0.00969329473373671360,
        -0.00957002117828420830,
        -0.00944040203390978520,
        -0.00930491020808503140
};


double fir_circular(double* input, double* history, unsigned int* p_state)
{
    int i;
    unsigned int state;
    double ret_val;

    state = *p_state;               /* copy the filter's state to a local */


    /* store input at the beginning of the delay line */
    history[state] = *input;
    if (++state >= n_coeff)
    {         /* incr state and check for wrap */
        state = 0;
    }

    /* calc FIR and shift data */
    ret_val = 0;
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

double saturation(double input)
{
    double threshold = THRESHOLD;

    if (input > threshold)
    {
        return threshold;
    }
    if (input < -threshold)
    {
        return -threshold;
    }

    return input;
}

void processing(double pInbuf[][BLOCK_SIZE], double pOutbuf[][BLOCK_SIZE])
{
    // In samples
    double* ptrInL = pInbuf[LEFT_CH];
    double* ptrInR = pInbuf[RIGHT_CH];

    // Out pointers
    double* ptrOutLS = pOutbuf[LS_CH];
    double* ptrOutL = pOutbuf[L_CH];
    double* ptrOutC = pOutbuf[C_CH];
    double* ptrOutR = pOutbuf[R_CH];
    double* ptrOutRS = pOutbuf[RS_CH];
    double* ptrOutLFE = pOutbuf[LFE_CH];


    for (int j = 0; j < BLOCK_SIZE; j++)
    {
        *(ptrInL) *= inputGain;
        *(ptrInR) *= inputGain;

        // R channel
        *ptrOutR = *ptrInR;

        // L channel
        *ptrOutL = *ptrInL;


        if (outputMode == MOD3_2_1)
        {
            // Ls channel
            *ptrOutLS = fir_circular(ptrOutL, history[LEFT_CH], &pState[LEFT_CH]);

            // C channel
            *ptrOutC = *ptrOutR + *ptrOutL;
            *ptrOutC = saturation(*ptrOutC);

            // Rs channel
            *ptrOutRS = fir_circular(ptrOutR, history[RIGHT_CH], &pState[RIGHT_CH]);

            // LFE channel
            *ptrOutLFE = *ptrOutRS + *ptrOutLS;
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
