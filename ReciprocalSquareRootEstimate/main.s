			AREA	Resp, CODE,READONLY
			ENTRY
			EXPORT	__main
				
__main		
			LDR		R0,=0xE000ED88
			LDR		R1,[R0]
			ORR		R1,R1,#(0xF<<20)
			
			DSB
			ISB
			
			ADR		R0,RecipSQRTTableOdd
			ADR		R1,RecipSQRTTableEven
			
			VLDR.F32	S0,InputValue
			VMOV.F		R2,S0
			
			MOV		R3,R2
			LSR		R2,#23 		; shift the exponent for substraction
			SUB		R2,#127		; subtact out the bias
			AND		R4,R2,#1
			TEQ		R4,#1
			
			ADDEQ	R2,#1
			
			LSR		R2,R2,#1
			NEG		R2,R2
			ADD		R2,#127
			LSL		R2,#23
			
			AND 	R3,#0x00780000
			LSR		R3,#18
			
			LDRHEQ	R4,[R3,R0]
			LDRHNE	R4,[R3,R1]	; index into the even table
			
			VMOV.F32		S3,R4
			VCVTB.F32.F16	S4,S3
			VMOV.F32		S5,R2
			VMUL.F32		S6,S5,S4

Stop		B		Stop

			ALIGN

InputValue			
			DCD		0x42333333


			
RecipSQRTTableEven
			DCW	0x3C00	;	1.0000	->	1.0000
			DCW	0x3BC3	;	1.0625	->	0.9701
			DCW	0x3B8B	;	1.1250	->	0.9428
			DCW	0x3A57	;	1.1875	->	0.9177
			DCW	0x3B28	;	1.2500	->	0.8944
			DCW	0x3AFC	;	1.3125	->	0.8729
			DCW	0x3AD3	;	1.3750	->	0.8528
			DCW	0x3AAC	;	1.4375	->	0.8340
			DCW	0x3A88	;	1.5000	->	0.8165
			DCW	0x3A66	;	1.5625	->	0.8000
			DCW	0x3A47	;	1.6250	->	0.7845
			DCW	0x3A29	;	1.6875	->	0.7698
			DCW	0x3A0C	;	1.7500	->	0.7559
			DCW	0x39F1	;	1.8125	->	0.7428
			DCW	0x39D8	;	1.8750	->	0.7303
			DCW	0x39BF	;	1.9375	->	0.7184
			
			ALIGN
				
RecipSQRTTableOdd
			DCW	0x3D8A	;	0.5000 -> 1.4142
			DCW	0x3D7C	;	0.5322 -> 1.3707
			DCW	0x3D55	;	0.5625 -> 1.3333
			DCW	0x3D31	;	0.5938 -> 1.2978
			DCW	0x3D0F	;	0.6250 -> 1.2649
			DCW	0x3CF0	;	0.6563 -> 1.2344
			DCW	0x3CD3	;	0.6875 -> 1.2060
			DCW	0x3CB8	;	0.7186 -> 1.1795
			DCW	0x3C9E	;	0.7500 -> 1.1547
			DCW	0x3C87	;	0.7813 -> 1.1313
			DCW	0x3C70	;	0.8125 -> 1.1094
			DCW	0x3C5B	;	0.8438 -> 1.0886
			DCW	0x3C47	;	0.8750 -> 1.0690
			DCW	0x3C34	;	0.9063 -> 1.0504
			DCW	0x3C22	;	0.9375 -> 1.0328
			DCW	0x3C10	;	0.9688 -> 1.0160
			
			ALIGN
			END
