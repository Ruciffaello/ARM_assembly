
		IMPORT	Fifo_Init
		IMPORT	Fifo_Put
		IMPORT	Fifo_Get
		IMPORT	Fifo_Size
			
			
		AREA	DATA
			
			
		AREA	myFifo,CODE,READONLY
		ENTRY
		EXPORT	__main

__main	

		BL		Fifo_Init
		
		MOV		R0,#10
		BL		Fifo_Put
		MOV		R0,#20
		BL		Fifo_Put
		MOV		R0,#30
		BL		Fifo_Put
		MOV		R0,#40
		BL		Fifo_Put
		MOV		R0,#50
		BL		Fifo_Put
		MOV		R0,#60
		BL		Fifo_Put
		MOV		R0,#70
		BL		Fifo_Put
		MOV		R0,#80
		BL		Fifo_Put

Stop	B		Stop
		END
