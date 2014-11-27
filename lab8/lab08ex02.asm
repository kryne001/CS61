;-----------------------------------
;Name: Kyler Rynear
;Login: kryne001
;Email address: kryne001@ucr.edu
;Assignment: lab 08, exercise 02
;Lab Section: <021 or 022>
;TA: Bryan Marsh
;
;I hereby certify that I have not received assistance on this assignment, or used code, from ANY outside source other than thte instruction team.
;-----------------------------------
.orig x3000

LD R3, sub_output
JSRR R3

HALT

;-----------------------
;data x3000
;-----------------------
sub_output					.FILL						x3400

;----------------------
;sub output routine
;----------------------
.orig x3400

ST R3, BACKUP_R3_3400
ST R7, BACKUP_R7_3400

LD R2, mem_op_name
LD R3, mem_op_num

LOOP
	LDR R0, R2, #0
	BRn END_LOOP
	NAME
		LDR R0, R2, #0
		ADD R0, R0, #0
		BRz END_NAME
		OUT
		ADD R2, R2, #1
		BR NAME
	END_NAME
	LD R4, twelve
	LDR R5, R3, #0
	LEFT
		ADD R5, R5, R5
		ADD R4, R4, #-1
		BRp LEFT
		BRnz END_LEFT
	END_LEFT
	LD R4, four
	OUTPUT_LOOP
		ADD R5, R5, #0
		BRp POSITIVE
		BRn NEGATIVE
		POSITIVE
			LD R0, pos_out
			OUT
			ADD R5, R5, R5
			ADD R4, R4, #-1
			BRp OUTPUT_LOOP
			BRnz END_OUTPUT_LOOP
		NEGATIVE
			LD R0, neg_out
			OUT
			ADD R5, R5, R5
			ADD R4, R4, #-1
			BRp OUTPUT_LOOP
	END_OUTPUT_LOOP
	LD R0, ten
	OUT
	ADD R2, R2, #1
	ADD R3, R3, #1
	BR LOOP
END_LOOP
		

LD R3, BACKUP_R3_3400
LD R7, BACKUP_R7_3400

RET
;----------------------
;data x34000
;----------------------
BACKUP_R3_3400				.blkw						#1
BACKUP_R7_3400				.blkw						#1
mem_op_name					.FILL						x4000
mem_op_num					.FILL						x4200
negative_one				.FILL						#-1
zero							.FILL						#0
pos_out						.FILL						#48
neg_out						.FILL						#49
twelve						.FILL						#12
four							.FILL						#4
ten							.FILL						#10


.orig x4000

add_op_name					.STRINGZ					"ADD = "
and_op_name					.STRINGZ					"AND = "
br_op_name					.STRINGZ					"BR = "
jmp_op_name					.STRINGZ					"JMP = "
jsr_op_name	 				.STRINGZ					"JSRR = "
jsrr_op_name				.STRINGZ					"JSRR = "
ld_op_name					.STRINGZ					"LD = "
ldi_op_name					.STRINGZ					"LDI = "
ldr_op_name					.STRINGZ					"LDR = "
lea_op_name					.STRINGZ					"LEA = "
not_op_name					.STRINGZ					"NOT = "
ret_op_name					.STRINGZ					"RET = "
rti_op_name					.STRINGZ					"RTI = "
st_op_name					.STRINGZ					"ST = "
sti_op_name					.STRINGZ					"STI = "
str_op_name					.STRINGZ					"STR = "
trap_op_name				.STRINGZ					"TRAP = "
end_op_name					.FILL						#-1

.orig x4200

add_op_num					.FILL						#1
and_op_num					.FILL						#5
br_op_num					.FILL						#0
jmp_op_num					.FILL						#12
jsr_op_num					.FILL						#4
jsrr_op_num					.FILL						#4
ld_op_num					.FILL						#2
ldi_op_num					.FILL						#10
ldr_op_num					.FILL						#6
lea_op_num					.FILL						#14
not_op_num					.FILL						#9
ret_op_num					.FILL						#12
rti_op_num					.FILL						#8
st_op_num					.FILL						#3
sti_op_num					.FILL						#11
str_op_num					.FILL						#7
trap_op_num					.FILL						#15
end_op_num					.FILL						#-1
