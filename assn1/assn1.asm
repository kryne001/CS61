;-----------------------------------
;Name: Kyler Rynear
;Login: kryne001
;Email address: kryne001@ucr.edu
;Assignment: assn1
;Lab Section: <021 or 022>
;TA: Bryan Marsh
;
;I hereby certify that I have not received assistance on this assignment, or used code, from ANY outside source other than thte instruction team.
;
;----------------------------------
; For the numbers, I used 3 and 4 
;----------------------------------
;REG VALUES			R0		R1		R2		R3		R4		R5		R6		R7
;----------------------------------
;Pre-loop			0		32767	0		0		0		0		0		1168
;Iteration 01		0		3		4		0		0		0		0		1168
;Iteration 02		0		2		4		4		0		0		0		1168
;Iteration 03 		0		1		4		8		0		0		0		1168
;Iteration 04		0		0		4		12		0		0		0		DEC_0
;End of program	0		0		4		12		0		0		0		DEC_0
;----------------------------------

.ORIG x3000							;Program begins here
;-------------
;Instructions
;-------------
LD	R1, DEC_3						;R1 <-- 3
LD R2, DEC_4						;R2 <-- 4
LD	R3, DEC_0						;R3 <-- 0

DO_WHILE		ADD R3, R3, R2		;R3 <-- R3 + R2
				ADD R1, R1, #-1	;R1 <-- R1 - 1
				BRp DO_WHILE		;if (LMR > 0) goto DO_WHILE

HALT									;Terminate the program
;------------
;Data
;------------
DEC_0		.FILL		#0				;Put the value 0 into memory here
DEC_3		.FILL		#3				;Put the value 3 into memory here
DEC_4		.FILL		#4			;Put the value 4 into memory here

.END
