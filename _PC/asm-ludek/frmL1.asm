.local	frmL1
_0
	jsr DEF1._00

	lda (rw31),y
	and #$F0
	ora #$08
	sta (rw31),y
	lda (rw30),y
	and #$F0
	ora #$09
	sta (rw30),y
	lda (rw29),y
	and #$FC
	ora #$02
	sta (rw29),y
	@@INCRW
	jsr DEF1._01

	lda (rw29),y
	and #$03
	ora #$08
	sta (rw29),y
	lda (rw30),y
	and #$03
	ora #$08
	sta (rw30),y
	lda (rw31),y
	and #$03
	ora #$08
	sta (rw31),y
	lda (rw25),y
	and #$C0
	sta (rw25),y
	lda (rw24),y
	and #$C0
	ora #$04
	sta (rw24),y
	lda (rw26),y
	and #$C0
	ora #$20
	sta (rw26),y
	lda #$86
	sta (rw27),y
	lda #$92
	sta (rw28),y
	@@INCRW
	jsr DEF1._02

	lda (rw27),y
	and #$03
	ora #$08
	sta (rw27),y
	lda (rw24),y
	and #$0F
	ora #$20
	sta (rw24),y
	lda (rw25),y
	and #$0F
	ora #$20
	sta (rw25),y
	lda (rw31),y
	and #$03
	ora #$88
	sta (rw31),y
	lda (rw26),y
	and #$0F
	ora #$80
	sta (rw26),y
	lda (rw29),y
	and #$C0
	ora #$2A
	sta (rw29),y
	lda #$82
	sta (rw28),y
	sta (rw30),y
	jmp FRM1
_1
	jsr DEF1._10

	lda (rw30),y
	and #$FC
	ora #$02
	sta (rw30),y
	lda (rw31),y
	and #$FC
	ora #$02
	sta (rw31),y
	@@INCRW
	jsr DEF1._11

	lda (rw27),y
	and #$C0
	ora #$21
	sta (rw27),y
	lda (rw28),y
	and #$C0
	ora #$24
	sta (rw28),y
	lda (rw25),y
	and #$F0
	sta (rw25),y
	lda (rw24),y
	and #$F0
	ora #$01
	sta (rw24),y
	lda (rw26),y
	and #$F0
	ora #$08
	sta (rw26),y
	lda #$02
	sta (rw31),y
	lda #$42
	sta (rw30),y
	lda #$82
	sta (rw29),y
	@@INCRW
	jsr DEF1._12

	lda (rw24),y
	and #$03
	ora #$08
	sta (rw24),y
	lda (rw25),y
	and #$03
	ora #$08
	sta (rw25),y
	lda (rw26),y
	and #$03
	ora #$20
	sta (rw26),y
	lda (rw30),y
	and #$C0
	ora #$20
	sta (rw30),y
	lda (rw31),y
	and #$C0
	ora #$22
	sta (rw31),y
	lda (rw29),y
	and #$F0
	ora #$0A
	sta (rw29),y
	lda #$82
	sta (rw27),y
	lda #$A0
	sta (rw28),y
	@@INCRW
	jsr DEF1._13

	lda (rw28),y
	and #$3F
	ora #$80
	sta (rw28),y
	lda (rw29),y
	and #$3F
	ora #$80
	sta (rw29),y
	lda (rw30),y
	and #$3F
	ora #$80
	sta (rw30),y
	jmp FRM1
_2
	jsr DEF1._20

	@@INCRW
	jsr DEF1._21

	lda (rw29),y
	and #$C0
	ora #$20
	sta (rw29),y
	lda (rw27),y
	and #$F0
	ora #$08
	sta (rw27),y
	lda (rw28),y
	and #$F0
	ora #$09
	sta (rw28),y
	lda (rw24),y
	and #$FC
	sta (rw24),y
	lda (rw25),y
	and #$FC
	sta (rw25),y
	lda (rw26),y
	and #$FC
	ora #$02
	sta (rw26),y
	lda #$80
	sta (rw31),y
	lda #$90
	sta (rw30),y
	@@INCRW
	jsr DEF1._22

	lda (rw30),y
	and #$30
	ora #$88
	sta (rw30),y
	lda (rw31),y
	and #$30
	ora #$88
	sta (rw31),y
	lda (rw29),y
	and #$3C
	ora #$82
	sta (rw29),y
	lda #$02
	sta (rw25),y
	lda #$08
	sta (rw26),y
	lda #$28
	sta (rw28),y
	lda #$42
	sta (rw24),y
	lda #$60
	sta (rw27),y
	@@INCRW
	jsr DEF1._23

	lda (rw28),y
	and #$0F
	ora #$20
	sta (rw28),y
	lda (rw30),y
	and #$0F
	ora #$20
	sta (rw30),y
	lda (rw29),y
	and #$0F
	ora #$A0
	sta (rw29),y
	lda (rw27),y
	and #$3F
	ora #$80
	sta (rw27),y
	lda (rw31),y
	and #$3F
	ora #$80
	sta (rw31),y
	jmp FRM1
_3
	jsr DEF1._30

	@@INCRW
	jsr DEF1._31

	lda (rw31),y
	and #$C0
	ora #$20
	sta (rw31),y
	lda (rw30),y
	and #$C0
	ora #$24
	sta (rw30),y
	lda (rw29),y
	and #$F0
	ora #$08
	sta (rw29),y
	lda (rw27),y
	and #$FC
	ora #$02
	sta (rw27),y
	lda (rw28),y
	and #$FC
	ora #$02
	sta (rw28),y
	@@INCRW
	jsr DEF1._32

	lda (rw30),y
	and #$0C
	ora #$22
	sta (rw30),y
	lda (rw31),y
	and #$0C
	ora #$22
	sta (rw31),y
	lda (rw29),y
	and #$0F
	ora #$20
	sta (rw29),y
	lda #$00
	sta (rw25),y
	lda #$10
	sta (rw24),y
	lda #$18
	sta (rw27),y
	lda #$4A
	sta (rw28),y
	lda #$82
	sta (rw26),y
	@@INCRW
	jsr DEF1._33

	lda (rw28),y
	and #$03
	ora #$08
	sta (rw28),y
	lda (rw30),y
	and #$03
	ora #$08
	sta (rw30),y
	lda (rw27),y
	and #$0F
	ora #$20
	sta (rw27),y
	lda (rw31),y
	and #$0F
	ora #$20
	sta (rw31),y
	lda (rw26),y
	and #$3F
	sta (rw26),y
	lda (rw29),y
	and #$03
	ora #$A8
	sta (rw29),y
	lda (rw24),y
	and #$3F
	ora #$80
	sta (rw24),y
	lda (rw25),y
	and #$3F
	ora #$80
	sta (rw25),y
	jmp FRM1
.end
