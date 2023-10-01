/***************************************/
/*  Use MADS http://mads.atari8.info/  */
/*  Mode: DLI (char mode)              */
/***************************************/

	icl "GameOver.h"

	org $f0

fcnt	.ds 2
fadr	.ds 2
fhlp	.ds 2
cloc	.ds 1
regA	.ds 1
regX	.ds 1
regY	.ds 1

WIDTH	= 40
HEIGHT	= 30

; ---	BASIC switch OFF
	org $2000\ mva #$ff portb\ rts\ ini $2000

; ---	MAIN PROGRAM
	org $2000
ant	dta $44,a(scr)
	dta $84,$84,$04,$84,$04,$04,$04,$84,$84,$04,$84,$84,$84,$84,$04,$84
	dta $84,$84,$84,$84,$04,$82,$02,$02,$02,$02,$82,$02,$04
	dta $41,a(ant)

scr	ins "GameOver.scr"

	.ds 0*40

	.ALIGN $0400
fnt	ins "GameOver.fnt"

	ift USESPRITES
	.ALIGN $0800
pmg	.ds $0300
	ift FADECHR = 0
	SPRITES
	els
	.ds $500
	eif
	eif

main
; ---	init PMG

	ift USESPRITES
	mva >pmg pmbase		;missiles and players data address
	mva #$03 pmcntl		;enable players and missiles
	eif

	ift CHANGES		;if label CHANGES defined
	jsr save_color		;then save all colors and set value 0 for all colors
	eif

	lda:cmp:req $14		;wait 1 frame

	sei			;stop IRQ interrupts
	mva #$00 nmien		;stop NMI interrupts
	sta dmactl
	mva #$fe portb		;switch off ROM to get 16k more ram

	mwa #NMI $fffa		;new NMI handler

	mva #$c0 nmien		;switch on NMI+DLI again

	ift CHANGES		;if label CHANGES defined

	jsr fade_in		;fade in colors

_lp	lda trig0		; FIRE #0
	beq stop

	lda trig1		; FIRE #1
	beq stop

	lda consol		; START
	and #1
	beq stop

	lda skctl
	and #$04
	bne _lp			;wait to press any key; here you can put any own routine

	jsr fade_out		;fade out colors

	els

null	jmp DLI.dli1		;CPU is busy here, so no more routines allowed

	eif


stop
	mva #$00 pmcntl		;PMG disabled
	tax
	sta:rne hposp0,x+

	mva #$ff portb		;ROM switch on
	mva #$40 nmien		;only NMI interrupts, DLI disabled
	cli			;IRQ enabled

	rts			;return to ... DOS

; ---	DLI PROGRAM

.local	DLI

	?old_dli = *

	ift !CHANGES

dli1	lda trig0		; FIRE #0
	beq stop

	lda trig1		; FIRE #1
	beq stop

	lda consol		; START
	and #1
	beq stop

	lda skctl
	and #$04
	beq stop

	lda vcount
	cmp #$02
	bne dli1

	:3 sta wsync

	DLINEW dli10

	eif

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
	lda >fnt+$400*$02
c44	ldx #$08
	sta wsync		;line=176
	sta chbase
	stx color1
	DLINEW dli6 1 1 1

dli6
	sta regA
	lda >fnt+$400*$04
	sta wsync		;line=184
	sta chbase
	DLINEW dli7 1 0 0

dli7
	sta regA
	lda >fnt+$400*$00
	sta wsync		;line=224
	sta chbase

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

; Initial values

	lda >fnt+$400*$00
	sta chbase
c0	lda #$00
	sta colbak
c1	lda #$0E
	sta color0
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
s0	lda #$00
	sta sizep0
	sta sizep2
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
s1	lda #$00
	sta sizep3
s2	lda #$C0
	sta sizem
x3	lda #$44
	sta hposp3
x4	lda #$B0
	sta hposm3
c7	lda #$0E
	sta colpm3
s3	lda #$00
	sta sizep1
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

quit
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

	run main
; ---

	opt l-

.MACRO	SPRITES
missiles
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 02 02 03 03 02 02 02 03
	.he 03 C2 C2 C0 C2 C0 C2 C0 C0 C0 C0 C0 C0 C0 C0 C0
	.he C0 C0 C0 C0 C0 C0 C8 CC C0 CC C8 C4 C5 C7 C8 08
	.he 08 08 00 00 00 08 48 0C 08 48 48 CC CC CC CC CC
	.he CC CC CC CC CC C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0
	.he C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0
	.he C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 F0 F0 F0 F0 F0 F0
	.he F0 F0 F0 F4 C0 CC C8 CC CC CC CC CC CC C0 C0 C0
	.he C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0
	.he C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
player0
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 19 3C 3E 7F 7F 3F 7F 3F 7F FF 7F FF 7F
	.he FF 2F 7F 06 3F 00 2F 00 03 00 01 00 1E 00 0C 00
	.he 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 0C 1E 3E 7E 79 FD F9 FD FF 9D BF
	.he BF BF 3F 3F 3E 3E 3E 3E 3E 3E 3E 3C 3C 3C 3D 3D
	.he 18 18 18 18 00 81 FF FF FF FF FF FF 7F 3E 02 2E
	.he 7E 7E 5E 7E 00 00 02 06 0E 0E 0E 0E 2E 2E 2E 24
	.he 20 26 26 06 00 08 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
player1
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 07 11 58 FE FE FF BE B8 B9 F8 7F 3F
	.he 3C 1F 00 00 0A 00 01 00 02 02 26 76 26 0D AE F6
	.he FC 38 00 60 C5 FC FC FC FE FE 7E 7E 3F 3F 1F 64
	.he 34 FA 7A 7A 3D BD 9D 1C 1E 0E 30 70 70 78 6A EA
	.he DA DB F3 B1 21 C1 00 00 00 00 6C 72 FA FE FD FD
	.he 7F FE FE FE FE DE FE FE FE FC F8 F8 E0 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
player2
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 FF FF FF FF FF FF FF FE FE FF FD FD F9
	.he 7B 7B 73 B2 B6 A6 26 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 40 48 41 41 61 7D 7D 7D 7D 7D 7D 7D 7C 7C 7C F8
	.he F8 FA 70 40 00 AA 40 80 40 A0 70 B8 3C BE FD BE
	.he FD 7C FE 7C F8 60 FA F0 C0 04 84 04 08 1C 08 10
	.he 08 10 30 10 10 10 3A 10 38 1C FC FE FC FE FC FF
	.he FE FF FF FF FF FF FF FF 80 00 80 00 80 45 C0 40
	.he E0 F0 70 70 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
player3
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 0C 0C 0C 0C 0C 0C 0C 0C
	.he 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C
	.he 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 8A C2 EB 0C 0C
	.he 0C 08 02 04 00 80 81 03 01 1F 1D 3F 3E 3E 3F 3E
	.he 3E 3F 3F 3F 3F 3F 3F 3F 3F 3F 1F 3F 1F 3F 1F 3F
	.he 1F 0E 1F 3F 7F 7F 7F 39 05 12 39 10 00 00 00 00
	.he 80 00 00 00 10 08 00 00 01 00 08 08 0C 0C 0C 0C
	.he 0C 0C 0C 0C 0C 0C 0C 0C 0C 8C 8C 8C 8C 8C CC CC
	.he CC CC CC EC EC EC E4 E4 F4 F4 74 70 70 78 38 B8
	.he B8 FC FC FC FC FE 7E 7E 3E 3F 1F 1F 0F 0F 17 17
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
.ENDM

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

