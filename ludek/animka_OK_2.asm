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

	ift .def CHANGES	;if label CHANGES defined
	jsr save_color		;then save all colors and set value 0 for all colors
	eif

	lda:cmp:req 20		;wait 1 frame

	sei			;stop IRQ interrupts
	mva #0 $d40e		;stop NMI interrupts
	mva #$fe $d301		;switch off ROM to get 16k more ram

	mwa #NMI $fffa		;new NMI handler

	mva #$c0 $d40e		;switch on NMI+DLI again


	ift .def CHANGES	;if label CHANGES defined

	jsr fade_in		;fade in colors
_lp	lda $d20f		;wait to press any key; here you can put any own routine
	and #4
	bne _lp
	jsr fade_out		;fade out colors
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
	jmp NMI.quit
dli_start


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

	mva #scr32 $d400	;set new screen's width

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
	lda #$21
	sta gtictl
	lda #$00
	sta sizep0
	sta sizep1
	sta sizep2
	sta sizep3
	sta sizem
	lda #$68
	sta hposp0
	sta hposp1
	sta hposp2
	sta hposp3
	lda #$70
	sta hposm0
	sta hposm1
	sta hposm2
	sta hposm3
c5	lda #$06
	sta colpm0
c6	lda #$78
	sta colpm1
c7	lda #$02
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

.ENDP

;---
	icl 'animka_OK_2.fad'

	run main

;---

	opt l-

.macro	SPRITES
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$20,$B2,$B8,$FB,$F7,$30
	dta $F2,$E0,$70,$B2,$B2,$20,$B8,$FE,$D5,$F3,$F0,$D0,$F1,$B2,$30,$B8
	dta $B8,$B2,$20,$20,$20,$20,$20,$20,$00,$00,$20,$B2,$B8,$FB,$F7,$30
	dta $F2,$E0,$70,$B2,$B2,$20,$B8,$FE,$D5,$F3,$F0,$D0,$F1,$B2,$30,$B8
	dta $20,$20,$A2,$B0,$F2,$30,$FE,$B2,$00,$00,$20,$B2,$B8,$FB,$F7,$30
	dta $F2,$E0,$70,$B2,$B2,$20,$B8,$FE,$D5,$F3,$F0,$D0,$F1,$B2,$30,$B8
	dta $20,$20,$20,$00,$20,$20,$20,$00,$00,$00,$20,$B2,$B8,$FB,$F7,$30
	dta $F2,$E0,$70,$B2,$B2,$20,$B8,$FE,$D5,$F3,$F0,$D0,$F1,$B2,$30,$B8
	dta $B8,$B2,$20,$20,$20,$20,$20,$20,$00,$00,$20,$B2,$B8,$FB,$F7,$30
	dta $F2,$E0,$70,$B2,$B2,$20,$B8,$FE,$D5,$F3,$F0,$D0,$F1,$B2,$30,$B8
	dta $20,$20,$A0,$90,$E0,$70,$FE,$B2,$00,$00,$20,$B2,$B8,$FB,$F7,$30
	dta $F2,$E0,$70,$B2,$B2,$20,$B8,$FE,$D5,$F3,$F0,$D0,$F1,$B2,$30,$B8
	dta $20,$20,$20,$30,$B0,$B8,$B2,$20,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F

	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$0F,$1D,$23,$10,$2D
	dta $18,$00,$01,$00,$00,$84,$00,$6C,$01,$08,$62,$49,$14,$00,$0C,$01
	dta $01,$00,$00,$01,$00,$01,$02,$03,$00,$00,$02,$0F,$1D,$23,$10,$2D
	dta $18,$00,$01,$00,$00,$84,$00,$6C,$01,$08,$62,$49,$14,$00,$0C,$01
	dta $03,$09,$02,$01,$00,$10,$10,$18,$00,$00,$02,$0F,$1D,$23,$10,$2D
	dta $18,$00,$01,$00,$00,$84,$00,$6C,$01,$08,$62,$49,$14,$00,$0C,$01
	dta $03,$09,$00,$02,$09,$00,$09,$0C,$00,$00,$02,$0F,$1D,$23,$10,$2D
	dta $18,$00,$01,$00,$00,$84,$00,$6C,$01,$08,$62,$49,$14,$00,$0C,$01
	dta $01,$00,$00,$01,$00,$01,$02,$03,$00,$00,$02,$0F,$1D,$23,$10,$2D
	dta $18,$00,$01,$00,$00,$84,$00,$6C,$01,$08,$62,$49,$14,$00,$0C,$01
	dta $03,$09,$02,$04,$04,$10,$10,$18,$00,$00,$02,$0F,$1D,$23,$10,$2D
	dta $18,$00,$01,$00,$00,$84,$00,$6C,$01,$08,$62,$49,$14,$00,$0C,$01
	dta $03,$09,$00,$04,$08,$01,$09,$08,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$07,$00,$1D,$3C,$20,$00
	dta $00,$00,$00,$00,$00,$80,$80,$21,$13,$25,$46,$00,$00,$00,$00,$00
	dta $03,$01,$00,$00,$00,$00,$03,$04,$00,$00,$07,$00,$1D,$3C,$20,$00
	dta $00,$00,$00,$00,$00,$80,$80,$21,$13,$25,$46,$00,$00,$00,$00,$00
	dta $0B,$06,$00,$00,$00,$00,$18,$20,$00,$00,$07,$00,$1D,$3C,$20,$00
	dta $00,$00,$00,$00,$00,$80,$80,$21,$13,$25,$46,$00,$00,$00,$00,$00
	dta $0B,$06,$00,$00,$00,$00,$0C,$10,$00,$00,$07,$00,$1D,$3C,$20,$00
	dta $00,$00,$00,$00,$00,$80,$80,$21,$13,$25,$46,$00,$00,$00,$00,$00
	dta $03,$01,$00,$00,$00,$00,$03,$04,$00,$00,$07,$00,$1D,$3C,$20,$00
	dta $00,$00,$00,$00,$00,$80,$80,$21,$13,$25,$46,$00,$00,$00,$00,$00
	dta $0B,$06,$00,$00,$00,$00,$18,$20,$00,$00,$07,$00,$1D,$3C,$20,$00
	dta $00,$00,$00,$00,$00,$80,$80,$21,$13,$25,$46,$00,$00,$00,$00,$00
	dta $0B,$06,$00,$00,$00,$01,$0A,$10,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$07,$0F,$1F,$3D,$7F,$7F,$7F
	dta $3D,$1F,$17,$1D,$9D,$CF,$BB,$FF,$FF,$7D,$FF,$FF,$74,$2F,$1F,$0F
	dta $07,$03,$07,$05,$07,$07,$0B,$0F,$00,$07,$0F,$1F,$3D,$7F,$7F,$7F
	dta $3D,$1F,$17,$1D,$9D,$CF,$BB,$FF,$FF,$7D,$FF,$FF,$74,$2F,$1F,$0F
	dta $0B,$0F,$0F,$1B,$17,$3C,$5D,$7D,$00,$07,$0F,$1F,$3D,$7F,$7F,$7F
	dta $3D,$1F,$17,$1D,$9D,$CF,$BB,$FF,$FF,$7D,$FF,$FF,$74,$2F,$1F,$0F
	dta $0B,$0F,$0F,$0B,$1B,$1F,$2F,$3F,$00,$07,$0F,$1F,$3D,$7F,$7F,$7F
	dta $3D,$1F,$17,$1D,$9D,$CF,$BB,$FF,$FF,$7D,$FF,$FF,$74,$2F,$1F,$0F
	dta $07,$03,$07,$05,$07,$07,$0B,$0F,$00,$07,$0F,$1F,$3D,$7F,$7F,$7F
	dta $3D,$1F,$17,$1D,$9D,$CF,$BB,$FF,$FF,$7D,$FF,$FF,$74,$2F,$1F,$0F
	dta $0B,$0F,$0F,$1F,$1F,$3C,$5D,$7D,$00,$07,$0F,$1F,$3D,$7F,$7F,$7F
	dta $3D,$1F,$17,$1D,$9D,$CF,$BB,$FF,$FF,$7D,$FF,$FF,$74,$2F,$1F,$0F
	dta $0B,$0F,$0F,$0D,$1F,$1D,$2F,$3F,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$07,$0F,$1F,$3F,$30,$2F
	dta $1F,$0B,$0B,$1F,$0F,$87,$CE,$6D,$93,$EF,$E6,$49,$1F,$1F,$0C,$01
	dta $03,$01,$02,$03,$03,$01,$07,$07,$00,$00,$07,$0F,$1F,$3F,$30,$2F
	dta $1F,$0B,$0B,$1F,$0F,$87,$CE,$6D,$93,$EF,$E6,$49,$1F,$1F,$0C,$01
	dta $0F,$0F,$06,$0D,$0C,$18,$38,$38,$00,$00,$07,$0F,$1F,$3F,$30,$2F
	dta $1F,$0B,$0B,$1F,$0F,$87,$CE,$6D,$93,$EF,$E6,$49,$1F,$1F,$0C,$01
	dta $0F,$0F,$06,$06,$0D,$0C,$1D,$1C,$00,$00,$07,$0F,$1F,$3F,$30,$2F
	dta $1F,$0B,$0B,$1F,$0F,$87,$CE,$6D,$93,$EF,$E6,$49,$1F,$1F,$0C,$01
	dta $03,$01,$02,$03,$03,$01,$07,$07,$00,$00,$07,$0F,$1F,$3F,$30,$2F
	dta $1F,$0B,$0B,$1F,$0F,$87,$CE,$6D,$93,$EF,$E6,$49,$1F,$1F,$0C,$01
	dta $0F,$0F,$02,$0D,$0C,$18,$38,$38,$00,$00,$07,$0F,$1F,$3F,$30,$2F
	dta $1F,$0B,$0B,$1F,$0F,$87,$CE,$6D,$93,$EF,$E6,$49,$1F,$1F,$0C,$01
	dta $0F,$0F,$06,$07,$09,$0B,$1B,$18,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
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
	dta $44,a(:1),$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	dta $04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	dta $41,a(:2)
.endm

.macro	SCREEN_DATA
	ins 'animka_OK_2.scr'
.endm

.macro	FONTS
	ins 'animka_OK_2.fnt'
.endm
