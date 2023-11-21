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

#define LS_CH 0
#define L_CH 1
#define C_CH 2
#define R_CH 3
#define RS_CH 4
#define LFE_CH 5

double sampleBuffer[MAX_NUM_CHANNEL][BLOCK_SIZE];

static double history[2][n_coeff];
static unsigned int pState[2];

enum ENABLE_STATE { ON, OFF };
enum OUTPUT_MODE { MOD2_0_0, MOD2_2_0, MOD3_2_1 };

ENABLE_STATE enable;
OUTPUT_MODE outputMode;
double inputGain;

WAV_HEADER inputWAVhdr, outputWAVhdr;

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


double fir_circular(double input, double* coeffs, double* history, unsigned int n_coeffs, unsigned int* p_state)
{
	int i;
	unsigned int state;
	double ret_val;

	state = *p_state;               /* copy the filter's state to a local */


	/* store input at the beginning of the delay line */
	history[state] = input;
	if (++state >= n_coeffs)
	{         /* incr state and check for wrap */
		state = 0;
	}

	/* calc FIR and shift data */
	ret_val = 0;
	for (i = n_coeffs - 1; i >= 0; i--)
	{
		ret_val += coeffs[i] * history[state];
		if (++state >= n_coeffs) /* incr state and check for wrap */
		{
			state = 0;
		}
	}

	*p_state = state;               /* return new state to caller */

	return ret_val;
}

double saturation(double input)
{

	if (input > THRESHOLD)
	{
		return THRESHOLD;
	}
	if (input < -THRESHOLD)
	{
		return -THRESHOLD;
	}

	return input;
}

void processing(double pInbuf[MAX_NUM_CHANNEL][BLOCK_SIZE], double pOutbuf[MAX_NUM_CHANNEL][BLOCK_SIZE])
{
	for (int j = 0; j < BLOCK_SIZE; j++)
	{
		pOutbuf[R_CH][j] = pInbuf[1][j] * inputGain;
		pOutbuf[L_CH][j] = pInbuf[0][j] * inputGain;

		if (outputMode == MOD3_2_1)
		{
			pOutbuf[LS_CH][j] = fir_circular(pOutbuf[L_CH][j], coeffs, history[LEFT_CH], n_coeff, &pState[LEFT_CH]);

			pOutbuf[C_CH][j] = pOutbuf[L_CH][j] + pOutbuf[R_CH][j];
			pOutbuf[C_CH][j] = saturation(pOutbuf[C_CH][j]);

			pOutbuf[RS_CH][j] = fir_circular(pOutbuf[R_CH][j], coeffs, history[RIGHT_CH], n_coeff, &pState[RIGHT_CH]);

			pOutbuf[LFE_CH][j] = pOutbuf[LS_CH][j] + pOutbuf[RS_CH][j];
			pOutbuf[LFE_CH][j] = saturation(pOutbuf[LFE_CH][j]);

		}
		if (outputMode == MOD2_2_0)
		{
			pOutbuf[LS_CH][j] = fir_circular(pOutbuf[L_CH][j], coeffs, history[LEFT_CH], n_coeff, &pState[LEFT_CH]);
			pOutbuf[RS_CH][j] = fir_circular(pOutbuf[R_CH][j], coeffs, history[RIGHT_CH], n_coeff, &pState[RIGHT_CH]);
		}
	}
}

int main(int argc, char* argv[])
{
	FILE* wav_in = NULL;
	FILE* wav_out = NULL;
	char WavInputName[256];
	char WavOutputName[256];


	for (int i = 0; i < n_coeff; i++) { history[0][i] = 0; }
	for (int i = 0; i < n_coeff; i++) { history[1][i] = 0; }
	pState[0] = 0;
	pState[1] = 0;

	// Init channel buffers
	for (int i = 0; i < MAX_NUM_CHANNEL; i++)
		memset(&sampleBuffer[i], 0, BLOCK_SIZE);

	// Open input and output wav files
	//-------------------------------------------------
	strcpy(WavInputName, argv[1]);
	char rb[] = "rb";
	wav_in = OpenWavFileForRead(WavInputName, rb);
	strcpy(WavOutputName, argv[2]);
	char wb[] = "wb";
	wav_out = OpenWavFileForRead(WavOutputName, wb);
	//-------------------------------------------------

	// Read input wav header
	//-------------------------------------------------
	ReadWavHeader(wav_in, inputWAVhdr);
	//-------------------------------------------------

	// Set up output WAV header
	//-------------------------------------------------	
	outputWAVhdr = inputWAVhdr;
	//outputWAVhdr.fmt.NumChannels = inputWAVhdr.fmt.NumChannels; 
	// change number of channels

	if (argc > 3)
	{
		if (!strcmp(argv[3], "On"))
		{
			enable = ON;
		}
		else
		{
			enable = OFF;
		}

		if (!strcmp(argv[5], "2_0_0"))
		{
			outputMode = MOD2_0_0;
		}
		else if (!strcmp(argv[5], "2_2_0"))
		{
			outputMode = MOD2_2_0;
		}
		else
		{
			outputMode = MOD3_2_1;
		}

		inputGain = atof(argv[4]);

		if (inputGain >= 0.0)
		{
			inputGain = -4.0;
		}
	}
	else
	{
		inputGain = -4.0;
		outputMode = MOD3_2_1;
		enable = ON;

	}

	inputGain = pow(10.0, inputGain / 20.0);


	if (enable == ON && outputMode == MOD3_2_1)
	{
		outputWAVhdr.fmt.NumChannels = 6;
	}
	if (enable == ON && outputMode == MOD2_2_0)
	{
		outputWAVhdr.fmt.NumChannels = 4;
	}
	if (enable == OFF || outputMode == MOD2_0_0)
	{
		outputWAVhdr.fmt.NumChannels = inputWAVhdr.fmt.NumChannels;
	}


	int oneChannelSubChunk2Size = inputWAVhdr.data.SubChunk2Size / inputWAVhdr.fmt.NumChannels;
	int oneChannelByteRate = inputWAVhdr.fmt.ByteRate / inputWAVhdr.fmt.NumChannels;
	int oneChannelBlockAlign = inputWAVhdr.fmt.BlockAlign / inputWAVhdr.fmt.NumChannels;

	outputWAVhdr.data.SubChunk2Size = oneChannelSubChunk2Size * outputWAVhdr.fmt.NumChannels;
	outputWAVhdr.fmt.ByteRate = oneChannelByteRate * outputWAVhdr.fmt.NumChannels;
	outputWAVhdr.fmt.BlockAlign = oneChannelBlockAlign * outputWAVhdr.fmt.NumChannels;


	// Write output WAV header to file
	//-------------------------------------------------
	WriteWavHeader(wav_out, outputWAVhdr);


	// Processing loop
	//-------------------------------------------------	
	{
		int sample;
		int BytesPerSample = inputWAVhdr.fmt.BitsPerSample / 8;
		const double SAMPLE_SCALE = -(double)(1 << 31);		//2^31
		int iNumSamples = inputWAVhdr.data.SubChunk2Size / (inputWAVhdr.fmt.NumChannels * BytesPerSample);

		// exact file length should be handled correctly...
		for (int i = 0; i < iNumSamples / BLOCK_SIZE; i++)
		{
			for (int j = 0; j < BLOCK_SIZE; j++)
			{
				for (int k = 0; k < inputWAVhdr.fmt.NumChannels; k++)
				{
					sample = 0; //debug
					fread(&sample, BytesPerSample, 1, wav_in);
					sample = sample << (32 - inputWAVhdr.fmt.BitsPerSample); // force signextend
					sampleBuffer[k][j] = sample / SAMPLE_SCALE;				// scale sample to 1.0/-1.0 range		
				}
			}

			if (enable == ON)
				processing(sampleBuffer, sampleBuffer);

			for (int j = 0; j < BLOCK_SIZE; j++)
			{
				for (int k = 0; k < outputWAVhdr.fmt.NumChannels; k++)
				{
					if (enable == ON)
					{
						int ch = 0;
						switch (outputMode)
						{
						case MOD2_0_0:
							if (k == 0) ch = L_CH;
							if (k == 1) ch = R_CH;
							break;
						case MOD2_2_0:
							if (k == 0) ch = LS_CH;
							if (k == 1) ch = L_CH;
							if (k == 2) ch = R_CH;
							if (k == 3) ch = RS_CH;
							break;
						case MOD3_2_1:
							if (k == 0) ch = LS_CH;
							if (k == 1) ch = L_CH;
							if (k == 2) ch = C_CH;
							if (k == 3) ch = R_CH;
							if (k == 4) ch = RS_CH;
							if (k == 5) ch = LFE_CH;
						}
						sample = sampleBuffer[ch][j] * SAMPLE_SCALE;	// crude, non-rounding 		
					}
					else
					{
						sample = sampleBuffer[k][j] * SAMPLE_SCALE;	// crude, non-rounding 	
					}
					sample = sample >> (32 - inputWAVhdr.fmt.BitsPerSample);
					fwrite(&sample, outputWAVhdr.fmt.BitsPerSample / 8, 1, wav_out);
				}
			}
		}
	}

	// Close files
	//-------------------------------------------------	
	fclose(wav_in);
	fclose(wav_out);
	//-------------------------------------------------	

	return 0;
}