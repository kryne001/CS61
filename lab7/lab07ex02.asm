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

LEA R0, output_message
PUTS

LD R3, input_subroutine
JSRR R3

LD R3, palindrome_subroutine
JSRR R3

ADD R4, R4, #0
BRz ISNT_PALINDROME
BRp IS_PALINDROME

IS_PALINDROME
	LEA R0, is_palindrome_message
	PUTS
	BR END_PROGRAM

ISNT_PALINDROME
	LEA R0, isnt_palindrome_message
	PUTS
	BR END_PROGRAM

END_PROGRAM

HALT
;--------------------
;data x3000
;--------------------

output_message					.STRINGZ					"Please enter a string, terminated by inputting the enter character.\n"
input_subroutine				.FILL						x3400
is_palindrome_message		.STRINGZ					"\nThe input word is a palindrome\n"
isnt_palindrome_message		.STRINGZ					"\nThe input word isn't a palindrome\n"
palindrome_subroutine		.FILL						x3700

;-----------------
;input subroutine
;-----------------
.orig x3400

ST R0, BACKUP_R0_3400
ST R3, BACKUP_R3_3400
ST R7, BACKUP_R7_3400

LD R2, memory_place
LD R5, zero
LD R4, check_enter
NOT R4, R4
ADD R4, R4, #1

LOOP
	GETC
	OUT
	
	ADD R3, R0, R4
	BRz END_LOOP
	STR R0, R2, #0
	ADD R2, R2, #1
	ADD R5, R5, #1
	BR LOOP
END_LOOP

LD R0, BACKUP_R0_3400
LD R3, BACKUP_R3_3400
LD R7, BACKUP_R7_3400

RET

;-----------------------
;data input subroutine
;-----------------------

BACKUP_R0_3400					.blkw					#1
BACKUP_R3_3400					.blkw					#1
BACKUP_R7_3400					.blkw					#1
memory_place					.FILL					x5000
zero								.FILL					#0
check_enter						.FILL					#10



;----------------------
;palindrome subroutine
;----------------------
.orig x3700

ST R0, BACKUP_R0_3700
ST R5, BACKUP_R5_3700
ST R7, BACKUP_R7_3700

LD R3, start_memory_place
LD R4, start_memory_place
ADD R4, R4, R5
ADD R4, R4, #-1

LOOP_1
	NOT R4, R4
	ADD R4, R4, #1
	ADD R4, R3, R4
	BRz PALINDROME
	LD R4, start_memory_place
	ADD R4, R4, R5
	ADD R4, R4, #-1
	NOT R4, R4
	ADD R4, R4, #1
	ADD R6, R3, R4
	LD R4, one_1
	NOT R4, R4
	ADD R4, R4, #1
	ADD R4, R6, R4
	BRz PALINDROME
	LD R4, start_memory_place
	ADD R4, R4, R5
	ADD R4, R4, #-1
	LDR R2, R3, #0
	NOT R2, R2
	ADD R2, R2, #1
	LDR R6, R4, #0
	ADD R6, R6, R2
	BRnp NOT_PALINDROME
	ADD R3, R3, #1
	ADD R5, R5, #-1
	BR LOOP_1
END_LOOP_1

NOT_PALINDROME
	LD R4, zero_1
	BR END_SUB_3700

PALINDROME
	LD R4, one_1
	BR END_SUB_3700

END_SUB_3700

LD R0, BACKUP_R0_3700
LD R5, BACKUP_R5_3700
LD R7, BACKUP_R7_3700

RET

;-------------------------
;data palindrome subroutine
;-------------------------

BACKUP_R0_3700					.blkw						#1
BACKUP_R5_3700					.blkw						#1
BACKUP_R7_3700					.blkw						#1
start_memory_place			.FILL						x5000
one_1								.FILL						#1
zero_1							.FILL						#0
