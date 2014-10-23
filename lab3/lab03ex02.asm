;-----------------------------------
;Name: Kyler Rynear
;Login: kryne001
;Email address: kryne001@ucr.edu
;Assignment: lab 3, exercise 2
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
PUTS										;output "Enter 10 Characters"
LD R0, tab 								
TRAP x21									;output new line

LD R1, counter
LD R2, mem

DO_WHILE
	GETC									;get user input
	STR R0, R2, #0						;store value into current array index
	ADD R2, R2, #1						;move current array index to next index

	ADD R1, R1, #-1					;decrement counter
	BRp DO_WHILE						;if counter > 0 loop
END_DO_WHILE
		
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
