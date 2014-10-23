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

LD R5, DATA_PTR							;Load memory location of pointer into R5

LDR R3, R5, #0								;Load data from R5 into R3
ADD R3, R3, #1								;Add data + 1
STR R3, R5, #0								;store the data value
ADD R5, R5, #1								;go to next memory location

STR R3, R5, #0								;store memory value in next location into R3

HALT
;-----------------
;Data
;-----------------

DATA_PTR		.FILL			x4000

.ORIG x4000
NEW_DEC_65	.FILL			#65
NEW_HEX_41	.FILL			x41


.END
