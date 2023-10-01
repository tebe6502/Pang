// Range Checking Byte

; Approach by White Flame

; In checking for the range [x,y), instead of performing 2 comparisons the idea
; is to subtract x to align the range to [0,y-x). This then allows us to perform
; a single unsigned comparison to check both ends of the range.

; Any numbers lower than the original range will have wrapped the byte into
; the high values ?255, and any number higher than the original range will
; still be too large.

	org $2000

; Check .A for the range [10..100)
main
;	sta DETECT.ay0
	lda #100

	sta ay

	lda #32			; wysokosc bohatera
;	sta DETECT.dy0
	sta dy


	lda #131

	sec
	sbc #10			; start of the range
ay	equ *-1
	cmp #90			; length of the range
dy	equ *-1
	bcs fail		; result needs to be 0-89 to pass the original 10-99 check
				; .A is in range here, and Carry is clear

	mva #$cc 712
	jmp *

fail	mva #$24 712
	jmp *

	run main

