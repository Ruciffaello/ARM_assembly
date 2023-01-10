			AREA DATA	
SIZE		EQU		8
PutPt		SPACE	4
GetPt		SPACE	4
Fifo		SPACE	SIZE
			EXPORT	PutPt	[DATA, SIZE=4]
			EXPORT	GetPt	[DATA, SIZE=4]
			EXPORT	Fifo	[DATA, SIZE=8]
			EXPORT	Fifo_Init
			EXPORT	Fifo_Put
			EXPORT	Fifo_Get
			EXPORT	Fifo_Size
				
			AREA	|.text|,CODE,READONLY
				
Fifo_Init
			LDR		R0,=Fifo
			LDR		R1,=PutPt
			STR		R0,[R1]
			
			LDR		R1,=GetPt
			STR		R0,[R1]
			BX		LR

Fifo_Put
			LDR		R1,=PutPt
			LDR		R2,[R1]
			ADD		R3,R2,#1
			LDR		R12,=Fifo + SIZE
			CMP		R3,R12
			BNE		NoWrap
			LDR		R3,=Fifo
			
NoWrap		
			LDR		R12,=GetPt
			LDR		R12,[R12]
			CMP		R3,R12
			BNE		NotFull		;not full
			MOV		R0,#0		;full
			BX		LR
			
			
NotFull		
			STRB	R0,[R2]
			STR		R3,[R1]
			MOV		R0,#1
			BX		LR
			
Fifo_Get	
			PUSH	{R4,R5,LR}
			LDR		R1,=PutPt
			LDR		R1,[R1]
			LDR		R2,=GetPt
			LDR		R3,[R2]
			CMP		R1,R3
			BNE		NotEmpty
			MOV		R0,#0
			B		done

NotEmpty	
			LDRSB	R4,[R3]
			STRB	R4,[R0]
			LDR		R5,=Fifo+SIZE
			CMP		R3,R5
			BNE		NoWrap2
			LDR		R3,=Fifo
			
NoWrap2		
			STR		R3,[R2]
			
done		
			POP		{R4,R5,PC}
			
Fifo_Size	
			LDR		R1,=PutPt
			LDR		R1,[R1]
			LDR		R2,=GetPt
			LDR		R3,[R2]
			SUB		R0,R1,R3
			AND		R0,#(SIZE-1)
			
			BX		LR
			ALIGN
			END
			