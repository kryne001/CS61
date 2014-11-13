;-----------------------------------
;Name: Kyler Rynear
;Login: kryne001
;Email address: kryne001@ucr.edu
;Assignment: lab 06, exercise 02
;Lab Section: <021 or 022>
;TA: Bryan Marsh
;
;I hereby certify that I have not received assistance on this assignment, or used code, from ANY outside source other than thte instruction team.
;-----------------------------------

.orig x3000
LEA R0, start_message
PUTS

ADD R2, R0, #0
LD R3, counter
;-----------
;data
;-----------
start_message					.STRINGZ					"Input a single character "
counter							.FILL						#0
