#include "common.h"

static DSPfract sampleBuffer[MAX_NUM_CHANNEL][BLOCK_SIZE];
static double inputGain;
DSPfract history[2][n_coeff];
unsigned int pState[2];
DSPaccum out[MAX_NUM_CHANNEL];

ENABLE_STATE enable;
OUTPUT_MODE outputMode;
DSPfract gain;

void filter_init()
{
    DSPfract* historyPtr1 = history[LEFT_CH];
    DSPfract* historyPtr2 = history[RIGHT_CH];
    for (DSPint i = 0; i < n_coeff; i++)
    {
        *historyPtr1 = FRACT_NUM(0);
        *historyPtr2 = FRACT_NUM(0);

        historyPtr1++;
        historyPtr2++;
    }

    pState[LEFT_CH] = 0;
    pState[RIGHT_CH] = 0;
    gain = pow(10.0, inputGain / 20.0);
    //gain = 0.630957;
}


int main(int argc, char* argv[])
{
	FILE* wav_in = NULL;
	FILE* wav_out = NULL;
	char WavInputName[256];
	char WavOutputName[256];
	WAV_HEADER inputWAVhdr, outputWAVhdr;

	// Init channel buffers
    for (DSPint i = 0; i < MAX_NUM_CHANNEL; i++)
    {
        for (DSPint j = 0; j < BLOCK_SIZE; j++)
        {
            sampleBuffer[i][j] = FRACT_NUM(0.0);
        }
    }

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
        outputMode = MOD2_0_0;
	}



    // Filter history clear
    filter_init();

    DSPint oneChannelSubChunk2Size = inputWAVhdr.data.SubChunk2Size / inputWAVhdr.fmt.NumChannels;
    DSPint oneChannelByteRate = inputWAVhdr.fmt.ByteRate / inputWAVhdr.fmt.NumChannels;
    DSPint oneChannelBlockAlign = inputWAVhdr.fmt.BlockAlign / inputWAVhdr.fmt.NumChannels;

    outputWAVhdr.data.SubChunk2Size = oneChannelSubChunk2Size * outputWAVhdr.fmt.NumChannels;
    outputWAVhdr.fmt.ByteRate = oneChannelByteRate * outputWAVhdr.fmt.NumChannels;
    outputWAVhdr.fmt.BlockAlign = oneChannelBlockAlign * outputWAVhdr.fmt.NumChannels;


    // Write output WAV header to file
    //-------------------------------------------------
    WriteWavHeader(wav_out, outputWAVhdr);
    
    // Processing loop
    //-------------------------------------------------	
    {
        
        DSPint sample;
        DSPint BytesPerSample = inputWAVhdr.fmt.BitsPerSample / 8;
        const double SAMPLE_SCALE = -(double)(1 << 31);		//2^31
        DSPint iNumSamples = inputWAVhdr.data.SubChunk2Size / (inputWAVhdr.fmt.NumChannels * inputWAVhdr.fmt.BitsPerSample / 8);

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
                                break;
                            default:
                                break;
                        }
                        sample = sampleBuffer[ch][j].toLong();
                    }
                    else
                    {
                        sample = sampleBuffer[k][j].toLong();
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
