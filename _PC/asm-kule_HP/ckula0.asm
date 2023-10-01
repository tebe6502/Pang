	.RELOC

	.extrn rw0 .byte
	.extrn _posx _posy _addx _addy .byte
	.extrn linv48 hinv48 tmul8 .word

	.public ck0.main

.local	ck0
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

_jmp	jmp (ck0)


dx0_dy0	.local

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
	ldy #192
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #4
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #100
	ora (rw0),y
	ldy #148
	ora (rw0),y
	ldy #196
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #2
	lda (rw0),y
	beq u1
	lda #8
	bne y
u1
	dey
	lda (rw0),y
	ldy #3
	ora (rw0),y
	beq u2
	lda #7
	bne y
u2
	ldy #0
	lda (rw0),y
	ldy #4
	ora (rw0),y
	beq quit
	lda #2
	bne y
down
	ldy #194
	lda (rw0),y
	beq d1
	lda #-8
	bne y
d1
	dey
	lda (rw0),y
	ldy #195
	ora (rw0),y
	beq d2
	lda #-7
	bne y
d2
	ldy #192
	lda (rw0),y
	ldy #196
	ora (rw0),y
	beq quit
	lda #-2

y	add:sta _posy

quit	rts
	.endl

dx1_dy0	.local

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
	ldy #193
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #4
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #148
	ora (rw0),y
	ldy #196
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
	ldy #101
	ora (rw0),y
	beq u1
	lda #8
	bne y
u1
	ldy #3
	lda (rw0),y
	beq u2
	lda #7
	bne y
u2
	ldy #1
	lda (rw0),y
	beq u3
	lda #6
	bne y
u3
	ldy #4
	lda (rw0),y
	beq quit
	lda #4
	bne y
down
	ldy #144
	lda (rw0),y
	ldy #194
	ora (rw0),y
	ldy #101
	ora (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #195
	lda (rw0),y
	beq d2
	lda #-7
	bne y
d2
	ldy #193
	lda (rw0),y
	beq d3
	lda #-6
	bne y
d3
	ldy #196
	lda (rw0),y
	beq quit
	lda #-4

y	add:sta _posy

quit	rts
	.endl

dx2_dy0	.local

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
	ldy #193
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #4
	lda (rw0),y
	ldy #53
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #196
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #2
	lda (rw0),y
	iny
	ora (rw0),y
	beq u1
	lda #8
	bne y
u1
	ldy #48
	lda (rw0),y
	ldy #1
	ora (rw0),y
	ldy #4
	ora (rw0),y
	ldy #53
	ora (rw0),y
	beq quit
	lda #5
	bne y
down
	ldy #194
	lda (rw0),y
	iny
	ora (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #144
	lda (rw0),y
	ldy #193
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #149
	ora (rw0),y
	beq quit
	lda #-5

y	add:sta _posy

quit	rts
	.endl

dx3_dy0	.local

	beq updown
	bpl right
left
	iny
	lda (rw0),y
	ldy #49
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #145
	ora (rw0),y
	ldy #193
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #4
	lda (rw0),y
	ldy #53
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #196
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #96
	lda (rw0),y
	ldy #3
	ora (rw0),y
	ldy #53
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
	ldy #4
	lda (rw0),y
	beq u3
	lda #6
	bne y
u3
	ldy #1
	lda (rw0),y
	beq quit
	lda #4
	bne y
down
	ldy #96
	lda (rw0),y
	ldy #195
	ora (rw0),y
	ldy #149
	ora (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #194
	lda (rw0),y
	beq d2
	lda #-7
	bne y
d2
	ldy #196
	lda (rw0),y
	beq d3
	lda #-6
	bne y
d3
	ldy #193
	lda (rw0),y
	beq quit
	lda #-4

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
	ldy #144
	ora (rw0),y
	ldy #192
	ora (rw0),y
	ldy #242
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #4
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #100
	ora (rw0),y
	ldy #148
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #242
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #2
	lda (rw0),y
	beq u1
	lda #7
	bne y
u1
	dey
	lda (rw0),y
	ldy #3
	ora (rw0),y
	beq u2
	lda #6
	bne y
u2
	ldy #0
	lda (rw0),y
	ldy #4
	ora (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #193
	lda (rw0),y
	ldy #195
	ora (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #192
	lda (rw0),y
	ldy #196
	ora (rw0),y
	beq d2
	lda #-3
	bne y
d2
	ldy #242
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
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #192
	ora (rw0),y
	ldy #242
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #4
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #242
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
	ldy #101
	ora (rw0),y
	beq u1
	lda #7
	bne y
u1
	ldy #3
	lda (rw0),y
	beq u2
	lda #6
	bne y
u2
	ldy #1
	lda (rw0),y
	beq u3
	lda #5
	bne y
u3
	ldy #4
	lda (rw0),y
	beq quit
	lda #3
	bne y
down
	ldy #195
	lda (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #193
	lda (rw0),y
	beq d2
	lda #-7
	bne y
d2
	ldy #196
	lda (rw0),y
	beq d3
	lda #-5
	bne y
d3
	ldy #192
	lda (rw0),y
	ldy #242
	ora (rw0),y
	ldy #149
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
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #193
	ora (rw0),y
	ldy #242
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #4
	lda (rw0),y
	ldy #53
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #243
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #2
	lda (rw0),y
	iny
	ora (rw0),y
	beq u1
	lda #7
	bne y
u1
	ldy #48
	lda (rw0),y
	ldy #1
	ora (rw0),y
	ldy #4
	ora (rw0),y
	ldy #53
	ora (rw0),y
	beq quit
	lda #4
	bne y
down
	ldy #144
	lda (rw0),y
	ldy #193
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #149
	ora (rw0),y
	beq d1
	lda #-6
	bne y
d1
	ldy #242
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
	ldy #49
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #193
	ora (rw0),y
	ldy #243
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #4
	lda (rw0),y
	ldy #53
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #197
	ora (rw0),y
	ldy #243
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #96
	lda (rw0),y
	ldy #3
	ora (rw0),y
	ldy #53
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
	ldy #4
	lda (rw0),y
	beq u3
	lda #5
	bne y
u3
	ldy #1
	lda (rw0),y
	beq quit
	lda #3
	bne y
down
	ldy #194
	lda (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #196
	lda (rw0),y
	beq d2
	lda #-7
	bne y
d2
	ldy #193
	lda (rw0),y
	beq d3
	lda #-5
	bne y
d3
	ldy #144
	lda (rw0),y
	ldy #243
	ora (rw0),y
	ldy #197
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
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #192
	ora (rw0),y
	ldy #241
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #100
	ora (rw0),y
	ldy #148
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #243
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	ldy #52
	ora (rw0),y
	beq u1
	lda #8
	bne y
u1
	ldy #2
	lda (rw0),y
	beq u2
	lda #6
	bne y
u2
	dey
	lda (rw0),y
	ldy #3
	ora (rw0),y
	beq quit
	lda #5
	bne y
down
	ldy #192
	lda (rw0),y
	ldy #196
	ora (rw0),y
	beq d1
	lda #-4
	bne y
d1
	ldy #242
	lda (rw0),y
	beq d2
	lda #-2
	bne y
d2
	dey
	lda (rw0),y
	ldy #243
	ora (rw0),y
	beq quit
	lda #-1

y	add:sta _posy

quit	rts
	.endl

dx1_dy2	.local

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
	ldy #192
	ora (rw0),y
	ldy #242
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #4
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #243
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
	ldy #101
	ora (rw0),y
	beq u1
	lda #6
	bne y
u1
	ldy #3
	lda (rw0),y
	beq u2
	lda #5
	bne y
u2
	ldy #1
	lda (rw0),y
	beq u3
	lda #4
	bne y
u3
	ldy #4
	lda (rw0),y
	beq quit
	lda #2
	bne y
down
	ldy #193
	lda (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #196
	lda (rw0),y
	beq d2
	lda #-6
	bne y
d2
	ldy #192
	lda (rw0),y
	ldy #242
	ora (rw0),y
	ldy #149
	ora (rw0),y
	beq d3
	lda #-2
	bne y
d3
	ldy #243
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
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #193
	ora (rw0),y
	ldy #242
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #4
	lda (rw0),y
	ldy #53
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #243
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #2
	lda (rw0),y
	iny
	ora (rw0),y
	beq u1
	lda #6
	bne y
u1
	ldy #48
	lda (rw0),y
	ldy #1
	ora (rw0),y
	ldy #4
	ora (rw0),y
	ldy #53
	ora (rw0),y
	beq quit
	lda #3
	bne y
down
	ldy #144
	lda (rw0),y
	ldy #193
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #149
	ora (rw0),y
	beq d1
	lda #-7
	bne y
d1
	ldy #242
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
	ldy #49
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #193
	ora (rw0),y
	ldy #242
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #4
	lda (rw0),y
	ldy #53
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #197
	ora (rw0),y
	ldy #243
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #96
	lda (rw0),y
	ldy #3
	ora (rw0),y
	ldy #53
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
	ldy #4
	lda (rw0),y
	beq u3
	lda #4
	bne y
u3
	ldy #1
	lda (rw0),y
	beq quit
	lda #2
	bne y
down
	ldy #196
	lda (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #193
	lda (rw0),y
	beq d2
	lda #-6
	bne y
d2
	ldy #144
	lda (rw0),y
	ldy #243
	ora (rw0),y
	ldy #197
	ora (rw0),y
	beq d3
	lda #-2
	bne y
d3
	ldy #242
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
	iny
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #192
	ora (rw0),y
	ldy #241
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #100
	ora (rw0),y
	ldy #148
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #243
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	ldy #52
	ora (rw0),y
	beq u1
	lda #7
	bne y
u1
	ldy #2
	lda (rw0),y
	beq u2
	lda #5
	bne y
u2
	dey
	lda (rw0),y
	ldy #3
	ora (rw0),y
	beq quit
	lda #4
	bne y
down
	ldy #192
	lda (rw0),y
	ldy #196
	ora (rw0),y
	beq d1
	lda #-5
	bne y
d1
	ldy #242
	lda (rw0),y
	beq d2
	lda #-3
	bne y
d2
	dey
	lda (rw0),y
	ldy #243
	ora (rw0),y
	beq quit
	lda #-2

y	add:sta _posy

quit	rts
	.endl

dx1_dy3	.local

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
	ldy #192
	ora (rw0),y
	ldy #241
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #4
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #243
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
	ldy #101
	ora (rw0),y
	beq u1
	lda #5
	bne y
u1
	ldy #3
	lda (rw0),y
	beq u2
	lda #4
	bne y
u2
	ldy #1
	lda (rw0),y
	beq u3
	lda #3
	bne y
u3
	ldy #4
	lda (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #196
	lda (rw0),y
	beq d1
	lda #-7
	bne y
d1
	ldy #192
	lda (rw0),y
	ldy #242
	ora (rw0),y
	ldy #149
	ora (rw0),y
	beq d2
	lda #-3
	bne y
d2
	ldy #243
	lda (rw0),y
	beq d3
	lda #-2
	bne y
d3
	ldy #241
	lda (rw0),y
	beq quit
	lda #-1

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
	ldy #144
	ora (rw0),y
	ldy #193
	ora (rw0),y
	ldy #242
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #4
	lda (rw0),y
	ldy #53
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #243
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #2
	lda (rw0),y
	iny
	ora (rw0),y
	beq u1
	lda #5
	bne y
u1
	ldy #48
	lda (rw0),y
	ldy #1
	ora (rw0),y
	ldy #4
	ora (rw0),y
	ldy #53
	ora (rw0),y
	beq quit
	lda #2
	bne y
down
	ldy #144
	lda (rw0),y
	ldy #193
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #149
	ora (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #242
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
	ldy #49
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #193
	ora (rw0),y
	ldy #242
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #4
	lda (rw0),y
	ldy #53
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #197
	ora (rw0),y
	ldy #244
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #96
	lda (rw0),y
	ldy #3
	ora (rw0),y
	ldy #53
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
	ldy #4
	lda (rw0),y
	beq u3
	lda #3
	bne y
u3
	ldy #1
	lda (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #193
	lda (rw0),y
	beq d1
	lda #-7
	bne y
d1
	ldy #144
	lda (rw0),y
	ldy #243
	ora (rw0),y
	ldy #197
	ora (rw0),y
	beq d2
	lda #-3
	bne y
d2
	ldy #242
	lda (rw0),y
	beq d3
	lda #-2
	bne y
d3
	ldy #244
	lda (rw0),y
	beq quit
	lda #-1

y	add:sta _posy

quit	rts
	.endl

dx0_dy4	.local

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
	ldy #192
	ora (rw0),y
	ldy #241
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #100
	ora (rw0),y
	ldy #148
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #243
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	ldy #52
	ora (rw0),y
	beq u1
	lda #6
	bne y
u1
	ldy #2
	lda (rw0),y
	beq u2
	lda #4
	bne y
u2
	dey
	lda (rw0),y
	ldy #3
	ora (rw0),y
	beq quit
	lda #3
	bne y
down
	ldy #192
	lda (rw0),y
	ldy #196
	ora (rw0),y
	beq d1
	lda #-6
	bne y
d1
	ldy #242
	lda (rw0),y
	beq d2
	lda #-4
	bne y
d2
	dey
	lda (rw0),y
	ldy #243
	ora (rw0),y
	beq quit
	lda #-3

y	add:sta _posy

quit	rts
	.endl

dx1_dy4	.local

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
	ldy #192
	ora (rw0),y
	ldy #241
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #243
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #52
	lda (rw0),y
	beq u1
	lda #8
	bne y
u1
	ldy #48
	lda (rw0),y
	ldy #2
	ora (rw0),y
	ldy #101
	ora (rw0),y
	beq u2
	lda #4
	bne y
u2
	ldy #3
	lda (rw0),y
	beq u3
	lda #3
	bne y
u3
	ldy #1
	lda (rw0),y
	beq quit
	lda #2
	bne y
down
	ldy #196
	lda (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #192
	lda (rw0),y
	ldy #242
	ora (rw0),y
	ldy #149
	ora (rw0),y
	beq d2
	lda #-4
	bne y
d2
	ldy #243
	lda (rw0),y
	beq d3
	lda #-3
	bne y
d3
	ldy #241
	lda (rw0),y
	beq quit
	lda #-2

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
	ldy #144
	ora (rw0),y
	ldy #192
	ora (rw0),y
	ldy #241
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #4
	lda (rw0),y
	ldy #53
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #197
	ora (rw0),y
	ldy #244
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #2
	lda (rw0),y
	iny
	ora (rw0),y
	beq u1
	lda #4
	bne y
u1
	ldy #48
	lda (rw0),y
	ldy #1
	ora (rw0),y
	ldy #4
	ora (rw0),y
	ldy #53
	ora (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #242
	lda (rw0),y
	iny
	ora (rw0),y
	beq d1
	lda #-4
	bne y
d1
	ldy #192
	lda (rw0),y
	ldy #241
	ora (rw0),y
	ldy #244
	ora (rw0),y
	ldy #197
	ora (rw0),y
	beq quit
	lda #-1

y	add:sta _posy

quit	rts
	.endl

dx3_dy4	.local

	beq updown
	bpl right
left
	ldy #2
	lda (rw0),y
	ldy #49
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #193
	ora (rw0),y
	ldy #242
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #4
	lda (rw0),y
	ldy #53
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #197
	ora (rw0),y
	ldy #244
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
	ldy #96
	lda (rw0),y
	ldy #3
	ora (rw0),y
	ldy #53
	ora (rw0),y
	beq u2
	lda #4
	bne y
u2
	ldy #2
	lda (rw0),y
	beq u3
	lda #3
	bne y
u3
	ldy #4
	lda (rw0),y
	beq quit
	lda #2
	bne y
down
	ldy #193
	lda (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #144
	lda (rw0),y
	ldy #243
	ora (rw0),y
	ldy #197
	ora (rw0),y
	beq d2
	lda #-4
	bne y
d2
	ldy #242
	lda (rw0),y
	beq d3
	lda #-3
	bne y
d3
	ldy #244
	lda (rw0),y
	beq quit
	lda #-2

y	add:sta _posy

quit	rts
	.endl

dx0_dy5	.local

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
	ldy #192
	ora (rw0),y
	ldy #241
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #100
	ora (rw0),y
	ldy #148
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #243
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	ldy #52
	ora (rw0),y
	beq u1
	lda #5
	bne y
u1
	ldy #2
	lda (rw0),y
	beq u2
	lda #3
	bne y
u2
	dey
	lda (rw0),y
	ldy #3
	ora (rw0),y
	beq quit
	lda #2
	bne y
down
	ldy #192
	lda (rw0),y
	ldy #196
	ora (rw0),y
	beq d1
	lda #-7
	bne y
d1
	ldy #242
	lda (rw0),y
	beq d2
	lda #-5
	bne y
d2
	dey
	lda (rw0),y
	ldy #243
	ora (rw0),y
	beq quit
	lda #-4

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
	ldy #192
	ora (rw0),y
	ldy #241
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #244
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #52
	lda (rw0),y
	beq u1
	lda #7
	bne y
u1
	ldy #48
	lda (rw0),y
	ldy #2
	ora (rw0),y
	ldy #101
	ora (rw0),y
	beq u2
	lda #3
	bne y
u2
	ldy #3
	lda (rw0),y
	beq u3
	lda #2
	bne y
u3
	ldy #1
	lda (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #192
	lda (rw0),y
	ldy #242
	ora (rw0),y
	ldy #149
	ora (rw0),y
	beq d1
	lda #-5
	bne y
d1
	ldy #243
	lda (rw0),y
	beq d2
	lda #-4
	bne y
d2
	ldy #241
	lda (rw0),y
	beq d3
	lda #-3
	bne y
d3
	ldy #244
	lda (rw0),y
	beq quit
	lda #-1

y	add:sta _posy

quit	rts
	.endl

dx2_dy5	.local

	beq updown
	bpl right
left
	ldy #2
	lda (rw0),y
	ldy #49
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #192
	ora (rw0),y
	ldy #241
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #197
	ora (rw0),y
	ldy #244
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #96
	lda (rw0),y
	ldy #49
	ora (rw0),y
	ldy #52
	ora (rw0),y
	ldy #101
	ora (rw0),y
	beq u1
	lda #8
	bne y
u1
	ldy #2
	lda (rw0),y
	iny
	ora (rw0),y
	beq quit
	lda #3
	bne y
down
	ldy #242
	lda (rw0),y
	iny
	ora (rw0),y
	beq d1
	lda #-5
	bne y
d1
	ldy #192
	lda (rw0),y
	ldy #241
	ora (rw0),y
	ldy #244
	ora (rw0),y
	ldy #197
	ora (rw0),y
	beq quit
	lda #-2

y	add:sta _posy

quit	rts
	.endl

dx3_dy5	.local

	beq updown
	bpl right
left
	ldy #2
	lda (rw0),y
	ldy #49
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #193
	ora (rw0),y
	ldy #241
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #4
	lda (rw0),y
	ldy #53
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #197
	ora (rw0),y
	ldy #244
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
	lda #7
	bne y
u1
	ldy #96
	lda (rw0),y
	ldy #3
	ora (rw0),y
	ldy #53
	ora (rw0),y
	beq u2
	lda #3
	bne y
u2
	ldy #2
	lda (rw0),y
	beq u3
	lda #2
	bne y
u3
	ldy #4
	lda (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #144
	lda (rw0),y
	ldy #243
	ora (rw0),y
	ldy #197
	ora (rw0),y
	beq d1
	lda #-5
	bne y
d1
	ldy #242
	lda (rw0),y
	beq d2
	lda #-4
	bne y
d2
	ldy #244
	lda (rw0),y
	beq d3
	lda #-3
	bne y
d3
	ldy #241
	lda (rw0),y
	beq quit
	lda #-1

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
	ldy #192
	ora (rw0),y
	ldy #241
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #100
	ora (rw0),y
	ldy #148
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #243
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #48
	lda (rw0),y
	ldy #52
	ora (rw0),y
	beq u1
	lda #4
	bne y
u1
	ldy #2
	lda (rw0),y
	beq u2
	lda #2
	bne y
u2
	dey
	lda (rw0),y
	ldy #3
	ora (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #192
	lda (rw0),y
	ldy #196
	ora (rw0),y
	beq d1
	lda #-8
	bne y
d1
	ldy #242
	lda (rw0),y
	beq d2
	lda #-6
	bne y
d2
	dey
	lda (rw0),y
	ldy #243
	ora (rw0),y
	beq quit
	lda #-5

y	add:sta _posy

quit	rts
	.endl

dx1_dy6	.local

	beq updown
	bpl right
left
	ldy #2
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #192
	ora (rw0),y
	ldy #241
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #244
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
	ldy #52
	lda (rw0),y
	beq u2
	lda #6
	bne y
u2
	ldy #48
	lda (rw0),y
	ldy #2
	ora (rw0),y
	ldy #101
	ora (rw0),y
	beq u3
	lda #2
	bne y
u3
	ldy #3
	lda (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #192
	lda (rw0),y
	ldy #242
	ora (rw0),y
	ldy #149
	ora (rw0),y
	beq d1
	lda #-6
	bne y
d1
	ldy #243
	lda (rw0),y
	beq d2
	lda #-5
	bne y
d2
	ldy #241
	lda (rw0),y
	beq d3
	lda #-4
	bne y
d3
	ldy #244
	lda (rw0),y
	beq quit
	lda #-2

y	add:sta _posy

quit	rts
	.endl

dx2_dy6	.local

	beq updown
	bpl right
left
	ldy #2
	lda (rw0),y
	ldy #49
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #192
	ora (rw0),y
	ldy #241
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #197
	ora (rw0),y
	ldy #244
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #96
	lda (rw0),y
	ldy #49
	ora (rw0),y
	ldy #52
	ora (rw0),y
	ldy #101
	ora (rw0),y
	beq u1
	lda #7
	bne y
u1
	ldy #2
	lda (rw0),y
	iny
	ora (rw0),y
	beq quit
	lda #2
	bne y
down
	ldy #242
	lda (rw0),y
	iny
	ora (rw0),y
	beq d1
	lda #-6
	bne y
d1
	ldy #192
	lda (rw0),y
	ldy #241
	ora (rw0),y
	ldy #244
	ora (rw0),y
	ldy #197
	ora (rw0),y
	beq quit
	lda #-3

y	add:sta _posy

quit	rts
	.endl

dx3_dy6	.local

	beq updown
	bpl right
left
	ldy #2
	lda (rw0),y
	ldy #49
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #193
	ora (rw0),y
	ldy #241
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #53
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #197
	ora (rw0),y
	ldy #244
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #52
	lda (rw0),y
	beq u1
	lda #8
	bne y
u1
	ldy #49
	lda (rw0),y
	beq u2
	lda #6
	bne y
u2
	ldy #96
	lda (rw0),y
	ldy #3
	ora (rw0),y
	ldy #53
	ora (rw0),y
	beq u3
	lda #2
	bne y
u3
	ldy #2
	lda (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #144
	lda (rw0),y
	ldy #243
	ora (rw0),y
	ldy #197
	ora (rw0),y
	beq d1
	lda #-6
	bne y
d1
	ldy #242
	lda (rw0),y
	beq d2
	lda #-5
	bne y
d2
	ldy #244
	lda (rw0),y
	beq d3
	lda #-4
	bne y
d3
	ldy #241
	lda (rw0),y
	beq quit
	lda #-2

y	add:sta _posy

quit	rts
	.endl

dx0_dy7	.local

	beq updown
	bpl right
left
	ldy #2
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #192
	ora (rw0),y
	ldy #240
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #100
	ora (rw0),y
	ldy #148
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #244
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #49
	lda (rw0),y
	ldy #51
	ora (rw0),y
	beq u1
	lda #8
	bne y
u1
	ldy #48
	lda (rw0),y
	ldy #52
	ora (rw0),y
	beq u2
	lda #3
	bne y
u2
	ldy #2
	lda (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #242
	lda (rw0),y
	beq d1
	lda #-7
	bne y
d1
	dey
	lda (rw0),y
	ldy #243
	ora (rw0),y
	beq d2
	lda #-6
	bne y
d2
	ldy #240
	lda (rw0),y
	ldy #244
	ora (rw0),y
	beq quit
	lda #-1

y	add:sta _posy

quit	rts
	.endl

dx1_dy7	.local

	beq updown
	bpl right
left
	ldy #2
	lda (rw0),y
	ldy #48
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #192
	ora (rw0),y
	ldy #241
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #2
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #196
	ora (rw0),y
	ldy #244
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
	ldy #49
	lda (rw0),y
	beq u2
	lda #7
	bne y
u2
	ldy #52
	lda (rw0),y
	beq u3
	lda #5
	bne y
u3
	ldy #48
	lda (rw0),y
	ldy #2
	ora (rw0),y
	ldy #101
	ora (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #192
	lda (rw0),y
	ldy #242
	ora (rw0),y
	ldy #149
	ora (rw0),y
	beq d1
	lda #-7
	bne y
d1
	ldy #243
	lda (rw0),y
	beq d2
	lda #-6
	bne y
d2
	ldy #241
	lda (rw0),y
	beq d3
	lda #-5
	bne y
d3
	ldy #244
	lda (rw0),y
	beq quit
	lda #-3

y	add:sta _posy

quit	rts
	.endl

dx2_dy7	.local

	beq updown
	bpl right
left
	ldy #2
	lda (rw0),y
	ldy #49
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #192
	ora (rw0),y
	ldy #241
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #52
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #197
	ora (rw0),y
	ldy #244
	ora (rw0),y
	beq updown

	dec _posx

updown	lda _addy
	beq quit
	bpl down
up
	ldy #96
	lda (rw0),y
	ldy #49
	ora (rw0),y
	ldy #52
	ora (rw0),y
	ldy #101
	ora (rw0),y
	beq u1
	lda #6
	bne y
u1
	ldy #2
	lda (rw0),y
	iny
	ora (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #242
	lda (rw0),y
	iny
	ora (rw0),y
	beq d1
	lda #-7
	bne y
d1
	ldy #192
	lda (rw0),y
	ldy #241
	ora (rw0),y
	ldy #244
	ora (rw0),y
	ldy #197
	ora (rw0),y
	beq quit
	lda #-4

y	add:sta _posy

quit	rts
	.endl

dx3_dy7	.local

	beq updown
	bpl right
left
	ldy #3
	lda (rw0),y
	ldy #49
	ora (rw0),y
	ldy #96
	ora (rw0),y
	ldy #144
	ora (rw0),y
	ldy #193
	ora (rw0),y
	ldy #241
	ora (rw0),y
	beq updown

	inc _posx
	bne updown
right
	ldy #3
	lda (rw0),y
	ldy #53
	ora (rw0),y
	ldy #101
	ora (rw0),y
	ldy #149
	ora (rw0),y
	ldy #197
	ora (rw0),y
	ldy #244
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
	ldy #52
	lda (rw0),y
	beq u2
	lda #7
	bne y
u2
	ldy #49
	lda (rw0),y
	beq u3
	lda #5
	bne y
u3
	ldy #96
	lda (rw0),y
	ldy #3
	ora (rw0),y
	ldy #53
	ora (rw0),y
	beq quit
	lda #1
	bne y
down
	ldy #144
	lda (rw0),y
	ldy #243
	ora (rw0),y
	ldy #197
	ora (rw0),y
	beq d1
	lda #-7
	bne y
d1
	ldy #242
	lda (rw0),y
	beq d2
	lda #-6
	bne y
d2
	ldy #244
	lda (rw0),y
	beq d3
	lda #-5
	bne y
d3
	ldy #241
	lda (rw0),y
	beq quit
	lda #-3

y	add:sta _posy

quit	rts
	.endl
.endl

.print .len ck0
