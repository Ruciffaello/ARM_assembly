



		AREA SimplrAdd, DATA, READONLY

P	SPACE 4	;Reserve 4 bytes of memory
Q	DCD	2	;Create variable Q With inirtial value 2, Q =0x00000002
R	DCD	4	;Create variable Q With inirtial value 4
S	DCD	5	;Create variable Q With inirtial value 5
	
		AREA SimpleAddCode, CODE, READONLY
		ENTRY
		EXPORT __main

__main
		LDR R1,Q
		LDR R2,R
		LDR R3,S
		
		ADD R0,R1,R2
		ADD R0,R0,R3
		
Stop	B	Stop
		END