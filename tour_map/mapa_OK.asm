/***************************************/
/*  Use MADS http://mads.atari8.info/  */
/*  Mode: DLI (char mode)              */
/***************************************/

	icl "mapa_OK.h"

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
ant	dta $70
	dta $70,$44,a(scr),$04,$04,$04,$84,$84,$84,$84,$04,$04,$84,$04,$84,$84,$04
	dta $84,$84,$84,$04,$84,$84,$84,$84,$84,$84,$70,$70,$70
	dta $41,a(ant)

scr	ins "mapa_OK.scr"

	.ds 5*40

	.ALIGN $0400
fnt	ins "mapa_OK.fnt"

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

	lda:cmp:req $14		;wait 1 frame

	sei			;stop IRQ interrupts
	mva #$00 nmien		;stop NMI interrupts
	sta dmactl
	mva #$fe portb		;switch off ROM to get 16k more ram

	mwa #NMI $fffa		;new NMI handler

	.ifdef FADE_CHARS\ jsr fade_chars.init\ eif

	mva #$c0 nmien		;switch on NMI+DLI again

	ift CHANGES		;if label CHANGES defined

	.ifdef FADE_CHARS\ lda #1\ jsr fade_chars\ eif

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

	els

null	jmp DLI.dli1		;CPU is busy here, so no more routines allowed

	eif


stop
	.ifdef FADE_CHARS\ lda #0\ jsr fade_chars\ eif

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

	DLINEW DLI.dli2
	eif


dli_start

dli2
	sta regA
	lda >fnt+$400*$01
	sta wsync		;line=56
	sta chbase
	DLINEW dli3 1 0 0

dli3
	sta regA
	lda >fnt+$400*$00
	sta wsync		;line=64
	sta chbase
	sta wsync		;line=65
x3	lda #$76
	sta wsync		;line=66
	sta hposp0
	sta hposp1
	DLINEW dli4 1 0 0

dli4
	sta regA
	lda >fnt+$400*$01
	sta wsync		;line=72
	sta chbase
	DLINEW dli14 1 0 0

dli14
	sta regA
	stx regX

x4	lda #$61
x5	ldx #$BE
	sta wsync		;line=80
	sta hposp0
	sta hposp1
	stx hposp2
	stx hposp3
	DLINEW dli5 1 1 0

dli5
	sta regA
	lda >fnt+$400*$02
	sta wsync		;line=104
	sta chbase
	sta wsync		;line=105
x6	lda #$44
	sta wsync		;line=106
	sta hposp0
	sta hposp1
x7	lda #$9E
	sta wsync		;line=107
	sta hposp2
	sta hposp3
	DLINEW dli15 1 0 0

dli15
	sta regA

	sta wsync		;line=120
	sta wsync		;line=121
	sta wsync		;line=122
	sta wsync		;line=123
	sta wsync		;line=124
	sta wsync		;line=125
x8	lda #$58
	sta wsync		;line=126
	sta hposp0
	sta hposp1
	DLINEW dli6 1 0 0

dli6
	sta regA
	lda >fnt+$400*$03
	sta wsync		;line=128
	sta chbase
	DLINEW dli16 1 0 0

dli16
	sta regA

	sta wsync		;line=144
	sta wsync		;line=145
	sta wsync		;line=146
	sta wsync		;line=147
	sta wsync		;line=148
x9	lda #$7B
	sta wsync		;line=149
	sta hposp0
	sta hposp1
	DLINEW dli7 1 0 0

dli7
	sta regA
	lda >fnt+$400*$04
	sta wsync		;line=152
	sta chbase
	DLINEW dli17 1 0 0

dli17
	sta regA

	sta wsync		;line=160
	sta wsync		;line=161
	sta wsync		;line=162
	sta wsync		;line=163
x10	lda #$33
	sta wsync		;line=164
	sta hposp0
	sta hposp1
	DLINEW dli18 1 0 0

dli18
	sta regA

	sta wsync		;line=176
	sta wsync		;line=177
	sta wsync		;line=178
	sta wsync		;line=179
	sta wsync		;line=180
x11	lda #$C0
	sta wsync		;line=181
	sta hposp0
	sta hposp1
	DLINEW dli8 1 0 0

dli8
	sta regA
	lda >fnt+$400*$05
	sta wsync		;line=184
	sta chbase
	DLINEW dli19 1 0 0

dli19
	sta regA

	sta wsync		;line=192
	sta wsync		;line=193
	sta wsync		;line=194
	sta wsync		;line=195
	sta wsync		;line=196
x12	lda #$4D
	sta wsync		;line=197
	sta hposp0
	sta hposp1
	DLINEW dli9 1 0 0

dli9
	sta regA
	lda >fnt+$400*$02
	sta wsync		;line=200
	sta chbase
	DLINEW dli10 1 0 0

dli10
	sta regA
	lda >fnt+$400*$05
	sta wsync		;line=208
	sta chbase
	DLINEW dli11 1 0 0

dli11
	sta regA
	lda >fnt+$400*$00
	sta wsync		;line=216
	sta chbase

	lda regA
	rti

.endl

; ---

CHANGES = 1
FADECHR	= 3

SCHR	= 0

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
	lda #$02
	sta chrctl
	lda #$21
	sta gtictl
c1	lda #$76
	sta color0
c2	lda #$EE
	sta color1
c3	lda #$1A
	sta color2
c4	lda #$74
	sta color3
s0	lda #$00
	sta sizep2
	sta sizep3
x0	lda #$6F
	sta hposp2
	sta hposp3
c5	lda #$0C
	sta colpm2
c6	lda #$06
	sta colpm3
s1	lda #$00
	sta sizep0
	sta sizep1
x1	lda #$82
	sta hposp0
	sta hposp1
c7	lda #$0C
	sta colpm0
c8	lda #$06
	sta colpm1
x2	lda #$00
	sta hposm0
	sta hposm1
	sta hposm2
	sta hposm3
	sta sizem

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
		icl 'mapa_OK.fad'
		els
		icl 'mapa_OK.hcl'
		icl 'mapa_OK.pmf'
		eif
	eif

	run main
; ---

	opt l-

.MACRO	SPRITES
missiles
	.ds $100
player0
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 10 20 00 40 40 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 10 20 00 40
	.he 40 00 00 00 00 00 00 00 00 00 10 20 00 40 40 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 10 20 00 40 40 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 10 20 00 40 40 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10
	.he 20 00 40 40 00 00 00 00 00 00 00 00 00 00 10 20
	.he 00 40 40 00 00 00 00 00 00 00 00 00 00 00 00 10
	.he 20 00 40 40 00 00 00 00 00 00 00 00 00 00 00 08
	.he 10 00 20 20 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
player1
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 18 3C 7E 7E FF FF FF FF FF FF 7E
	.he 7E 3C 18 00 00 00 00 00 00 00 18 3C 7E 7E FF FF
	.he FF FF FF FF 7E 7E 3C 18 18 3C 7E 7E FF FF FF FF
	.he FF FF 7E 7E 3C 18 00 00 00 00 00 00 00 00 00 00
	.he 00 00 18 3C 7E 7E FF FF FF FF FF FF 7E 7E 3C 18
	.he 00 00 00 00 00 00 00 18 3C 7E 7E FF FF FF FF FF
	.he FF 7E 7E 3C 18 00 00 00 00 00 00 00 00 18 3C 7E
	.he 7E FF FF FF FF FF FF 7E 7E 3C 18 00 18 3C 7E 7E
	.he FF FF FF FF FF FF 7E 7E 3C 18 00 00 00 18 3C 7E
	.he 7E FF FF FF FF FF FF 7E 7E 3C 18 00 00 18 3C 7E
	.he 7E FF FF FF FF FF FF 7E 7E 3C 18 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
player2
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 10 20 00 40
	.he 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 10 20 00 40 40 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 10 20 00 40 40 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
player3
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 18 3C 7E 7E FF FF
	.he FF FF FF FF 7E 7E 3C 18 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 18 3C 7E 7E FF FF FF FF
	.he FF FF 7E 7E 3C 18 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 18 3C 7E 7E FF FF FF FF FF FF 7E 7E 3C
	.he 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

