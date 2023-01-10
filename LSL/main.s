

			AREA	SimpleShift,CODE,READONLY
			ENTRY
			EXPORT __main
		
__main	
			MOV R0,#0x11	;move 17
			LSL	R1,R0,#1	;Shift 1 bit left =34 = 17 x 2^1=34
			LSL	R2,R1,#1	;Shift 1 bit left =68 = 17 x 2^2=68
			
Stop		B	Stop
			END