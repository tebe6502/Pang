.local	ck4
* ---------------------------------------------------
r0	.local				; ROW = 0
left
	beq up
	bpl right

	lda ?invers-1+48*0+0,y
	jmp eox

right	lda ?invers+48*0+1+0,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	jmp BALL_COLLISION.returnX

down	lda ?invers+48+0,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r1	.local				; ROW = 1
left
	beq up
	bpl right

	lda ?invers-1+48*0+48,y
	jmp eox

right	lda ?invers+48*0+1+48,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+48,y
	jmp BALL_COLLISION.return

down	lda ?invers+48+48,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r2	.local				; ROW = 2
left
	beq up
	bpl right

	lda ?invers-1+48*0+96,y
	jmp eox

right	lda ?invers+48*0+1+96,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+96,y
	jmp BALL_COLLISION.return

down	lda ?invers+48+96,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r3	.local				; ROW = 3
left
	beq up
	bpl right

	lda ?invers-1+48*0+144,y
	jmp eox

right	lda ?invers+48*0+1+144,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+144,y
	jmp BALL_COLLISION.return

down	lda ?invers+48+144,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r4	.local				; ROW = 4
left
	beq up
	bpl right

	lda ?invers-1+48*0+192,y
	jmp eox

right	lda ?invers+48*0+1+192,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+192,y
	jmp BALL_COLLISION.return

down	lda ?invers+48+192,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r5	.local				; ROW = 5
left
	beq up
	bpl right

	lda ?invers-1+48*0+240,y
	jmp eox

right	lda ?invers+48*0+1+240,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+240,y
	jmp BALL_COLLISION.return

down	lda ?invers+48+240,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r6	.local				; ROW = 6
left
	beq up
	bpl right

	lda ?invers-1+48*0+288,y
	jmp eox

right	lda ?invers+48*0+1+288,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+288,y
	jmp BALL_COLLISION.return

down	lda ?invers+48+288,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r7	.local				; ROW = 7
left
	beq up
	bpl right

	lda ?invers-1+48*0+336,y
	jmp eox

right	lda ?invers+48*0+1+336,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+336,y
	jmp BALL_COLLISION.return

down	lda ?invers+48+336,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r8	.local				; ROW = 8
left
	beq up
	bpl right

	lda ?invers-1+48*0+384,y
	jmp eox

right	lda ?invers+48*0+1+384,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+384,y
	jmp BALL_COLLISION.return

down	lda ?invers+48+384,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r9	.local				; ROW = 9
left
	beq up
	bpl right

	lda ?invers-1+48*0+432,y
	jmp eox

right	lda ?invers+48*0+1+432,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+432,y
	jmp BALL_COLLISION.return

down	lda ?invers+48+432,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r10	.local				; ROW = 10
left
	beq up
	bpl right

	lda ?invers-1+48*0+480,y
	jmp eox

right	lda ?invers+48*0+1+480,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+480,y
	jmp BALL_COLLISION.return

down	lda ?invers+48+480,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r11	.local				; ROW = 11
left
	beq up
	bpl right

	lda ?invers-1+48*0+528,y
	jmp eox

right	lda ?invers+48*0+1+528,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+528,y
	jmp BALL_COLLISION.return

down	lda ?invers+48+528,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r12	.local				; ROW = 12
left
	beq up
	bpl right

	lda ?invers-1+48*0+576,y
	jmp eox

right	lda ?invers+48*0+1+576,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+576,y
	jmp BALL_COLLISION.return

down	lda ?invers+48+576,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r13	.local				; ROW = 13
left
	beq up
	bpl right

	lda ?invers-1+48*0+624,y
	jmp eox

right	lda ?invers+48*0+1+624,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+624,y
	jmp BALL_COLLISION.return

down	lda ?invers+48+624,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r14	.local				; ROW = 14
left
	beq up
	bpl right

	lda ?invers-1+48*0+672,y
	jmp eox

right	lda ?invers+48*0+1+672,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+672,y
	jmp BALL_COLLISION.return

down	lda ?invers+48+672,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r15	.local				; ROW = 15
left
	beq up
	bpl right

	lda ?invers-1+48*0+720,y
	jmp eox

right	lda ?invers+48*0+1+720,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+720,y
	jmp BALL_COLLISION.return

down	lda ?invers+48+720,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r16	.local				; ROW = 16
left
	beq up
	bpl right

	lda ?invers-1+48*0+768,y
	jmp eox

right	lda ?invers+48*0+1+768,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+768,y
	jmp BALL_COLLISION.return

down	lda ?invers+48+768,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r17	.local				; ROW = 17
left
	beq up
	bpl right

	lda ?invers-1+48*0+816,y
	jmp eox

right	lda ?invers+48*0+1+816,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+816,y
	jmp BALL_COLLISION.return

down	lda ?invers+48+816,y
	jmp BALL_COLLISION.return

	.endl

* ---------------------------------------------------
r18	.local				; ROW = 18
left
	beq up
	bpl right

	lda ?invers-1+48*0+864,y
	jmp eox

right	lda ?invers+48*0+1+864,y
eox	beq up

	lda addx,x
	eor #$fe
	sta addx,x

up	lda addy,x
	bpl down

	lda ?invers-48+864,y
	jmp BALL_COLLISION.return

down	jmp BALL_COLLISION.returnX
	.endl

.endl
