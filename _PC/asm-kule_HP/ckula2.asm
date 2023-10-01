	.RELOC

	.extrn rw0 .byte
	.extrn _posx _posy _addx _addy .byte
	.extrn linv48 hinv48 tmul8 .word

	.public ck2.main

.local	ck2
	dta a(dx0_dy0, dx1_dy0, dx2_dy0, dx3_dy0)
	dta a(dx0_dy1, dx1_dy1, dx2_dy1, dx3_dy1)
	dta a(dx0_dy2, dx1_dy2, dx2_dy2, dx3_dy2)
	dta a(dx0_dy3, dx1_dy3, dx2_dy3, dx3_dy3)
	dta a(dx0_dy4, dx1_dy4, dx2_dy4, dx3_dy4)
	dta a(dx0_dy5, dx1_dy5, dx2_dy5, dx3_dy5)
	dta a(dx0_dy6, dx1_dy6, dx2_dy6, dx3_dy6)
	dta a(dx0_dy7, dx1_dy7, dx2_dy7, dx3_dy7)

main	lda _posx
	cmp #240
	scc
	mva #0 _posx

	:2 lsr @

	ldy _posy
	cpy #240
	scc
	mvy #0 _posy

	add linv48,y
	sta rw0
	lda #0
	adc hinv48,y
	sta rw0+1

	tya
	and #7
	tay

	lda _posx
	and #3
	asl @
	ora tmul8,y
	sta _jmp+1

	ldy #0

	lda _addx

_jmp	jmp (ck2)


dx0_dy0	.local

	beq updown
	bpl right
left
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #50
	ora (rw0),y
	ldy #98
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #1
	lda (rw0),y
	beq u1
	lda #8
	bne y
u1
	dey
	lda (rw0),y
	ldy #2
	ora (rw0),y
	beq quit
	lda #6
	bne y
down
	ldy #97
	lda (rw0),y
	beq d1
	lda #-8
	bne y
d1
	dey
	lda (rw0),y
	ldy #98
	ora (rw0),y
	beq quit
	lda #-6

y	add:sta _posy

quit	rts
	.endl

dx1_dy0	.local

	beq updown
	bpl right
left
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #98
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #1
	lda (rw0),y
	ldy #51
	ora (rw0),y
	beq u1
	lda #8
	bne y
u1
	ldy #2
	lda (rw0),y
	beq u2
	lda #7
	bne y
u2
	ldy #0
	lda (rw0),y
	beq quit
	lda #5
	bne y
down
	ldy #97
	lda (rw0),y
	ldy #51
	ora (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #98
	lda (rw0),y
	beq d2
	lda #-7
	bne y
d2
	ldy #96
	lda (rw0),y
	beq quit
	lda #-5

y	add:sta _posy

quit	rts
	.endl

dx2_dy0	.local

	beq updown
	bpl right
left
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #1
	lda (rw0),y
	iny
	ora (rw0),y
	beq u1
	lda #8
	bne y
u1
	ldy #0
	lda (rw0),y
	ldy #3
	ora (rw0),y
	beq quit
	lda #3
	bne y
down
	ldy #97
	lda (rw0),y
	iny
	ora (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #96
	lda (rw0),y
	ldy #99
	ora (rw0),y
	beq quit
	lda #-3

y	add:sta _posy

quit	rts
	.endl

dx3_dy0	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #97
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	ldy #2
	ora (rw0),y
	beq u1
	lda #8
	bne y
u1
	dey
	lda (rw0),y
	beq u2
	lda #7
	bne y
u2
	ldy #3
	lda (rw0),y
	beq quit
	lda #5
	bne y
down
	ldy #48
	lda (rw0),y
	ldy #98
	ora (rw0),y
	beq d1
	lda #-8
	bne y
d1
	dey
	lda (rw0),y
	beq d2
	lda #-7
	bne y
d2
	ldy #99
	lda (rw0),y
	beq quit
	lda #-5

y	add:sta _posy

quit	rts
	.endl

dx0_dy1	.local

	beq updown
	bpl right
left
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #50
	ora (rw0),y
	ldy #98
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #1
	lda (rw0),y
	beq u1
	lda #7
	bne y
u1
	dey
	lda (rw0),y
	ldy #2
	ora (rw0),y
	beq quit
	lda #5
	bne y
down
	ldy #96
	lda (rw0),y
	ldy #98
	ora (rw0),y
	beq d1
	lda #-7
	bne y
d1
	ldy #145
	lda (rw0),y
	beq quit
	lda #-1

y	add:sta _posy

quit	rts
	.endl

dx1_dy1	.local

	beq updown
	bpl right
left
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #1
	lda (rw0),y
	ldy #51
	ora (rw0),y
	beq u1
	lda #7
	bne y
u1
	ldy #2
	lda (rw0),y
	beq u2
	lda #6
	bne y
u2
	ldy #0
	lda (rw0),y
	beq quit
	lda #4
	bne y
down
	ldy #98
	lda (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #96
	lda (rw0),y
	beq d2
	lda #-6
	bne y
d2
	ldy #145
	lda (rw0),y
	ldy #99
	ora (rw0),y
	beq quit
	lda #-1

y	add:sta _posy

quit	rts
	.endl

dx2_dy1	.local

	beq updown
	bpl right
left
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #1
	lda (rw0),y
	iny
	ora (rw0),y
	beq u1
	lda #7
	bne y
u1
	ldy #0
	lda (rw0),y
	ldy #3
	ora (rw0),y
	beq quit
	lda #2
	bne y
down
	ldy #96
	lda (rw0),y
	ldy #99
	ora (rw0),y
	beq d1
	lda #-4
	bne y
d1
	ldy #145
	lda (rw0),y
	iny
	ora (rw0),y
	beq quit
	lda #-1

y	add:sta _posy

quit	rts
	.endl

dx3_dy1	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	ldy #2
	ora (rw0),y
	beq u1
	lda #7
	bne y
u1
	dey
	lda (rw0),y
	beq u2
	lda #6
	bne y
u2
	ldy #3
	lda (rw0),y
	beq quit
	lda #4
	bne y
down
	ldy #97
	lda (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #99
	lda (rw0),y
	beq d2
	lda #-6
	bne y
d2
	ldy #96
	lda (rw0),y
	ldy #146
	ora (rw0),y
	beq quit
	lda #-1

y	add:sta _posy

quit	rts
	.endl

dx0_dy2	.local

	beq updown
	bpl right
left
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #50
	ora (rw0),y
	ldy #98
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #1
	lda (rw0),y
	beq u1
	lda #6
	bne y
u1
	dey
	lda (rw0),y
	ldy #2
	ora (rw0),y
	beq quit
	lda #4
	bne y
down
	ldy #96
	lda (rw0),y
	ldy #98
	ora (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #145
	lda (rw0),y
	beq quit
	lda #-2

y	add:sta _posy

quit	rts
	.endl

dx1_dy2	.local

	beq updown
	bpl right
left
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #1
	lda (rw0),y
	ldy #51
	ora (rw0),y
	beq u1
	lda #6
	bne y
u1
	ldy #2
	lda (rw0),y
	beq u2
	lda #5
	bne y
u2
	ldy #0
	lda (rw0),y
	beq quit
	lda #3
	bne y
down
	ldy #96
	lda (rw0),y
	beq d1
	lda #-7
	bne y
d1
	ldy #145
	lda (rw0),y
	ldy #99
	ora (rw0),y
	beq d2
	lda #-2
	bne y
d2
	ldy #146
	lda (rw0),y
	beq quit
	lda #-1

y	add:sta _posy

quit	rts
	.endl

dx2_dy2	.local

	beq updown
	bpl right
left
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #1
	lda (rw0),y
	iny
	ora (rw0),y
	beq u1
	lda #6
	bne y
u1
	ldy #0
	lda (rw0),y
	ldy #3
	ora (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #96
	lda (rw0),y
	ldy #99
	ora (rw0),y
	beq d1
	lda #-5
	bne y
d1
	ldy #145
	lda (rw0),y
	iny
	ora (rw0),y
	beq quit
	lda #-2

y	add:sta _posy

quit	rts
	.endl

dx3_dy2	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	ldy #2
	ora (rw0),y
	beq u1
	lda #6
	bne y
u1
	dey
	lda (rw0),y
	beq u2
	lda #5
	bne y
u2
	ldy #3
	lda (rw0),y
	beq quit
	lda #3
	bne y
down
	ldy #99
	lda (rw0),y
	beq d1
	lda #-7
	bne y
d1
	ldy #96
	lda (rw0),y
	ldy #146
	ora (rw0),y
	beq d2
	lda #-2
	bne y
d2
	dey
	lda (rw0),y
	beq quit
	lda #-1

y	add:sta _posy

quit	rts
	.endl

dx0_dy3	.local

	beq updown
	bpl right
left
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #50
	ora (rw0),y
	ldy #98
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #1
	lda (rw0),y
	beq u1
	lda #5
	bne y
u1
	dey
	lda (rw0),y
	ldy #2
	ora (rw0),y
	beq quit
	lda #3
	bne y
down
	ldy #145
	lda (rw0),y
	beq d1
	lda #-3
	bne y
d1
	dey
	lda (rw0),y
	ldy #146
	ora (rw0),y
	beq quit
	lda #-1

y	add:sta _posy

quit	rts
	.endl

dx1_dy3	.local

	beq updown
	bpl right
left
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #1
	lda (rw0),y
	ldy #51
	ora (rw0),y
	beq u1
	lda #5
	bne y
u1
	ldy #2
	lda (rw0),y
	beq u2
	lda #4
	bne y
u2
	ldy #0
	lda (rw0),y
	beq quit
	lda #2
	bne y
down
	ldy #96
	lda (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #145
	lda (rw0),y
	ldy #99
	ora (rw0),y
	beq d2
	lda #-3
	bne y
d2
	ldy #146
	lda (rw0),y
	beq quit
	lda #-2

y	add:sta _posy

quit	rts
	.endl

dx2_dy3	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	ldy #51
	ora (rw0),y
	beq u1
	lda #8
	bne y
u1
	ldy #1
	lda (rw0),y
	iny
	ora (rw0),y
	beq quit
	lda #5
	bne y
down
	ldy #96
	lda (rw0),y
	ldy #99
	ora (rw0),y
	beq d1
	lda #-6
	bne y
d1
	ldy #145
	lda (rw0),y
	iny
	ora (rw0),y
	beq quit
	lda #-3

y	add:sta _posy

quit	rts
	.endl

dx3_dy3	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	ldy #2
	ora (rw0),y
	beq u1
	lda #5
	bne y
u1
	dey
	lda (rw0),y
	beq u2
	lda #4
	bne y
u2
	ldy #3
	lda (rw0),y
	beq quit
	lda #2
	bne y
down
	ldy #99
	lda (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #96
	lda (rw0),y
	ldy #146
	ora (rw0),y
	beq d2
	lda #-3
	bne y
d2
	dey
	lda (rw0),y
	beq quit
	lda #-2

y	add:sta _posy

quit	rts
	.endl

dx0_dy4	.local

	beq updown
	bpl right
left
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #50
	ora (rw0),y
	ldy #98
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #1
	lda (rw0),y
	beq u1
	lda #4
	bne y
u1
	dey
	lda (rw0),y
	ldy #2
	ora (rw0),y
	beq quit
	lda #2
	bne y
down
	ldy #145
	lda (rw0),y
	beq d1
	lda #-4
	bne y
d1
	dey
	lda (rw0),y
	ldy #146
	ora (rw0),y
	beq quit
	lda #-2

y	add:sta _posy

quit	rts
	.endl

dx1_dy4	.local

	beq updown
	bpl right
left
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #1
	lda (rw0),y
	ldy #51
	ora (rw0),y
	beq u1
	lda #4
	bne y
u1
	ldy #2
	lda (rw0),y
	beq u2
	lda #3
	bne y
u2
	ldy #0
	lda (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #145
	lda (rw0),y
	ldy #99
	ora (rw0),y
	beq d1
	lda #-4
	bne y
d1
	ldy #146
	lda (rw0),y
	beq d2
	lda #-3
	bne y
d2
	ldy #144
	lda (rw0),y
	beq quit
	lda #-1

y	add:sta _posy

quit	rts
	.endl

dx2_dy4	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	ldy #51
	ora (rw0),y
	beq u1
	lda #7
	bne y
u1
	ldy #1
	lda (rw0),y
	iny
	ora (rw0),y
	beq quit
	lda #4
	bne y
down
	ldy #96
	lda (rw0),y
	ldy #99
	ora (rw0),y
	beq d1
	lda #-7
	bne y
d1
	ldy #145
	lda (rw0),y
	iny
	ora (rw0),y
	beq quit
	lda #-4

y	add:sta _posy

quit	rts
	.endl

dx3_dy4	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #147
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	ldy #2
	ora (rw0),y
	beq u1
	lda #4
	bne y
u1
	dey
	lda (rw0),y
	beq u2
	lda #3
	bne y
u2
	ldy #3
	lda (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #96
	lda (rw0),y
	ldy #146
	ora (rw0),y
	beq d1
	lda #-4
	bne y
d1
	dey
	lda (rw0),y
	beq d2
	lda #-3
	bne y
d2
	ldy #147
	lda (rw0),y
	beq quit
	lda #-1

y	add:sta _posy

quit	rts
	.endl

dx0_dy5	.local

	beq updown
	bpl right
left
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #50
	ora (rw0),y
	ldy #98
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #1
	lda (rw0),y
	beq u1
	lda #3
	bne y
u1
	dey
	lda (rw0),y
	ldy #2
	ora (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #145
	lda (rw0),y
	beq d1
	lda #-5
	bne y
d1
	dey
	lda (rw0),y
	ldy #146
	ora (rw0),y
	beq quit
	lda #-3

y	add:sta _posy

quit	rts
	.endl

dx1_dy5	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	beq u1
	lda #8
	bne y
u1
	ldy #1
	lda (rw0),y
	ldy #51
	ora (rw0),y
	beq u2
	lda #3
	bne y
u2
	ldy #2
	lda (rw0),y
	beq quit
	lda #2
	bne y
down
	ldy #145
	lda (rw0),y
	ldy #99
	ora (rw0),y
	beq d1
	lda #-5
	bne y
d1
	ldy #146
	lda (rw0),y
	beq d2
	lda #-4
	bne y
d2
	ldy #144
	lda (rw0),y
	beq quit
	lda #-2

y	add:sta _posy

quit	rts
	.endl

dx2_dy5	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	ldy #51
	ora (rw0),y
	beq u1
	lda #6
	bne y
u1
	ldy #1
	lda (rw0),y
	iny
	ora (rw0),y
	beq quit
	lda #3
	bne y
down
	ldy #96
	lda (rw0),y
	ldy #99
	ora (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #145
	lda (rw0),y
	iny
	ora (rw0),y
	beq quit
	lda #-5

y	add:sta _posy

quit	rts
	.endl

dx3_dy5	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #147
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #51
	lda (rw0),y
	beq u1
	lda #8
	bne y
u1
	ldy #48
	lda (rw0),y
	ldy #2
	ora (rw0),y
	beq u2
	lda #3
	bne y
u2
	dey
	lda (rw0),y
	beq quit
	lda #2
	bne y
down
	ldy #96
	lda (rw0),y
	ldy #146
	ora (rw0),y
	beq d1
	lda #-5
	bne y
d1
	dey
	lda (rw0),y
	beq d2
	lda #-4
	bne y
d2
	ldy #147
	lda (rw0),y
	beq quit
	lda #-2

y	add:sta _posy

quit	rts
	.endl

dx0_dy6	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	iny
	lda (rw0),y
	ldy #50
	ora (rw0),y
	ldy #98
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	ldy #50
	ora (rw0),y
	beq u1
	lda #8
	bne y
u1
	ldy #1
	lda (rw0),y
	beq quit
	lda #2
	bne y
down
	ldy #145
	lda (rw0),y
	beq d1
	lda #-6
	bne y
d1
	dey
	lda (rw0),y
	ldy #146
	ora (rw0),y
	beq quit
	lda #-4

y	add:sta _posy

quit	rts
	.endl

dx1_dy6	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	beq u1
	lda #7
	bne y
u1
	ldy #1
	lda (rw0),y
	ldy #51
	ora (rw0),y
	beq u2
	lda #2
	bne y
u2
	ldy #2
	lda (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #145
	lda (rw0),y
	ldy #99
	ora (rw0),y
	beq d1
	lda #-6
	bne y
d1
	ldy #146
	lda (rw0),y
	beq d2
	lda #-5
	bne y
d2
	ldy #144
	lda (rw0),y
	beq quit
	lda #-3

y	add:sta _posy

quit	rts
	.endl

dx2_dy6	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #147
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	ldy #51
	ora (rw0),y
	beq u1
	lda #5
	bne y
u1
	ldy #1
	lda (rw0),y
	iny
	ora (rw0),y
	beq quit
	lda #2
	bne y
down
	ldy #145
	lda (rw0),y
	iny
	ora (rw0),y
	beq d1
	lda #-6
	bne y
d1
	ldy #144
	lda (rw0),y
	ldy #147
	ora (rw0),y
	beq quit
	lda #-1

y	add:sta _posy

quit	rts
	.endl

dx3_dy6	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #147
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #51
	lda (rw0),y
	beq u1
	lda #7
	bne y
u1
	ldy #48
	lda (rw0),y
	ldy #2
	ora (rw0),y
	beq u2
	lda #2
	bne y
u2
	dey
	lda (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #96
	lda (rw0),y
	ldy #146
	ora (rw0),y
	beq d1
	lda #-6
	bne y
d1
	dey
	lda (rw0),y
	beq d2
	lda #-5
	bne y
d2
	ldy #147
	lda (rw0),y
	beq quit
	lda #-3

y	add:sta _posy

quit	rts
	.endl

dx0_dy7	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	iny
	lda (rw0),y
	ldy #50
	ora (rw0),y
	ldy #98
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	ldy #50
	ora (rw0),y
	beq u1
	lda #7
	bne y
u1
	ldy #1
	lda (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #145
	lda (rw0),y
	beq d1
	lda #-7
	bne y
d1
	dey
	lda (rw0),y
	ldy #146
	ora (rw0),y
	beq quit
	lda #-5

y	add:sta _posy

quit	rts
	.endl

dx1_dy7	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	iny
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #146
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #50
	lda (rw0),y
	beq u1
	lda #8
	bne y
u1
	ldy #48
	lda (rw0),y
	beq u2
	lda #6
	bne y
u2
	ldy #1
	lda (rw0),y
	ldy #51
	ora (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #145
	lda (rw0),y
	ldy #99
	ora (rw0),y
	beq d1
	lda #-7
	bne y
d1
	ldy #146
	lda (rw0),y
	beq d2
	lda #-6
	bne y
d2
	ldy #144
	lda (rw0),y
	beq quit
	lda #-4

y	add:sta _posy

quit	rts
	.endl

dx2_dy7	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #147
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	ldy #51
	ora (rw0),y
	beq u1
	lda #4
	bne y
u1
	ldy #1
	lda (rw0),y
	iny
	ora (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #145
	lda (rw0),y
	iny
	ora (rw0),y
	beq d1
	lda #-7
	bne y
d1
	ldy #144
	lda (rw0),y
	ldy #147
	ora (rw0),y
	beq quit
	lda #-2

y	add:sta _posy

quit	rts
	.endl

dx3_dy7	.local

	beq updown
	bpl right
left
	ldy #2
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #145
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #51
	ora (rw0),y
	ldy #99
	ora (rw0),y
	ldy #147
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #49
	lda (rw0),y
	beq u1
	lda #8
	bne y
u1
	ldy #51
	lda (rw0),y
	beq u2
	lda #6
	bne y
u2
	ldy #48
	lda (rw0),y
	ldy #2
	ora (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #96
	lda (rw0),y
	ldy #146
	ora (rw0),y
	beq d1
	lda #-7
	bne y
d1
	dey
	lda (rw0),y
	beq d2
	lda #-6
	bne y
d2
	ldy #147
	lda (rw0),y
	beq quit
	lda #-4

y	add:sta _posy

quit	rts
	.endl
.endl

.print .len ck2
