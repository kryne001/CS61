;-----------------------------------
;Name: Kyler Rynear
;Login: kryne001
;Email address: kryne001@ucr.edu
;Assignment: assn2
;Lab Section: <021 or 022>
;TA: Bryan Marsh
;
;I hereby certify that I have not received assistance on this assignment, or used code, from ANY outside source other than thte instruction team.
;
;------------------------------------

.ORIG x3000

;----------------
;Instructions
;----------------

						  LEA R0, FIRST							;load string into R0
						  PUTS										;print out message
						  LD R0, tab								;new line
						  TRAP x21									;display
						  GETC										;get user input for first number
						  TRAP x21 									;display first number
						  ADD R2, R0, R2							;take user input, put it in R2
						  LEA R0, minus							;" - "
						  TRAP x22									;display
						  GETC										;get user input for second number
						  TRAP x21									;display second number
						  ADD R3, R0, R3							;put second number into register 3
						  LEA R0, equals							;" = "
						  TRAP x22									;display
						  NOT R3, R3								;negative number 2
						  ADD R3, R3, x1							;two's complement
						  ADD R4, R2, R3							;add number 1 to number 2, put in R4
						  BRzp NOT_NEGATIVE						;if result is not negative, goto label
						  BRn NEGATIVE								;if result is negative, goto label
NEGATIVE   			  NOT R4, R4								;two's complement to make result negative
						  ADD R4, R4, x1							
						  LEA R0, negative						
						  TRAP x22									;print negative sign before answer
						  LD R6, converter						;Load convert decimal into R6
						  ADD R0, R4, R6							
						  TRAP x21
HALT
NOT_NEGATIVE		  LD R6, converter
						  												;convert from decimal to ascii, store in R0
						  												;print answer to console
						  ADD R0, R4, R6							; answer
						  TRAP x21									;display
						  
HALT
;----------------
;Data
;----------------

	FIRST 		.STRINGZ 		"Enter number 1"
	SECOND		.STRINGZ			"Enter number 2"
	converter 	.FILL				#48
	tab			.FILL				#10
	minus			.STRINGZ			" - "
	equals		.STRINGZ			" = "
	negative		.STRINGZ			"-"
.END
