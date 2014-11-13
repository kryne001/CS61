;-----------------------------------
;Name: Kyler Rynear
;Login: kryne001
;Email address: kryne001@ucr.edu
;Assignment: lab 06, exercise 02
;Lab Section: <021 or 022>
;TA: Bryan Marsh
;
;I hereby certify that I have not received assistance on this assignment, or used code, from ANY outside source other than thte instruction team.
;-----------------------------------

.orig x3000
LEA R0, start_message
PUTS
GETC
OUT
ADD R2, R0, #0
LD R3, counter
LOOP
	ADD R2, R2, R2
	BRn ITS_ONE
	BRzp END_ITS_ONE
	ITS_ONE
		ADD R4, R4, #1
		ADD R3, R3, #-1
		BRp LOOP
		BRnz END_LOOP
	END_ITS_ONE
	ADD R3, R3, #-1
	BRp LOOP
	BRnz END_LOOP
END_LOOP

LEA R0, end_message
PUTS
LD R0, #0
LD R2, converter
ADD R4, R4, R2
ADD R0, R4, #0
OUT

HALT
;-----------
;data
;-----------
start_message					.STRINGZ					"Input a single character: "
counter							.FILL						#16
end_message						.STRINGZ					"\nThe number of 1s is "
converter						.FILL						#48
