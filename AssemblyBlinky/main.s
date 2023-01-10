RCC_BASE		EQU		0x40023800
RCC_AHB1ENR		EQU		0x40023830	;RCC_BASE + 0x30
GPIOD_BASE		EQU		0x40020C00
GPIOD_MODER		EQU		GPIOD_BASE
GPIOD_ODR		EQU		0x40020C14	;GPIOD_BASE + 0x14
	
GPIODEN			EQU		1<<3
	
MODER15_OUT		EQU		1<<30
MODER14_OUT		EQU		1<<28
MODER13_OUT		EQU		1<<26
MODER12_OUT		EQU		1<<24
	
LED_BLUE		EQU		1<<15
LED_RED			EQU		1<<14
LED_ORANGE		EQU		1<<13
LED_GREEN		EQU		1<<12
	
DELAY			EQU		0x000F
	
ONESEC			EQU		53333333
HSEC			EQU		266667
FSEC			EQU		106667
	
			AREA	|.text|,CODE,READONLY,ALIGN=2
			THUMB
			EXPORT	__main
				
__main		
			BL	GPIOD_Init
			
			
GPIOD_Init	
			
			LDR	R0,=RCC_AHB1ENR ;R0 points to peripheral clock register
			LDR	R1,[R0]			;Load Peripheral clock register is into R1
			ORR	R1,GPIODEN		;RCC_AHB1ENR ORR 1<<3, store results in R1
			STR	R1,[R0]			;Store content of R1 into RCC_AHB1ENR
			
			LDR	R0,=GPIOD_MODER	;R0	points to PORTD configuration register
			LDR	R1,=(MODER15_OUT|MODER14_OUT|MODER13_OUT|MODER12_OUT)	;R1 points to Pins 15,14,13,12
			STR	R1,[R0]			;Store Pins 15,14,13,12 into MODER
			MOV	R1,#0
			LDR	R2,=GPIOD_ODR	;GPIO output data register
			
Blink		
			MOVW	R1, #LED_GREEN
			STR	R1,[R2]
			LDR	R3,=ONESEC
			BL	Delay
			
			MOVW	R1, #LED_BLUE
			STR	R1,[R2]
			LDR	R3,=HSEC
			BL	Delay
			
			MOVW	R1, #LED_RED
			STR	R1,[R2]
			LDR	R3,=ONESEC
			BL	Delay
			
			MOVW	R1, #LED_ORANGE
			STR	R1,[R2]
			LDR	R3,=FSEC
			BL	Delay
			B	Blink
Delay
			SUBS	R3,R3,#1
			BNE	Delay
			BX	LR
			ALIGN
			END
			
			
			
			