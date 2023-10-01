.local	frmR0
_0
	jsr DEF0._00

	lda (rw24),y
	and #$C0
	ora #$20
	sta (rw24),y
	lda (rw26),y
	and #$F0
	ora #$08
	sta (rw26),y
	lda (rw27),y
	and #$F0
	ora #$08
	sta (rw27),y
	lda (rw28),y
	and #$F0
	ora #$08
	sta (rw28),y
	lda (rw29),y
	and #$F0
	ora #$08
	sta (rw29),y
	lda (rw30),y
	and #$F0
	ora #$08
	sta (rw30),y
	lda (rw25),y
	and #$F0
	ora #$0A
	sta (rw25),y
	lda (rw31),y
	and #$F0
	ora #$0A
	sta (rw31),y
	@@INCRW
	jsr DEF0._01

	lda (rw30),y
	and #$03
	ora #$08
	sta (rw30),y
	lda (rw29),y
	and #$03
	ora #$18
	sta (rw29),y
	lda (rw25),y
	and #$0F
	ora #$20
	sta (rw25),y
	lda (rw27),y
	and #$0F
	ora #$20
	sta (rw27),y
	lda (rw26),y
	and #$0F
	ora #$60
	sta (rw26),y
	lda (rw28),y
	and #$0F
	ora #$A0
	sta (rw28),y
	lda (rw31),y
	and #$0F
	ora #$A0
	sta (rw31),y
	lda (rw24),y
	and #$3F
	ora #$80
	sta (rw24),y
	@@INCRW
	jsr DEF0._02

	jmp FRM0
_1
	jsr DEF0._10

	lda (rw24),y
	and #$F0
	ora #$08
	sta (rw24),y
	lda (rw25),y
	and #$FC
	ora #$02
	sta (rw25),y
	lda (rw26),y
	and #$FC
	ora #$02
	sta (rw26),y
	lda (rw27),y
	and #$FC
	ora #$02
	sta (rw27),y
	lda (rw28),y
	and #$FC
	ora #$02
	sta (rw28),y
	lda (rw29),y
	and #$FC
	ora #$02
	sta (rw29),y
	lda (rw30),y
	and #$FC
	ora #$02
	sta (rw30),y
	lda (rw31),y
	and #$FC
	ora #$02
	sta (rw31),y
	@@INCRW
	jsr DEF0._11

	lda (rw27),y
	and #$03
	ora #$08
	sta (rw27),y
	lda (rw26),y
	and #$03
	ora #$18
	sta (rw26),y
	lda (rw28),y
	and #$03
	ora #$28
	sta (rw28),y
	lda (rw24),y
	and #$0F
	ora #$20
	sta (rw24),y
	lda (rw25),y
	and #$03
	ora #$88
	sta (rw25),y
	lda (rw31),y
	and #$03
	ora #$A8
	sta (rw31),y
	lda #$02
	sta (rw30),y
	lda #$06
	sta (rw29),y
	@@INCRW
	jsr DEF0._12

	@@INCRW
	jsr DEF0._13

	jmp FRM0
_2
	jsr DEF0._20

	lda (rw24),y
	and #$FC
	ora #$02
	sta (rw24),y
	@@INCRW
	jsr DEF0._21

	lda (rw24),y
	and #$03
	ora #$08
	sta (rw24),y
	lda #$80
	sta (rw30),y
	lda #$81
	sta (rw29),y
	lda #$82
	sta (rw27),y
	lda #$86
	sta (rw26),y
	lda #$8A
	sta (rw28),y
	lda #$A2
	sta (rw25),y
	lda #$AA
	sta (rw31),y
	@@INCRW
	jsr DEF0._22

	lda (rw29),y
	and #$3F
	ora #$80
	sta (rw29),y
	lda (rw30),y
	and #$3F
	ora #$80
	sta (rw30),y
	@@INCRW
	jsr DEF0._23

	jmp FRM0
_3
	jsr DEF0._30

	@@INCRW
	jsr DEF0._31

	lda (rw27),y
	and #$C0
	ora #$20
	sta (rw27),y
	lda (rw29),y
	and #$C0
	ora #$20
	sta (rw29),y
	lda (rw30),y
	and #$C0
	ora #$20
	sta (rw30),y
	lda (rw26),y
	and #$C0
	ora #$21
	sta (rw26),y
	lda (rw28),y
	and #$C0
	ora #$22
	sta (rw28),y
	lda (rw25),y
	and #$C0
	ora #$28
	sta (rw25),y
	lda (rw31),y
	and #$C0
	ora #$2A
	sta (rw31),y
	lda #$82
	sta (rw24),y
	@@INCRW
	jsr DEF0._32

	lda (rw30),y
	and #$0F
	ora #$20
	sta (rw30),y
	lda (rw29),y
	and #$0F
	ora #$60
	sta (rw29),y
	lda (rw25),y
	and #$3F
	ora #$80
	sta (rw25),y
	lda (rw26),y
	and #$3F
	ora #$80
	sta (rw26),y
	lda (rw27),y
	and #$3F
	ora #$80
	sta (rw27),y
	lda (rw28),y
	and #$3F
	ora #$80
	sta (rw28),y
	lda (rw31),y
	and #$3F
	ora #$80
	sta (rw31),y
	@@INCRW
	jsr DEF0._33

	jmp FRM0
.end
