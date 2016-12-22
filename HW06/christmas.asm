;;===============================
;;Name: YEA WON YOON
;;===============================

.orig x3000

	AND R0, R0, 0		;initialize to 0 (MSG)
	AND R1, R1, 0		;initialize to 0 (DAY)
	AND R2, R2, 0		;initialize to 0 (G_ARR)
	AND R3, R3, 0 		;initialize to 0 (M_ARR)

	LEA R0, START_MSG_1	;Load the address of START_MSG_1 into R0
	PUTS			;Print R0 (START_MSG_1)

	LD R1, DAY		;Load DAY into R1
	ADD R1, R1, -1		;DAY--
	ST R1, DAY		;Store R1 value to DAY

	LEA R2, GRAMMAR_ARR	;Load the address of GRAMMAR_ARR into R2
	ADD R2, R1, R2		;grammar_arr[day-1]
	ADD R0, R2, 0		;Put R2 into R0
	LDR R0, R0, 0		;Load the value of R0 into R0
	PUTS			;Print R0 (DAY)

	LEA R0, START_MSG_2	;Load the address of START_MSG_2 into R0
	PUTS			;Print R0 (START_MSG_2)


WHILE
	LD R1, DAY		;Load DAY into R1
				;DAY is actually DAY - 1 because DAY was decremented before the loop
				;So day-- starts after printing message_arr[day]
	LEA R3, MESSAGE_ARR	;Load the address of MESSAGE_ARR into R3
	ADD R3, R1, R3		;message_arr[day] 
	ADD R0, R3, 0		;Put R3 to R0
	LDR R0, R0, 0		;Load the value of R0 into R0
	PUTS			;Print R0 (vese of the carol)

	ADD R1, R1, -1		;day--
	ST R1, DAY		;Store R1 value into DAY

BRzp WHILE			;If day < 0, don't loop again 
	
	HALT			;Stop running

	
DAY	.fill 12

START_MSG_1
	.stringz "On the "

START_MSG_2
	.stringz " day of Christmas my true love gave to me:\n"

GRAMMAR_ARR
	.fill GRAM01
	.fill GRAM02
	.fill GRAM03
	.fill GRAM04
	.fill GRAM05
	.fill GRAM06
	.fill GRAM07
	.fill GRAM08
	.fill GRAM09
	.fill GRAM10
	.fill GRAM11
	.fill GRAM12

MESSAGE_ARR
	.fill MESS01
	.fill MESS02
	.fill MESS03
	.fill MESS04
	.fill MESS05
	.fill MESS06
	.fill MESS07
	.fill MESS08
	.fill MESS09
	.fill MESS10
	.fill MESS11
	.fill MESS12
.end

.orig x5000
GRAM01
	.stringz "first"
GRAM02
	.stringz "second"
GRAM03
	.stringz "third"
GRAM04
	.stringz "fourth"
GRAM05
	.stringz "fifth"
GRAM06
	.stringz "sixth"
GRAM07
	.stringz "seventh"
GRAM08
	.stringz "eighth"
GRAM09
	.stringz "ninth"
GRAM10
	.stringz "tenth"
GRAM11
	.stringz "eleventh"
GRAM12
	.stringz "twelfth"
MESS01
	.stringz "A partridge in a pear tree\n"
MESS02
	.stringz "Two turtle doves\n"
MESS03
	.stringz "Three French hens\n"
MESS04
	.stringz "Four calling birds\n"
MESS05
	.stringz "Five golden rings\n"
MESS06
	.stringz "Six geese a-laying\n"
MESS07
	.stringz "Seven swans a-swimming\n"
MESS08
	.stringz "Eight maids a-milking\n"
MESS09
	.stringz "Nine ladies dancing\n"
MESS10
	.stringz "Ten lords a-leaping\n"
MESS11
	.stringz "Eleven pipers piping\n"
MESS12
	.stringz "Twelve drummers drumming\n"
.end

