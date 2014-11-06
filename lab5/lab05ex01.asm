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
LD R2, number
LD R3, SUB_ROUTINE
JSRR R3

HALT

SUB_ROUTINE .FILL x3400
number		.FILL	#-32000
.orig x3400
ST R2, BACKUP_R2_3400
ST R7, BACKUP_R7_3400

LEA R0, opener
PUTS
LD R0, new_line
OUT

LD R3, first_space
NOT R3, R3
ADD R3, R3, #1
LD R4, second_space
NOT R4, R4
ADD R4, R4, #1
LD R5, third_space
NOT R5, R5
ADD R5, R5, #1
LD R6, counter
WHILE
	ADD R0, R6, R3
	BRz SPACE
	ADD R0, R6, R4
	BRz SPACE
	ADD R0, R6, R5
	BRz SPACE
	ADD R1, R2, #0
	BRp POSITIVE
	BRn NEGATIVE
	POSITIVE 
		LD R0, pos_out
		OUT
		ADD R2, R2, R2
		ADD R6, R6, #-1
		BRzp WHILE
		BRn END_DO_WHILE
	NEGATIVE
		LD R0, neg_out
		OUT
		ADD R2, R2, R2
		ADD R6, R6, #-1
		BRzp WHILE
		BRn END_DO_WHILE

	SPACE
		LEA R0, space_out
		PUTS
		ADD R6, R6, #-1
		BRzp WHILE
		BRnz END_DO_WHILE

END_DO_WHILE

LD R7, BACKUP_R7_3400
LD R2, BACKUP_R2_3400

RET

;---------
;data
;---------
opener 			.STRINGZ			"The number is the value -32000"
new_line			.FILL				#10
pos_out			.FILL				#48
neg_out			.FILL				#49
counter			.FILL				#18
first_space		.FILL				#14
second_space	.FILL				#9
third_space		.FILL				#4
space_out		.STRINGZ			" "
BACKUP_R7_3400	.BLKW				#1
BACKUP_R2_3400	.BLKW				#1
.END
