.local	ck0
* ---------------------------------------------------
r0	.local				; ROW = 0
left
	beq up
	bpl right

	lda ?invers-1+48*0+0,y
	ora ?invers-1+48*1+0,y
	ora ?invers-1+48*2+0,y
	ora ?invers-1+48*3+0,y
	ora ?invers-1+48*4+0,y
	jmp eox

right	lda ?invers+48*0+5+0,y
	ora ?invers+48*1+5+0,y
	ora ?invers+48*2+5+0,y
	ora ?invers+48*3+5+0,y
	ora ?invers+48*4+5+0,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	jmp BALL_COLLISION.returnX

down	lda ?invers+240+0,y
	ora ?invers+1+240+0,y
	ora ?invers+2+240+0,y
	ora ?invers+3+240+0,y
	ora ?invers+4+240+0,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r1	.local				; ROW = 1
left
	beq up
	bpl right

	lda ?invers-1+48*0+48,y
	ora ?invers-1+48*1+48,y
	ora ?invers-1+48*2+48,y
	ora ?invers-1+48*3+48,y
	ora ?invers-1+48*4+48,y
	jmp eox

right	lda ?invers+48*0+5+48,y
	ora ?invers+48*1+5+48,y
	ora ?invers+48*2+5+48,y
	ora ?invers+48*3+5+48,y
	ora ?invers+48*4+5+48,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+48,y
	ora ?invers-48+1+48,y
	ora ?invers-48+2+48,y
	ora ?invers-48+3+48,y
	ora ?invers-48+4+48,y
	jmp BALL_COLLISION.return

down	lda ?invers+240+48,y
	ora ?invers+1+240+48,y
	ora ?invers+2+240+48,y
	ora ?invers+3+240+48,y
	ora ?invers+4+240+48,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r2	.local				; ROW = 2
left
	beq up
	bpl right

	lda ?invers-1+48*0+96,y
	ora ?invers-1+48*1+96,y
	ora ?invers-1+48*2+96,y
	ora ?invers-1+48*3+96,y
	ora ?invers-1+48*4+96,y
	jmp eox

right	lda ?invers+48*0+5+96,y
	ora ?invers+48*1+5+96,y
	ora ?invers+48*2+5+96,y
	ora ?invers+48*3+5+96,y
	ora ?invers+48*4+5+96,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+96,y
	ora ?invers-48+1+96,y
	ora ?invers-48+2+96,y
	ora ?invers-48+3+96,y
	ora ?invers-48+4+96,y
	jmp BALL_COLLISION.return

down	lda ?invers+240+96,y
	ora ?invers+1+240+96,y
	ora ?invers+2+240+96,y
	ora ?invers+3+240+96,y
	ora ?invers+4+240+96,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r3	.local				; ROW = 3
left
	beq up
	bpl right

	lda ?invers-1+48*0+144,y
	ora ?invers-1+48*1+144,y
	ora ?invers-1+48*2+144,y
	ora ?invers-1+48*3+144,y
	ora ?invers-1+48*4+144,y
	jmp eox

right	lda ?invers+48*0+5+144,y
	ora ?invers+48*1+5+144,y
	ora ?invers+48*2+5+144,y
	ora ?invers+48*3+5+144,y
	ora ?invers+48*4+5+144,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+144,y
	ora ?invers-48+1+144,y
	ora ?invers-48+2+144,y
	ora ?invers-48+3+144,y
	ora ?invers-48+4+144,y
	jmp BALL_COLLISION.return

down	lda ?invers+240+144,y
	ora ?invers+1+240+144,y
	ora ?invers+2+240+144,y
	ora ?invers+3+240+144,y
	ora ?invers+4+240+144,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r4	.local				; ROW = 4
left
	beq up
	bpl right

	lda ?invers-1+48*0+192,y
	ora ?invers-1+48*1+192,y
	ora ?invers-1+48*2+192,y
	ora ?invers-1+48*3+192,y
	ora ?invers-1+48*4+192,y
	jmp eox

right	lda ?invers+48*0+5+192,y
	ora ?invers+48*1+5+192,y
	ora ?invers+48*2+5+192,y
	ora ?invers+48*3+5+192,y
	ora ?invers+48*4+5+192,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+192,y
	ora ?invers-48+1+192,y
	ora ?invers-48+2+192,y
	ora ?invers-48+3+192,y
	ora ?invers-48+4+192,y
	jmp BALL_COLLISION.return

down	lda ?invers+240+192,y
	ora ?invers+1+240+192,y
	ora ?invers+2+240+192,y
	ora ?invers+3+240+192,y
	ora ?invers+4+240+192,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r5	.local				; ROW = 5
left
	beq up
	bpl right

	lda ?invers-1+48*0+240,y
	ora ?invers-1+48*1+240,y
	ora ?invers-1+48*2+240,y
	ora ?invers-1+48*3+240,y
	ora ?invers-1+48*4+240,y
	jmp eox

right	lda ?invers+48*0+5+240,y
	ora ?invers+48*1+5+240,y
	ora ?invers+48*2+5+240,y
	ora ?invers+48*3+5+240,y
	ora ?invers+48*4+5+240,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+240,y
	ora ?invers-48+1+240,y
	ora ?invers-48+2+240,y
	ora ?invers-48+3+240,y
	ora ?invers-48+4+240,y
	jmp BALL_COLLISION.return

down	lda ?invers+240+240,y
	ora ?invers+1+240+240,y
	ora ?invers+2+240+240,y
	ora ?invers+3+240+240,y
	ora ?invers+4+240+240,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r6	.local				; ROW = 6
left
	beq up
	bpl right

	lda ?invers-1+48*0+288,y
	ora ?invers-1+48*1+288,y
	ora ?invers-1+48*2+288,y
	ora ?invers-1+48*3+288,y
	ora ?invers-1+48*4+288,y
	jmp eox

right	lda ?invers+48*0+5+288,y
	ora ?invers+48*1+5+288,y
	ora ?invers+48*2+5+288,y
	ora ?invers+48*3+5+288,y
	ora ?invers+48*4+5+288,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+288,y
	ora ?invers-48+1+288,y
	ora ?invers-48+2+288,y
	ora ?invers-48+3+288,y
	ora ?invers-48+4+288,y
	jmp BALL_COLLISION.return

down	lda ?invers+240+288,y
	ora ?invers+1+240+288,y
	ora ?invers+2+240+288,y
	ora ?invers+3+240+288,y
	ora ?invers+4+240+288,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r7	.local				; ROW = 7
left
	beq up
	bpl right

	lda ?invers-1+48*0+336,y
	ora ?invers-1+48*1+336,y
	ora ?invers-1+48*2+336,y
	ora ?invers-1+48*3+336,y
	ora ?invers-1+48*4+336,y
	jmp eox

right	lda ?invers+48*0+5+336,y
	ora ?invers+48*1+5+336,y
	ora ?invers+48*2+5+336,y
	ora ?invers+48*3+5+336,y
	ora ?invers+48*4+5+336,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+336,y
	ora ?invers-48+1+336,y
	ora ?invers-48+2+336,y
	ora ?invers-48+3+336,y
	ora ?invers-48+4+336,y
	jmp BALL_COLLISION.return

down	lda ?invers+240+336,y
	ora ?invers+1+240+336,y
	ora ?invers+2+240+336,y
	ora ?invers+3+240+336,y
	ora ?invers+4+240+336,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r8	.local				; ROW = 8
left
	beq up
	bpl right

	lda ?invers-1+48*0+384,y
	ora ?invers-1+48*1+384,y
	ora ?invers-1+48*2+384,y
	ora ?invers-1+48*3+384,y
	ora ?invers-1+48*4+384,y
	jmp eox

right	lda ?invers+48*0+5+384,y
	ora ?invers+48*1+5+384,y
	ora ?invers+48*2+5+384,y
	ora ?invers+48*3+5+384,y
	ora ?invers+48*4+5+384,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+384,y
	ora ?invers-48+1+384,y
	ora ?invers-48+2+384,y
	ora ?invers-48+3+384,y
	ora ?invers-48+4+384,y
	jmp BALL_COLLISION.return

down	lda ?invers+240+384,y
	ora ?invers+1+240+384,y
	ora ?invers+2+240+384,y
	ora ?invers+3+240+384,y
	ora ?invers+4+240+384,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r9	.local				; ROW = 9
left
	beq up
	bpl right

	lda ?invers-1+48*0+432,y
	ora ?invers-1+48*1+432,y
	ora ?invers-1+48*2+432,y
	ora ?invers-1+48*3+432,y
	ora ?invers-1+48*4+432,y
	jmp eox

right	lda ?invers+48*0+5+432,y
	ora ?invers+48*1+5+432,y
	ora ?invers+48*2+5+432,y
	ora ?invers+48*3+5+432,y
	ora ?invers+48*4+5+432,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+432,y
	ora ?invers-48+1+432,y
	ora ?invers-48+2+432,y
	ora ?invers-48+3+432,y
	ora ?invers-48+4+432,y
	jmp BALL_COLLISION.return

down	lda ?invers+240+432,y
	ora ?invers+1+240+432,y
	ora ?invers+2+240+432,y
	ora ?invers+3+240+432,y
	ora ?invers+4+240+432,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r10	.local				; ROW = 10
left
	beq up
	bpl right

	lda ?invers-1+48*0+480,y
	ora ?invers-1+48*1+480,y
	ora ?invers-1+48*2+480,y
	ora ?invers-1+48*3+480,y
	ora ?invers-1+48*4+480,y
	jmp eox

right	lda ?invers+48*0+5+480,y
	ora ?invers+48*1+5+480,y
	ora ?invers+48*2+5+480,y
	ora ?invers+48*3+5+480,y
	ora ?invers+48*4+5+480,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+480,y
	ora ?invers-48+1+480,y
	ora ?invers-48+2+480,y
	ora ?invers-48+3+480,y
	ora ?invers-48+4+480,y
	jmp BALL_COLLISION.return

down	lda ?invers+240+480,y
	ora ?invers+1+240+480,y
	ora ?invers+2+240+480,y
	ora ?invers+3+240+480,y
	ora ?invers+4+240+480,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r11	.local				; ROW = 11
left
	beq up
	bpl right

	lda ?invers-1+48*0+528,y
	ora ?invers-1+48*1+528,y
	ora ?invers-1+48*2+528,y
	ora ?invers-1+48*3+528,y
	ora ?invers-1+48*4+528,y
	jmp eox

right	lda ?invers+48*0+5+528,y
	ora ?invers+48*1+5+528,y
	ora ?invers+48*2+5+528,y
	ora ?invers+48*3+5+528,y
	ora ?invers+48*4+5+528,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+528,y
	ora ?invers-48+1+528,y
	ora ?invers-48+2+528,y
	ora ?invers-48+3+528,y
	ora ?invers-48+4+528,y
	jmp BALL_COLLISION.return

down	lda ?invers+240+528,y
	ora ?invers+1+240+528,y
	ora ?invers+2+240+528,y
	ora ?invers+3+240+528,y
	ora ?invers+4+240+528,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r12	.local				; ROW = 12
left
	beq up
	bpl right

	lda ?invers-1+48*0+576,y
	ora ?invers-1+48*1+576,y
	ora ?invers-1+48*2+576,y
	ora ?invers-1+48*3+576,y
	ora ?invers-1+48*4+576,y
	jmp eox

right	lda ?invers+48*0+5+576,y
	ora ?invers+48*1+5+576,y
	ora ?invers+48*2+5+576,y
	ora ?invers+48*3+5+576,y
	ora ?invers+48*4+5+576,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+576,y
	ora ?invers-48+1+576,y
	ora ?invers-48+2+576,y
	ora ?invers-48+3+576,y
	ora ?invers-48+4+576,y
	jmp BALL_COLLISION.return

down	lda ?invers+240+576,y
	ora ?invers+1+240+576,y
	ora ?invers+2+240+576,y
	ora ?invers+3+240+576,y
	ora ?invers+4+240+576,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r13	.local				; ROW = 13
left
	beq up
	bpl right

	lda ?invers-1+48*0+624,y
	ora ?invers-1+48*1+624,y
	ora ?invers-1+48*2+624,y
	ora ?invers-1+48*3+624,y
	ora ?invers-1+48*4+624,y
	jmp eox

right	lda ?invers+48*0+5+624,y
	ora ?invers+48*1+5+624,y
	ora ?invers+48*2+5+624,y
	ora ?invers+48*3+5+624,y
	ora ?invers+48*4+5+624,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+624,y
	ora ?invers-48+1+624,y
	ora ?invers-48+2+624,y
	ora ?invers-48+3+624,y
	ora ?invers-48+4+624,y
	jmp BALL_COLLISION.return

down	lda ?invers+240+624,y
	ora ?invers+1+240+624,y
	ora ?invers+2+240+624,y
	ora ?invers+3+240+624,y
	ora ?invers+4+240+624,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r14	.local				; ROW = 14
left
	beq up
	bpl right

	lda ?invers-1+48*0+672,y
	ora ?invers-1+48*1+672,y
	ora ?invers-1+48*2+672,y
	ora ?invers-1+48*3+672,y
	jmp eox

right	lda ?invers+48*0+5+672,y
	ora ?invers+48*1+5+672,y
	ora ?invers+48*2+5+672,y
	ora ?invers+48*3+5+672,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+672,y
	ora ?invers-48+1+672,y
	ora ?invers-48+2+672,y
	ora ?invers-48+3+672,y
	ora ?invers-48+4+672,y
	jmp BALL_COLLISION.return

down	jmp BALL_COLLISION.returnX
	.endl

* ---------------------------------------------------
r15	.local				; ROW = 15
left
	beq up
	bpl right

	lda ?invers-1+48*0+720,y
	ora ?invers-1+48*1+720,y
	ora ?invers-1+48*2+720,y
	jmp eox

right	lda ?invers+48*0+5+720,y
	ora ?invers+48*1+5+720,y
	ora ?invers+48*2+5+720,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+720,y
	ora ?invers-48+1+720,y
	ora ?invers-48+2+720,y
	ora ?invers-48+3+720,y
	ora ?invers-48+4+720,y
	jmp BALL_COLLISION.return

down	jmp BALL_COLLISION.returnX
	.endl

* ---------------------------------------------------
r16	.local				; ROW = 16
left
	beq up
	bpl right

	lda ?invers-1+48*0+768,y
	ora ?invers-1+48*1+768,y
	jmp eox

right	lda ?invers+48*0+5+768,y
	ora ?invers+48*1+5+768,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+768,y
	ora ?invers-48+1+768,y
	ora ?invers-48+2+768,y
	ora ?invers-48+3+768,y
	ora ?invers-48+4+768,y
	jmp BALL_COLLISION.return

down	jmp BALL_COLLISION.returnX
	.endl

* ---------------------------------------------------
r17	.local				; ROW = 17
left
	beq up
	bpl right

	lda ?invers-1+48*0+816,y
	jmp eox

right	lda ?invers+48*0+5+816,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+816,y
	ora ?invers-48+1+816,y
	ora ?invers-48+2+816,y
	ora ?invers-48+3+816,y
	ora ?invers-48+4+816,y
	jmp BALL_COLLISION.return

down	jmp BALL_COLLISION.returnX
	.endl

* ---------------------------------------------------
r18	.local				; ROW = 18
left
	beq up
	bpl right

	lda ?invers-1+48*0+864,y
	jmp eox

right	lda ?invers+48*0+5+864,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+864,y
	ora ?invers-48+1+864,y
	ora ?invers-48+2+864,y
	ora ?invers-48+3+864,y
	ora ?invers-48+4+864,y
	jmp BALL_COLLISION.return

down	jmp BALL_COLLISION.returnX
	.endl

.endl
