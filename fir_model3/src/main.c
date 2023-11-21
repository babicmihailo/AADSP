#include "common.h"
#include <dsplib\wavefile.h>
#include <dsplib\timers.h>
#include <stdio.h>

__memY static DSPfract sampleBuffer[MAX_NUM_CHANNEL][BLOCK_SIZE];
DSPfract history[2][n_coeff];
unsigned int pState[2];
unsigned int* pStateL = history[0];
unsigned int* pStateR = history[1];
DSPint outputMode;
DSPint enable;
DSPfract gain;
DSPaccum out[MAX_NUM_CHANNEL];
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

void processing_init()
{
	DSPint i;
    DSPfract* historyPtr1 = history[LEFT_CH];
    DSPfract* historyPtr2 = history[RIGHT_CH];
    for (i = 0; i < n_coeff; i++)
    {
        *historyPtr1 = FRACT_NUM(0);
        *historyPtr2 = FRACT_NUM(0);

        historyPtr1++;
        historyPtr2++;
    }
    *pStateL = 0;
    *pStateL = 0;
    pState[LEFT_CH] = 0;
    pState[RIGHT_CH] = 0;
    //gain = FRACT_NUM(pow(10.0, inputGain / 20.0));
    gain = MINUS4DB;
}


int main(int argc, char* argv[])
{
	WAVREAD_HANDLE *wav_in;
	WAVWRITE_HANDLE *wav_out;

	char WavInputName[256];
	char WavOutputName[256];
	char mode[256];
	char toggle[256];

	DSPint inChannels;
	DSPint outChannels;
	DSPint bitsPerSample;
	DSPint sampleRate;
	DSPint iNumSamples;
	DSPint i;
	DSPint j;

	unsigned long long count1, count2, spent_cycles;

	// Init channel buffers
    for (i = 0; i < MAX_NUM_CHANNEL; i++)
    {
        for (j = 0; j < BLOCK_SIZE; j++)
        {
            sampleBuffer[i][j] = FRACT_NUM(0.0);
        }
    }


	// Open input wav file
	//-------------------------------------------------
	strcpy(WavInputName,argv[0]);
	wav_in = cl_wavread_open(WavInputName);
	 if(wav_in == NULL)
	{
		return -1;
	}
	//-------------------------------------------------

	// Read input wav header
	//-------------------------------------------------
	inChannels = cl_wavread_getnchannels(wav_in);
	bitsPerSample = cl_wavread_bits_per_sample(wav_in);
	sampleRate = cl_wavread_frame_rate(wav_in);
	iNumSamples =  cl_wavread_number_of_frames(wav_in);
	//-------------------------------------------------
	strcpy(WavOutputName, argv[1]);

	strcpy(toggle, argv[2]);

	if (strcmp(toggle, "Off") == 0)
	{
		enable = 0;
	}
	else
	{
		enable = 1;
	}

	strcpy(mode, argv[3]);
	if (strcmp(mode, "2_0_0") == 0)
	{
		outputMode = 2;
	}
	else if (strcmp(mode, "2_2_0") == 0)
	{
		outputMode = 1;
	}
	else
	{
		outputMode = 0;
	}

	if (enable == 1 && outputMode == 0)
	{
		outChannels = 6;
		wav_out = cl_wavwrite_open(WavOutputName, bitsPerSample, outChannels, sampleRate);
	}
	if (enable == 1 && outputMode == 1)
	{
		outChannels = 4;
		wav_out = cl_wavwrite_open(WavOutputName, bitsPerSample, outChannels, sampleRate);
	}
	if (enable == 0 || outputMode == 2)
	{
		outChannels = 2;
		wav_out = cl_wavwrite_open(WavOutputName, bitsPerSample, outChannels, sampleRate);
	}



    // Filter history clear
    processing_init();

    
    // Processing loop
    //-------------------------------------------------	
    {
    	int i;
		int j;
		int k;
		int sample;

		// exact file length should be handled correctly...
		for(i=0; i<iNumSamples/BLOCK_SIZE; i++)
		{
			for(j=0; j<BLOCK_SIZE; j++)
			{
				for(k=0; k<inChannels; k++)
				{
					sample = cl_wavread_recvsample(wav_in);
					sampleBuffer[k][j] = rbits(sample);
				}
			}

            if (enable == 1)
            {
            	count1 = cl_get_cycle_count();
                processing(sampleBuffer, sampleBuffer);
                count2 = cl_get_cycle_count();
                spent_cycles = count2 - count1;
                printf("%llu\n", spent_cycles);
            }

			for(j=0; j<BLOCK_SIZE; j++)
			{
				for(k=0; k<outChannels; k++)
				{
                    if (enable == 1)
                    {
                        int ch = 0;
                        switch (outputMode)
                        {
                            case 2:
                                if (k == 0) ch = L_CH;
                                if (k == 1) ch = R_CH;
                                break;
                            case 1:
                                if (k == 0) ch = LS_CH;
                                if (k == 1) ch = L_CH;
                                if (k == 2) ch = R_CH;
                                if (k == 3) ch = RS_CH;
                                break;
                            case 0:
                                if (k == 0) ch = LS_CH;
                                if (k == 1) ch = L_CH;
                                if (k == 2) ch = C_CH;
                                if (k == 3) ch = R_CH;
                                if (k == 4) ch = RS_CH;
                                if (k == 5) ch = LFE_CH;
                                break;
                            default:
                                break;
                        }
                    	sample = bitsr(sampleBuffer[ch][j]);
                    }
                    else
                    {
                    	sample = bitsr(sampleBuffer[k][j]);
                    }
                    cl_wavwrite_sendsample(wav_out, sample);
                }
            }
        }
    }


    // Close files
    //-------------------------------------------------	
    cl_wavread_close(wav_in);
    cl_wavwrite_close(wav_out);
    //-------------------------------------------------

	return 0;
}
