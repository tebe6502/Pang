.local	frmR5
_0
	jsr DEF1._00

	lda (rw28),y
	and #$C0
	ora #$20
	sta (rw28),y
	lda (rw29),y
	and #$C0
	ora #$20
	sta (rw29),y
	lda (rw30),y
	and #$C0
	ora #$20
	sta (rw30),y
	lda (rw27),y
	and #$C0
	ora #$28
	sta (rw27),y
	lda (rw24),y
	and #$F0
	ora #$08
	sta (rw24),y
	lda (rw25),y
	and #$F0
	ora #$08
	sta (rw25),y
	lda (rw26),y
	and #$F0
	ora #$0A
	sta (rw26),y
	lda (rw31),y
	and #$F0
	ora #$0A
	sta (rw31),y
	@@INCRW
	jsr DEF1._01

	lda (rw25),y
	and #$03
	sta (rw25),y
	lda (rw26),y
	and #$03
	ora #$08
	sta (rw26),y
	lda (rw24),y
	and #$03
	ora #$10
	sta (rw24),y
	lda (rw27),y
	and #$03
	ora #$48
	sta (rw27),y
	lda #$21
	sta (rw30),y
	lda #$62
	sta (rw29),y
	lda #$A0
	sta (rw31),y
	lda #$A2
	sta (rw28),y
	@@INCRW
	jsr DEF1._02

	lda (rw30),y
	and #$3F
	ora #$80
	sta (rw30),y
	lda (rw31),y
	and #$3F
	ora #$80
	sta (rw31),y
	jmp FRM5
_1
	jsr DEF1._10

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
	lda (rw27),y
	and #$F0
	ora #$0A
	sta (rw27),y
	lda (rw24),y
	and #$FC
	ora #$02
	sta (rw24),y
	lda (rw25),y
	and #$FC
	ora #$02
	sta (rw25),y
	lda (rw26),y
	and #$FC
	ora #$02
	sta (rw26),y
	lda (rw31),y
	and #$FC
	ora #$02
	sta (rw31),y
	@@INCRW
	jsr DEF1._11

	lda #$00
	sta (rw25),y
	lda #$04
	sta (rw24),y
	lda #$08
	sta (rw30),y
	lda #$12
	sta (rw27),y
	lda #$18
	sta (rw29),y
	lda #$28
	sta (rw28),y
	lda #$82
	sta (rw26),y
	lda #$A8
	sta (rw31),y
	@@INCRW
	jsr DEF1._12

	lda (rw31),y
	and #$0F
	ora #$20
	sta (rw31),y
	lda (rw30),y
	and #$0F
	ora #$60
	sta (rw30),y
	lda (rw28),y
	and #$3F
	ora #$80
	sta (rw28),y
	lda (rw29),y
	and #$3F
	ora #$80
	sta (rw29),y
	@@INCRW
	jsr DEF1._13

	jmp FRM5
_2
	jsr DEF1._20

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
	@@INCRW
	jsr DEF1._21

	lda #$02
	sta (rw30),y
	lda #$06
	sta (rw29),y
	lda #$0A
	sta (rw28),y
	lda #$80
	sta (rw25),y
	lda #$81
	sta (rw24),y
	lda #$84
	sta (rw27),y
	lda #$A0
	sta (rw26),y
	lda #$AA
	sta (rw31),y
	@@INCRW
	jsr DEF1._22

	lda (rw31),y
	and #$03
	ora #$08
	sta (rw31),y
	lda (rw30),y
	and #$03
	ora #$18
	sta (rw30),y
	lda (rw28),y
	and #$0F
	ora #$20
	sta (rw28),y
	lda (rw29),y
	and #$0F
	ora #$20
	sta (rw29),y
	lda (rw24),y
	and #$3F
	sta (rw24),y
	lda (rw25),y
	and #$3F
	sta (rw25),y
	lda (rw26),y
	and #$3F
	ora #$80
	sta (rw26),y
	lda (rw27),y
	and #$3F
	ora #$80
	sta (rw27),y
	@@INCRW
	jsr DEF1._23

	jmp FRM5
_3
	jsr DEF1._30

	@@INCRW
	jsr DEF1._31

	lda (rw24),y
	and #$C0
	ora #$20
	sta (rw24),y
	lda (rw25),y
	and #$C0
	ora #$20
	sta (rw25),y
	lda (rw26),y
	and #$C0
	ora #$28
	sta (rw26),y
	lda (rw31),y
	and #$C0
	ora #$2A
	sta (rw31),y
	lda #$80
	sta (rw30),y
	lda #$81
	sta (rw29),y
	lda #$82
	sta (rw28),y
	lda #$A1
	sta (rw27),y
	@@INCRW
	jsr DEF1._32

	lda (rw25),y
	and #$0F
	sta (rw25),y
	lda (rw26),y
	and #$0F
	ora #$20
	sta (rw26),y
	lda (rw27),y
	and #$0F
	ora #$20
	sta (rw27),y
	lda (rw24),y
	and #$0F
	ora #$40
	sta (rw24),y
	lda (rw28),y
	and #$03
	ora #$88
	sta (rw28),y
	lda (rw29),y
	and #$03
	ora #$88
	sta (rw29),y
	lda #$82
	sta (rw31),y
	lda #$86
	sta (rw30),y
	@@INCRW
	jsr DEF1._33

	jmp FRM5
.end
