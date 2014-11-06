;-----------------------------------
;Name: Kyler Rynear
;Login: kryne001
;Email address: kryne001@ucr.edu
;Assignment: lab 05, exercise 03
;Lab Section: <021 or 022>
;TA: Bryan Marsh
;
;I hereby certify that I have not received assistance on this assignment, or used code, from ANY outside source other than thte instruction team.
;-----------------------------------
.orig x3000

LD R4, SUB_ROUTINE
JSRR R4


HALT

SUB_ROUTINE				.FILL				x3400
.orig x3400
	ST R3, R3_BACKUP_3400
	ST R4, R3_BACKUP_3400
	ST R7, R7_BACKUP_3400
	LD R5, counter2
	LD R3, mem2
	LEA R0, BEGIN
	PUTS
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
		GETC
		OUT
		LD R4, counter2
		NOT R4, R4
		ADD R4, R4, #1
		ADD R6, R5, R4
		BRz CHECK_B
		BRn END_CHECK_B
		CHECK_B
			LD R4, ASCII_B
			NOT R4, R4
			ADD R4, R4, #1
			ADD R4, R0, R4
			BRnp ERROR
			STR R0, R3, #0
			ADD R3, R3, #1
			ADD R5, R5, #-1
			BRp WHILE
		END_CHECK_B
		LD R4, zero
		NOT R4, R4
		ADD R4, R4, #1
		ADD R4, R0, R4
		BRz GO_ZERO
		BRnp END_GO_ZERO
		GO_ZERO
			STR R0, R3, #0
			ADD R3, R3, #1
			ADD R5, R5, #-1
			BRp WHILE
			BRnz END_WHILE
		END_GO_ZERO
		LD R4, one
		NOT R4, R4
		ADD R4, R4, #1
		ADD R4, R0, R4
		BRz GO_ONE
		BRnp END_GO_ONE
		GO_ONE
			STR R0, R3, #0
			ADD R3, R3, #1
			ADD R5, R5, #-1
			BRp WHILE
			BRnz END_WHILE
		END_GO_ONE
		BR ERROR

	ERROR
		LD R3, #0
		LEA R0, error_message
		PUTS
		LD R0, #10
		OUT
		BR WHILE
	END_ERROR

	SPACE
		LD R4, space_char
		STR R4, R3, #0
		ADD R3, R3, #1
		ADD R5, R5, #-1
		BRnzp WHILE
	END_SPACE
	
	END_WHILE

	LD R0, #10
	OUT
	LD R5, counter2
	LD R3, mem2
	PRINT_ARRAY
		LDR R0, R3, #0
		OUT
		ADD R3, R3, #1
		ADD R5, R5, #-1
		BRp PRINT_ARRAY
		BRnz END_PRINT_ARRAY
	END_PRINT_ARRAY

	LD R7, R7_BACKUP_3400

	RET
;---------
;SUB Data
;---------

R3_BACKUP_3400			.BLKW						#1
R4_BACKUP_3400			.BLKW						#1
R7_BACKUP_3400			.BLKW						#1
counter2					.FILL						#20
SPACE_1					.FILL						#-15
SPACE_2					.FILL						#-10
SPACE_3					.FILL						#-5
BEGIN						.STRINGZ					"Enter a \'b\' character followed by a 16 digit binary number\n"
ASCII_B					.FILL						#98
zero						.FILL						#48
one						.FILL						#49
error_message			.STRINGZ					"\nInput value is not a zero or one or b, please re-enter a correct value\n"
mem2						.FILL						x4000
space_char				.FILL						#32
.orig x4000

							.BLKW 			#20
