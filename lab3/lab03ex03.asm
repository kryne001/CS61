;-----------------------------------
;Name: Kyler Rynear
;Login: kryne001
;Email address: kryne001@ucr.edu
;Assignment: lab 3, exercise 3
;Lab Section: <021 or 022>
;TA: Bryan Marsh
;
;I hereby certify that I have not received assistance on this assignment, or used code, from ANY outside source other than thte instruction team.
;-----------------------------------
.ORIG x3000
;---------------
;instructions
;---------------

LEA R0, first_message
PUTS												;output "enter 10 characters"
LD R0, tab
TRAP x21											;output new line

LD R1, counter
LD R2, mem										;load into R2 the memory location of the start of array

DO_WHILE
	GETC											;get user input
	STR R0, R2, #0								;store input value into current array index
	ADD R2, R2, #1								;move current array index by 1

	ADD R1, R1, #-1							;decrement counter
	BRp DO_WHILE								;if counter > 0 loop
END_DO_WHILE
		
LD R2, mem
LD R1, counter
WHILE
	LDR R0, R2, #0								;Load value at current array index into R0
	OUT											;output value
	ADD R2, R2, #1								;move to next index

	ADD R1, R1, #-1							;decrement counter
	BRp WHILE									;if counter > 0 loop
END_WHILE
HALT
;------------
;data
;------------

first_message					.STRINGZ				"Enter 10 characters"
tab								.FILL					#10
counter							.FILL					#10
index								.FILL					#0
mem								.FILL					x4000

.ORIG x4000
	
			 						.BLKW					#10
