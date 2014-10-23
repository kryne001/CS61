;-----------------------------------
;Name: Kyler Rynear
;Login: kryne001
;Email address: kryne001@ucr.edu
;Assignment: lab 3, exercise 4
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
PUTS											;Output "Enter any number of characters"
LD R0, tab									
TRAP x21										;Newline

LD R1, counter
LD R2, mem
DO_WHILE
	LD R6, enter	
	NOT R6, R6
	ADD R6, R6, #1							;Two's complement to make ascii value of enter negative
	GETC										;get user input
	STR R0, R2, #0							;store value into array
	ADD R2, R2, #1							;move current index
	ADD R1, R1, #1							;increment counter 
	ADD R6, R6, R0							;add current user input ascii value to negative enter ascii value
	BRz END_DO_WHILE						;if zero, means they're the same, exit loop
	BRnp DO_WHILE							;if !=0, next iteration
END_DO_WHILE
		
LD R2, mem
WHILE
	LDR R0, R2, #0							;load value at current index into R0
	OUT										;print value
	ADD R2, R2, #1							;increment to next index in array

	ADD R1, R1, #-1						;decrement counter
	BRp WHILE								;loop if counter is still positive
END_WHILE
HALT
;------------
;data
;------------

first_message					.STRINGZ				"Enter any number of characters"
tab								.FILL					#10
counter							.FILL					#0
mem								.FILL					x4000
enter								.FILL					#10

.ORIG x4000
	
			 						.BLKW					#100
