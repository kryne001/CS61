;-----------------------------------
;Name: Kyler Rynear
;Login: kryne001
;Email address: kryne001@ucr.edu
;Assignment: lab 06, exercise 01
;Lab Section: <021 or 022>
;TA: Bryan Marsh
;
;I hereby certify that I have not received assistance on this assignment, or used code, from ANY outside source other than thte instruction team.
;-----------------------------------
.orig x3000
LD R3, ASSN_4_SUBROUTINE
JSRR R3

ADD R1, R1, #1

LD R3, OUTPUT_SUBROUTINE
JSRR R3

LD R0, #10
OUT
HALT
;---------------------
;Data orig 3000
;---------------------
open_message				.STRINGZ				"Input any positive decimal number less than or equal to #32766 from the keyboard"
ASSN_4_SUBROUTINE			.FILL					x3400
OUTPUT_SUBROUTINE			.FILL					x3700
mem							.FILL					x4000

.orig x3400

ST R0, BACKUP_R0_3400
ST R2, BACKUP_R2_3400
ST R3, BACKUP_R3_3400
ST R4, BACKUP_R4_3400
ST R5, BACKUP_R5_3400
ST R6, BACKUP_R6_3400
ST R7, BACKUP_R7_3400

RESTART

	LEA R0, OUTPUT												;R0 character input
	PUTS															;R1 open register for calculations 
																	;R2 converter
	LD R2, converter											;R3 mem location of array
	NOT R2, R2													;R4 counter
	ADD R2, R2, #1												;R5 value to check if input value goes over 9
																	;R6 value to check it input is the negative symbol
	LD R3, mem													;R7 value to check if input the positive symbol
	
	LD R5, above
	NOT R5, R5
	ADD R5, R5, #1

	LD R6, neg
	NOT R6, R6
	ADD R6, R6, #1

	POP_ARRAY
		GETC														;get user input
		OUT														;output the user input
		LD R7, pos												
		NOT R7, R7
		ADD R7, R7, #1
		ADD R1, R0, #-10										;check if input value is the enter character
		BRz END_POP_ARRAY										;if input char == enter, end branch
		ADD R1, R0, R5											;check if input value is above 9
		BRp ERROR												;if addition is greater than 0, go to error message
	
		BRz POSITIVE											;if zero go to positive branch
		BRnp END_POSITIVE										;if != 0 skip this branch
		POSITIVE
			ADD R4, R4, #0										;check the counter to see if it's at 0
			BRp ERROR											;if the counter is greater than 0, means we're not at the first inputted character, go to error
			STR R0, R3, #0										;store user input into current index of array
			ADD R3, R3, #1										;go to next index of array
			ADD R4, R4, #1										;add counter
			BRnzp POP_ARRAY									;loop
		END_POSITIVE
		ADD R1, R0, R6											;Check to see if user input is negative
		BRz NEGATIVE											;if zero, means user input is negative
		BRnp END_NEGATIVE										;if != zero, skip negative branch
		NEGATIVE
			ADD R4, R4, #0										;check if counter is at zero
			BRnp ERROR											;if > 0, means we're not at first input character, go to error
			STR R0, R3, #0										;store value of user input value into current index
			ADD R3, R3, #1										;go to next value of current index
			ADD R4, R4, #1										;increment counter
			BRnzp POP_ARRAY									;loop
		END_NEGATIVE
		ADD R1, R0, R2											;finally, convert number
		BRn ERROR												;if number is negative, means that it's less than 0 in the ascii table, meaning not a numberand go to error
		STR R0, R3, #0											;store value of current user input into array
		ADD R3, R3, #1											;go to next index
		ADD R4, R4, #1											;increment counter
		BRp POP_ARRAY
	END_POP_ARRAY

	LD R3, mem
	LD R5, mem
	NOT R5, R5
	ADD R5, R5, #1
	LD R1, zero
	ANSWER
		ADD R0, R3, R5											;Check if current index is start index
		BRz CHECK_SIGN											;if zero, means it's first index, go to CHECK_SIGN to check the sign
		BRnp END_CHECK_SIGN									;if != 0, skip checking the sign
		CHECK_SIGN											
			LDR R0, R3, #0										;load into R0 the data in the first index
			LD R6, neg
			NOT R6, R6
			ADD R6, R6, #1
			ADD R0, R0, R6										;check if the value is the negative symbol
			BRz NEGATIVE_2										;if the result is zero, go to negative branch
			BRnp POSITIVE_2									;if result != 0, go to positive branch
			NEGATIVE_2
				LD R7, one										;if the final number is negative, load the value 1 into R7	
				ADD R3, R3, #1									;go to next index in array
				ADD R4, R4, #-1								;decrement counter
				BRnzp ANSWER									;go back to start of loop
			END_NEGATIVE_2
			POSITIVE_2
				LD R7, zero
				LDR R0, R3, #0
				LD R6, pos
				NOT R6, R6
				ADD R6, R6, #1
				ADD R0, R0, R6
				BRnp END_CHECK_SIGN
				ADD R3, R3, #1									;go to next index in array
				ADD R4, R4, #-1								;decrement counter
				BRnzp	ANSWER									;go back to start of loop
			END_POSITIVE_2
		END_CHECK_SIGN
		ADD R1, R1, #0											;check the value of the final number
		BRz END_MULTIPLY										;if it's zero, skip multiplication
		ADD R6, R1, #0											;Load current value of final number into R6
		LD R0, counter											;Load counter (10) into R0
		MULTIPLY													;we want to multiply the current value in R1 by 10
			ADD R1, R1, R6										;add the current current value of the number by the start value, store in R1
			ADD R0, R0, #-1									;decrement counter
			BRp MULTIPLY										;if > 0 keep going
			BRz END_MULTIPLY									;if = 0 multiplication by 10 complete
		END_MULTIPLY
		LDR R0, R3, #0											;load into R0 the value in the current index of our user-input array
		ADD R0, R0, R2											;convert it from char to decimal
		ADD R1, R1, R0											;add the converted value to r1
		ADD R3, R3, #1
		ADD R4, R4, #-1										;decrement counter
		BRp ANSWER												;if counter >= 0 loop
		BRnz END_ANSWER											;if counter < 0 end loop
	END_ANSWER
	
	ADD R7, R7, #0
	BRp NEG_ANSWER
	BRnz END_RESTART
	NEG_ANSWER
		NOT R1, R1
		ADD R1, R1, #1
		BRnzp END_RESTART
		

ERROR
	LEA R0, error_message
	PUTS
	LD R0, zero
	ERASE_ARRAY
		STR R0, R3, #0
		ADD R3, R3, #-1
		ADD R4, R4, #-1
		BRp ERASE_ARRAY
		BRnz END_ERASE_ARRAY
	END_ERASE_ARRAY
	ADD R3, R3, #0
	BRnzp RESTART
END_ERROR

END_RESTART

LD R0, BACKUP_R0_3400
LD R2, BACKUP_R2_3400
LD R3, BACKUP_R3_3400
LD R4, BACKUP_R4_3400
LD R5, BACKUP_R5_3400
LD R6, BACKUP_R6_3400
LD R7, BACKUP_R7_3400

RET

;----------
;Data x3400
;----------

BACKUP_R0_3400				.BLKW						#1
BACKUP_R2_3400				.BLKW						#1
BACKUP_R3_3400				.BLKW						#1
BACKUP_R4_3400				.BLKW						#1
BACKUP_R5_3400				.BLKW						#1
BACKUP_R6_3400				.BLKW						#1
BACKUP_R7_3400				.BLKW						#1
OUTPUT						.STRINGZ					"Input a positive or negative decimal number (less than or equal to 32766) followed by ENTER\n"
converter					.FILL						#48
mem							.FILL						x4000
above							.FILL						#57
neg							.FILL						#45
pos							.FILL						#43
error_message				.STRINGZ					"\nInput an invalid character, restarting program\n"
zero							.FILL						#0
one							.FILL						#1
counter						.FILL						#9
enter							.FILL						#-10


;----------------------------
;OUTPUT_SUBROUTINE
;----------------------------
.orig x3700

LD R3, tenthous
NOT R3, R3
ADD R3, R3, #1
LD R5, zero_1
TENTHOUSAND
	ADD R4, R1, #0
	ADD R4, R1, R3
	BRn END_TENTHOUSAND
	ADD R1, R1, R3
	ADD R5, R5, #1
	BR TENTHOUSAND
END_TENTHOUSAND
ADD R0, R5, #0
LD R4, converter_1
ADD R0, R0, R4
OUT

LD R3, thous
NOT R3, R3
ADD R3, R3, #1
LD R5, zero_1
THOUSAND
	ADD R4, R1, #0
	ADD R4, R1, R3
	BRn END_THOUSAND
	ADD R1, R1, R3
	ADD R5, R5, #1
	BR THOUSAND
END_THOUSAND
ADD R0, R5, #0
LD R4, converter_1
ADD R0, R0, R4
OUT

LD R3, hunnid
NOT R3, R3
ADD R3, R3, #1
LD R5, zero_1
HUNDREDS
	ADD R4, R1, #0
	ADD R4, R1, R3
	BRn END_HUNDREDS
	ADD R1, R1, R3
	ADD R5, R5, #1
	BR HUNDREDS
END_HUNDREDS
ADD R0, R5, #0
LD R4, converter_1
ADD R0, R0, R4
OUT

LD R3, tens
NOT R3, R3
ADD R3, R3, #1
LD R5, zero_1
THE_TENS
	ADD R4, R1, #0
	ADD R4, R1, R3
	BRn END_THE_TENS
	ADD R1, R1, R3
	ADD R5, R5, #1
	BR THE_TENS
END_THE_TENS
ADD R0, R5, #0
LD R4, converter_1
ADD R0, R0, R4
OUT

LD R3, ones
NOT R3, R3
ADD R3, R3, #1
LD R5, zero_1
THE_ONES
	ADD R4, R1, #0
	ADD R4, R1, R3
	BRn END_THE_ONES
	ADD R1, R1, R3
	ADD R5, R5, #1
	BR THE_ONES
END_THE_ONES
ADD R0, R5, #0
LD R4, converter_1
ADD R0, R0, R4
OUT
;--------------
;data x3700
;--------------
tenthous					.FILL					#10000
thous						.FILL					#1000
hunnid					.FILL					#100
tens						.FILL					#10
ones						.FILL					#1
zero_1					.FILL					#0
converter_1				.FILL					#48
.orig x4000
							.BLKW						#6
