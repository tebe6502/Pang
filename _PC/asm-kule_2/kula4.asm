.local	k4
_0
	lda (ln1),y
	and #$C3
	ora #$28
	sta (ln1),y
	lda (ln6),y
	and #$C3
	ora #$28
	sta (ln6),y
	lda #$82
	sta (ln2),y
	sta (ln4),y
	lda #$86
	sta (ln5),y
	lda #$92
	sta (ln3),y
	jmp BALL.MINMAX
_1
	lda (ln2),y
	and #$C0
	ora #$20
	sta (ln2),y
	lda (ln4),y
	and #$C0
	ora #$20
	sta (ln4),y
	lda (ln5),y
	and #$C0
	ora #$21
	sta (ln5),y
	lda (ln3),y
	and #$C0
	ora #$24
	sta (ln3),y
	lda (ln1),y
	and #$F0
	ora #$0A
	sta (ln1),y
	lda (ln6),y
	and #$F0
	ora #$0A
	sta (ln6),y
	@@INC inck4
	lda (ln2),y
	and #$3F
	ora #$80
	sta (ln2),y
	lda (ln3),y
	and #$3F
	ora #$80
	sta (ln3),y
	lda (ln4),y
	and #$3F
	ora #$80
	sta (ln4),y
	lda (ln5),y
	and #$3F
	ora #$80
	sta (ln5),y
	jmp BALL.MINMAX
_2
	lda (ln2),y
	and #$F0
	ora #$08
	sta (ln2),y
	lda (ln4),y
	and #$F0
	ora #$08
	sta (ln4),y
	lda (ln5),y
	and #$F0
	ora #$08
	sta (ln5),y
	lda (ln3),y
	and #$F0
	ora #$09
	sta (ln3),y
	lda (ln1),y
	and #$FC
	ora #$02
	sta (ln1),y
	lda (ln6),y
	and #$FC
	ora #$02
	sta (ln6),y
	@@INC inck4
	lda (ln2),y
	and #$0F
	ora #$20
	sta (ln2),y
	lda (ln3),y
	and #$0F
	ora #$20
	sta (ln3),y
	lda (ln4),y
	and #$0F
	ora #$20
	sta (ln4),y
	lda (ln5),y
	and #$0F
	ora #$60
	sta (ln5),y
	lda (ln1),y
	and #$3F
	ora #$80
	sta (ln1),y
	lda (ln6),y
	and #$3F
	ora #$80
	sta (ln6),y
	jmp BALL.MINMAX
_3
	lda (ln2),y
	and #$FC
	ora #$02
	sta (ln2),y
	lda (ln3),y
	and #$FC
	ora #$02
	sta (ln3),y
	lda (ln4),y
	and #$FC
	ora #$02
	sta (ln4),y
	lda (ln5),y
	and #$FC
	ora #$02
	sta (ln5),y
	@@INC inck4
	lda (ln2),y
	and #$03
	ora #$08
	sta (ln2),y
	lda (ln4),y
	and #$03
	ora #$08
	sta (ln4),y
	lda (ln5),y
	and #$03
	ora #$18
	sta (ln5),y
	lda (ln3),y
	and #$03
	ora #$48
	sta (ln3),y
	lda (ln1),y
	and #$0F
	ora #$A0
	sta (ln1),y
	lda (ln6),y
	and #$0F
	ora #$A0
	sta (ln6),y
	jmp BALL.MINMAX
.end
