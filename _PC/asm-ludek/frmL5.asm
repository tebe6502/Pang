.local	frmL5
_0
	jsr DEF1._00

	lda (rw30),y
	and #$FC
	ora #$02
	sta (rw30),y
	lda (rw31),y
	and #$FC
	ora #$02
	sta (rw31),y
	@@INCRW
	jsr DEF1._01

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
	lda (rw27),y
	and #$C0
	ora #$21
	sta (rw27),y
	lda #$0A
	sta (rw31),y
	lda #$48
	sta (rw30),y
	lda #$89
	sta (rw29),y
	lda #$8A
	sta (rw28),y
	@@INCRW
	jsr DEF1._02

	lda (rw28),y
	and #$03
	ora #$08
	sta (rw28),y
	lda (rw29),y
	and #$03
	ora #$08
	sta (rw29),y
	lda (rw30),y
	and #$03
	ora #$08
	sta (rw30),y
	lda (rw27),y
	and #$03
	ora #$28
	sta (rw27),y
	lda (rw24),y
	and #$0F
	ora #$20
	sta (rw24),y
	lda (rw25),y
	and #$0F
	ora #$20
	sta (rw25),y
	lda (rw26),y
	and #$0F
	ora #$A0
	sta (rw26),y
	lda (rw31),y
	and #$0F
	ora #$A0
	sta (rw31),y
	jmp FRM5
_1
	jsr DEF1._10

	@@INCRW
	jsr DEF1._11

	lda (rw28),y
	and #$C0
	ora #$22
	sta (rw28),y
	lda (rw29),y
	and #$C0
	ora #$22
	sta (rw29),y
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
	lda (rw27),y
	and #$F0
	ora #$08
	sta (rw27),y
	lda #$82
	sta (rw31),y
	lda #$92
	sta (rw30),y
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
	ora #$28
	sta (rw26),y
	lda (rw31),y
	and #$03
	ora #$A8
	sta (rw31),y
	lda #$02
	sta (rw30),y
	lda #$42
	sta (rw29),y
	lda #$4A
	sta (rw27),y
	lda #$82
	sta (rw28),y
	@@INCRW
	jsr DEF1._13

	jmp FRM5
_2
	jsr DEF1._20

	@@INCRW
	jsr DEF1._21

	lda (rw31),y
	and #$C0
	ora #$20
	sta (rw31),y
	lda (rw30),y
	and #$C0
	ora #$24
	sta (rw30),y
	lda (rw28),y
	and #$F0
	ora #$08
	sta (rw28),y
	lda (rw29),y
	and #$F0
	ora #$08
	sta (rw29),y
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
	lda (rw27),y
	and #$FC
	ora #$02
	sta (rw27),y
	@@INCRW
	jsr DEF1._22

	lda #$02
	sta (rw25),y
	lda #$0A
	sta (rw26),y
	lda #$12
	sta (rw27),y
	lda #$42
	sta (rw24),y
	lda #$80
	sta (rw30),y
	lda #$90
	sta (rw29),y
	lda #$A0
	sta (rw28),y
	lda #$AA
	sta (rw31),y
	@@INCRW
	jsr DEF1._23

	lda (rw27),y
	and #$3F
	ora #$80
	sta (rw27),y
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
	jmp FRM5
_3
	jsr DEF1._30

	@@INCRW
	jsr DEF1._31

	lda (rw31),y
	and #$F0
	ora #$08
	sta (rw31),y
	lda (rw30),y
	and #$F0
	ora #$09
	sta (rw30),y
	lda (rw28),y
	and #$FC
	ora #$02
	sta (rw28),y
	lda (rw29),y
	and #$FC
	ora #$02
	sta (rw29),y
	@@INCRW
	jsr DEF1._32

	lda #$00
	sta (rw25),y
	lda #$10
	sta (rw24),y
	lda #$20
	sta (rw30),y
	lda #$24
	sta (rw29),y
	lda #$28
	sta (rw28),y
	lda #$2A
	sta (rw31),y
	lda #$82
	sta (rw26),y
	lda #$84
	sta (rw27),y
	@@INCRW
	jsr DEF1._33

	lda (rw28),y
	and #$0F
	ora #$20
	sta (rw28),y
	lda (rw29),y
	and #$0F
	ora #$20
	sta (rw29),y
	lda (rw30),y
	and #$0F
	ora #$20
	sta (rw30),y
	lda (rw27),y
	and #$0F
	ora #$A0
	sta (rw27),y
	lda (rw24),y
	and #$3F
	ora #$80
	sta (rw24),y
	lda (rw25),y
	and #$3F
	ora #$80
	sta (rw25),y
	lda (rw26),y
	and #$3F
	ora #$80
	sta (rw26),y
	lda (rw31),y
	and #$3F
	ora #$80
	sta (rw31),y
	jmp FRM5
.end
