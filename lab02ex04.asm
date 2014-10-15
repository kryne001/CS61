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

LD R0, DEC_1
LD R1, DEC_2

LOOP
	TRAP x21
	ADD R0, RO, #1
	ADD R1, R1, #-1
BRp LOOP

HALT

;-----------
;Data
;---------
DEC_1		.FILL		x61
DEC_2		.FILL		x1A
