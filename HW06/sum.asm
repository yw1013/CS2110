;;===============================
;;Name: YEA WON YOON
;;===============================

.orig x3000

	AND R0, R0, 0		;initialize to 0 (SUM)
	AND R1, R1, 0		;initialize to 0 (ARRAY)
	AND R2, R2, 0		;initialize to 0 (LENGTH)
	AND R3, R3, 0 		;initialize to 0 (value of index)

	LD R1, ARRAY		;Load ARRAY into R1
	LD R2, LENGTH		;Load LENGTH into R2

FOR
	LDR R3, R1, 0		;Load the value of R1's pointer's index 0 into R3
	ADD R0, R0, R3		;Add the value of R3 to SUM: update SUM
	ADD R1, R1, 1		;Move the pointer to the next index of ARRAY: update array address 
	ADD R2, R2, -1		;LENGTH--

BRp FOR				;If LENGTH <= 0, don't loop again

	ADD R0, R0, 0		;Put R0 into R0 
	BRzp DONE		;If R0 >= 0, go to DONE
	NOT R0, R0		;~R0: 2's complement to make it absolute value
	ADD R0, R0, 1		;~R0 + 1: 2's complement to make it absolute value

DONE	ST R0, ANSWER		;Store R0 value into ANSWER

	HALT			;Stop running


	
ARRAY   .fill x6000
LENGTH  .fill 10
ANSWER	.fill 0		; The answer should have the abs(sum) when finished.
.end

.orig x6000
.fill -200
.fill 9
.fill 0
.fill 256
.fill -100
.fill -11
.fill 150
.fill 84
.fill -96
.fill 104
.end
