;-----------------------------------
;Name: Kyler Rynear
;Login: kryne001
;Email address: kryne001@ucr.edu
;Assignment: lab04ex01
;Lab Section: <021 or 022>
;TA: Bryan Marsh
;
;I hereby certify that I have not received assistance on this assignment, or used code, from ANY outside source other than thte instruction team.
;-----------------------------------
.orig x3000

;------------------
;Instructions
;------------------
LD R5, start_value
LD R4, mem
LD R3, counter

DO_WHILE
	STR R5, R4, #0						;store value into array index
	ADD R5, R5, #1						;add 1 to value
	ADD R4, R4, #1						;go to next index of array
	ADD R3, R3, #-1					;decrement counter
	BRzp DO_WHILE						;loop if counter >= 0
	BRn END_DO_WHILE					;exit if counter < 0
END_DO_WHILE

LD R4, mem
ADD R4, R4, #6							;go to sixth index of array
LDR R2, R4, #0							;load value in current index into R2

HALT

;--------------
;data
;-------------

start_value					.FILL				#0
mem							.FILL				x4000
counter						.FILL				#9

.orig x4000
								.BLKW				#10

.END
