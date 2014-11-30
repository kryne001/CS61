;-----------------------------------
;Name: Kyler Rynear
;Login: kryne001
;Email address: kryne001@ucr.edu
;Assignment: assignment 6
;
;I hereby certify that I have not received assistance on this assignment, or used code, from ANY outside source other than thte instruction team.
;-----------------------------------
.orig x3000

LD R4, BUSY_1
LOOP_1

	LD R3, MENU_SUB
	JSRR R3

	;return is R1

	LD R3, option_1
	LD R2, sub_option_1
	NOT R3, R3
	ADD R3, R3, #1
	ADD R0, R1, R3
	BRz GO_TO_SUB
	
	LD R3, option_2
	LD R2, sub_option_2
	NOT R3, R3
	ADD R3, R3, #1
	ADD R0, R1, R3
	BRz GO_TO_SUB

	LD R3, option_3
	LD R2, sub_option_3
	NOT R3, R3
	ADD R3, R3, #1
	ADD R0, R1, R3
	BRz GO_TO_SUB
	
	LD R3, option_4
	LD R2, sub_option_4
	NOT R3, R3
	ADD R3, R3, #1
	ADD R0, R1, R3
	BRz GO_TO_SUB
	
	LD R3, option_5
	LD R2, sub_option_5
	NOT R3, R3
	ADD R3, R3, #1
	ADD R0, R1, R3
	BRz GO_TO_SUB
	
	LD R3, option_6
	LD R2, sub_option_6
	NOT R3, R3
	ADD R3, R3, #1
	ADD R0, R1, R3
	BRz GO_TO_SUB
	
	LD R3, option_7
	NOT R3, R3
	ADD R3, R3, #1
	ADD R0, R1, R3
	BRz END_PROGRAM

	LEA R0, error_message
	PUTS
	BR LOOP_1

	GO_TO_SUB
		JSRR R2
		BR LOOP_1
	END_GO_TO_SUB

	END_PROGRAM
		LEA R0, goodbye
		PUTS
	
	HALT

;------------------
;data x3000
;------------------
MENU_SUB						.FILL						x3100
option_1						.FILL						#49
sub_option_1				.FILL						x3400
option_2						.FILL						#50
sub_option_2				.FILL						x3500
option_3						.FILL						#51
sub_option_3				.FILL						x3600
option_4						.FILL						#52
sub_option_4				.FILL						x3700
option_5						.FILL						#53
sub_option_5				.FILL						x3800
option_6						.FILL						#54
sub_option_6				.FILL						x3900
option_7						.FILL						#55
goodbye						.STRINGZ					"goodbye!"
error_message				.STRINGZ					"invalid input"
BUSY_1						.FILL						x5000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, allowed the
; user to select an option, and returned the selected option.
; Return Value (R1): The option selected: #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
.orig x3100

ST R3, BACKUP_R3_3100
ST R7, BACKUP_R7_3100

LD R1, zero_1

LEA R0, menu_list
PUTS

GETC
ADD R1, R0, R1

LD R3, BACKUP_R3_3100
LD R7, BACKUP_R7_3100

RET

;-------------------
;data menu sub
;-------------------
BACKUP_R3_3100				.blkw					#1
BACKUP_R7_3100				.blkw					#1
zero_1						.FILL					#0
menu_list				   .STRINGZ 			"**********************\n* The Busyness Server *\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
.orig x3400

ST R3, BACKUP_R3_3200
ST R7, BACKUP_R7_3200

LD R6, mem
JSRR R6

LD R3, sixteen
LD R2, zero_2
ADD R2, R2, R5
LOOP_2
	ADD R2, R2, #0
	BRn NOPE
	ADD R2, R2, R2
	ADD R3, R3, #-1
	BRp LOOP_2
	BR YEP
END_LOOP_2

NOPE
	LD R2, zero_2
	LEA R0, nope_message
	PUTS
	BR END_SUB_1

YEP
	LD R2, one_1
	LEA R0, yep_message
	PUTS
	BR END_SUB_1

END_SUB_1

LD R3, BACKUP_R3_3200
LD R7, BACKUP_R7_3200

RET


;-------------
;data AMB sub
;-------------

BACKUP_R3_3200				.BLKW				#1
BACKUP_R7_3200				.BLKW				#1
mem							.FILL				x5000
sixteen						.FILL				#16
zero_2						.FILL				#0
one_1							.FILL				#1
nope_message				.STRINGZ			"Not all machines are busy.\n"
yep_message					.STRINGZ			"All machines are busy.\n"


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
.orig x3500


ST R3, BACKUP_R3_3500
ST R7, BACKUP_R7_3500

LD R6, mem_1
JSRR R6

LD R3, sixteen_1
LD R2, zero_3
ADD R2, R2, R5
LOOP_3
	ADD R2, R2, #0
	BRn NOPE_1
	ADD R2, R2, R2
	ADD R3, R3, #-1
	BRp LOOP_3
	BR YEP_1
END_LOOP_3

NOPE_1
	LD R2, zero_3
	LEA R0, nope_message_1
	PUTS
	BR END_SUB_2

YEP_1
	LD R2, one_2
	LEA R0, yep_message_1
	PUTS
	BR END_SUB_2

END_SUB_2

LD R3, BACKUP_R3_3500
LD R7, BACKUP_R7_3500

RET


;-------------
;data AMF sub
;-------------

BACKUP_R3_3500				.BLKW				#1
BACKUP_R7_3500				.BLKW				#1
mem_1							.FILL				x5000
sixteen_1					.FILL				#16
zero_3						.FILL				#0
one_2							.FILL				#1
nope_message_1				.STRINGZ			"Not all machines are free.\n"
yep_message_1				.STRINGZ			"All machines are free.\n"


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
.orig x3600

ST R3, BACKUP_R3_3600
ST R7, BACKUP_R7_3600

LD R6, mem_2
JSRR R6

LD R3, sixteen_2
LD R2, zero_4
ADD R2, R2, R5
LD R6, zero_4
LOOP_4
	ADD R2, R2, #0
	BRp ADD_COUNT
	BRnz END_ADD_COUNT
	ADD_COUNT
		ADD R6, R6, #1
	END_ADD_COUNT
	ADD R2, R2, R2
	ADD R3, R3, #-1
	BRp LOOP_4
END_LOOP_4

LEA R0, start_out_message
PUTS
LD R3, converter_1
ADD R6, R6, R3
LD R0, zero_4
ADD R0, R6, R0
OUT
lD R0, zero_4
LEA R0, end_start_message
PUTS

LD R3, BACKUP_R3_3600
LD R7, BACKUP_R7_3600

RET
;---------------
;data NUM_BUSY_MACHINES
;---------------
BACKUP_R3_3600				.blkw				#1
BACKUP_R7_3600				.blkw				#1
mem_2							.FILL				x5000
sixteen_2					.FILL				#16
zero_4						.FILL				#0
start_out_message			.STRINGZ			"\nThere are "
end_start_message			.STRINGZ			" busy machines\n"
converter_1					.FILL				#48

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------
.orig x3700

ST R3, BACKUP_R3_3700
ST R7, BACKUP_R7_3700

LD R6, mem_5
JSRR R6

LD R3, sixteen_5
LD R2, zero_5
ADD R2, R2, R5
LD R6, zero_5
LOOP_5
	ADD R2, R2, #0
	BRn ADD_COUNT_1
	BRzp END_ADD_COUNT_1
	ADD_COUNT_1
		ADD R6, R6, #1
	END_ADD_COUNT_1
	ADD R2, R2, R2
	ADD R3, R3, #-1
	BRp LOOP_5
END_LOOP_5

LEA R0, start_out_message_1
PUTS
LD R3, converter_2
ADD R6, R6, R3
LD R0, zero_5
ADD R0, R6, R0
OUT
lD R0, zero_5
LEA R0, end_start_message_1
PUTS

LD R3, BACKUP_R3_3700
LD R7, BACKUP_R7_3700

RET
;---------------
;data NUM_BUSY_MACHINES
;---------------
BACKUP_R3_3700				.blkw				#1
BACKUP_R7_3700				.blkw				#1
mem_5							.FILL				x5000
sixteen_5					.FILL				#16
zero_5						.FILL				#0
start_out_message_1		.STRINGZ			"\nThere are "
end_start_message_1		.STRINGZ			" free machines\n"
converter_2					.FILL				#48


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the machine indicated
; by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;-----------------------------------------------------------------------------------------------------------------
.orig x3800

ST R3, BACKUP_R3_3800
ST R7, BACKUP_R7_3800

LD R3, mem_6
JSRR R3

LD R1, zero_6
ADD R1, R1, R5
LEA R0, out_3800_message
PUTS
GETC
OUT
ST R0, machine_selected
LD R3, converter_backwards
NOT R3, R3
ADD R3, R3, #1
ADD R0, R0, R3

LD R2, sixteen_6
NOT R0, R0
ADD R0, R0, #1
ADD R2, R2, R0
;ADD R2, R2, #-1
BRz END_LOOP_6
LOOP_6
	ADD R1, R1, R1
	ADD R2, R2, #-1
	BRp LOOP_6
END_LOOP_6

ADD R1, R1, #0
BRp ITS_BUSY
BRn ITS_FREE

ITS_BUSY
	LEA R0, start_busy_message
	PUTS
	LD R0, machine_selected
	OUT
	LEA R0, end_busy_message
	PUTS
	BR END_SUB_3800

ITS_FREE
	LEA R0, start_free_message
	PUTS
	LD R0, machine_selected
	OUT
	LEA R0, end_free_message
	PUTS
	BR END_SUB_3800

END_SUB_3800

LD R3, BACKUP_R3_3800
LD R7, BACKUP_R7_3800

RET
;---------------
;data x3700
;---------------
BACKUP_R3_3800					.blkw				#1
BACKUP_R7_3800					.blkw				#1
mem_6								.FILL				x5000
zero_6							.FILL				#0
out_3800_message				.STRINGZ			"which machine? "
machine_selected				.FILL				#2
sixteen_6						.FILL				#16
start_busy_message			.STRINGZ			"\nMachine "
end_busy_message				.STRINGZ			" is busy.\n"
start_free_message			.STRINGZ			"\nMachine "
end_free_message				.STRINGZ			" is free.\n"
converter_backwards			.FILL				#48
ten								.FILL				#10

.orig x5000
ST R7, BACKUP_R7_5000

LD R5, BUSYNESS

LD R7, BACKUP_R7_5000
RET

BUSYNESS					.FILL					x0F0F
BACKUP_R7_5000			.BLKW					#1
