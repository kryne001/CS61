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

LD R3, sub_uppercase
JSRR R3

HALT

;-----------------
;data x3000
;-----------------
start_message					.STRINGZ						"Enter a string of lower-case letters, terminated by ENTER\n"
sub_uppercase					.FILL							x3400


;-----------------------
;sub lower to upper
;-----------------------
.orig x3400

ST R3, BACKUP_R3_3400
ST R7, BACKUP_R7_3400

LD R3, mem
LD R5, enter
NOT R5, R5
ADD R5, R5, #1
LD R6, zero
LOOP
	GETC
	OUT
	ADD R4, R0, R5
	BRz END_LOOP
	STR R0, R3, #0
	ADD R3, R3, #1
	ADD R6, R6, #1
	BR LOOP
END_LOOP

LD R3, mem
LD R2, and_char
LOOP_2
	LDR R4, R3, #0
	AND R4, R4, R2
	STR R4, R3, #0
	ADD R3, R3, #1
	ADD R6, R6, #-1
	BRp LOOP_2
END_LOOP_2

LDR R0, R3, #0

LD R3, BACKUP_R3_3400
LD R7, BACKUP_R7_3400

RET

;-----------------------
;data x3400
;-----------------------
BACKUP_R3_3400					.blkw							#1
BACKUP_R7_3400					.blkw							#1
mem								.FILL							x4000
enter								.FILL							#10
zero								.FILL							#0
and_char							.FILL							x5F
