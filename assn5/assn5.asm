;-----------------------------------
;Name: Kyler Rynear
;Login: kryne001
;Email address: kryne001@ucr.edu
;Assignment: lab 06, exercise 03
;Lab Section: <021 or 022>
;TA: Bryan Marsh
;
;I hereby certify that I have not received assistance on this assignment, or used code, from ANY outside source other than thte instruction team.
;-----------------------------------
.orig x3000

LD R2, mem_twonumber_array

LEA R0, first_message
PUTS

LD R3, SR_INPUT_1
JSRR R3

STR R1, R2, #0
ADD R2, R2, #1

LEA R0, second_message
PUTS

LD R3, SR_INPUT_2
JSRR R3

STR R1, R2, #0

LD R3, SR_MULTIPLICATION
JSRR R3

LD R4, five
NOT R6, R6
ADD R6, R6, #1

ADD R4, R4, R6
BRz SKIP_OUTPUT

;LD R3, SR_OUTPUT
;JSRR R3

SKIP_OUTPUT

HALT

;------------------
;data x3000
;------------------


first_message					.STRINGZ						"Input the first decimal number (between #-32767 and +32767) to be multiplied"
SR_INPUT_1						.FILL							x3200
SR_INPUT_2						.FILL							x3700
second_message					.STRINGZ						"Input the second decimal number"
SR_MULTIPLICATION				.FILL							x4200
SR_OUTPUT						.FILL							x4700
mem_twonumber_array			.FILL							x5016
five								.FILL							#5
;------------------
;subroutine input 1
;------------------
.orig x3200

ST R0, BACKUP_R0_3200
ST R2, BACKUP_R2_3200
ST R3, BACKUP_R3_3200
ST R4, BACKUP_R4_3200
ST R5, BACKUP_R5_3200
ST R6, BACKUP_R6_3200
ST R7, BACKUP_R7_3200


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
		ADD R1, R0, R7											;check if the input value is the '+' character
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

LD R0, BACKUP_R0_3200
LD R2, BACKUP_R2_3200
LD R3, BACKUP_R3_3200
LD R4, BACKUP_R4_3200
LD R5, BACKUP_R5_3200
LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200

RET

;--------------------
;data x3200
;--------------------
BACKUP_R0_3200					.BLKW					#1
BACKUP_R2_3200					.BLKW					#1
BACKUP_R3_3200					.BLKW					#1
BACKUP_R4_3200					.BLKW					#1
BACKUP_R5_3200					.BLKW					#1
BACKUP_R6_3200					.BLKW					#1
BACKUP_R7_3200					.BLKW					#1
OUTPUT						.STRINGZ					"Input a positive or negative decimal number (max 5 digits) followed by ENTER\n"
converter					.FILL						#48
mem							.FILL						x5000
above							.FILL						#57
neg							.FILL						#45
pos							.FILL						#43
error_message				.STRINGZ					"\nInput an invalid character, restarting program\n"
zero							.FILL						#0
one							.FILL						#1
counter						.FILL						#9
enter							.FILL						#-10

;------------------
;subroutine input 2
;------------------
.orig x3700

ST R0, BACKUP_R0_3700
ST R2, BACKUP_R2_3700
ST R3, BACKUP_R3_3700
ST R4, BACKUP_R4_3700
ST R5, BACKUP_R5_3700
ST R6, BACKUP_R6_3700
ST R7, BACKUP_R7_3700


RESTART_1

	LEA R0, OUTPUT_1											;R0 character input
	PUTS															;R1 open register for calculations 
																	;R2 converter
	LD R2, converter_1										;R3 mem location of array
	NOT R2, R2													;R4 counter
	ADD R2, R2, #1												;R5 value to check if input value goes over 9
																	;R6 value to check it input is the negative symbol
	LD R3, mem_1												;R7 value to check if input the positive symbol
	
	LD R5, above_1
	NOT R5, R5
	ADD R5, R5, #1

	LD R6, neg_1
	NOT R6, R6
	ADD R6, R6, #1

	POP_ARRAY_1
		GETC														;get user input
		OUT														;output the user input
		LD R7, pos_1											
		NOT R7, R7
		ADD R7, R7, #1
		ADD R1, R0, #-10										;check if input value is the enter character
		BRz END_POP_ARRAY_1									;if input char == enter, end branch
		ADD R1, R0, R5											;check if input value is above 9
		BRp ERROR_1												;if addition is greater than 0, go to error message
		ADD R1, R0, R7											;check if the input value is the '+' character
		BRz POSITIVE_1											;if zero go to positive branch
		BRnp END_POSITIVE_1									;if != 0 skip this branch
		POSITIVE_1
			ADD R4, R4, #0										;check the counter to see if it's at 0
			BRp ERROR_1											;if the counter is greater than 0, means we're not at the first inputted character, go to error
			STR R0, R3, #0										;store user input into current index of array
			ADD R3, R3, #1										;go to next index of array
			ADD R4, R4, #1										;add counter
			BRnzp POP_ARRAY_1									;loop
		END_POSITIVE_1
		ADD R1, R0, R6											;Check to see if user input is negative
		BRz NEGATIVE_1											;if zero, means user input is negative
		BRnp END_NEGATIVE_1										;if != zero, skip negative branch
		NEGATIVE_1
			ADD R4, R4, #0										;check if counter is at zero
			BRnp ERROR_1										;if > 0, means we're not at first input character, go to error
			STR R0, R3, #0										;store value of user input value into current index
			ADD R3, R3, #1										;go to next value of current index
			ADD R4, R4, #1										;increment counter
			BRnzp POP_ARRAY_1									;loop
		END_NEGATIVE_1
		ADD R1, R0, R2											;finally, convert number
		BRn ERROR_1												;if number is negative, means that it's less than 0 in the ascii table, meaning not a numberand go to error
		STR R0, R3, #0											;store value of current user input into array
		ADD R3, R3, #1											;go to next index
		ADD R4, R4, #1											;increment counter
		BRp POP_ARRAY_1
	END_POP_ARRAY_1

	LD R3, mem_1
	LD R5, mem_1
	NOT R5, R5
	ADD R5, R5, #1
	LD R1, zero_1
	ANSWER_1
		ADD R0, R3, R5											;Check if current index is start index
		BRz CHECK_SIGN_1										;if zero, means it's first index, go to CHECK_SIGN to check the sign
		BRnp END_CHECK_SIGN_1									;if != 0, skip checking the sign
		CHECK_SIGN_1											
			LDR R0, R3, #0										;load into R0 the data in the first index
			LD R6, neg_1
			NOT R6, R6
			ADD R6, R6, #1
			ADD R0, R0, R6										;check if the value is the negative symbol
			BRz NEGATIVE_3										;if the result is zero, go to negative branch
			BRnp POSITIVE_3									;if result != 0, go to positive branch
			NEGATIVE_3
				LD R7, one_1									;if the final number is negative, load the value 1 into R7	
				ADD R3, R3, #1									;go to next index in array
				ADD R4, R4, #-1								;decrement counter
				BRnzp ANSWER_1									;go back to start of loop
			END_NEGATIVE_3
			POSITIVE_3
				LD R7, zero_1
				LDR R0, R3, #0
				LD R6, pos_1
				NOT R6, R6
				ADD R6, R6, #1
				ADD R0, R0, R6
				BRnp END_CHECK_SIGN_1
				ADD R3, R3, #1									;go to next index in array
				ADD R4, R4, #-1								;decrement counter
				BRnzp	ANSWER_1									;go back to start of loop
			END_POSITIVE_3
		END_CHECK_SIGN_1
		ADD R1, R1, #0											;check the value of the final number
		BRz END_MULTIPLY_1									;if it's zero, skip multiplication
		ADD R6, R1, #0											;Load current value of final number into R6
		LD R0, counter_1										;Load counter (10) into R0
		MULTIPLY_1												;we want to multiply the current value in R1 by 10
			ADD R1, R1, R6										;add the current current value of the number by the start value, store in R1
			ADD R0, R0, #-1									;decrement counter
			BRp MULTIPLY_1										;if > 0 keep going
			BRz END_MULTIPLY_1								;if = 0 multiplication by 10 complete
		END_MULTIPLY_1
		LDR R0, R3, #0											;load into R0 the value in the current index of our user-input array
		ADD R0, R0, R2											;convert it from char to decimal
		ADD R1, R1, R0											;add the converted value to r1
		ADD R3, R3, #1
		ADD R4, R4, #-1										;decrement counter
		BRp ANSWER_1											;if counter >= 0 loop
		BRnz END_ANSWER_1										;if counter < 0 end loop
	END_ANSWER_1
	
	ADD R7, R7, #0
	BRp NEG_ANSWER_1
	BRnz END_RESTART_1
	NEG_ANSWER_1
		NOT R1, R1
		ADD R1, R1, #1
		BRnzp END_RESTART_1
		

ERROR_1
	LEA R0, error_message_1
	PUTS
	LD R0, zero_1
	ERASE_ARRAY_1
		STR R0, R3, #0
		ADD R3, R3, #-1
		ADD R4, R4, #-1
		BRp ERASE_ARRAY_1
		BRnz END_ERASE_ARRAY_1
	END_ERASE_ARRAY_1
	ADD R3, R3, #0
	BRnzp RESTART_1
END_ERROR_1

END_RESTART_1

LD R0, BACKUP_R0_3700
LD R2, BACKUP_R2_3700
LD R3, BACKUP_R3_3700
LD R4, BACKUP_R4_3700
LD R5, BACKUP_R5_3700
LD R6, BACKUP_R6_3700
LD R7, BACKUP_R7_3700

RET
;--------------------
;data x3700
;--------------------
BACKUP_R0_3700					.BLKW					#1
BACKUP_R2_3700					.BLKW					#1
BACKUP_R3_3700					.BLKW					#1
BACKUP_R4_3700					.BLKW					#1
BACKUP_R5_3700					.BLKW					#1
BACKUP_R6_3700					.BLKW					#1
BACKUP_R7_3700					.BLKW					#1
OUTPUT_1							.STRINGZ					"Input a positive or negative decimal number (max 5 digits) followed by ENTER\n"
converter_1					.FILL						#48
mem_1							.FILL						x500A
above_1						.FILL						#57
neg_1							.FILL						#45
pos_1							.FILL						#43
error_message_1			.STRINGZ					"\nInput an invalid character, restarting program\n"
zero_1						.FILL						#0
one_1							.FILL						#1
counter_1					.FILL						#9
enter_1						.FILL						#-10


;--------------------------
;multiplication subroutine
;--------------------------
.orig x4200

ST R0, BACKUP_R0_4200
ST R2, BACKUP_R2_4200
ST R3, BACKUP_R3_4200
ST R4, BACKUP_R4_4200
ST R5, BACKUP_R4_4200
ST R7, BACKUP_R7_4200


LD R3, zeero
LD R4, zeero
LD R6, zeero
LD R2, mem_final_array
LDR R3, R2, #0
ADD R2, R2, #1
LDR R4, R2, #0

ADD R3, R3, #0
BRn TURN_POSITIVE_1
BRzp END_TURN_POSITIVE_1
TURN_POSITIVE_1
	NOT R3, R3
	ADD R3, R3, #1
	LD R6, negative_one
	BR END_TURN_POSITIVE_1
END_TURN_POSITIVE_1
ADD R4, R4, #0
BRn TURN_POSITIVE_2
BRzp END_TURN_POSITIVE_2
TURN_POSITIVE_2
	NOT R4, R4
	ADD R4, R4, #1
	ADD R6, R6, #0
	BRn MAKE_ANSWER_POSITIVE
	BRzp END_MAKE_ANSWER_POSITIVE
	MAKE_ANSWER_POSITIVE
		LD R6, oneee
		BR END_TURN_POSITIVE_2
	END_MAKE_ANSWER_POSITIVE
	LD R6, negative_one
END_TURN_POSITIVE_2




ADD R3, R3, #0
BRz ANSWER_IS_ZERO
ADD R4, R4, #0
BRz ANSWER_IS_ZERO

NOT R4, R4
ADD R4, R4, #1
ADD R3, R3, R4
BRzp FIRST_IS_BIGGER
BRn SECOND_IS_BIGGER
FIRST_IS_BIGGER
	LD R2, mem_final_array
	LD R3, zeero
	LD R4, zeero
	LDR R3, R2, #0
	ADD R3, R3, #0
	BRn MAKE_POSITIVE_1
	BRzp END_MAKE_POSITIVE_1
	MAKE_POSITIVE_1
		NOT R3, R3
		ADD R3, R3, #1
	END_MAKE_POSITIVE_1
	ADD R2, R2, #1
	LDR R4, R2, #0
	ADD R4, R4, #0
	BRn MAKE_POSITIVE_2
	BRzp END_MAKE_POSITIVE_2
	MAKE_POSITIVE_2
		NOT R4, R4
		ADD R4, R4, #1
	END_MAKE_POSITIVE_2
	ST R4, multiplier
	LD R1, zeero
	LD R5, multiplier
	MULTIPLICATION
		ADD R1, R1, R3
		ADD R5, R5, #-1
		BRp MULTIPLICATION
		BRnz END_MULTIPLICATION
	END_MULTIPLICATION
	ADD R1, R1, #0
	BRn OVERFLOW
	ADD R6, R6, #0
	BRn NEGATIVE_ANSWER
	BR END_SUBROUTINE_4200
END_FIRST_IS_BIGGER

SECOND_IS_BIGGER
	LD R2, mem_final_array
	LD R3, zeero
	LD R4, zeero
	LDR R3, R2, #0
	ADD R3, R3, #0
	BRn MAKE_POSITIVE_1_2
	BRzp END_MAKE_POSITIVE_1_2
	MAKE_POSITIVE_1_2
		NOT R3, R3
		ADD R3, R3, #1
	END_MAKE_POSITIVE_1_2
	ADD R2, R2, #1
	LDR R4, R2, #0
	ADD R4, R4, #0
	BRn MAKE_POSITIVE_2_2
	BRzp END_MAKE_POSITIVE_2_2
	MAKE_POSITIVE_2_2
		NOT R4, R4
		ADD R4, R4, #1
	END_MAKE_POSITIVE_2_2
	ST R3, multiplier
	LD R1, zeero
	ADD R1, R4, #0
	LD R5, multiplier
	MULTIPLICATION_1
		ADD R1, R1, R4
		ADD R5, R5, #-1
		BRp MULTIPLICATION_1
		BRnz END_MULTIPLICATION_1
	END_MULTIPLICATION_1
	ADD R1, R1, #0
	BRn OVERFLOW
	ADD R6, R6, #0
	BRn NEGATIVE_ANSWER
	BR END_SUBROUTINE_4200
END_SECOND_IS_BIGGER

ANSWER_IS_ZERO
	LD R1, zeero
	BR END_SUBROUTINE_4200
END_ANSWER_IS_ZERO

OVERFLOW
	LEA R0, overflow_message
	PUTS
	LD R6, fivee
	BR END_SUBROUTINE_4200
END_OVERFLOW


NEGATIVE_ANSWER
	NOT R1, R1
	ADD R1, R1, #1
	BR END_SUBROUTINE_4200
END_NEGATIVE_ANSWER

END_SUBROUTINE_4200

LD R0, BACKUP_R0_4200
LD R2, BACKUP_R2_4200
LD R3, BACKUP_R3_4200
LD R4, BACKUP_R4_4200
LD R5, BACKUP_R5_4200
LD R7, BACKUP_R7_4200

RET
;---------------------
;data x4200
;---------------------
BACKUP_R0_4200						.blkw						#1
BACKUP_R2_4200						.blkw						#1
BACKUP_R3_4200						.blkw						#1
BACKUP_R4_4200						.blkw						#1
BACKUP_R5_4200						.blkw						#1
BACKUP_R7_4200						.blkw						#1
zeero									.FILL						#0
negative_one						.FILL						#-1
mem_final_array					.FILL						x5016
multiplier							.blkw						#1
oneee									.FILL						#1
fivee									.FILL						#5
overflow_message					.STRINGZ					"The two numbers input, when multiplied, exceed the limit of + or - 32767"
;-------------------
;first number array
;-------------------
.orig x5000

								.blkw						#6

;--------------------
;second number array
;--------------------
.orig x500A

								.blkw						#6

;--------------------
;two number array
;--------------------
.orig x5016
	
								.blkw						#2
