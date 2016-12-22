;;===============================
;;Name: YEA WON YOON
;;===============================

int gcd(int m, int n) {
	if(m == n) {
		return m;
	} else if (m > n) {
		return gcd(m-n, n);
	} else {
		return gcd(m, n-m);
	}
}

int odd_sum(int N) {
	int sum;
	if (N <= 0){
		return 0;
	}
	sum = odd_sum(N - 1);
	if (N & 1 == 0){
		return sum;
	}else {
		return sum + N;
	}
}

.orig x3000

MAIN
	LD R6, STACK 		;initialize stack pointer
;;=========================================================
;;Call GCD subroutine with correct arguments here
;;Store the result from the subroutine in ANSWER
;;=========================================================

	LD R0, M		;Load m
	LD R1, N		;Load n
	ADD R6, R6, -2
	STR R0, R6, 0
	STR R1, R6, 1
	JSR GCD

	LDR R0, R6, 0
	ADD R6, R6, 3

	ST R0, ANSWER

	HALT

STACK .fill xF000
N .fill 1	; input n
M .fill 9999		; input m
ANSWER .fill 0  ; save your answer here

GCD
;;=====================
;;Your subroutine here
;;=====================

	ADD R6, R6, -3		;Point R6 to old FP
	STR R7, R6 ,1		;Store return address
	STR R5, R6, 0		;Store old FP
	ADD R6, R6, -1		;Make room for new FP
	ADD R5, R6, 0		;Create new FP
	LDR R0, R5, 4		;Load m
	LDR R1, R5, 5		;Load n


IF
	NOT R2, R1		;~n
	ADD R2, R2, 1		;~n + 1 = -n
	ADD R2, R0, R2		;m + (-n)
	BRz RET0
	BRp RET1
	BRn RET2
	

RET0
	AND R1, R1, 0		;initialize R0
	ADD R1, R1, R0		;R0 = m
	BR RETURN


RET1
	ADD R6, R6, -1		;Make new stack
	NOT R2, R1		;~n
	ADD R2, R2, 1		;~n + 1 = -n
	ADD R0, R0, R2		;m + (-n)
	STR R0, R6, 0		;Store m
	STR R1, R6, 1		;Store n
	JSR GCD
	BR RETURN		


RET2
	ADD R6, R6, -1		;Make new stack
	STR R0, R6, 0		;Store m
	NOT R2, R0		;~m
	ADD R2, R2, 1		;~m + 1 = -m
	ADD R1, R1, R2		;n + (-m)
	STR R1, R6, 1		;Store n
	JSR GCD
	BR RETURN		


RETURN
	ADD R6, R5, 0	;Point SP to FP
	STR R1, R5, 3	;Store return value
	LDR R7, R5, 2	;Restore return address
	LDR R5, R5, 1	;Load old frame pointer
	ADD R6, R6, 3	;Point SP to RV
	RET


.end
