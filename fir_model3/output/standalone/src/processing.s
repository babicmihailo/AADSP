	.extern _coeffs
	.extern _gain
	.extern _history
	.extern _out
	.extern _outputMode
	.extern _pState
	.extern _pStateL
	.extern _pStateR
	.public _saturation
	.xdata_ovly
__extractedConst_0_1
	.dw  (0x7ffff79d)
	.xdata_ovly
__extractedConst_1_1
	.dw  (0x80000863)
	.code_ovly



_saturation:			/* LN: 49 | CYCLE: 0 | RULES: () */ 
	xmem[i7] = i7			# LN: 49 | 
	i7 += 1			# LN: 49 | 
	i7 = i7 + (0x4)			# LN: 49 | 
	i0 = i7 - (0x1)			# LN: 49 | 
	xmem[i0] = a0h			# LN: 49 | 
cline_49_0:			/* LN: 51 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x1)			# LN: 51 | 
	a0 = xmem[i0]			# LN: 51 | 
	i0 = i7 - (0x4)			# LN: 51 | 
	xmem[i0] = a0g; i0 += 1			# LN: 51, 51 | 
	xmem[i0] = a0h; i0 += 1			# LN: 51, 51 | 
	xmem[i0] = a0l			# LN: 51 | 
cline_51_0:			/* LN: 53 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x4)			# LN: 53 | 
	a0g = xmem[i0]; i0 += 1			# LN: 53, 53 | 
	a0h = xmem[i0]; i0 += 1			# LN: 53, 53 | 
	a0l = xmem[i0]			# LN: 53 | 
	a0 = a0 >> 1			# LN: 53 | 
	ufixed16(a1) = (0x7fff)			# LN: 53 | 
	lo16(a1) = (0xf79d)			# LN: 53 | 
	a1 = a1 >> 1			# LN: 53 | 
	a0 - a1			# LN: 53 | 
	if (a <= 0) jmp (else_0)			# LN: 53 | 
cline_53_0:			/* LN: 55 | CYCLE: 0 | RULES: () */ 
	a0 = xmem[__extractedConst_0_1 + 0]			# LN: 55 | 
	jmp (__epilogue_160)			# LN: 55 | 
cline_55_0:			/* LN: 57 | CYCLE: 0 | RULES: () */ 
else_0:			/* LN: 53 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x4)			# LN: 57 | 
	a0g = xmem[i0]; i0 += 1			# LN: 57, 57 | 
	a0h = xmem[i0]; i0 += 1			# LN: 57, 57 | 
	a0l = xmem[i0]			# LN: 57 | 
	a0 = a0 >> 1			# LN: 57 | 
	a1 = (0x8000)			# LN: 57 | 
	lo16(a1) = (0x863)			# LN: 57 | 
	a1 = a1 >> 1			# LN: 57 | 
	a0 - a1			# LN: 57 | 
	if (a >= 0) jmp (else_1)			# LN: 57 | 
cline_57_0:			/* LN: 59 | CYCLE: 0 | RULES: () */ 
	a0 = xmem[__extractedConst_1_1 + 0]			# LN: 59 | 
	jmp (__epilogue_160)			# LN: 59 | 
cline_59_0:			/* LN: 62 | CYCLE: 0 | RULES: () */ 
endif_0:			/* LN: 53 | CYCLE: 0 | RULES: () */ 
endif_1:			/* LN: 57 | CYCLE: 0 | RULES: () */ 
else_1:			/* LN: 57 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x1)			# LN: 62 | 
	a0 = xmem[i0]			# LN: 62 | 
	jmp (__epilogue_160)			# LN: 62 | 
cline_62_0:			/* LN: 63 | CYCLE: 0 | RULES: () */ 
__epilogue_160:			/* LN: 63 | CYCLE: 0 | RULES: () */ 
	i7 = i7 - (0x4)			# LN: 63 | 
	i7 -= 1			# LN: 63 | 
	ret			# LN: 63 | 
