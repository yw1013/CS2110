;;===============================
;;Name: YEA WON YOON
;;===============================

.orig x3000

	AND R0, R0, 0	;initialize to 0
	AND R1, R1, 0	;initialize to 0
	AND R2, R2, 0	;initialize to 0

	LD R1, A	;Load A into R1
	LD R2, B	;Load B into R2

	NOT R1, R1	;~A
	NOT R2, R2	;~B
	AND R0, R1, R2	;~A&~B
	NOT R0, R0	;~(~A&~B)
	
	ST R0, ANSWER	;Store R0 value to ANSWER

	HALT	

A       .fill -10304
B       .fill 20000
ANSWER  .fill 0		; This answer should contain A | B when finished.
.end
