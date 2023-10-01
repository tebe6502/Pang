/***************************************/
/*  Use MADS http://mads.atari8.info/  */
/*  Mode: DLI (char mode)              */
/***************************************/

	opt l-
	icl "mapa.h"
	opt l+

	org $e0

tmp	.ds 1
fcnt	.ds 2
fadr	.ds 2
fhlp	.ds 2
cloc	.ds 1
regA	.ds 1
regX	.ds 1
regY	.ds 1

zpage	.ds 1

	.print *

WIDTH	= 40
HEIGHT	= 27

; ---	MAIN PROGRAM
	org $2000

fnt	ins "mapa_OK.fnt",0,5*1024+80*8

ant	dta $70
	dta $70,$44,a(scr),$04,$04,$04,$84,$84,$84,$84,$04,$04,$84,$04,$84,$84,$04
	dta $84,$84,$84,$04,$84,$84,$84,$84,$84,4
	dta $41,a(ant)

scr	ins "mapa_OK.scr"

	.ds 40*2

main
; ---	init PMG

	lda:rne vcount

	ift USESPRITES
	mva >pmg pmbase		;missiles and players data address
	mva #$03 pmcntl		;enable players and missiles
	eif

	sei			;stop IRQ interrupts
	mva #$00 nmien		;stop NMI interrupts
	sta dmactl
	mva #$fe portb		;switch off ROM to get 16k more ram

	mwa #NMI $fffa		;new NMI handler

	jsr fade_chars.init


// --------------------------------------------------------------------------------------
//	wylaczenie wszystkich kulek
// --------------------------------------------------------------------------------------

	mva #11 tmp

loop0	ldx tmp

	jsr set_jsr

	adw _jsr #2

	lda #0

	jsr set_val

	dec tmp
	bpl loop0


// --------------------------------------------------------------------------------------
//	zapalenie kulek wg levelu
// --------------------------------------------------------------------------------------

	ldx nstage
	beq skp

	stx max

	mva #{jsr} set_val

	mva #0 tmp

loop2	ldx tmp

	jsr set_jsr

	ldx #$0c
	ldy #$06

	jsr set_val

	inc tmp
	lda tmp
	cmp #0
max	equ *-1
	bne loop2

skp

// --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------

	mva #$c0 nmien		;switch on NMI+DLI again

	lda #1
	jsr fade_chars

	wait #16

// --------------------------------------------------------------------------------------
//	zapalenie nowej kulki
// --------------------------------------------------------------------------------------

	mva #{jmp} set_val

	ldx nstage
	stx tmp		; nr aktualnego levelu

	ldx tmp

	jsr set_jsr

lpcl0	lda #$1a
cl0	equ *-1
	cmp #$1f
	beq st0
	tax
	tay

	jsr set_val

	wait #1

	inc cl0
	jmp lpcl0

k0	dta $1f
k1	dta $1f

st0	ldx k0
	cpx #$e
	seq
	dec k0

	ldy k1
	cpy #$24
	seq
	inc k1

	jsr set_val

	wait #1

	lda k0
	cmp #$e
	seq
	jmp st0

st1

	mva #{jsr} set_val

	ldx #$0e
	ldy #$24
	jsr set_val


// --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
	
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

stop
	.ifdef FADE_CHARS\ lda #0\ jsr fade_chars\ eif

	mva #$00 pmcntl		;PMG disabled
	tax
	sta:rne hposp0,x+

	mva #$ff portb		;ROM switch on
	mva #$40 nmien		;only NMI interrupts, DLI disabled
	cli			;IRQ enabled

	rts			;return to ... DOS

/* -------------------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------------------- */

wait	.proc (.byte x) .reg
loop	lda:cmp:req cloc
	dex
	bne loop
	rts
	.endp


plot	.proc (.byte x,y)	.reg
/*
	inc step

	lda #0
step	equ *-1
	and #3
	seq
	rts
*/
	stx rX
	sty rY

	dey
	jsr _plot

	ldx rX
	ldy rY
	iny
	jsr _plot

	ldx rX
	ldy rY
	dex
	jsr _plot

	ldx rX
	ldy rY
	jsr _plot

	ldx #0
rX	equ *-1
	ldy #0
rY	equ *-1

	rts
.endp


_plot	.local

	stx rX
	sty rY

	tya
	:3 lsr @
	tay
	lda tab,y
	sta fhlp+1

	lda fade_chars.plot.lmul,y	; obliczamy adres do znaku
	add <scrn
	sta fadr
	lda fade_chars.plot.hmul,y
	adc >scrn
	sta fadr+1

	txa
	:2 lsr @
	tay

	lda (fadr),y
	and #$7f

	sta fcnt
	lda #0

	asl fcnt
	rol @
	asl fcnt
	rol @
	asl fcnt
	rol @

	sta fcnt+1

	lda fcnt			; adres do definicji znaku w zestawie
	add #0
	sta fhlp
	lda fcnt+1
	adc fhlp+1
	sta fhlp+1

	lda #0
rY	equ *-1
	and #7
	tay

	lda #0
rX	equ *-1
	and #3
	tax

	lda (fhlp),y
	and msk,x
	ora pix,x
	sta (fhlp),y

stop	rts

msk	dta %11000000^$ff
	dta %00110000^$ff
	dta %00001100^$ff
	dta %00000011^$ff

pix	dta %10000000
	dta %00100000
	dta %00001000
	dta %00000010

tab	.get 'mapa_OK.tab'

	:25 dta h(fnt+.get[#]*$400)
	.endl

	
set_jsr	mva lline,x _lne
	mva hline,x _lne+1

	lda order,x
	tax

	mva ladr,x _jsr
	mva hadr,x _jsr+1

	rts

set_val	jmp $ffff
_jsr	equ *-2

	jmp $ffff
_lne	equ *-2

	.rept 16,#
	.ifdef dli.x%%1
b%%1	lda #dli.x%%1_
	sta dli.x%%1+1
	stx dli.x%%1_0+1
	sty dli.x%%1_1+1
	rts
	eif

	.ifdef nmi.x%%1
b%%1	lda #nmi.x%%1_
	sta nmi.x%%1+1
	stx nmi.x%%1_0+1
	sty nmi.x%%1_1+1
	rts
	eif
	.endr

order	dta 9,11,7,5,3,8,2,0,1,6,4,10

ladr	dta l(b0,b1,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12)
hadr	dta h(b0,b1,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12)

lline	:12 dta l(ln%%1)
hline	:12 dta h(ln%%1)

ln1	line #7 #154 #33 #187
ln0	rts

ln2	line #33 #187 #44 #116
	rts

ln3	line #44 #116 #24 #97
	rts

ln4	line #24 #97 #52 #69
	rts

ln5	line #52 #69 #79 #139
	rts

ln6	line #79 #139 #75 #56
	rts

ln7	line #75 #56 #66 #24
	rts

ln8	line #66 #24 #86 #34
	rts

ln9	line #86 #34 #113 #98
	rts

ln10	line #113 #98 #146 #69
	rts

ln11	line #146 #69 #148 #172
	rts

/* -------------------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------------------- */

; ---	DLI PROGRAM

.local	DLI

	?old_dli = *

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

	pm1 "3" $76

	DLINEW dli4 1 0 0

dli4
	sta regA
	lda >fnt+$400*$01
	sta wsync		;line=72
	sta chbase
	DLINEW dli14 1 0 0

dli14
	sta regA

	pm1 "4" $61
	pm2 "5" $be

	DLINEW dli5 1 0 0

dli5
	sta regA
	lda >fnt+$400*$02
	sta wsync		;line=104
	sta chbase
	sta wsync		;line=105

	pm1 "6" $44
	pm2 "7" $9e

	DLINEW dli15 1 0 0

dli15
	sta regA

	sta wsync		;line=120
	sta wsync		;line=121
	sta wsync		;line=122
	sta wsync		;line=123
	sta wsync		;line=124
	sta wsync		;line=125
	
	pm1 "8" $58

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

	pm1 "9" $7b

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

	pm1 "10" $33

	DLINEW dli18 1 0 0

dli18
	sta regA

	sta wsync		;line=176
	sta wsync		;line=177
	sta wsync		;line=178
	sta wsync		;line=179
	sta wsync		;line=180

	pm1 "11" $c0

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

	pm1 "12" $4d

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

	sta hposm0
	sta hposm1
	sta hposm2
	sta hposm3
	sta sizem
	sta sizep0
	sta sizep1
	sta sizep2
	sta sizep3

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

	pm2 "0" $6f
	pm1 "1" $82

	mwa #DLI.dli_start dliv	;set the first address of DLI interrupt

;this area is for yours routines

quit	lda regA
	ldx regX
	ldy regY
	rti

.endp


; ---

	icl 'mapa.hcl'
	icl 'mapa.pmf'

	.link 'line.obx'

// --------------------------------------------------------------------------------------

nstage	dta 5			; numer levelu 0..11

// --------------------------------------------------------------------------------------


.print *

	run main
; ---

	opt l-


USESPRITES = 1

.macro	pm1
	.def x%%1_ = %%2
	.def x%%1
	lda #%%2
	sta hposp0
	sta hposp1
	.def x%%1_0
	lda #$0C
	sta colpm0
	.def x%%1_1
	lda #$06
	sta colpm1
.endm


.macro	pm2
	.def x%%1_ = %%2
	.def x%%1
	lda #%%2
	sta hposp2
	sta hposp3
	.def x%%1_0
	lda #$0C
	sta colpm2
	.def x%%1_1
	lda #$06
	sta colpm3
.endm


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

