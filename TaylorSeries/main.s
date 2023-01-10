; The algorithm is a Taylor seies with
; 4 terns (x = x-x^3/3! + x^5/5! =x^7/7!)
; This formula works for all x in the range [0, pi/2]
; Register usage:
; s0 - input operand and return result
; s1 - 1/3! (invfact3)
; s2 - 1/5! (invfact3)
; s3 - 1/7! (invfact3)
; s4 - x * s1 (xdiv3), then s4 * s7 (x^2 * xdiv3) (x3div3)
; s5 - x * s2 (xdiv5), then s5 * s8 (x^4 * xdiv5) (x5div5)
; s6 - x * s3 (xdiv7), then s6 * s9 (x^6 * xdiv7) (x7div7)
; s7 - x^2
; s8 - x^4
; s9 - x^6
; s10 - scratch
; we can avoid the divisions by computing 1/3!, 1/5!, etc. and 
; using the constant in a multiplication.


			AREA Tylr_Se, CODE, READONLY
			ENTRY
			EXPORT	__main

__main
			LDR	R0, =0xE000ED88
			LDR	R1,[R0]
			
			ORR	R1,R1,#(0xF<<20)
			STR	R1,[R0]
			DSB
			ISB
			
			VLDR.F32		S0,=1.04719
			BL				SinCalculator
			
			
Stop		B		Stop



SinCalculator

			VLDR.F32	S1,invfact3
			VLDR.F32	S2,invfact5
			VLDR.F32	S3,invfact7
			
			VMUL.F32	S4,S0,S1	;compute	xdiv3
			VMUL.F32	S7,S0,S0	;compute	X^2
			VMUL.F32	S5,S0,S2	;compute	xdiv5
			VMUL.F32	S4,S4,S7	;compute	x3div3
			VMUL.F32	S8,S7,S7	;compute	x^4
			
			VMUL.F32	S6,S0,S3	;compute	xdiv7
			VSUB.F32	S10,S0,S4	;compute	term12,x-x^3/3!
			VMUL.F32	S9,S7,S8	;compute	x^6
			VMUL.F32	S5,S5,S8	;compute	x5div5
			VMUL.F32	S6,S6,S9	;compute	x7div7
			VADD.F32	S10,S10,S5	;compute	term123, x-x^3/3! + x^5/5!
			VSUB.F32	S0,S10,S6	;compute	result
			
			BX	LR




invfact3		DCD		0x3E2AAAAA	;1/3!
invfact5		DCD		0x3C088888	;1/5!
invfact7		DCD		0x39500D00	;1/7!

			END

