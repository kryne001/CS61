;-----------------------------------
;Name: Kyler Rynear
;Login: kryne001
;Email address: kryne001@ucr.edu
;Assignment: assn 4
;Lab Section: <021 or 022>
;TA: Bryan Marsh
;
;I hereby certify that I have not received assistance on this assignment, or used code, from ANY outside source other than thte instruction team.
;-----------------------------------
.orig x3000

RESTART

	LEA R0, OUTPUT
	PUTS
	
	LD R1, x0
	
	LD R1, converter
	NOT R1, R1
	ADD R1, R1, #1

	LD R3, mem
	
	LD R5, above
	NOT R5, R5
	ADD R5, R5, #1

	LD R6, neg
	NOT R6, R6
	ADD R6, R6, #1

	POP_ARRAY
		GETC
		OUT
		LD R7, pos
		NOT R7, R7
		ADD R7, R7, #1
		ADD R2, R0, #-10
		BRz END_POP_ARRAY										;if input char == enter, end branch
		ADD R2, R0, R5
		BRp ERROR												;if input char > 9, go to error message
		ADD R2, R0, R7
		BRz POSITIVE
		BRnp END_POSITIVE
		POSITIVE
			ADD R4, R4, #0
			BRp ERROR
			STR R0, R3, #0
			ADD R3, R3, #1
			ADD R4, R4, #1
			BRp POP_ARRAY
		END_POSITIVE
		ADD R2, R0, R6
		BRz NEGATIVE
		BRnp END_NEGATIVE
		NEGATIVE
			ADD R4, R4, #0
			BRp ERROR
			STR R0, R3, #0
			ADD R3, R3, #1
			ADD R4, R4, #1
			BRp POP_ARRAY
		END_NEGATIVE
		ADD R2, R0, R1
		BRn ERROR
		STR R0, R3, #0
		ADD R3, R3, #1
		ADD R4, R4, #1
		BRp POP_ARRAY
	END_POP_ARRAY

	LD R3, mem
	LD R5, mem
	NOT R5, R5
	ADD R5, R5, #1
	ANSWER
		ADD R2, R3, R5
		BRz CHECK_SIGN
		BRnp END_CHECK_SIGN
		CHECK_SIGN
			LDR R2, R3, #0
			ADD R2, R2, R6
			BRz NEGATIVE_2
			BRnp POSITIVE_2
			NEGATIVE_2
				LD R7, #1
				ADD R4, R4, #1
				BRnzp ANSWER
			END_NEGATIVE_2
			POSITIVE_2
				LD R7, #0
				ADD R4, R4, #1
				BRnzp	ANSWER
			END_POSITIVE_2
		END_CHECK_SIGN

		

ERROR
	LEA R0, error_message
	PUTS
	LD R3, #1
	ADD R3, R3, #0
	BRp RESTART
END_ERROR

END_RESTART


HALT


;----------
;Data
;----------

OUTPUT						.STRINGZ					"Input a positive or negative decimal number (max 5 digits) followed by ENTER\n"
converter					.FILL						#48
mem							.FILL						x4000
above							.FILL						#57
neg							.FILL						#45
pos							.FILL						#43
error_message				.STRINGZ					"\nInput an invalid character, restarting program\n"


.orig x4000
								.BLKW						#6
