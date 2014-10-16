;-----------------------------------
;Name: Kyler Rynear
;Login: kryne001
;Email address: kryne001@ucr.edu
;Assignment: assn1
;Lab Section: <021 or 022>
;TA: Bryan Marsh
;
;I hereby certify that I have not received assistance on this assignment, or used code, from ANY outside source other than thte instruction team.
;-----------------------------------
.ORIG x3000

;-----------------
;Instructions
;-----------------

LDI R3, DEC_65					;R1 <- 65
LDI R4, HEX_41					;R2 <- x41

LD R5, DEC_65
LD R6, HEX_41

LDR R3, R5, #0
ADD R3, R3, #1
LDR R4, R6, #0
ADD R4, R4, #1

STR R3, R5, #0
STR R4, R6, #0

HALT
;-----------------
;Data
;-----------------

DEC_65		.FILL			x4000
HEX_41		.FILL			x4001

.ORIG x4000
NEW_DEC_65	.FILL			#65
NEW_HEX_41	.FILL			x41


.END
