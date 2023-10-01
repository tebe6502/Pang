// PANG - GAME OVER
// changes: 24.10.2016

// SortScore zwraca w regY numer wpisu (0..4) dla ktorego mamy wprowadzic 3 literowy 'ksywke'


TEST	= 0

	opt l-
	icl "GameOver.h"
	opt l+


	ift !TEST
	opt h-f+
	eif

cloc	= $14

ScoreBoard	= $0200		; tablica z aktualnymi wynikami

	org $80

fcnt	.ds 2
fadr	.ds 2
fhlp	.ds 2
regA	.ds 1
regX	.ds 1
regY	.ds 1

joy	.ds 1
joyFire	.ds 1
newPos	.ds 1

WIDTH	= 40
HEIGHT	= 30

space_chr = $2f
score_cnt = 6
score_all = score_cnt+3+2

pmg	= 0

joy_none	= 15
joy_up		= 14
joy_down	= 13
joy_left	= 11
joy_right	= 7

; ---	MAIN PROGRAM

	ift TEST
	org $2000

fnt	ins "GameOver.fnt",0,4*1024+26*8
	els
	org $d800

fnt	= $bc00
	eif

rfnt	ins 'g2f\ranking.fnt',0,$27f

ant	dta $44,a(scr)
	dta $84,$84,$04,$84,$04,$04,$04,$84,$84,$04,$84,$84,$84,$84,$04,$84
	dta $84,$84,$84,$84,$04

	dta $00			; ranking tour/panic mode
	dta $4e,a(line)
	dta $4e+$80,a(line)
	dta $44,a(scr+22*40)

	dta $4e,a(line)
	dta $4e,a(line)
	dta $4e,a(line)
	dta $4e+$80,a(line)

	dta $44,a(scr+23*40)	; 1st
	dta $4e,a(line)
	dta $4e+$80,a(line)

	dta $44,a(scr+24*40)	; 2nd
	dta $4e,a(line)
	dta $4e+$80,a(line)

	dta $44,a(scr+25*40)	; 3rd
	dta $4e,a(line)
	dta $4e+$80,a(line)

	dta $44,a(scr+26*40)	; 4th
	dta $4e,a(line)
	dta $4e+$80,a(line)

	dta $44,a(scr+27*40)	; 5th
	dta $4e,a(line)
	dta $4e,a(line)

	dta $41,a(ant)

scr	ins "GameOver.scr",0,40*22

ranking
	ins 'g2f\ranking.scr',13*40,6*40

line	dta %01100001
	:38 dta $55
	dta %01001001

tabpp  dta 156,78,52,39			;line counter spacing table for instrument speed from 1 to 4

main
; ---	init PMG

	pha

	ift !TEST
	lda tabpp-1,y
	sta acpapx2+1				;sync counter spacing
	lda #86+0
	sta acpapx1+1
	eif

	lda:rne vcount

	ift TEST
	sei			;stop IRQ interrupts
	mva #$00 nmien		;stop NMI interrupts
	sta dmactl
	mva #$fe portb		;switch off ROM to get 16k more ram
	els
	mva #$00 nmien		;stop NMI interrupts
	eif

	mwa #NMI $fffa		;new NMI handler

	mva >pmg pmbase		;missiles and players data address
	mva #$03 pmcntl		;enable players and missiles

	jsr save_color		;then save all colors and set value 0 for all colors

	rle #pmgrle-1 #pmg+$300

	mva #$c0 nmien		;switch on NMI+DLI again

	pla
	jsr ScoreMode

// dodaj nowy wpis -> scoreBoard._new

	jsr SortScore		; sortujemy liste wynikow
	jsr ShowScore		; przepiszemy na ekran uzywajac fontow GAMEOVER

	jsr fade_in		;fade in colors

	lda newPos
	cmp #5			; wynik nie znalazl sie na tablicy
	bcs _lp

	jsr EnterName		; wprowadz inicjaly jesli wynik jest na tablicy

_lp
	lda trig0		; FIRE #0
	beq stop

	lda trig1		; FIRE #1
	beq stop

	lda consol		; START
	and #1
	beq stop

	lda skctl
	and #$04
	beq stop		;wait to press any key; here you can put any own routine

	ift !TEST
	jsr playMusic
	eif

	jmp _lp
stop

	ift !TEST
	jsr msxStop
	eif

rts_	jmp fade_out		;fade out colors


playMusic
	ift !TEST
acpapx1	lda #$ff		;parameter overwrite (sync line counter value)
	clc
acpapx2	adc #$ff		;parameter overwrite (sync line counter spacing)
	cmp #156
	bcc lop4
	sbc #156
lop4
	sta acpapx1+1
waipap
	cmp VCOUNT		;vertical line counter synchro
	bne waipap
;
	jsr msxPlay		; 1 play
;
	eif
	rts

; ---	DLI PROGRAM

.local	DLI

	?old_dli = *

dli_start

dli10
	sta regA
	stx regX

c9	lda #$78
	sta wsync		;line=16
	sta color0
	sta wsync		;line=17
	sta wsync		;line=18
	sta wsync		;line=19
x8	lda #$B3
x9	ldx #$BB
	sta wsync		;line=20
	sta hposp0
	stx hposm0
	DLINEW dli11 1 1 0

dli11
	sta regA
	stx regX

x10	lda #$B4
	sta wsync		;line=24
	sta hposp0
s4	lda #$40
x11	ldx #$58
	sta wsync		;line=25
	sta sizem
	stx hposm3
x12	lda #$BC
	sta wsync		;line=26
	sta hposm0
	sta wsync		;line=27
	sta wsync		;line=28
s5	lda #$C0
x13	ldx #$A3
	sta wsync		;line=29
	sta sizem
	stx hposm3
	sta wsync		;line=30
c10	lda #$76
c11	ldx #$3E
	sta wsync		;line=31
	sta color0
	stx color2
c12	lda #$78
	sta wsync		;line=32
	sta color0
	sta wsync		;line=33
c13	lda #$76
	sta wsync		;line=34
	sta color0
c14	lda #$78
x14	ldx #$B7
	sta wsync		;line=35
	sta color0
	stx hposp0
c15	lda #$76
	sta wsync		;line=36
	sta color0
	DLINEW dli12 1 1 0

dli12
	sta regA
	stx regX
	sty regY

	sta wsync		;line=40
x15	lda #$76
	sta wsync		;line=41
	sta hposp0
s6	lda #$01
	sta wsync		;line=42
	sta sizep0
	sta wsync		;line=43
c16	lda #$2C
s7	ldx #$C4
	sta wsync		;line=44
	sta color2
	stx sizem
	sta wsync		;line=45
c17	lda #$74
	sta wsync		;line=46
	sta color0
c18	lda #$76
	sta wsync		;line=47
	sta color0
	lda >fnt+$400*$01
s8	ldx #$C0
x16	ldy #$80
	sta wsync		;line=48
	sta chbase
	stx sizem
	sty hposm1
c19	lda #$74
	sta wsync		;line=49
	sta color0
c20	lda #$76
	sta wsync		;line=50
	sta color0
c21	lda #$74
s9	ldx #$00
x17	ldy #$77
	sta wsync		;line=51
	sta color0
	stx sizem
	sty hposp3
x18	lda #$7F
	sta hposm0
x19	lda #$48
	sta hposm3
c22	lda #$0E
	sta colpm0
	sta wsync		;line=52
c23	lda #$76
	sta wsync		;line=53
	sta color0
c24	lda #$74
	sta wsync		;line=54
	sta color0
x20	lda #$44
	sta wsync		;line=55
	sta hposp3
s10	lda #$03
x21	ldx #$66
c25	ldy #$5E
	sta wsync		;line=56
	sta sizep2
	stx hposp2
	sty colpm2
	sta wsync		;line=57
	sta wsync		;line=58
x22	lda #$8B
x23	ldx #$88
	sta wsync		;line=59
	sta hposp1
	stx hposm1
x24	lda #$B5
	sta wsync		;line=60
	sta hposm3
	sta wsync		;line=61
s11	lda #$01
x25	ldx #$4E
	sta wsync		;line=62
	sta sizep3
	stx hposp3
	sta wsync		;line=63
s12	lda #$04
x26	ldx #$90
x27	ldy #$87
	sta wsync		;line=64
	sta sizem
	stx hposp1
	sty hposm1
	sta wsync		;line=65
c26	lda #$5C
	sta wsync		;line=66
	sta colpm2
x28	lda #$86
	sta wsync		;line=67
	sta hposm1
	DLINEW dli13 1 1 1

dli13
	sta regA
	stx regX
	sty regY

	sta wsync		;line=72
s13	lda #$00
x29	ldx #$85
	sta wsync		;line=73
	sta sizep2
	stx hposm1
	sta wsync		;line=74
	sta wsync		;line=75
x30	lda #$8B
x31	ldx #$64
c27	ldy #$5A
	sta wsync		;line=76
	sta hposp1
	stx hposp2
	sty colpm2
c28	lda #$16
x32	ldx #$87
c29	ldy #$2C
	sta wsync		;line=77
	sta color2
	stx hposp1
	sty colpm0
	sty colpm1
	DLINEW DLI.dli2 1 1 1

dli2
	sta regA
	stx regX
	lda >fnt+$400*$02
	sta wsync		;line=80
	sta chbase
s14	lda #$00
x33	ldx #$7D
	sta wsync		;line=81
	sta sizep3
	stx hposp3
	sta wsync		;line=82
	sta wsync		;line=83
	sta wsync		;line=84
	sta wsync		;line=85
	sta wsync		;line=86
x34	lda #$8B
	sta wsync		;line=87
	sta hposp1
	sta wsync		;line=88
x35	lda #$63
	sta wsync		;line=89
	sta hposp2
	sta wsync		;line=90
x36	lda #$A1
	sta wsync		;line=91
	sta hposp3
	DLINEW dli14 1 1 0

dli14
	sta regA
	stx regX

	sta wsync		;line=96
x37	lda #$69
c30	ldx #$0E
	sta wsync		;line=97
	sta hposp2
	stx colpm2
x38	lda #$8F
	sta wsync		;line=98
	sta hposp1
	sta wsync		;line=99
	sta wsync		;line=100
x39	lda #$44
	sta wsync		;line=101
	sta hposp3
	DLINEW dli15 1 1 0

dli15
	sta regA
	stx regX
	sty regY

	sta wsync		;line=104
	sta wsync		;line=105
	sta wsync		;line=106
	sta wsync		;line=107
	sta wsync		;line=108
s15	lda #$00
x40	ldx #$79
c31	ldy #$1C
	sta wsync		;line=109
	sta sizep0
	stx hposp0
	sty colpm0
c32	lda #$72
	sta wsync		;line=110
	sta color0
	DLINEW dli3 1 1 1

dli3
	sta regA
	stx regX
	sty regY
	lda >fnt+$400*$03
	sta wsync		;line=112
	sta chbase
	sta wsync		;line=113
s16	lda #$0C
x41	ldx #$63
x42	ldy #$87
	sta wsync		;line=114
	sta sizem
	stx hposp2
	sty hposm1
c33	lda #$2A
	sta colpm1
	DLINEW dli16 1 1 1

dli16
	sta regA
	stx regX
	sty regY

s17	lda #$1C
x43	ldx #$6E
	sta wsync		;line=120
	sta sizem
	stx hposm2
c34	lda #$04
	sta wsync		;line=121
	sta color3
	sta wsync		;line=122
	sta wsync		;line=123
	sta wsync		;line=124
	sta wsync		;line=125
s18	lda #$01
x44	ldx #$73
c35	ldy #$0E
	sta wsync		;line=126
	sta sizep0
	stx hposp0
	sty colpm0
	sta wsync		;line=127
x45	lda #$83
c36	ldx #$1E
	sta wsync		;line=128
	sta hposp2
	stx colpm2
	DLINEW dli17 1 1 1

dli17
	sta regA

	sta wsync		;line=136
	sta wsync		;line=137
c37	lda #$0E
	sta wsync		;line=138
	sta color0
	DLINEW dli18 1 0 0

dli18
	sta regA

	sta wsync		;line=144
	sta wsync		;line=145
	sta wsync		;line=146
c38	lda #$0A
	sta wsync		;line=147
	sta color1
	DLINEW dli19 1 0 0

dli19
	sta regA

	sta wsync		;line=152
	sta wsync		;line=153
	sta wsync		;line=154
	sta wsync		;line=155
c39	lda #$72
	sta wsync		;line=156
	sta color0
	DLINEW dli4 1 0 0

dli4
	sta regA
	lda >fnt+$400*$04
	sta wsync		;line=160
	sta chbase
	DLINEW dli5 1 0 0

dli5
	sta regA
	stx regX
	sty regY
	lda >fnt+$400*$00
c40	ldx #$0E
c41	ldy #$06
	sta wsync		;line=168
	sta chbase
	stx color0
	sty color1
	sta wsync		;line=169
	sta wsync		;line=170
	sta wsync		;line=171
	sta wsync		;line=172
	sta wsync		;line=173
	sta wsync		;line=174
c42	lda #$02
c43	ldx #$0E
	sta wsync		;line=175
	sta color2
	stx color3
	lda >rfnt
k0	ldx #$92
k1	ldy #$0f
	sta wsync		;line=176
	sta chbase
	stx color0
	sty color1

	DLINEW dli6 1 1 1

.macro	colorBar
	.def %%3_0
	lda #%%1
	sta wsync
	sta color2
	.def %%3_1
	lda #[%%1+%%2]&$ff
	sta wsync
	sta color2
	.def %%3_2
	lda #[%%1+%%2*2]&$ff
	sta wsync
	sta color2
	.def %%3_3
	lda #[%%1+%%2*3]&$ff
	sta wsync
	sta color2
	.def %%3_4
	lda #[%%1+%%2*4]&$ff
	sta wsync
	sta color2
	.def %%3_5
	lda #[%%1+%%2*3]&$ff
	sta wsync
	sta color2
	.def %%3_6
	lda #[%%1+%%2*2]&$ff
	sta wsync
	sta color2
	.def %%3_7
	lda #[%%1+%%2]&$ff
	sta wsync
	sta color2
.endm

dli6	sta regA		; ranking
	colorBar $7 2 k0
	DLINEW dli7 1 0 0

dli7	sta regA		; 1st
	colorBar $ce 14 k1
	DLINEW dli8 1 0 0

dli8	sta regA		; 2nd
	colorBar $fe 14 k2
	DLINEW dli9 1 0 0

dli9	sta regA		; 3rd
	colorBar $2e 14 k3
	DLINEW dli20 1 0 0

dli20	sta regA		; 4th
	colorBar $8e 14 k4
	DLINEW dli21 1 0 0

dli21	sta regA		; 5th
	colorBar $5e 14 k5
	lda regA
	rti

.endl

; ---

CHANGES = 1
FADECHR	= 0

SCHR	= 127

; ---

.proc	NMI

	bit nmist
	bpl VBL

	jmp DLI.dli_start
dliv	equ *-2

VBL
	sta regA
	stx regX
	sty regY

	sta nmist		;reset NMI flag

	mwa #ant dlptr		;ANTIC address program

	mva #scr40 dmactl	;set new screen width

	inc cloc		;little timer

	lda $d300
	and #$0f
	sta joy

	mva trig0 joyFire

; Initial values

	lda >fnt+$400*$00
	sta chbase

c1	lda #$0E
	sta color0
	sta colpm3

c2	lda #$08
	sta color1
c3	lda #$5C
	sta color2
c4	lda #$34
	sta color3
	lda #$02
	sta chrctl

	lda #$04
	sta gtictl

	lda #$00
	sta sizep0
	sta sizep2
	sta sizep1
	sta sizep3

	sta colbak

x0	lda #$B1
	sta hposp0
x1	lda #$BE
	sta hposp2
c5	lda #$04
	sta colpm0
c6	lda #$54
	sta colpm2
x2	lda #$B9
	sta hposm0
s2	lda #$C0
	sta sizem
x3	lda #$44
	sta hposp3
x4	lda #$B0
	sta hposm3
x5	lda #$71
	sta hposp1
x6	lda #$7A
	sta hposm1
c8	lda #$16
	sta colpm1
x7	lda #$6D
	sta hposm2

	mwa #DLI.dli_start dliv	;set the first address of DLI interrupt

;this area is for yours routines

	lda regA
	ldx regX
	ldy regY
	rti

.endp

; ---
	ift CHANGES
		ift FADECHR = 0
		icl 'GameOver.fad'
		eif
	eif


.local	EnterName

	mwa #scoreBoard+6 fhlp
	mwa #ranking+WIDTH+24 fadr

	ldy newPos
	beq ok
lop
	adw fhlp #score_all
	adw fadr #WIDTH

	dey
	bne lop

ok	lda #'a'		; aaa
	sta (fhlp),y
	iny
	sta (fhlp),y
	iny
	sta (fhlp),y

	mva #0 idx

delay	dec tim
	bpl loop

none	mva #63 tim
	mva #joy_none old_joy

loop
	ift TEST
	lda:cmp:req cloc
	els
	jsr playMusic
	eif

	jsr blink

	lda joyFire
	bne sk

;	cmp joyFire
;	beq loop

	jsr show

;	inc idx
;	lda idx
;	cmp #3
;	scc

	rts
sk
	lda joy

	cmp #joy_none
	beq none

	cmp #joy_none
old_joy	equ *-1
	beq delay

	sta old_joy

	cmp #joy_up
	beq up
	cmp #joy_down
	beq dw
	cmp #joy_left
	beq lf
	cmp #joy_right
	beq rg

	jmp loop

lf	;sta old_joy

	jsr show

	lda idx
	beq loop

	dec idx

	jmp wait


rg	;sta old_joy

	jsr show

	lda idx
	cmp #2
	beq loop

	inc idx

	jmp wait


dw	;sta old_joy

	ldy idx
	lda (fhlp),y
	cmp #'a'
	beq loop

	sub #1
	sta (fhlp),y

wait	jsr show
	jmp loop

up	;sta old_joy

	ldy idx
	lda (fhlp),y
	cmp #'z'
	beq loop

	add #1
	sta (fhlp),y

	jmp wait

blink	tya:pha

	lda idx
	asl @
	tay

	lda (fadr),y
	cmp #space_chr
	beq skp

	lda cloc
	cmp #10
	bcc skp2

	lda #space_chr		; pokaz pusty znak
	sta (fadr),y
	iny
	sta (fadr),y
	bne quit
skp
	lda cloc
	cmp #4
	bcc skp2

	jsr show

quit	mva #0 cloc

skp2
	pla:tay
	rts


show	ldy idx
	lda (fhlp),y

	sub #'a'
	asl @
	tax

	tya
	asl @
	tay

	lda ShowScore.leters,x
	sta (fadr),y
	iny
	lda ShowScore.leters+1,x
	sta (fadr),y
	rts

idx	brk
tim	brk

.endl


.local	SortScore

	ldy #0
lp2
	ldx #0
lp
	sec

	.rept score_cnt
	lda scoreBoard+score_cnt-1-#,x
	sbc scoreBoard+score_cnt-1-#,y
	.endr

	bpl skp

	jsr swap

skp	txa
	add #score_all
	tax

	cpx #6*score_all
	bne lp

	tya
	add #score_all
	tay

	cpy #6*score_all
	bne lp2

	ldy #0
	ldx #6

find	lda scoreBoard,x
	beq stop

	txa
	add #score_all
	tax

	iny
	cpy #5
	bne find

stop	sty newPos

	rts

swap	:score_all mva scoreBoard+#,y scoreTemp+#
	:score_all mva scoreBoard+#,x scoreBoard+#,y
	:score_all mva scoreTemp+# scoreBoard+#,x

	rts

scoreTemp :score_all brk

.endl


.local	ShowScore

	mwa #scoreBoard fhlp
	mwa #ranking+40+10 fcnt

	mva #5 cnt

loop	ldy #0

lp1	lda (fhlp),y		; zdobyte punkty
	asl @
	tax

	lda digits,x
	pha
	lda digits+1,x
	pha

	iny
	cpy #score_cnt
	bne lp1

	lda #$2f		; spacja
	pha
	pha

lp2	lda (fhlp),y		; ksywka
	sne
	lda #'a'

	sub #'a'
	asl @
	tax

	lda leters,x
	pha
	lda leters+1,x
	pha

	iny
	cpy #score_cnt+3
	bne lp2

	lda #$2f		; spacja
	pha
	pha

	lda #$46		; gwiazdka
	pha
	lda #$47
	pha

lp3	lda (fhlp),y		; nr levelu
	asl @
	tax

	lda digits,x
	pha
	lda digits+1,x
	pha

	iny
	cpy #score_cnt+3+2
	bne lp3

	ldy #score_cnt*2+16-1

lpx	pla
	sta (fcnt),y
	dey
	bpl lpx

	adw fhlp #score_all
	adw fcnt #40

	dec cnt
	bne loop

	rts

cnt	brk

digits	ins 'g2f\ranking.scr',80,20
leters	ins 'g2f\ranking.scr',0,40+12

.endl


.local	ScoreMode

// regA = 0	TOUR
// regA <> 0	PANIC

	tay
	seq
	ldy #10

	ldx #0
cp	lda ltmode,y
	sta ranking+18,x
	iny
	inx
	cpx #10
	bne cp

	rts

ltmode	ins 'g2f\ranking.scr',120,20

.endl

// po posortowaniu pierwsze 5 miejsc zajma najwyzsze wyniki
// ostatni wpis _NEW jest niewidoczny na tablicy
// wpis _NEW sluzy do wprowadzenia nowego wyniku, jesli wejdzie na tablice to uzupelniamy 3 literowa ksywke

/*
.local	ScoreBoard
	dta 0,1,0,0,0,0, d'aaa', 3,4
	dta 0,2,0,0,0,0, d'bbb', 5,6
	dta 0,4,0,0,3,0, d'ccc', 7,8
	dta 0,4,0,0,3,1, d'ddd', 9,0
	dta 0,0,5,0,0,0, d'eee', 1,2

_new	dta 0,3,0,0,0,0, d'   ', 0,0		; na podstawie pustego wpisu inicjalow zostanie ustalona pozycja na tablicy
.endl
*/
	.link 'rle\rle.obx'

pmgrle	ins 'gameover_pmg.rle'


	.print 'end: ',*


	ift TEST
	run main
	els
	org	$ffe0
	jmp	main

msxPlay	jmp	rts_
msxStop	jmp	rts_

	eif

; ---


USESPRITES = 1

.MACRO	DLINEW
	mva <:1 NMI.dliv
	ift [>?old_dli]<>[>:1]
	mva >:1 NMI.dliv+1
	eif

	ift :2
	lda regA
	eif

	ift :3
	ldx regX
	eif

	ift :4
	ldy regY
	eif

	rti

	.def ?old_dli = *
.ENDM

