
;rw 0..5


.local	ck0

dx0dy0	.local

	lda addx,x
	beq updown
	bpl right

left	ldy #0
	lda (rw0),y
	bne l0
	ldy #1
	lda (rw1),y
	bne l1

	jmp updown

	lda addx,x
	eor #$fe
	sta addx,x

l0	lda #xofset
	bne switchX

l1	lda #xofset
	bne switchX

right	ldy #5
	lda (rw0),y
	bne r0
	ldy #6
	lda(rw1),y
	bne r1

	jmp updown

	lda addx,x
	eor #$fe
	sta addx,x

	adb posx,x #xofset


switchX	add posx,x
	sta posx,x

	lda addx,x
	eor #$fe
	sta addx,x

updown	lda addy,x
	bpl down

up	ldy #2
	lda (rw0),y
	iny
	ora (rw0),y

	beq quit

	lda addy,x
	eor #$fe
	sta addy,x

	adb posy,x #yofset

down	ldy #2
	lda (rw5),y
	iny
	ora (rw5),y

	beq quit

	lda addy,x
	eor #$fe
	sta addy,x

	adb posy,x #yofset

quit	BALL_COLLISION.return

	.endl

.endl
