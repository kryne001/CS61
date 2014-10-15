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

LD R3, DEC_65					;R1 <- 65
LD R4, HEX_41					;R2 <- x41

HALT
;-----------------
;Data
;-----------------

DEC_65		.FILL			#65
HEX_41		.FILL			x41

.END
