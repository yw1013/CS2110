;;===============================
;;Name: YEA WON YOON
;;===============================

.orig x3000

	AND R0, R0, 0		;initialize to 0 (ARRAY) - R3
	AND R1, R1, 0		;initialize to 0 (LENGTH) - R4
	AND R2, R2, 0		;initialize to 0 (FOR_IN counter) - R5
	AND R3, R3, 0 		;initialize to 0 (Pointer's index 0) - R0
	AND R4, R4, 0		;initialize to 0 (Pointer's index 1) - R1
	AND R5, R5, 0		;initialize to 0 (temperory)
	
	LD R1, LENGTH		;Load LENGTH of the array to R1

FOR_OUT
	ADD R1, R1, -1		;LENGTH--: loop n-1 times.
	BRnz DONE		;If LENGTH <= 0, go to DONE
	ADD R2, R1, 0		;Put LENGTH into R2 
	LD R0, ARRAY		;Load ARRAY into R0

FOR_IN
	LDR R3, R0, 0		;Load the value of R0's pointer's index 0 into R3
	LDR R4, R0, 1		;Load the value of R0's pointer's index 1 into R4
	NOT R5, R4		;~R1: 2's complement
	ADD R5, R5, 1		;~R1 + 1: 2's complement 
	ADD R5, R3, R5		;R3 + (-R4) 
				;Check if the second item is bigger than the next item or not
	BRnz SKIP		;If (R3+(-R4)) <= 0, go to SKIP
	STR R4, R0, 0		;Put R0's pointer's index 0 to R4: Swap
	STR R3, R0, 1		;Put R0's pointer's index 1 to R3: Swap

SKIP
	ADD R0, R0, 1		;Move the pointer to the next index of ARRAY: update array address
	ADD R2, R2, -1		;FOR_IN counter--
	BRp FOR_IN		;if counter > 0, go to FOR_IN
	BRnzp FOR_OUT		;End of FOR_OUT

DONE	HALT			;Stop running

ARRAY   .fill x6000
LENGTH  .fill 12
.end

; This array should be sorted when finished.
.orig x6000
.fill -256
.fill 255
.fill 1
.fill 24
.fill 53
.fill -28
.fill -3
.fill 12
.fill 0
.fill -25
.fill -5
.fill -28
.end

