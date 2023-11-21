	.extern ___TIMER0_COUNT
	.extern ___TIMER1_COUNT
	.extern ___TIMER1_ENABLE
	.public _coeffs
	.public _enable
	.public _gain
	.public _history
	.public _out
	.public _outputMode
	.public _pState
	.public _pStateL
	.public _pStateR
	.extern _cl_get_cycle_count
	.extern _cl_wavread_bits_per_sample
	.extern _cl_wavread_close
	.extern _cl_wavread_frame_rate
	.extern _cl_wavread_getnchannels
	.extern _cl_wavread_number_of_frames
	.extern _cl_wavread_open
	.extern _cl_wavread_recvsample
	.extern _cl_wavwrite_close
	.extern _cl_wavwrite_open
	.extern _cl_wavwrite_sendsample
	.public _main
	.extern _printf
	.extern _processing
	.public _processing_init
	.extern _strcmp
	.extern _strcpy
	.extern __div
	.xdata_ovly
__extractedConst_0_1
	.dw  (0x50c335d4)
	.xdata_ovly
_coeffs
	.dw  (0xfecf18c1)
	.dw  (0xfecaa82b)
	.dw  (0xfec668d8)
	.dw  (0xfec25ec0)
	.dw  (0xfebe8df4)
	.dw  (0xfebafa9c)
	.dw  (0xfeb7a8fa)
	.dw  (0xfeb49d64)
	.dw  (0xfeb1dc48)
	.dw  (0xfeaf6a26)
	.dw  (0xfead4b96)
	.dw  (0xfeab853c)
	.dw  (0xfeaa1bd3)
	.dw  (0xfea91422)
	.dw  (0xfea872fe)
	.dw  (0x7d79998b)
	.dw  (0xfea872fe)
	.dw  (0xfea91422)
	.dw  (0xfeaa1bd3)
	.dw  (0xfeab853c)
	.dw  (0xfead4b96)
	.dw  (0xfeaf6a26)
	.dw  (0xfeb1dc48)
	.dw  (0xfeb49d64)
	.dw  (0xfeb7a8fa)
	.dw  (0xfebafa9c)
	.dw  (0xfebe8df4)
	.dw  (0xfec25ec0)
	.dw  (0xfec668d8)
	.dw  (0xfecaa82b)
	.dw  (0xfecf18c1)
	.xdata_ovly
_enable
	.bss (0x1)
	.xdata_ovly
_gain
	.bss (0x1)
	.xdata_ovly
_history
	.bss (0x3e)
	.xdata_ovly
_out
	.bss (0x18)
	.xdata_ovly
_outputMode
	.bss (0x1)
	.xdata_ovly
_pState
	.bss (0x2)
	.xdata_ovly
_pStateL
	.dw _history
	.xdata_ovly
_pStateR
	.dw _history+31
	.ydata_ovly
_sampleBuffer
	.bss (0x80)
	.xdata_ovly
_string_const_0
	.dw  (0x4f)
	.dw  (0x66)
	.dw  (0x66)
	.dw  (0x0)
	.xdata_ovly
_string_const_1
	.dw  (0x32)
	.dw  (0x5f)
	.dw  (0x30)
	.dw  (0x5f)
	.dw  (0x30)
	.dw  (0x0)
	.xdata_ovly
_string_const_2
	.dw  (0x32)
	.dw  (0x5f)
	.dw  (0x32)
	.dw  (0x5f)
	.dw  (0x30)
	.dw  (0x0)
	.xdata_ovly
_string_const_3
	.dw  (0x25)
	.dw  (0x6c)
	.dw  (0x6c)
	.dw  (0x75)
	.dw  (0xa)
	.dw  (0x0)
	.code_ovly



	# This construction should ensure linking of crt0 in case when target is a standalone program without the OS
	.if defined(_OVLY_)
		.if .strcmp('standalone',_OVLY_)=0
		.if .strcmp('crystal32',_TARGET_FAMILY_)=0
			.extern __start         # dummy use of __start to force linkage of crt0
dummy		.equ(__start)
		.else
			.extern __intvec         # dummy use of __intvec to force linkage of intvec
dummy		.equ(__intvec)
		.endif
		.endif
	.endif

_main:			/* LN: 71 | CYCLE: 0 | RULES: () */ 
	xmem[i7] = i7			# LN: 71 | 
	i7 += 1			# LN: 71 | 
	i7 = i7 + (0x416)			# LN: 71 | 
	i1 = i7 - (0x1)			# LN: 71 | 
	xmem[i1] = a0h			# LN: 71 | 
	i1 = i7 - (0x2)			# LN: 71 | 
	xmem[i1] = i0			# LN: 71 | 
cline_71_0:			/* LN: 92 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x3)			# LN: 92 | 
	a0 = 0			# LN: 92 | 
	xmem[i0] = a0h			# LN: 92 | 
	do (0x8), label_end_94			# LN: 92 | 
cline_92_0:			/* LN: 94 | CYCLE: 0 | RULES: () */ 
label_begin_94:			/* LN: 92 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x4)			# LN: 94 | 
	a0 = 0			# LN: 94 | 
	xmem[i0] = a0h			# LN: 94 | 
	do (0x10), label_end_93			# LN: 94 | 
cline_94_0:			/* LN: 96 | CYCLE: 0 | RULES: () */ 
label_begin_93:			/* LN: 94 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x3)			# LN: 96 | 
	a0 = xmem[i0]; a1 = 0			# LN: 96, 96 | 
	a0 = a0 << 4			# LN: 96 | 
	i0 = a0			# LN: 96 | 
	i1 = i7 - (0x4)			# LN: 96 | 
	i0 = i0 + (_sampleBuffer + 0)			# LN: 96 | 
	a0 = xmem[i1]			# LN: 96 | 
	b0 = i0			# LN: 96 | 
	a0 = a0 + b0			# LN: 96 | 
	AnyReg(i0, a0h)			# LN: 96 | 
	nop #empty cycle
	ymem[i0] = a1h			# LN: 96 | 
cline_96_0:			/* LN: 94 | CYCLE: 0 | RULES: () */ 
init_latch_label_1:			/* LN: 97 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x4)			# LN: 94 | 
	a0 = xmem[i0]			# LN: 94 | 
	uhalfword(a1) = (0x1)			# LN: 94 | 
	a0 = a0 + a1			# LN: 94 | 
	i0 = i7 - (0x4)			# LN: 94 | 
label_end_93:			# LN: 94 | CYCLE: 5 | RULES: ()
	xmem[i0] = a0h			# LN: 94 | 
cline_94_1:			/* LN: 92 | CYCLE: 0 | RULES: () */ 
init_latch_label_2:			/* LN: 98 | CYCLE: 0 | RULES: () */ 
for_end_2:			/* LN: 94 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x3)			# LN: 92 | 
	a0 = xmem[i0]			# LN: 92 | 
	uhalfword(a1) = (0x1)			# LN: 92 | 
	a0 = a0 + a1			# LN: 92 | 
	i0 = i7 - (0x3)			# LN: 92 | 
label_end_94:			# LN: 92 | CYCLE: 5 | RULES: ()
	xmem[i0] = a0h			# LN: 92 | 
cline_92_1:			/* LN: 103 | CYCLE: 0 | RULES: () */ 
for_end_1:			/* LN: 92 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x2)			# LN: 103 | 
	i0 = xmem[i0]			# LN: 103 | 
	i1 = i7 - (260 - 0)			# LN: 103 | 
	i4 = xmem[i0]			# LN: 103 | 
	i0 = i1			# LN: 103 | 
	i1 = i4			# LN: 103 | 
	call (_strcpy)			# LN: 103 | 
cline_103_0:			/* LN: 104 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (260 - 0)			# LN: 104 | 
	call (_cl_wavread_open)			# LN: 104 | 
	AnyReg(i0, a0h)			# LN: 104 | 
	i1 = i7 - (0x105)			# LN: 104 | 
	xmem[i1] = i0			# LN: 104 | 
cline_104_0:			/* LN: 105 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x105)			# LN: 105 | 
	a0 = xmem[i0]			# LN: 105 | 
	a0 & a0			# LN: 105 | 
	if (a != 0) jmp (else_0)			# LN: 105 | 
cline_105_0:			/* LN: 107 | CYCLE: 0 | RULES: () */ 
	halfword(a0) = (0xffff)			# LN: 107 | 
	jmp (__epilogue_258)			# LN: 107 | 
cline_107_0:			/* LN: 113 | CYCLE: 0 | RULES: () */ 
endif_0:			/* LN: 105 | CYCLE: 0 | RULES: () */ 
else_0:			/* LN: 105 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x105)			# LN: 113 | 
	i0 = xmem[i0]			# LN: 113 | 
	call (_cl_wavread_getnchannels)			# LN: 113 | 
	i0 = i7 - (0x106)			# LN: 113 | 
	xmem[i0] = a0h			# LN: 113 | 
cline_113_0:			/* LN: 114 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x105)			# LN: 114 | 
	i0 = xmem[i0]			# LN: 114 | 
	call (_cl_wavread_bits_per_sample)			# LN: 114 | 
	i0 = i7 - (0x107)			# LN: 114 | 
	xmem[i0] = a0h			# LN: 114 | 
cline_114_0:			/* LN: 115 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x105)			# LN: 115 | 
	i0 = xmem[i0]			# LN: 115 | 
	call (_cl_wavread_frame_rate)			# LN: 115 | 
	i0 = i7 - (0x108)			# LN: 115 | 
	xmem[i0] = a0h			# LN: 115 | 
cline_115_0:			/* LN: 116 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x105)			# LN: 116 | 
	i0 = xmem[i0]			# LN: 116 | 
	call (_cl_wavread_number_of_frames)			# LN: 116 | 
	i0 = i7 - (0x109)			# LN: 116 | 
	xmem[i0] = a0h			# LN: 116 | 
cline_116_0:			/* LN: 118 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x2)			# LN: 118 | 
	i0 = xmem[i0]			# LN: 118 | 
	i1 = i7 - (521 - 0)			# LN: 118 | 
	i0 += 1			# LN: 118 | 
	i4 = xmem[i0]			# LN: 118 | 
	i0 = i1			# LN: 118 | 
	i1 = i4			# LN: 118 | 
	call (_strcpy)			# LN: 118 | 
cline_118_0:			/* LN: 120 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x2)			# LN: 120 | 
	i0 = xmem[i0]			# LN: 120 | 
	i1 = i7 - (777 - 0)			# LN: 120 | 
	i0 += 2			# LN: 120 | 
	i4 = xmem[i0]			# LN: 120 | 
	i0 = i1			# LN: 120 | 
	i1 = i4			# LN: 120 | 
	call (_strcpy)			# LN: 120 | 
cline_120_0:			/* LN: 122 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (777 - 0)			# LN: 122 | 
	i1 = (0) + (_string_const_0)			# LN: 122 | 
	call (_strcmp)			# LN: 122 | 
	a0 & a0			# LN: 122 | 
	if (a != 0) jmp (else_1)			# LN: 122 | 
cline_122_0:			/* LN: 124 | CYCLE: 0 | RULES: () */ 
	a0 = 0			# LN: 124 | 
	xmem[_enable + 0] = a0h			# LN: 124 | 
	jmp (endif_1)			# LN: 124 | 
cline_124_0:			/* LN: 128 | CYCLE: 0 | RULES: () */ 
else_1:			/* LN: 122 | CYCLE: 0 | RULES: () */ 
	uhalfword(a0) = (0x1)			# LN: 128 | 
	xmem[_enable + 0] = a0h			# LN: 128 | 
cline_128_0:			/* LN: 131 | CYCLE: 0 | RULES: () */ 
endif_1:			/* LN: 122 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x2)			# LN: 131 | 
	i0 = xmem[i0]			# LN: 131 | 
	i1 = i7 - (1033 - 0)			# LN: 131 | 
	i0 = i0 + (0x3)			# LN: 131 | 
	i4 = xmem[i0]			# LN: 131 | 
	i0 = i1			# LN: 131 | 
	i1 = i4			# LN: 131 | 
	call (_strcpy)			# LN: 131 | 
cline_131_0:			/* LN: 132 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (1033 - 0)			# LN: 132 | 
	i1 = (0) + (_string_const_1)			# LN: 132 | 
	call (_strcmp)			# LN: 132 | 
	a0 & a0			# LN: 132 | 
	if (a != 0) jmp (else_2)			# LN: 132 | 
cline_132_0:			/* LN: 134 | CYCLE: 0 | RULES: () */ 
	uhalfword(a0) = (0x2)			# LN: 134 | 
	xmem[_outputMode + 0] = a0h			# LN: 134 | 
	jmp (endif_2)			# LN: 134 | 
cline_134_0:			/* LN: 136 | CYCLE: 0 | RULES: () */ 
else_2:			/* LN: 132 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (1033 - 0)			# LN: 136 | 
	i1 = (0) + (_string_const_2)			# LN: 136 | 
	call (_strcmp)			# LN: 136 | 
	a0 & a0			# LN: 136 | 
	if (a != 0) jmp (else_3)			# LN: 136 | 
cline_136_0:			/* LN: 138 | CYCLE: 0 | RULES: () */ 
	uhalfword(a0) = (0x1)			# LN: 138 | 
	xmem[_outputMode + 0] = a0h			# LN: 138 | 
	jmp (endif_3)			# LN: 138 | 
cline_138_0:			/* LN: 142 | CYCLE: 0 | RULES: () */ 
else_3:			/* LN: 136 | CYCLE: 0 | RULES: () */ 
	a0 = 0			# LN: 142 | 
	xmem[_outputMode + 0] = a0h			# LN: 142 | 
cline_142_0:			/* LN: 145 | CYCLE: 0 | RULES: () */ 
endif_2:			/* LN: 132 | CYCLE: 0 | RULES: () */ 
endif_3:			/* LN: 136 | CYCLE: 0 | RULES: () */ 
	a0 = xmem[_enable + 0]			# LN: 145 | 
	uhalfword(a1) = (0x1)			# LN: 145 | 
	a0 - a1			# LN: 145 | 
	if (a != 0) jmp (else_4)			# LN: 145 | 
	a0 = xmem[_outputMode + 0]			# LN: 145 | 
	a0 & a0			# LN: 145 | 
	if (a != 0) jmp (else_4)			# LN: 145 | 
cline_145_0:			/* LN: 147 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40a)			# LN: 147 | 
	uhalfword(a0) = (0x6)			# LN: 147 | 
	xmem[i0] = a0h			# LN: 147 | 
cline_147_0:			/* LN: 148 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (521 - 0)			# LN: 148 | 
	i1 = i7 - (0x107)			# LN: 148 | 
	a0 = xmem[i1]			# LN: 148 | 
	i1 = i7 - (0x40a)			# LN: 148 | 
	a1 = xmem[i1]			# LN: 148 | 
	i1 = i7 - (0x108)			# LN: 148 | 
	b0 = xmem[i1]			# LN: 148 | 
	call (_cl_wavwrite_open)			# LN: 148 | 
	AnyReg(i0, a0h)			# LN: 148 | 
	i1 = i7 - (0x40b)			# LN: 148 | 
	xmem[i1] = i0			# LN: 148 | 
	jmp (endif_4)			# LN: 148 | 
cline_148_0:			/* LN: 150 | CYCLE: 0 | RULES: () */ 
endif_4:			/* LN: 145 | CYCLE: 0 | RULES: () */ 
else_4:			/* LN: 145 | CYCLE: 0 | RULES: () */ 
	a0 = xmem[_enable + 0]			# LN: 150 | 
	uhalfword(a1) = (0x1)			# LN: 150 | 
	a0 - a1			# LN: 150 | 
	if (a != 0) jmp (else_5)			# LN: 150 | 
	a0 = xmem[_outputMode + 0]			# LN: 150 | 
	uhalfword(a1) = (0x1)			# LN: 150 | 
	a0 - a1			# LN: 150 | 
	if (a != 0) jmp (else_5)			# LN: 150 | 
cline_150_0:			/* LN: 152 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40a)			# LN: 152 | 
	uhalfword(a0) = (0x4)			# LN: 152 | 
	xmem[i0] = a0h			# LN: 152 | 
cline_152_0:			/* LN: 153 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (521 - 0)			# LN: 153 | 
	i1 = i7 - (0x107)			# LN: 153 | 
	a0 = xmem[i1]			# LN: 153 | 
	i1 = i7 - (0x40a)			# LN: 153 | 
	a1 = xmem[i1]			# LN: 153 | 
	i1 = i7 - (0x108)			# LN: 153 | 
	b0 = xmem[i1]			# LN: 153 | 
	call (_cl_wavwrite_open)			# LN: 153 | 
	AnyReg(i0, a0h)			# LN: 153 | 
	i1 = i7 - (0x40b)			# LN: 153 | 
	xmem[i1] = i0			# LN: 153 | 
	jmp (endif_5)			# LN: 153 | 
cline_153_0:			/* LN: 155 | CYCLE: 0 | RULES: () */ 
endif_5:			/* LN: 150 | CYCLE: 0 | RULES: () */ 
else_5:			/* LN: 150 | CYCLE: 0 | RULES: () */ 
	a0 = xmem[_enable + 0]			# LN: 155 | 
	a0 & a0			# LN: 155 | 
	if (a == 0) jmp (cline_155_0)			# LN: 155 | 
	a0 = xmem[_outputMode + 0]			# LN: 155 | 
	uhalfword(a1) = (0x2)			# LN: 155 | 
	a0 - a1			# LN: 155 | 
	if (a != 0) jmp (else_6)			# LN: 155 | 
cline_155_0:			/* LN: 157 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40a)			# LN: 157 | 
	uhalfword(a0) = (0x2)			# LN: 157 | 
	xmem[i0] = a0h			# LN: 157 | 
cline_157_0:			/* LN: 158 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (521 - 0)			# LN: 158 | 
	i1 = i7 - (0x107)			# LN: 158 | 
	a0 = xmem[i1]			# LN: 158 | 
	i1 = i7 - (0x40a)			# LN: 158 | 
	a1 = xmem[i1]			# LN: 158 | 
	i1 = i7 - (0x108)			# LN: 158 | 
	b0 = xmem[i1]			# LN: 158 | 
	call (_cl_wavwrite_open)			# LN: 158 | 
	AnyReg(i0, a0h)			# LN: 158 | 
	i1 = i7 - (0x40b)			# LN: 158 | 
	xmem[i1] = i0			# LN: 158 | 
	jmp (endif_6)			# LN: 158 | 
cline_158_0:			/* LN: 164 | CYCLE: 0 | RULES: () */ 
endif_6:			/* LN: 155 | CYCLE: 0 | RULES: () */ 
else_6:			/* LN: 155 | CYCLE: 0 | RULES: () */ 
	call (_processing_init)			# LN: 164 | 
cline_164_0:			/* LN: 176 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40c)			# LN: 176 | 
	a0 = 0			# LN: 176 | 
	xmem[i0] = a0h			# LN: 176 | 
for_3:			/* LN: 176 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x109)			# LN: 176 | 
	a0 = xmem[i0]			# LN: 176 | 
	uhalfword(a1) = (0x10)			# LN: 176 | 
	call (__div)			# LN: 176 | 
	i0 = i7 - (0x40c)			# LN: 176 | 
	a1 = xmem[i0]			# LN: 176 | 
	a1 - a0			# LN: 176 | 
	if (a >= 0) jmp (for_end_3)			# LN: 176 | 
cline_176_0:			/* LN: 178 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40d)			# LN: 178 | 
	a0 = 0			# LN: 178 | 
	xmem[i0] = a0h			# LN: 178 | 
	do (0x10), label_end_95			# LN: 178 | 
cline_178_0:			/* LN: 180 | CYCLE: 0 | RULES: () */ 
label_begin_95:			/* LN: 178 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 180 | 
	a0 = 0			# LN: 180 | 
	xmem[i0] = a0h			# LN: 180 | 
for_5:			/* LN: 180 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 180 | 
	a0 = xmem[i0]			# LN: 180 | 
	i0 = i7 - (0x106)			# LN: 180 | 
	a1 = xmem[i0]			# LN: 180 | 
	a0 - a1			# LN: 180 | 
	if (a >= 0) jmp (for_end_5)			# LN: 180 | 
cline_180_0:			/* LN: 182 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x105)			# LN: 182 | 
	i0 = xmem[i0]			# LN: 182 | 
	call (_cl_wavread_recvsample)			# LN: 182 | 
	i0 = i7 - (0x40f)			# LN: 182 | 
	xmem[i0] = a0h			# LN: 182 | 
cline_182_0:			/* LN: 183 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 183 | 
	a0 = xmem[i0]			# LN: 183 | 
	a0 = a0 << 4			# LN: 183 | 
	i0 = a0			# LN: 183 | 
	i1 = i7 - (0x40d)			# LN: 183 | 
	i0 = i0 + (_sampleBuffer + 0)			# LN: 183 | 
	a0 = xmem[i1]			# LN: 183 | 
	a1 = i0			# LN: 183 | 
	a0 = a1 + a0			# LN: 183 | 
	AnyReg(i0, a0h)			# LN: 183 | 
	i1 = i7 - (0x40f)			# LN: 183 | 
	a0 = xmem[i1]			# LN: 183 | 
	ymem[i0] = a0h			# LN: 183 | 
cline_183_0:			/* LN: 180 | CYCLE: 0 | RULES: () */ 
init_latch_label_3:			/* LN: 184 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 180 | 
	a0 = xmem[i0]			# LN: 180 | 
	uhalfword(a1) = (0x1)			# LN: 180 | 
	a0 = a0 + a1			# LN: 180 | 
	i0 = i7 - (0x40e)			# LN: 180 | 
	xmem[i0] = a0h			# LN: 180 | 
	jmp (for_5)			# LN: 180 | 
cline_180_1:			/* LN: 178 | CYCLE: 0 | RULES: () */ 
init_latch_label_4:			/* LN: 185 | CYCLE: 0 | RULES: () */ 
for_end_5:			/* LN: 180 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40d)			# LN: 178 | 
	a0 = xmem[i0]			# LN: 178 | 
	uhalfword(a1) = (0x1)			# LN: 178 | 
	a0 = a0 + a1			# LN: 178 | 
	i0 = i7 - (0x40d)			# LN: 178 | 
label_end_95:			# LN: 178 | CYCLE: 5 | RULES: ()
	xmem[i0] = a0h			# LN: 178 | 
cline_178_1:			/* LN: 187 | CYCLE: 0 | RULES: () */ 
for_end_4:			/* LN: 178 | CYCLE: 0 | RULES: () */ 
	a0 = xmem[_enable + 0]			# LN: 187 | 
	uhalfword(a1) = (0x1)			# LN: 187 | 
	a0 - a1			# LN: 187 | 
	if (a != 0) jmp (else_7)			# LN: 187 | 
cline_187_0:			/* LN: 189 | CYCLE: 0 | RULES: () */ 
	call (_cl_get_cycle_count)			# LN: 189 | 
	i0 = i7 - (0x411)			# LN: 189 | 
	xmem[i0] = a0h; i0 += 1			# LN: 189, 189 | 
	xmem[i0] = a0l			# LN: 189 | 
cline_189_0:			/* LN: 190 | CYCLE: 0 | RULES: () */ 
	i0 = (0) + (_sampleBuffer)			# LN: 190 | 
	i1 = (0) + (_sampleBuffer)			# LN: 190 | 
	call (_processing)			# LN: 190 | 
cline_190_0:			/* LN: 191 | CYCLE: 0 | RULES: () */ 
	call (_cl_get_cycle_count)			# LN: 191 | 
	i0 = i7 - (0x413)			# LN: 191 | 
	xmem[i0] = a0h; i0 += 1			# LN: 191, 191 | 
	xmem[i0] = a0l			# LN: 191 | 
cline_191_0:			/* LN: 192 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x413)			# LN: 192 | 
	a0 = xmem[i0]; i0 += 1			# LN: 192, 192 | 
	a0l = xmem[i0]			# LN: 192 | 
	i0 = i7 - (0x411)			# LN: 192 | 
	a1 = xmem[i0]; i0 += 1			# LN: 192, 192 | 
	a1l = xmem[i0]			# LN: 192 | 
	a0 = a0 - a1			# LN: 192 | 
	i0 = i7 - (0x415)			# LN: 192 | 
	xmem[i0] = a0h; i0 += 1			# LN: 192, 192 | 
	xmem[i0] = a0l			# LN: 192 | 
cline_192_0:			/* LN: 193 | CYCLE: 0 | RULES: () */ 
	i1 = i7 - (0x415)			# LN: 193 | 
	a0 = xmem[i1]; i1 += 1			# LN: 193, 193 | 
	a0l = xmem[i1]			# LN: 193 | 
	i0 = (0) + (_string_const_3)			# LN: 193 | 
	call (_printf)			# LN: 193 | 
	jmp (endif_7)			# LN: 193 | 
cline_193_0:			/* LN: 196 | CYCLE: 0 | RULES: () */ 
endif_7:			/* LN: 187 | CYCLE: 0 | RULES: () */ 
else_7:			/* LN: 187 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40d)			# LN: 196 | 
	a0 = 0			# LN: 196 | 
	xmem[i0] = a0h			# LN: 196 | 
	do (0x10), label_end_96			# LN: 196 | 
cline_196_0:			/* LN: 198 | CYCLE: 0 | RULES: () */ 
label_begin_96:			/* LN: 196 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 198 | 
	a0 = 0			# LN: 198 | 
	xmem[i0] = a0h			# LN: 198 | 
for_7:			/* LN: 198 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 198 | 
	a0 = xmem[i0]			# LN: 198 | 
	i0 = i7 - (0x40a)			# LN: 198 | 
	a1 = xmem[i0]			# LN: 198 | 
	a0 - a1			# LN: 198 | 
	if (a >= 0) jmp (for_end_7)			# LN: 198 | 
cline_198_0:			/* LN: 200 | CYCLE: 0 | RULES: () */ 
	a0 = xmem[_enable + 0]			# LN: 200 | 
	uhalfword(a1) = (0x1)			# LN: 200 | 
	a0 - a1			# LN: 200 | 
	if (a != 0) jmp (else_8)			# LN: 200 | 
cline_200_0:			/* LN: 202 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x416)			# LN: 202 | 
	a0 = 0			# LN: 202 | 
	xmem[i0] = a0h			# LN: 202 | 
cline_202_0:			/* LN: 203 | CYCLE: 0 | RULES: () */ 
switch_0:			/* LN: 203 | CYCLE: 0 | RULES: () */ 
	a0 = xmem[_outputMode + 0]			# LN: 203 | 
	a0 & a0			# LN: 203 | 
	if (a == 0) jmp (case_2)			# LN: 203 | 
	a0 = xmem[_outputMode + 0]			# LN: 203 | 
	uhalfword(a1) = (0x1)			# LN: 203 | 
	a0 - a1			# LN: 203 | 
	if (a == 0) jmp (case_1)			# LN: 203 | 
	a0 = xmem[_outputMode + 0]			# LN: 203 | 
	uhalfword(a1) = (0x2)			# LN: 203 | 
	a0 - a1			# LN: 203 | 
	if (a == 0) jmp (case_0)			# LN: 203 | 
	jmp (default_0)			# LN: 203 | 
cline_203_0:			/* LN: 206 | CYCLE: 0 | RULES: () */ 
case_0:			/* LN: 205 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 206 | 
	a0 = xmem[i0]			# LN: 206 | 
	a0 & a0			# LN: 206 | 
	if (a != 0) jmp (else_9)			# LN: 206 | 
	i0 = i7 - (0x416)			# LN: 206 | 
	uhalfword(a0) = (0x1)			# LN: 206 | 
	xmem[i0] = a0h			# LN: 206 | 
	jmp (endif_9)			# LN: 206 | 
cline_206_0:			/* LN: 207 | CYCLE: 0 | RULES: () */ 
endif_9:			/* LN: 206 | CYCLE: 0 | RULES: () */ 
else_9:			/* LN: 206 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 207 | 
	a0 = xmem[i0]			# LN: 207 | 
	uhalfword(a1) = (0x1)			# LN: 207 | 
	a0 - a1			# LN: 207 | 
	if (a != 0) jmp (else_10)			# LN: 207 | 
	i0 = i7 - (0x416)			# LN: 207 | 
	uhalfword(a0) = (0x3)			# LN: 207 | 
	xmem[i0] = a0h			# LN: 207 | 
	jmp (endif_10)			# LN: 207 | 
cline_207_0:			/* LN: 208 | CYCLE: 0 | RULES: () */ 
endif_10:			/* LN: 207 | CYCLE: 0 | RULES: () */ 
else_10:			/* LN: 207 | CYCLE: 0 | RULES: () */ 
	jmp (switch_end_0)			# LN: 208 | 
cline_208_0:			/* LN: 210 | CYCLE: 0 | RULES: () */ 
case_1:			/* LN: 209 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 210 | 
	a0 = xmem[i0]			# LN: 210 | 
	a0 & a0			# LN: 210 | 
	if (a != 0) jmp (else_11)			# LN: 210 | 
	i0 = i7 - (0x416)			# LN: 210 | 
	a0 = 0			# LN: 210 | 
	xmem[i0] = a0h			# LN: 210 | 
	jmp (endif_11)			# LN: 210 | 
cline_210_0:			/* LN: 211 | CYCLE: 0 | RULES: () */ 
endif_11:			/* LN: 210 | CYCLE: 0 | RULES: () */ 
else_11:			/* LN: 210 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 211 | 
	a0 = xmem[i0]			# LN: 211 | 
	uhalfword(a1) = (0x1)			# LN: 211 | 
	a0 - a1			# LN: 211 | 
	if (a != 0) jmp (else_12)			# LN: 211 | 
	i0 = i7 - (0x416)			# LN: 211 | 
	uhalfword(a0) = (0x1)			# LN: 211 | 
	xmem[i0] = a0h			# LN: 211 | 
	jmp (endif_12)			# LN: 211 | 
cline_211_0:			/* LN: 212 | CYCLE: 0 | RULES: () */ 
endif_12:			/* LN: 211 | CYCLE: 0 | RULES: () */ 
else_12:			/* LN: 211 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 212 | 
	a0 = xmem[i0]			# LN: 212 | 
	uhalfword(a1) = (0x2)			# LN: 212 | 
	a0 - a1			# LN: 212 | 
	if (a != 0) jmp (else_13)			# LN: 212 | 
	i0 = i7 - (0x416)			# LN: 212 | 
	uhalfword(a0) = (0x3)			# LN: 212 | 
	xmem[i0] = a0h			# LN: 212 | 
	jmp (endif_13)			# LN: 212 | 
cline_212_0:			/* LN: 213 | CYCLE: 0 | RULES: () */ 
endif_13:			/* LN: 212 | CYCLE: 0 | RULES: () */ 
else_13:			/* LN: 212 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 213 | 
	a0 = xmem[i0]			# LN: 213 | 
	uhalfword(a1) = (0x3)			# LN: 213 | 
	a0 - a1			# LN: 213 | 
	if (a != 0) jmp (else_14)			# LN: 213 | 
	i0 = i7 - (0x416)			# LN: 213 | 
	uhalfword(a0) = (0x4)			# LN: 213 | 
	xmem[i0] = a0h			# LN: 213 | 
	jmp (endif_14)			# LN: 213 | 
cline_213_0:			/* LN: 214 | CYCLE: 0 | RULES: () */ 
endif_14:			/* LN: 213 | CYCLE: 0 | RULES: () */ 
else_14:			/* LN: 213 | CYCLE: 0 | RULES: () */ 
	jmp (switch_end_0)			# LN: 214 | 
cline_214_0:			/* LN: 216 | CYCLE: 0 | RULES: () */ 
case_2:			/* LN: 215 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 216 | 
	a0 = xmem[i0]			# LN: 216 | 
	a0 & a0			# LN: 216 | 
	if (a != 0) jmp (else_15)			# LN: 216 | 
	i0 = i7 - (0x416)			# LN: 216 | 
	a0 = 0			# LN: 216 | 
	xmem[i0] = a0h			# LN: 216 | 
	jmp (endif_15)			# LN: 216 | 
cline_216_0:			/* LN: 217 | CYCLE: 0 | RULES: () */ 
endif_15:			/* LN: 216 | CYCLE: 0 | RULES: () */ 
else_15:			/* LN: 216 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 217 | 
	a0 = xmem[i0]			# LN: 217 | 
	uhalfword(a1) = (0x1)			# LN: 217 | 
	a0 - a1			# LN: 217 | 
	if (a != 0) jmp (else_16)			# LN: 217 | 
	i0 = i7 - (0x416)			# LN: 217 | 
	uhalfword(a0) = (0x1)			# LN: 217 | 
	xmem[i0] = a0h			# LN: 217 | 
	jmp (endif_16)			# LN: 217 | 
cline_217_0:			/* LN: 218 | CYCLE: 0 | RULES: () */ 
endif_16:			/* LN: 217 | CYCLE: 0 | RULES: () */ 
else_16:			/* LN: 217 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 218 | 
	a0 = xmem[i0]			# LN: 218 | 
	uhalfword(a1) = (0x2)			# LN: 218 | 
	a0 - a1			# LN: 218 | 
	if (a != 0) jmp (else_17)			# LN: 218 | 
	i0 = i7 - (0x416)			# LN: 218 | 
	uhalfword(a0) = (0x2)			# LN: 218 | 
	xmem[i0] = a0h			# LN: 218 | 
	jmp (endif_17)			# LN: 218 | 
cline_218_0:			/* LN: 219 | CYCLE: 0 | RULES: () */ 
endif_17:			/* LN: 218 | CYCLE: 0 | RULES: () */ 
else_17:			/* LN: 218 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 219 | 
	a0 = xmem[i0]			# LN: 219 | 
	uhalfword(a1) = (0x3)			# LN: 219 | 
	a0 - a1			# LN: 219 | 
	if (a != 0) jmp (else_18)			# LN: 219 | 
	i0 = i7 - (0x416)			# LN: 219 | 
	uhalfword(a0) = (0x3)			# LN: 219 | 
	xmem[i0] = a0h			# LN: 219 | 
	jmp (endif_18)			# LN: 219 | 
cline_219_0:			/* LN: 220 | CYCLE: 0 | RULES: () */ 
endif_18:			/* LN: 219 | CYCLE: 0 | RULES: () */ 
else_18:			/* LN: 219 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 220 | 
	a0 = xmem[i0]			# LN: 220 | 
	uhalfword(a1) = (0x4)			# LN: 220 | 
	a0 - a1			# LN: 220 | 
	if (a != 0) jmp (else_19)			# LN: 220 | 
	i0 = i7 - (0x416)			# LN: 220 | 
	uhalfword(a0) = (0x4)			# LN: 220 | 
	xmem[i0] = a0h			# LN: 220 | 
	jmp (endif_19)			# LN: 220 | 
cline_220_0:			/* LN: 221 | CYCLE: 0 | RULES: () */ 
endif_19:			/* LN: 220 | CYCLE: 0 | RULES: () */ 
else_19:			/* LN: 220 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 221 | 
	a0 = xmem[i0]			# LN: 221 | 
	uhalfword(a1) = (0x5)			# LN: 221 | 
	a0 - a1			# LN: 221 | 
	if (a != 0) jmp (else_20)			# LN: 221 | 
	i0 = i7 - (0x416)			# LN: 221 | 
	uhalfword(a0) = (0x5)			# LN: 221 | 
	xmem[i0] = a0h			# LN: 221 | 
	jmp (endif_20)			# LN: 221 | 
cline_221_0:			/* LN: 222 | CYCLE: 0 | RULES: () */ 
endif_20:			/* LN: 221 | CYCLE: 0 | RULES: () */ 
else_20:			/* LN: 221 | CYCLE: 0 | RULES: () */ 
	jmp (switch_end_0)			# LN: 222 | 
cline_222_0:			/* LN: 224 | CYCLE: 0 | RULES: () */ 
default_0:			/* LN: 223 | CYCLE: 0 | RULES: () */ 
	jmp (switch_end_0)			# LN: 224 | 
cline_224_0:			/* LN: 226 | CYCLE: 0 | RULES: () */ 
switch_end_0:			/* LN: 203 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x416)			# LN: 226 | 
	a0 = xmem[i0]			# LN: 226 | 
	a0 = a0 << 4			# LN: 226 | 
	i0 = a0			# LN: 226 | 
	i1 = i7 - (0x40d)			# LN: 226 | 
	i0 = i0 + (_sampleBuffer + 0)			# LN: 226 | 
	a0 = xmem[i1]			# LN: 226 | 
	a1 = i0			# LN: 226 | 
	a0 = a1 + a0			# LN: 226 | 
	AnyReg(i0, a0h)			# LN: 226 | 
	i1 = i7 - (0x40f)			# LN: 226 | 
	a0 = ymem[i0]			# LN: 226 | 
	xmem[i1] = a0h			# LN: 226 | 
	jmp (endif_8)			# LN: 226 | 
cline_226_0:			/* LN: 230 | CYCLE: 0 | RULES: () */ 
else_8:			/* LN: 200 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 230 | 
	a0 = xmem[i0]			# LN: 230 | 
	a0 = a0 << 4			# LN: 230 | 
	i0 = a0			# LN: 230 | 
	i1 = i7 - (0x40d)			# LN: 230 | 
	i0 = i0 + (_sampleBuffer + 0)			# LN: 230 | 
	a0 = xmem[i1]			# LN: 230 | 
	a1 = i0			# LN: 230 | 
	a0 = a1 + a0			# LN: 230 | 
	AnyReg(i0, a0h)			# LN: 230 | 
	i1 = i7 - (0x40f)			# LN: 230 | 
	a0 = ymem[i0]			# LN: 230 | 
	xmem[i1] = a0h			# LN: 230 | 
cline_230_0:			/* LN: 232 | CYCLE: 0 | RULES: () */ 
endif_8:			/* LN: 200 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40b)			# LN: 232 | 
	i1 = i7 - (0x40f)			# LN: 232 | 
	a0 = xmem[i1]			# LN: 232 | 
	i0 = xmem[i0]			# LN: 232 | 
	call (_cl_wavwrite_sendsample)			# LN: 232 | 
cline_232_0:			/* LN: 198 | CYCLE: 0 | RULES: () */ 
init_latch_label_5:			/* LN: 233 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40e)			# LN: 198 | 
	a0 = xmem[i0]			# LN: 198 | 
	uhalfword(a1) = (0x1)			# LN: 198 | 
	a0 = a0 + a1			# LN: 198 | 
	i0 = i7 - (0x40e)			# LN: 198 | 
	xmem[i0] = a0h			# LN: 198 | 
	jmp (for_7)			# LN: 198 | 
cline_198_1:			/* LN: 196 | CYCLE: 0 | RULES: () */ 
init_latch_label_6:			/* LN: 234 | CYCLE: 0 | RULES: () */ 
for_end_7:			/* LN: 198 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40d)			# LN: 196 | 
	a0 = xmem[i0]			# LN: 196 | 
	uhalfword(a1) = (0x1)			# LN: 196 | 
	a0 = a0 + a1			# LN: 196 | 
	i0 = i7 - (0x40d)			# LN: 196 | 
label_end_96:			# LN: 196 | CYCLE: 5 | RULES: ()
	xmem[i0] = a0h			# LN: 196 | 
cline_196_1:			/* LN: 176 | CYCLE: 0 | RULES: () */ 
init_latch_label_7:			/* LN: 235 | CYCLE: 0 | RULES: () */ 
for_end_6:			/* LN: 196 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40c)			# LN: 176 | 
	a0 = xmem[i0]			# LN: 176 | 
	uhalfword(a1) = (0x1)			# LN: 176 | 
	a0 = a0 + a1			# LN: 176 | 
	i0 = i7 - (0x40c)			# LN: 176 | 
	xmem[i0] = a0h			# LN: 176 | 
	jmp (for_3)			# LN: 176 | 
cline_176_1:			/* LN: 241 | CYCLE: 0 | RULES: () */ 
for_end_3:			/* LN: 176 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x105)			# LN: 241 | 
	i0 = xmem[i0]			# LN: 241 | 
	call (_cl_wavread_close)			# LN: 241 | 
cline_241_0:			/* LN: 242 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x40b)			# LN: 242 | 
	i0 = xmem[i0]			# LN: 242 | 
	call (_cl_wavwrite_close)			# LN: 242 | 
cline_242_0:			/* LN: 245 | CYCLE: 0 | RULES: () */ 
	a0 = 0			# LN: 245 | 
	jmp (__epilogue_258)			# LN: 245 | 
cline_245_0:			/* LN: 246 | CYCLE: 0 | RULES: () */ 
__epilogue_258:			/* LN: 246 | CYCLE: 0 | RULES: () */ 
	i7 = i7 - (0x416)			# LN: 246 | 
	i7 -= 1			# LN: 246 | 
	ret			# LN: 246 | 



_processing_init:			/* LN: 49 | CYCLE: 0 | RULES: () */ 
	xmem[i7] = i7			# LN: 49 | 
	i7 += 1			# LN: 49 | 
	i7 = i7 + (0x3)			# LN: 49 | 
cline_49_0:			/* LN: 52 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x1)			# LN: 52 | 
	uhalfword(a0) = (_history + 0)			# LN: 52 | 
	xmem[i0] = a0			# LN: 52 | 
cline_52_0:			/* LN: 53 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x2)			# LN: 53 | 
	uhalfword(a0) = (_history + 31)			# LN: 53 | 
	xmem[i0] = a0			# LN: 53 | 
cline_53_0:			/* LN: 54 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x3)			# LN: 54 | 
	a0 = 0			# LN: 54 | 
	xmem[i0] = a0h			# LN: 54 | 
	do (0x1f), label_end_92			# LN: 54 | 
cline_54_0:			/* LN: 56 | CYCLE: 0 | RULES: () */ 
label_begin_92:			/* LN: 54 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x1)			# LN: 56 | 
	i0 = xmem[i0]			# LN: 56 | 
	a0 = 0			# LN: 56 | 
	xmem[i0] = a0h			# LN: 56 | 
cline_56_0:			/* LN: 57 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x2)			# LN: 57 | 
	i0 = xmem[i0]			# LN: 57 | 
	a0 = 0			# LN: 57 | 
	xmem[i0] = a0h			# LN: 57 | 
cline_57_0:			/* LN: 59 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x1)			# LN: 59 | 
	i0 = xmem[i0]			# LN: 59 | 
	i1 = i7 - (0x1)			# LN: 59 | 
	i0 += 1			# LN: 59 | 
	xmem[i1] = i0			# LN: 59 | 
cline_59_0:			/* LN: 60 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x2)			# LN: 60 | 
	i0 = xmem[i0]			# LN: 60 | 
	i1 = i7 - (0x2)			# LN: 60 | 
	i0 += 1			# LN: 60 | 
	xmem[i1] = i0			# LN: 60 | 
cline_60_0:			/* LN: 54 | CYCLE: 0 | RULES: () */ 
init_latch_label_0:			/* LN: 61 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x3)			# LN: 54 | 
	a0 = xmem[i0]			# LN: 54 | 
	uhalfword(a1) = (0x1)			# LN: 54 | 
	a0 = a0 + a1			# LN: 54 | 
	i0 = i7 - (0x3)			# LN: 54 | 
label_end_92:			# LN: 54 | CYCLE: 5 | RULES: ()
	xmem[i0] = a0h			# LN: 54 | 
cline_54_1:			/* LN: 62 | CYCLE: 0 | RULES: () */ 
for_end_0:			/* LN: 54 | CYCLE: 0 | RULES: () */ 
	i0 = (0) + (_pStateL)			# LN: 62 | 
	i0 = xmem[i0]			# LN: 62 | 
	a0 = 0			# LN: 62 | 
	xmem[i0] = a0h			# LN: 62 | 
cline_62_0:			/* LN: 63 | CYCLE: 0 | RULES: () */ 
	i0 = (0) + (_pStateL)			# LN: 63 | 
	i0 = xmem[i0]			# LN: 63 | 
	a0 = 0			# LN: 63 | 
	xmem[i0] = a0h			# LN: 63 | 
cline_63_0:			/* LN: 64 | CYCLE: 0 | RULES: () */ 
	a0 = 0			# LN: 64 | 
	xmem[_pState + 0] = a0h			# LN: 64 | 
cline_64_0:			/* LN: 65 | CYCLE: 0 | RULES: () */ 
	a0 = 0			# LN: 65 | 
	xmem[_pState + 1] = a0h			# LN: 65 | 
cline_65_0:			/* LN: 67 | CYCLE: 0 | RULES: () */ 
	a0 = xmem[__extractedConst_0_1 + 0]			# LN: 67 | 
	xmem[_gain + 0] = a0h			# LN: 67 | 
cline_67_0:			/* LN: 68 | CYCLE: 0 | RULES: () */ 
	jmp (__epilogue_256)			# LN: 68 | 
__epilogue_256:			/* LN: 68 | CYCLE: 0 | RULES: () */ 
	i7 = i7 - (0x3)			# LN: 68 | 
	i7 -= 1			# LN: 68 | 
	ret			# LN: 68 | 
