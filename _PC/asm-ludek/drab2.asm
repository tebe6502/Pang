.local	drab2
_0
	lda (rw3),y
	and #$C0
	ora #$20
	sta (rw3),y
	lda (rw4),y
	and #$C0
	ora #$20
	sta (rw4),y
	lda (rw12),y
	and #$C0
	ora #$20
	sta (rw12),y
	lda (rw13),y
	and #$C0
	ora #$20
	sta (rw13),y
	lda (rw16),y
	and #$C0
	ora #$20
	sta (rw16),y
	lda (rw20),y
	and #$C0
	ora #$20
	sta (rw20),y
	lda (rw21),y
	and #$C0
	ora #$20
	sta (rw21),y
	lda (rw22),y
	and #$C0
	ora #$20
	sta (rw22),y
	lda (rw24),y
	and #$C0
	ora #$20
	sta (rw24),y
	lda (rw25),y
	and #$C0
	ora #$20
	sta (rw25),y
	lda (rw30),y
	and #$C0
	ora #$20
	sta (rw30),y
	lda (rw31),y
	and #$C0
	ora #$20
	sta (rw31),y
	lda (rw2),y
	and #$F0
	ora #$08
	sta (rw2),y
	lda (rw14),y
	and #$F0
	ora #$08
	sta (rw14),y
	lda (rw23),y
	and #$F0
	ora #$08
	sta (rw23),y
	lda (rw26),y
	and #$F0
	ora #$08
	sta (rw26),y
	lda (rw27),y
	and #$F0
	ora #$08
	sta (rw27),y
	lda (rw29),y
	and #$F0
	ora #$08
	sta (rw29),y
	lda (rw28),y
	and #$F0
	ora #$09
	sta (rw28),y
	lda (rw15),y
	and #$F0
	ora #$0A
	sta (rw15),y
	lda (rw1),y
	and #$FC
	ora #$02
	sta (rw1),y
	lda #$80
	sta (rw5),y
	sta (rw6),y
	sta (rw7),y
	sta (rw8),y
	sta (rw9),y
	sta (rw10),y
	sta (rw11),y
	sta (rw17),y
	sta (rw19),y
	lda #$81
	sta (rw18),y
	@@INCRW
	lda (rw31),y
	and #$0F
	ora #$20
	sta (rw31),y
	lda #$00
	sta (rw1),y
	sta (rw2),y
	sta (rw3),y
	sta (rw4),y
	sta (rw5),y
	sta (rw6),y
	sta (rw12),y
	sta (rw15),y
	sta (rw16),y
	sta (rw17),y
	sta (rw21),y
	sta (rw22),y
	sta (rw24),y
	lda #$04
	sta (rw7),y
	sta (rw11),y
	lda #$08
	sta (rw23),y
	lda #$0A
	sta (rw30),y
	lda #$10
	sta (rw19),y
	lda #$11
	sta (rw8),y
	sta (rw20),y
	lda #$14
	sta (rw14),y
	lda #$15
	sta (rw10),y
	lda #$20
	sta (rw28),y
	lda #$28
	sta (rw26),y
	sta (rw27),y
	lda #$41
	sta (rw18),y
	lda #$44
	sta (rw9),y
	lda #$48
	sta (rw25),y
	lda #$55
	sta (rw13),y
	lda #$68
	sta (rw29),y
	lda #$AA
	sta (rw0),y
	@@INCRW
	lda (rw3),y
	and #$03
	ora #$08
	sta (rw3),y
	lda (rw4),y
	and #$03
	ora #$08
	sta (rw4),y
	lda (rw12),y
	and #$03
	ora #$08
	sta (rw12),y
	lda (rw13),y
	and #$03
	ora #$08
	sta (rw13),y
	lda (rw16),y
	and #$03
	ora #$08
	sta (rw16),y
	lda (rw20),y
	and #$03
	ora #$08
	sta (rw20),y
	lda (rw21),y
	and #$03
	ora #$08
	sta (rw21),y
	lda (rw23),y
	and #$03
	ora #$08
	sta (rw23),y
	lda (rw24),y
	and #$03
	ora #$08
	sta (rw24),y
	lda (rw29),y
	and #$03
	ora #$08
	sta (rw29),y
	lda (rw2),y
	and #$0F
	ora #$20
	sta (rw2),y
	lda (rw14),y
	and #$0F
	ora #$20
	sta (rw14),y
	lda (rw22),y
	and #$0F
	ora #$20
	sta (rw22),y
	lda (rw26),y
	and #$0F
	ora #$20
	sta (rw26),y
	lda (rw27),y
	and #$0F
	ora #$20
	sta (rw27),y
	lda (rw25),y
	and #$03
	ora #$48
	sta (rw25),y
	lda (rw28),y
	and #$03
	ora #$48
	sta (rw28),y
	lda (rw15),y
	and #$0F
	ora #$A0
	sta (rw15),y
	lda (rw30),y
	and #$0F
	ora #$A0
	sta (rw30),y
	lda (rw1),y
	and #$3F
	ora #$80
	sta (rw1),y
	lda #$02
	sta (rw5),y
	sta (rw6),y
	sta (rw7),y
	sta (rw8),y
	sta (rw9),y
	sta (rw10),y
	sta (rw11),y
	sta (rw17),y
	sta (rw19),y
	lda #$42
	sta (rw18),y
	jmp pm_drab2
.end