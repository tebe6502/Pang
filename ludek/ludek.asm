/***************************************/
/*  Use MADS http://mads.atari8.info/  */
/*  Mode: DLI (char mode)              */
/***************************************/

scr48	= %00111111	;screen 48b
scr40	= %00111110	;screen 40b
scr32	= %00111101	;screen 32b

cloc	= $0014		;(1)
byt2	= $0000		;(1) <$0100
byt3	= $0100		;(1) >$00FF

ftmp	= $80		;(2)
regA	= ftmp+2	;(1)
regX	= regA+1	;(1)
regY	= regX+1	;(1)

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

chbase	= $D409

* ---	BASIC switch OFF
	org $2000\ mva #$ff $d301\ rts\ ini $2000

* ---	MAIN PROGRAM
	org $2000

ant	ANTIC_PROGRAM scr,ant

scr	SCREEN_DATA

	ALIGN $0400
fnt	FONTS

	ALIGN $0800
	.ds $0300
pmg	SPRITES

main
* ---	init PMG
	mva >pmg $d407		;missiles and players data address
	mva #3 $d01d		;enable players and missiles

	lda:cmp:req 20		;wait 1 frame

	sei			;stop IRQ interrupts
	mva #0 $d40e		;stop NMI interrupts
	mva #$fe $d301		;switch off ROM to get 16k more ram

	mwa #NMI $fffa		;new NMI handler

	mva #$c0 $d40e		;switch on NMI+DLI again


	ift .def CHANGES	;if label CHANGES defined

;	jsr fade_in		;fade in colors
_lp	lda $d20f		;wait to press any key; here you can put any own routine
	and #4
	bne _lp
;	jsr fade_out		;fade out colors
	mva #0   $d01d		;PMG disabled
	ldx #$0c\ sta:rpl $d000,x-
	mva #$ff $d301		;ROM switch on
	mva #$40 $d40e		;only NMI interrupts, DLI disabled
	cli			;IRQ enabled
	jmp ($a)		;jump to DOS

	els

null	jmp dli1		;CPU is busy here, so no more routines allowed

	eif


* ---	DLI PROGRAM

 ?old_dli = *

dli1
	lda $d40b
	cmp #2
	bne dli1
	:3 sta $d40a
	DLINEW dli4

dli_start
dli4

	lda #$32
	ldx #$3A
	sta $d40a		;line=32
	sta hposp0
	sta hposp1
	stx hposm0
	lda #$3A
	sta $d40a		;line=33
	sta hposm1
	DLINEW dli5

dli5

c7	lda #$14
	sta $d40a		;line=128
	sta color2
	DLINEW dli6

dli6

c8	lda #$B6
	sta $d40a		;line=168
	sta color2
	jmp NMI.quit


;---

CHANGES

;---

.PROC NMI
	sta regA
	stx regX
	sty regY

	bit $d40f
	bpl VBL

	jmp dli_start
dliv	equ *-2

VBL
	sta $d40f		;reset NMI flag

	inc cloc		;little timer

	mwa #ant $d402		;ANTIC address program

	mva #scr48 $d400	;set new screen's width

;--- first line of screen initialization

	lda >fnt
	sta chbase
c0	lda #$38
	sta colbak
c1	lda #$0A
	sta color0
c2	lda #$00
	sta color1
c3	lda #$9A
	sta color2
c4	lda #$44
	sta color3
	lda #$24
	sta gtictl
	lda #$00
	sta sizep0
	sta sizep1
	sta sizem
	lda #$30
	sta hposp0
	sta hposp1
	lda #$38
	sta hposm0
	sta hposm1
c5	lda #$04
	sta colpm0
c6	lda #$78
	sta colpm1

	mwa #dli_start dliv	;set the first address of DLI interrupt

;this area is for yours routines

quit
	lda regA
	ldx regX
	ldy regY
	rti

.ENDP

;---
;	icl 'ludek.fad'

	run main

;---

	opt l-

.macro	SPRITES
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$06,$07,$06,$09
	dta $0A,$02,$00,$00,$00,$02,$09,$0E,$01,$08,$00,$00,$02,$00,$02,$0B
	dta $0E,$02,$00,$00,$00,$01,$06,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$02,$08,$0B,$0B,$08,$03,$0C,$0B,$02,$00,$00,$02,$09
	dta $09,$09,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$08,$0A
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
	dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

	dta $00,$00,$00,$00,$00,$00,$00,$00,$17,$2D,$5F,$7E,$BF,$FF,$FE,$BD
	dta $DB,$3D,$C5,$FB,$77,$7F,$D5,$AF,$BF,$B6,$E7,$7F,$56,$7B,$3F,$7D
	dta $55,$2E,$03,$11,$28,$08,$B1,$D9,$00,$00,$00,$00,$00,$00,$00,$00
	dta $18,$28,$32,$99,$7E,$FF,$5F,$AE,$74,$6F,$28,$15,$00,$7D,$AA,$7D
	dta $BB,$13,$39,$37,$5A,$15,$62,$EF,$40,$55,$00,$00,$00,$80,$41,$02
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
	dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

	dta $00,$00,$00,$00,$00,$00,$00,$00,$08,$16,$32,$27,$5F,$7F,$7F,$5E
	dta $2C,$C3,$7E,$2C,$00,$00,$2F,$7F,$77,$73,$36,$2A,$2F,$04,$00,$13
	dta $2A,$11,$00,$00,$00,$00,$40,$60,$00,$00,$00,$00,$00,$00,$00,$00
	dta $04,$1A,$13,$39,$BE,$BF,$BF,$5E,$4D,$30,$1F,$0D,$00,$00,$7D,$FF
	dta $3B,$73,$1B,$15,$3D,$08,$00,$72,$D5,$22,$00,$00,$00,$00,$80,$01
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
	dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

	.ds $100
	.ds $100
.endm

.macro	DLINEW
	ift .hi(?old_dli)==.hi(:1)
	mva <:1 NMI.dliv
	els
	mwa #:1 NMI.dliv
	eif

	jmp NMI.quit

	?old_dli = *
.endm

.macro	ALIGN
	ift (*/:1)*:1<>*
	org (*/:1)*:1+:1
	eif
.endm

.macro	ANTIC_PROGRAM
	dta $44,a(:1),$04,$04,$84,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	dta $04,$84,$04,$04,$04,$04,$84,$04,$04,$04,$04,$04,$04,$04,$04,$04
	dta $41,a(:2)
.endm

.macro	SCREEN_DATA
	ins 'ludek.scr'
.endm

.macro	FONTS
	ins 'ludek.fnt'
.endm
