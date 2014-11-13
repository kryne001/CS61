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
LEA R0, start_message
PUTS

LD R2, number
LD R3, SUB_ROUTINE
JSRR R3

LEA R0, out_message
PUTS
LD R4, converter_1
ADD R1, R1, R4
LD R0, #0
ADD R0, R1, #0
OUT

HALT
;-------------
;data x3000
;-------------
start_message				.STRINGZ					"The number to be right-shifted is 14"
number						.FILL						#14
SUB_ROUTINE					.FILL						x3400
converter_1					.FILL						#48
out_message					.STRINGZ					"\nThe number 14, after being right-shifted, is "

;----------------------
;subroutine x3400 instructions
;----------------------

.orig x3400

ST R3, BACKUP_R3_3400
ST R4, BACKUP_R4_3400
ST R5, BACKUP_R5_3400
ST R6, BACKUP_R6_3400
ST R7, BACKUP_R7_3400

LD R3, counter
LD R1, zero
LOOP
	ADD R2, R2, #0
	BRp POSITIVE
	BRn NEGATIVE
	POSITIVE
		LD R4, pos
		ADD R1, R1, R1
		ADD R1, R1, R4
		ADD R2, R2, R2
		ADD R3, R3, #-1
		BRp LOOP
		BRnz END_LOOP
	END_POSITIVE
	NEGATIVE
		LD R4, neg
		ADD R1, R1, R1
		ADD R1, R1, R4
		ADD R2, R2, R2
		ADD R3, R3, #-1
		BRp LOOP
		BRnz END_LOOP
	END_NEGATIVE
END_LOOP

LD R3, BACKUP_R3_3400
LD R4, BACKUP_R4_3400
LD R5, BACKUP_R5_3400
LD R6, BACKUP_R6_3400
LD R7, BACKUP_R7_3400

RET
;--------------
;data x3400
;--------------
BACKUP_R3_3400				.BLKW						#1
BACKUP_R4_3400				.BLKW						#1
BACKUP_R5_3400				.BLKW						#1
BACKUP_R6_3400				.BLKW						#1
BACKUP_R7_3400				.BLKW						#1
counter						.FILL						#15
pos							.FILL						#0
neg							.FILL						#1
zero							.FILL						#0
