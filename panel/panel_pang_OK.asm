/***************************************/
/*  Use MADS http://mads.atari8.info/  */
/*  Mode: DLI (char mode)              */
/***************************************/

scr48	= %00111111	;screen 48b
scr40	= %00111110	;screen 40b
scr32	= %00111101	;screen 32b

hposp0	= $D000
hposp1	= $D001
hposp2	= $D002
hposp3	= $D003
hposm0	= $D004
hposm1	= $D005
hposm2	= $D006
hposm3	= $D007
sizep0	= $D008
sizep1	= $D009
sizep2	= $D00A
sizep3	= $D00B
sizem	= $D00C

colpm0	= $D012
colpm1	= $D013
colpm2	= $D014
colpm3	= $D015
color0	= $D016
color1	= $D017
color2	= $D018
color3	= $D019
colbak	= $D01A
gtictl	= $D01B

pmcntl	= $D01D
hitclr	= $D01E

skctl	= $D20F

portb	= $D301

dmactl	= $D400

dlptr	= $D402

pmbase	= $D407

chbase	= $D409
wsync	= $D40A
vcount	= $D40B

nmien	= $D40E
nmist	= $D40F


	org $00

fcnt	.ds 2
fadr	.ds 2
cloc	.ds 1
regA	.ds 1
regX	.ds 1
regY	.ds 1

	.ifdef ZCOLORS
zc	.ds ZCOLORS
	eif


* ---	BASIC switch OFF
	org $2000\ mva #$ff portb\ rts\ ini $2000

* ---	MAIN PROGRAM
	org $2000

ant	ANTIC_PROGRAM scr,ant

scr	SCREEN_DATA

	.ALIGN $0400
fnt	FONTS

	.ifdef USESPRITES
	.ALIGN $0800
	.ds $0300
pmg	SPRITES
	eif

main
* ---	init PMG

	.ifdef USESPRITES
	mva >pmg pmbase		;missiles and players data address
	mva #$03 pmcntl		;enable players and missiles
	eif

	.ifdef CHANGES		;if label CHANGES defined
	jsr save_color		;then save all colors and set value 0 for all colors
	eif

	lda:cmp:req $14		;wait 1 frame

	sei			;stop IRQ interrupts
	mva #$00 nmien		;stop NMI interrupts
	mva #$fe portb		;switch off ROM to get 16k more ram

	mwa #NMI $fffa		;new NMI handler

	mva #$c0 nmien		;switch on NMI+DLI again


	.ifdef CHANGES		;if label CHANGES defined

	jsr fade_in		;fade in colors

_lp	lda skctl		;wait to press any key; here you can put any own routine
	and #$04
	bne _lp

	jsr fade_out		;fade out colors
	mva #$00 pmcntl		;PMG disabled
	tax
	sta:rne hposp0,x+
	mva #$ff portb		;ROM switch on
	mva #$40 nmien		;only NMI interrupts, DLI disabled
	cli			;IRQ enabled
	jmp ($000a)		;jump to DOS

	els

null	jmp dli1		;CPU is busy here, so no more routines allowed

	eif


* ---	DLI PROGRAM

	?old_dli = *

dli1
	lda vcount
	cmp #$02
	bne dli1
	:3 sta wsync
	DLINEW dli14

dli_start
dli14

c9	lda #$E8
	sta wsync		;line=16
	sta color2
	DLINEW dli15

dli15

c10	lda #$74
	ldx #$57
	ldy #$7D
	sta wsync		;line=24
	sta color3
	stx hposm0
	sty hposm3
c11	lda #$18
	sta colpm0
	DLINEW dli16

dli16

c12	lda #$C8
	ldx #$48
	ldy #$79
	sta wsync		;line=32
	sta color3
	stx hposp1
	sty hposm3
c13	lda #$18
	sta colpm1
	DLINEW dli2


dli2
	lda >fnt+$400*$01
c14	ldx #$F8
c15	ldy #$A8
	sta wsync		;line=40
	sta chbase
	stx color2
	sty color3
	DLINEW dli3

dli3
	lda >fnt+$400*$00
	sta wsync		;line=48
	sta chbase
	DLINEW dli4

dli4
	lda >fnt+$400*$01
	sta wsync		;line=56
	sta chbase
	DLINEW dli5

dli5
	lda >fnt+$400*$00
	sta wsync		;line=72
	sta chbase
	DLINEW dli6

dli6
	lda >fnt+$400*$01
	sta wsync		;line=88
	sta chbase
	DLINEW dli7

dli7
	lda >fnt+$400*$00
	sta wsync		;line=104
	sta chbase
	DLINEW dli8

dli8
	lda >fnt+$400*$01
	sta wsync		;line=112
	sta chbase
	DLINEW dli9

dli9
	lda >fnt+$400*$00
	sta wsync		;line=184
	sta chbase
	DLINEW dli10

dli10
	lda >fnt+$400*$01
	sta wsync		;line=192
	sta chbase
	DLINEW dli11

dli11
	lda >fnt+$400*$00
	sta wsync		;line=200
	sta chbase
	jmp NMI.quit

;---

CHANGES

;---

.proc	NMI
	sta regA
	stx regX
	sty regY

	bit nmist
	bpl VBL

	jmp dli_start
dliv	equ *-2

VBL
	sta nmist		;reset NMI flag

	mwa #ant dlptr		;ANTIC address program

	mva #scr48 dmactl	;set new screen's width

	inc cloc		;little timer

;--- first line of screen initialization

	lda >fnt+$400*$00
	sta chbase
c0	lda #$00
	sta colbak
c1	lda #$14
	sta color0
c2	lda #$0A
	sta color1
c3	lda #$18
	sta color2
c4	lda #$98
	sta color3
	lda #$04
	sta gtictl
	lda #$00
	sta sizep0
	lda #$01
	sta sizep1
	sta sizep2
	sta sizep3
	lda #$00
	sta sizem
	lda #$49
	sta hposp0
	lda #$46
	sta hposp1
	lda #$A1
	sta hposp2
	lda #$74
	sta hposp3
	lda #$51
	sta hposm0
	lda #$7F
	sta hposm3
c5	lda #$74
	sta colpm0
c6	lda #$78
	sta colpm1
c7	lda #$08
	sta colpm2
c8	lda #$38
	sta colpm3

	mwa #dli_start dliv	;set the first address of DLI interrupt

;this area is for yours routines

quit
	lda regA
	ldx regX
	ldy regY
	rti

.endp

;---
	.ifdef CHANGES
	icl 'panel_pang_2.fad'
	eif

	run main
;---

	opt l-

.MACRO	SPRITES
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$40,$00,$40,$00,$40,$00,$00,$00,$02
	dta $00,$02,$42,$00,$00,$00,$00,$00,$00,$80,$00,$40,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C

	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3E,$41,$80
	dta $00,$00,$00,$00,$00,$00,$00,$06,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$28,$3C
	dta $24,$60,$7C,$76,$42,$81,$80,$00,$30,$3C,$18,$58,$30,$B8,$B8,$78
	dta $18,$70,$70,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$30,$00,$00,$30,$10,$F8,$78
	dta $30,$FC,$FC,$FC,$F8,$FC,$F8,$78,$FC,$FC,$FC,$7C,$78,$78,$30,$38
	dta $60,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$08,$7C,$F4,$BC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$7C
	dta $7C,$78,$78,$78,$38,$30,$38,$30,$10,$10,$10,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.ENDM

USESPRITES

.MACRO	DLINEW
	mva <:1 NMI.dliv
	ift [>?old_dli]<>[>:1]
	mva >:1 NMI.dliv+1
	eif

	jmp NMI.quit

	.def ?old_dli = *
.ENDM

.MACRO	ANTIC_PROGRAM
	dta $70,$C4,a(:1),$84,$84,$84,$84,$84,$04,$84,$04,$84,$04,$84,$84
	dta $04,$04,$04,$04,$04,$04,$04,$04,$84,$84,$84,$04,$04,$04,$04,$04
	dta $41,a(:2)
.ENDM

.MACRO	SCREEN_DATA
	ins 'panel_pang_2.scr'
.ENDM

.MACRO	FONTS
	ins 'panel_pang_2.fnt'
.ENDM
