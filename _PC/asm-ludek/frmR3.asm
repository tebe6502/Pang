.local	frmR3
_0
	jsr DEF0._00

	lda (rw24),y
	and #$C0
	ora #$22
	sta (rw24),y
	lda (rw25),y
	and #$F0
	ora #$08
	sta (rw25),y
	lda (rw26),y
	and #$F0
	ora #$08
	sta (rw26),y
	lda (rw29),y
	and #$F0
	ora #$08
	sta (rw29),y
	lda (rw30),y
	and #$F0
	ora #$08
	sta (rw30),y
	lda (rw31),y
	and #$F0
	ora #$08
	sta (rw31),y
	lda (rw27),y
	and #$F0
	ora #$09
	sta (rw27),y
	lda (rw28),y
	and #$F0
	ora #$09
	sta (rw28),y
	@@INCRW
	jsr DEF0._01

	lda (rw29),y
	and #$03
	ora #$08
	sta (rw29),y
	lda (rw31),y
	and #$03
	ora #$08
	sta (rw31),y
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
	ora #$80
	sta (rw28),y
	lda (rw24),y
	and #$3F
	ora #$80
	sta (rw24),y
	lda #$12
	sta (rw30),y
	@@INCRW
	jsr DEF0._02

	jmp FRM3
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

	lda (rw25),y
	and #$03
	ora #$08
	sta (rw25),y
	lda (rw26),y
	and #$03
	ora #$18
	sta (rw26),y
	lda (rw27),y
	and #$03
	ora #$48
	sta (rw27),y
	lda (rw28),y
	and #$03
	ora #$60
	sta (rw28),y
	lda (rw24),y
	and #$0F
	ora #$A0
	sta (rw24),y
	lda #$02
	sta (rw29),y
	sta (rw31),y
	lda #$04
	sta (rw30),y
	@@INCRW
	jsr DEF0._12

	lda (rw30),y
	and #$3F
	ora #$80
	sta (rw30),y
	@@INCRW
	jsr DEF0._13

	jmp FRM3
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
	ora #$28
	sta (rw24),y
	lda #$80
	sta (rw29),y
	sta (rw31),y
	lda #$81
	sta (rw30),y
	lda #$82
	sta (rw25),y
	lda #$86
	sta (rw26),y
	lda #$92
	sta (rw27),y
	lda #$98
	sta (rw28),y
	@@INCRW
	jsr DEF0._22

	lda (rw30),y
	and #$0F
	ora #$20
	sta (rw30),y
	lda (rw29),y
	and #$3F
	ora #$80
	sta (rw29),y
	lda (rw31),y
	and #$3F
	ora #$80
	sta (rw31),y
	@@INCRW
	jsr DEF0._23

	jmp FRM3
_3
	jsr DEF0._30

	@@INCRW
	jsr DEF0._31

	lda (rw25),y
	and #$C0
	ora #$20
	sta (rw25),y
	lda (rw29),y
	and #$C0
	ora #$20
	sta (rw29),y
	lda (rw30),y
	and #$C0
	ora #$20
	sta (rw30),y
	lda (rw31),y
	and #$C0
	ora #$20
	sta (rw31),y
	lda (rw26),y
	and #$C0
	ora #$21
	sta (rw26),y
	lda (rw27),y
	and #$C0
	ora #$24
	sta (rw27),y
	lda (rw28),y
	and #$C0
	ora #$26
	sta (rw28),y
	lda #$8A
	sta (rw24),y
	@@INCRW
	jsr DEF0._32

	lda (rw29),y
	and #$0F
	ora #$20
	sta (rw29),y
	lda (rw31),y
	and #$0F
	ora #$20
	sta (rw31),y
	lda (rw28),y
	and #$3F
	sta (rw28),y
	lda (rw30),y
	and #$03
	ora #$48
	sta (rw30),y
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
	@@INCRW
	jsr DEF0._33

	jmp FRM3
.end
