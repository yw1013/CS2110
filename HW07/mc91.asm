;;===============================
;; Name: YEA WON YOON
;;===============================

.orig x3000

	; Call MC91(n)
	LD R6, STACK
	LD R0, N
	ADD R6, R6, -1
	STR R0, R6, 0
	JSR MC91

	; Pop return value and arg off stack
	LDR R0, R6, 0
	ADD R6, R6, 2

	; Save the answer
	ST R0, ANSWER

;;=========================================================
;; Call MC91 subroutine with correct arguments here
;; Store the result from the subroutine in ANSWER
;;=========================================================

	HALT

STACK	.fill xF000
N	.fill 11       ;input n
ANSWER	.blkw 1    ;save your answer here

MC91
;;=====================
;;Your subroutine here
;;=====================

	ADD R6, R6, -3		;Point R6 to old FP
	STR R7, R6 ,1		;Store return address
	STR R5, R6, 0		;Store old FP
	ADD R5, R6, -1		;Create new FP
	ADD R6, R6, -1		;Make room for local variables
	LDR R0, R5, 4		;R0 = N
	
	AND R1, R1, 0		;initialize R1
	ADD R1, R0, -16		;n - 16
	ADD R1, R1, -16		;n - 16: n - 32
	ADD R1, R1, -16		;n - 16: n - 48
	ADD R1, R1, -16		;n - 16: n - 64
	ADD R1, R1, -16		;n - 16: n - 80
	ADD R1, R1, -16		;n - 16: n - 96
	ADD R1, R1, -4		;n - 4
	BRp RET0


ELSE
	ADD R6, R6, -1		;else
	ADD R0, R0, 11		;n + 11
	STR R0, R6, 0		;Store the argument
	JSR MC91
	JSR MC91

	LDR R0, R6, 0		;Load mc91
	ADD R2, R0, 0		;R2 = R0
	BR RETURN


RET0
	LDR R0, R5, 4		;Load N
	ADD R1, R0, -10		;n - 10
	Br RETURN

RETURN
	ADD R6, R5, 0	;Point SP to FP
	STR R1, R5, 3	;Store return value
	LDR R7, R5, 2	;Restore return address
	LDR R5, R5, 1	;Load old frame pointer
	ADD R6, R6, 3	;Point SP to RV
	RET


.end
