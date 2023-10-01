.LOCAL	CK3

	lda posy
	and #7
	lsr @
	tay
	lda posx,x
	and #3
	add tmul4,y
	tay

	mva ladr,y _jmp+1
	mva hadr,y _jmp+2
_jmp	jmp $ffff

ladr	dta l(h0v0,h1v0,h2v0,h3v0, h0v1,h1v1,h2v1,h3v1, h0v2,h1v2,h2v2,h3v2, h0v3,h1v3,h2v3,h3v3)
hadr	dta h(h0v0,h1v0,h2v0,h3v0, h0v1,h1v1,h2v1,h3v1, h0v2,h1v2,h2v2,h3v2, h0v3,h1v3,h2v3,h3v3)

h0v0
	lda addx,x
	beq up00
	bpl right00

	ldy #48*0+0
	lda (inv),y
	ldy #48*1+0
	ora (inv),y

	jmp eox00
right00
	ldy #48*0+2
	lda (inv),y
	ldy #48*1+2
	ora (inv),y

eox00	beq up00

	lda addx,x
	eor #$fe
	sta addx,x

up00	lda addcnt,x
	bpl down00

	ldy #0+48*0
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2

down00
	ldy #0+48*1
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2


h1v0
	lda addx,x
	beq up10
	bpl right10

	ldy #48*0+0
	lda (inv),y
	ldy #48*1+0
	ora (inv),y

	jmp eox10
right10
	ldy #48*0+2
	lda (inv),y
	ldy #48*1+2
	ora (inv),y

eox10	beq up10

	lda addx,x
	eor #$fe
	sta addx,x

up10	lda addcnt,x
	bpl down10

	ldy #0+48*0
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2

down10
	ldy #0+48*1
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2


h2v0
	lda addx,x
	beq up20
	bpl right20

	ldy #48*0+0
	lda (inv),y
	ldy #48*1+0
	ora (inv),y

	jmp eox20
right20
	ldy #48*0+2
	lda (inv),y
	ldy #48*1+2
	ora (inv),y

eox20	beq up20

	lda addx,x
	eor #$fe
	sta addx,x

up20	lda addcnt,x
	bpl down20

	ldy #0+48*0
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2

down20
	ldy #0+48*1
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2


h3v0
	lda addx,x
	beq up30
	bpl right30

	ldy #48*0+0
	lda (inv),y
	ldy #48*1+0
	ora (inv),y

	jmp eox30
right30
	ldy #48*0+2
	lda (inv),y
	ldy #48*1+2
	ora (inv),y

eox30	beq up30

	lda addx,x
	eor #$fe
	sta addx,x

up30	lda addcnt,x
	bpl down30

	ldy #0+48*0
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2

down30
	ldy #0+48*1
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2


h0v1
	lda addx,x
	beq up01
	bpl right01

	ldy #48*0+0
	lda (inv),y
	ldy #48*1+0
	ora (inv),y

	jmp eox01
right01
	ldy #48*0+2
	lda (inv),y
	ldy #48*1+2
	ora (inv),y

eox01	beq up01

	lda addx,x
	eor #$fe
	sta addx,x

up01	lda addcnt,x
	bpl down01

	ldy #0+48*0
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2

down01
	ldy #0+48*2
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2


h1v1
	lda addx,x
	beq up11
	bpl right11

	ldy #48*0+0
	lda (inv),y
	ldy #48*1+0
	ora (inv),y

	jmp eox11
right11
	ldy #48*0+2
	lda (inv),y
	ldy #48*1+2
	ora (inv),y

eox11	beq up11

	lda addx,x
	eor #$fe
	sta addx,x

up11	lda addcnt,x
	bpl down11

	ldy #0+48*0
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2

down11
	ldy #0+48*2
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2


h2v1
	lda addx,x
	beq up21
	bpl right21

	ldy #48*0+0
	lda (inv),y
	ldy #48*1+0
	ora (inv),y

	jmp eox21
right21
	ldy #48*0+2
	lda (inv),y
	ldy #48*1+2
	ora (inv),y

eox21	beq up21

	lda addx,x
	eor #$fe
	sta addx,x

up21	lda addcnt,x
	bpl down21

	ldy #0+48*0
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2

down21
	ldy #0+48*1
	lda (inv),y
	ldy #1+48*2
	ora (inv),y
	jmp BALL_COLLISION.return2


h3v1
	lda addx,x
	beq up31
	bpl right31

	ldy #48*0+0
	lda (inv),y
	ldy #48*1+0
	ora (inv),y

	jmp eox31
right31
	ldy #48*0+2
	lda (inv),y
	ldy #48*1+2
	ora (inv),y

eox31	beq up31

	lda addx,x
	eor #$fe
	sta addx,x

up31	lda addcnt,x
	bpl down31

	ldy #0+48*0
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2

down31
	ldy #0+48*1
	lda (inv),y
	ldy #1+48*2
	ora (inv),y
	jmp BALL_COLLISION.return2


h0v2
	lda addx,x
	beq up02
	bpl right02

	ldy #48*0+0
	lda (inv),y
	ldy #48*1+0
	ora (inv),y

	jmp eox02
right02
	ldy #48*0+1
	lda (inv),y
	ldy #48*1+2
	ora (inv),y

eox02	beq up02

	lda addx,x
	eor #$fe
	sta addx,x

up02	lda addcnt,x
	bpl down02

	ldy #0+48*0
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2

down02
	ldy #0+48*2
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2


h1v2
	lda addx,x
	beq up12
	bpl right12

	ldy #48*0+0
	lda (inv),y
	ldy #48*1+0
	ora (inv),y

	jmp eox12
right12
	ldy #48*0+2
	lda (inv),y
	ldy #48*1+2
	ora (inv),y

eox12	beq up12

	lda addx,x
	eor #$fe
	sta addx,x

up12	lda addcnt,x
	bpl down12

	ldy #0+48*0
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2

down12
	ldy #0+48*2
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2


h2v2
	lda addx,x
	beq up22
	bpl right22

	ldy #48*0+0
	lda (inv),y
	ldy #48*1+0
	ora (inv),y

	jmp eox22
right22
	ldy #48*0+2
	lda (inv),y
	ldy #48*1+2
	ora (inv),y

eox22	beq up22

	lda addx,x
	eor #$fe
	sta addx,x

up22	lda addcnt,x
	bpl down22

	ldy #0+48*0
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2

down22
	ldy #0+48*2
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2


h3v2
	lda addx,x
	beq up32
	bpl right32

	ldy #48*0+1
	lda (inv),y
	ldy #48*1+0
	ora (inv),y

	jmp eox32
right32
	ldy #48*0+2
	lda (inv),y
	ldy #48*1+2
	ora (inv),y

eox32	beq up32

	lda addx,x
	eor #$fe
	sta addx,x

up32	lda addcnt,x
	bpl down32

	ldy #0+48*1
	lda (inv),y
	ldy #1+48*0
	ora (inv),y
	jmp BALL_COLLISION.return2

down32
	ldy #0+48*1
	lda (inv),y
	ldy #1+48*2
	ora (inv),y
	jmp BALL_COLLISION.return2


h0v3
	lda addx,x
	beq up03
	bpl right03

	ldy #48*0+0
	lda (inv),y
	ldy #48*1+0
	ora (inv),y

	jmp eox03
right03
	ldy #48*0+1
	lda (inv),y
	ldy #48*1+2
	ora (inv),y

eox03	beq up03

	lda addx,x
	eor #$fe
	sta addx,x

up03	lda addcnt,x
	bpl down03

	ldy #0+48*0
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2

down03
	ldy #0+48*2
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2


h1v3
	lda addx,x
	beq up13
	bpl right13

	ldy #48*0+0
	lda (inv),y
	ldy #48*1+0
	ora (inv),y

	jmp eox13
right13
	ldy #48*0+1
	lda (inv),y
	ldy #48*1+2
	ora (inv),y

eox13	beq up13

	lda addx,x
	eor #$fe
	sta addx,x

up13	lda addcnt,x
	bpl down13

	ldy #0+48*0
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2

down13
	ldy #0+48*2
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2


h2v3
	lda addx,x
	beq up23
	bpl right23

	ldy #48*0+1
	lda (inv),y
	ldy #48*1+0
	ora (inv),y

	jmp eox23
right23
	ldy #48*0+2
	lda (inv),y
	ldy #48*1+2
	ora (inv),y

eox23	beq up23

	lda addx,x
	eor #$fe
	sta addx,x

up23	lda addcnt,x
	bpl down23

	ldy #0+48*1
	lda (inv),y
	ldy #1+48*0
	ora (inv),y
	jmp BALL_COLLISION.return2

down23
	ldy #0+48*2
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2


h3v3
	lda addx,x
	beq up33
	bpl right33

	ldy #48*0+1
	lda (inv),y
	ldy #48*1+0
	ora (inv),y

	jmp eox33
right33
	ldy #48*0+2
	lda (inv),y
	ldy #48*1+2
	ora (inv),y

eox33	beq up33

	lda addx,x
	eor #$fe
	sta addx,x

up33	lda addcnt,x
	bpl down33

	ldy #0+48*1
	lda (inv),y
	ldy #1+48*0
	ora (inv),y
	jmp BALL_COLLISION.return2

down33
	ldy #0+48*2
	lda (inv),y
	iny
	ora (inv),y
	jmp BALL_COLLISION.return2

.endl
