;;===============================
;;Name: YEA WON YOON
;;===============================

int bsearch(int *array, int low, int high, int X) {
	int mid = 0;
	if(low > high) {
		return -1;
	}
	mid = (low + high) / 2;
	if(array[mid] == X) {
		return mid;
	}
	if(array[mid] < X) {
		return bsearch(array, mid + 1, high, X);
	} else {
		return bsearch(array, low, mid - 1, X);
	}
}

; Main
; Do not edit this function!

;@plugin filename=lc3_udiv vector=x80

.orig x3000

	LD R6, STACK	; Initialize stack pointer

	LD R0, ARR_PTR	; \ Load parameters
	AND R1, R1, 0	; |
	LD R2, ARR_LEN	; |
	ADD R2, R2, -1	; |
	LD R3, X	; /

	ADD R6, R6, -4	; \ Call BSEARCH
	STR R0, R6, 0	; |
	STR R1, R6, 1	; |
	STR R2, R6, 2	; |
	STR R3, R6, 3	; |
	JSR BSEARCH	; /

	LDR R0, R6, 0	; \ Pop return value and args off the stack
	ADD R6, R6, 5	; /

	ST R0, ANSWER

	HALT

STACK   .fill xF000 ; Bottom of the stack + 1
ARR_PTR .fill x6000 ; Pointer to the array of elements
ARR_LEN .fill 16
X       .fill 99    ; What to search for
ANSWER  .fill -999  ; Do NOT write to this label from the subroutine!


; To call UDIV, use TRAP x80
; Preconditions:
;    R0 = X
;    R1 = Y
; Postconditions:
;    R0 = X / Y
;    R1 = X % Y

BSEARCH

	; Write your function here
	ADD R6, R6, -3		;Point R6 to old FP
	STR R7, R6 ,1		;Store return address
	STR R5, R6, 0		;Store old FP
	ADD R6, R6, -1		;Make room for new FP
	ADD R5, R6, 0		;Create new FP
	ADD R6, R6, -1		;Make room for local variables
	LDR R1, R5, 5		;Load low
	LDR R2, R5, 6		;Load high
	LDR R3, R5, 7		;Load X
	AND R4, R4, 0		;Initialize R4 (mid)
	

IF_ONE
	NOT R0, R2		;~high 
	ADD R0, R0, 1 		;~high + 1 
	ADD R0, R1, R0		;low + (-high) 
	BRp RET0		;if low > high , go to RET0

MID
	ADD R0, R1, R2		;low + high save to R0
	AND R1, R1, 0		;R1 = 0 
	ADD R1, R1, 2		;R1 = 2 save to R1
	TRAP x80
	LDR R1, R5, 5		;Load low
	ADD R4, R0, R4		;Store local (mid) at R4
	STR R4, R5, 0		;Store local (mid)

IF_TWO
	LD R0, ARR_PTR		;Load ARR_PTR at R0
	ADD R0, R0, R4		;array[mid]
	LDR R1, R0, 0		;Load the value of R0 to R1
	NOT R2, R3		;~X
	ADD R2, R2, 1		;~X + 1
	ADD R2, R1, R2		;array[mid] + (-X)
	BRz RET1		;If array[mid] == X, go to RET1
	BRn RET2		;If array[mid] < X, go to RET2
	BRp RET3		;If array[mid] > X, go to RET3


RET0
	AND R0, R0, 0		;initialize R0
	ADD R0, R0, -1		;R0 = -1
	BR RETURN


RET1
	AND R0, R0, 0		;initialize R0
	ADD R0, R0, R4		;R0 = mid
	BR RETURN


RET2
	ADD R6, R6, -4		;Make new stack
	STR R0, R6, 0		;Store ARR_PTR
	ADD R4, R4, 1		;mid + 1
	AND R1, R1, 0		;initialzie R1 (low)
	ADD R1, R1, R4		;low = mid + 1
	STR R1, R6, 1		;Store low
	LDR R2, R5, 6		;Load low
	STR R2, R6, 2		;Store high
	STR R3, R6, 3		;Store X
	JSR BSEARCH
	BR RETURN


RET3
	ADD R6, R6, -4		;Make new stack
	STR R0, R6, 0		;Store ARR_PTR
	LDR R1, R5, 5		;Load low
	STR R1, R6, 1		;Store low
	ADD R4, R4, -1		;mid - 1
	AND R2, R2, 0		;initialize R2 (high)
	ADD R2, R2, R4		;high = mid - 1
	STR R2, R6, 2		;Store high
	STR R3, R6, 3		;Store X
	JSR BSEARCH
	BR RETURN


RETURN
	ADD R6, R5, 0	;Point SP to FP
	STR R0, R5, 3	;Store return value
	LDR R7, R5, 2	;Restore return address
	LDR R5, R5, 1	;Load old frame pointer
	ADD R6, R6, 3	;Point SP to RV
	RET

.end

.orig x6000

	.fill -45
	.fill -42
	.fill -30
	.fill -2
	.fill 6
	.fill 15
	.fill 16
	.fill 28
	.fill 51
	.fill 78
	.fill 99
	.fill 178
	.fill 200
	.fill 299
	.fill 491
	.fill 5103

.end

