;-----------------------------------
;Name: Kyler Rynear
;Login: kryne001
;Email address: kryne001@ucr.edu
;Assignment: lab 05, exercise 01
;Lab Section: <021 or 022>
;TA: Bryan Marsh
;
;I hereby certify that I have not received assistance on this assignment, or used code, from ANY outside source other than thte instruction team.
;-----------------------------------
.orig x3000

LD R3, mem
LD R4, SUB_ROUTINE
JSRR R4

PRINT_ARRAY
HALT

SUB_ROUTINE				.FILL				x3400
mem						.FILL				x4000
.orig x4000

							.BLKW 			#20
.orig x3400
	ST R3, R3_BACKUP_3400
	ST R4, R3_BACKUP_3400
	ST R7, R7_BACKUP_3400
	LD R5, counter
	WHILE
		LD R4, SPACE_1
		ADD R4, R5, R4
		BRz SPACE
		LD R4, SPACE_2
		ADD R4, R5, R4
		BRz SPACE
		LD R4, SPACE_3
		ADD R4, R5, R4
		BRz SPACE
		LEA R0, BEGIN
		PUTS
		GETC
		LD R4, #-1
		ADD R6, R5, R4
		BRz CHECK_B
		BRp END_CHECK_B
		CHECK_B
			LD R4, ASCII_B
			NOT R4, R4
			ADD R4, R4, #1
			ADD R4, R0, R4
			BRnp ERROR
			STR R3, R0, #0
			ADD R3, R3, #-1
			BRp WHILE
		END_CHECK_B
		LD R4, zero
		ADD R4, R0, R4
		BRnp ERROR
		LD R4, one
		ADD R4, R0, R4
		BRnp ERROR
		STR R0, R3, #0
		ADD R3, R3, #1
		ADD R5, R5, #-1
		BRp WHILE
	END_WHILE

	ERROR
		LEA R0, error_message
		PUTS
		LD R0, #10
		OUT
		BR WHILE
	END_ERROR

	SPACE
		LD R4, space_char
		STR R3, R4, #0
		ADD R3, R3, #1
		BRnzp WHILE
	END_SPACE

;---------
;SUB Data
;---------

R3_BACKUP_3400			.BLKW						#1
R4_BACKUP_3400			.BLKW						#1
R4_BACKUP_3400			.BLKW						#1
counter					.FILL						#20
SPACE_1					.FILL						#-15
SPACE_2					.FILL						#-10
SPACE_3					.FILL						#-5
BEGIN						.STRINGZ					"Enter a \'b\' character followed by a 16 digit binary number\n"
ASCII_B					.FILL						#98
mem						.FILL						x4000











