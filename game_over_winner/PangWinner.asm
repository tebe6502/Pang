// PANG - WINNER
// 02.09.2016

TEST	= 0

	opt l-
	icl "PangWinner.h"
	opt l+

	ift !TEST
	opt h-f+
	eif

cloc	= $14

	org $80

fcnt	.ds 2
fadr	.ds 2
fhlp	.ds 2
regA	.ds 1
regX	.ds 1
regY	.ds 1

WIDTH	= 40
HEIGHT	= 30

pmg	= 0

; ---	MAIN PROGRAM

	ift TEST
	org $2000
	els
	org $d800
	eif

fnt	ins "PangWinner.fnt",0,6*1024	//5*1024+41*8

ant	dta $44,a(scr)
	dta $84,$84,$84,$84,$84,$84,$84,$04,$84,$84,$04,$04,$84,$04,$04,$84
	dta $84,$04,$04,$84,$84,$84,$84,$84,$84,$84,$84,$04
	dta $41,a(ant)

scr	ins "PangWinner.scr"

tabpp  dta 156,78,52,39			;line counter spacing table for instrument speed from 1 to 4

main
; ---	init PMG

	ift !TEST
	lda tabpp-1,y
	sta acpapx2+1				;sync counter spacing
	lda #86+0
	sta acpapx1+1
	eif

	lda:rne vcount

	mva >pmg pmbase		;missiles and players data address
	mva #$03 pmcntl		;enable players and missiles

	jsr save_color		;then save all colors and set value 0 for all colors

	rle #pmgrle-1 #pmg+$300

	ift TEST
	sei			;stop IRQ interrupts
	mva #$00 nmien		;stop NMI interrupts
	sta dmactl
	mva #$fe portb		;switch off ROM to get 16k more ram
	els
	mva #$00 nmien		;stop NMI interrupts
	eif

	mwa #NMI $fffa		;new NMI handler

	mva #$c0 nmien		;switch on NMI+DLI again

	jsr fade_in		;fade in colors

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

	jmp _lp
stop

	ift !TEST
	jsr msxStop
	eif

rts_	jmp fade_out		;fade out colors


; ---	DLI PROGRAM

.local	DLI

	?old_dli = *

dli_start

dli12
	sta regA

	sta wsync		;line=16
	sta wsync		;line=17
	sta wsync		;line=18
	sta wsync		;line=19
	sta wsync		;line=20
x8	lda #$C5
	sta wsync		;line=21
	sta hposm3
	DLINEW dli13 1 0 0

dli13
	sta regA

x9	lda #$C2
	sta wsync		;line=24
	sta hposm3
	DLINEW dli14 1 0 0

dli14
	sta regA

	sta wsync		;line=32
c9	lda #$16
	sta wsync		;line=33
	sta color1
	DLINEW dli15 1 0 0

dli15
	sta regA
	stx regX
	sty regY

c10	lda #$34
x10	ldx #$B8
c11	ldy #$1A
	sta wsync		;line=40
	sta color2
	stx hposp3
	sty colpm3
	DLINEW dli16 1 1 1

dli16
	sta regA

	sta wsync		;line=48
	sta wsync		;line=49
s4	lda #$10
	sta wsync		;line=50
	sta sizem
c12	lda #$36
	sta wsync		;line=51
	sta color2
	DLINEW dli17 1 0 0

dli17
	sta regA
	stx regX

c13	lda #$38
	sta wsync		;line=56
	sta color2
	sta wsync		;line=57
c14	lda #$36
x11	ldx #$81
	sta wsync		;line=58
	sta color2
	stx hposm2
c15	lda #$38
	sta wsync		;line=59
	sta color2
	DLINEW dli18 1 1 0

dli18
	sta regA
	stx regX
	sty regY

	sta wsync		;line=64
	sta wsync		;line=65
c16	lda #$2A
s5	ldx #$30
	sta wsync		;line=66
	sta color2
	stx sizem
c17	lda #$38
s6	ldx #$10
x12	ldy #$83
	sta wsync		;line=67
	sta color2
	stx sizem
	sty hposm2
c18	lda #$2A
	sta wsync		;line=68
	sta color2
x13	lda #$3C
	sta wsync		;line=69
	sta hposp3
c19	lda #$38
	sta wsync		;line=70
	sta color2
c20	lda #$2A
	sta wsync		;line=71
	sta color2
	lda >fnt+$400*$01
x14	ldx #$95
	sta wsync		;line=72
	sta chbase
	stx hposp0
	sta wsync		;line=73
	sta wsync		;line=74
	sta wsync		;line=75
	sta wsync		;line=76
s7	lda #$13
	sta wsync		;line=77
	sta sizem
	DLINEW dli19 1 1 1

dli19
	sta regA
	stx regX

c21	lda #$0E
c22	ldx #$8A
	sta wsync		;line=80
	sta color1
	stx color3
	DLINEW dli20 1 1 0

dli20
	sta regA

	sta wsync		;line=88
	sta wsync		;line=89
	sta wsync		;line=90
c23	lda #$1C
	sta wsync		;line=91
	sta color2
c24	lda #$2A
	sta wsync		;line=92
	sta color2
	sta wsync		;line=93
x15	lda #$AB
	sta wsync		;line=94
	sta hposm1
	sta wsync		;line=95
c25	lda #$1C
	sta wsync		;line=96
	sta color2
c26	lda #$2A
	sta wsync		;line=97
	sta color2
c27	lda #$1C
	sta wsync		;line=98
	sta color2
c28	lda #$2A
	sta wsync		;line=99
	sta color2
c29	lda #$1C
	sta wsync		;line=100
	sta color2
	sta wsync		;line=101
c30	lda #$2A
	sta wsync		;line=102
	sta color2
c31	lda #$1C
	sta wsync		;line=103
	sta color2
	lda >fnt+$400*$02
	sta wsync		;line=104
	sta chbase
	DLINEW dli21 1 0 0

dli21
	sta regA
	stx regX
	sty regY

	sta wsync		;line=112
	sta wsync		;line=113
	sta wsync		;line=114
	sta wsync		;line=115
	sta wsync		;line=116
	sta wsync		;line=117
c32	lda #$1E
	sta wsync		;line=118
	sta color2
c33	lda #$1C
	sta wsync		;line=119
	sta color2
c34	lda #$04
c35	ldx #$1E
x16	ldy #$C1
	sta wsync		;line=120
	sta color1
	stx color2
	sty hposm3
c36	lda #$0E
	sta colpm3
c37	lda #$1C
	sta wsync		;line=121
	sta color2
c38	lda #$1E
	sta wsync		;line=122
	sta color2
s8	lda #$00
x17	ldx #$7F
x18	ldy #$66
	sta wsync		;line=123
	sta sizep2
	stx hposp2
	sty hposm2
c39	lda #$0C
	sta colpm2
c40	lda #$1C
	sta wsync		;line=124
	sta color2
c41	lda #$1E
	sta wsync		;line=125
	sta color2
	sta wsync		;line=126
x19	lda #$9B
c42	ldx #$FE
	sta wsync		;line=127
	sta hposp1
	stx colpm1
	sta wsync		;line=128
c43	lda #$84
c44	ldx #$08
	sta wsync		;line=129
	sta color0
	stx color2
	sta wsync		;line=130
c45	lda #$C2
	sta wsync		;line=131
	sta color3
	sta wsync		;line=132
	sta wsync		;line=133
s9	lda #$11
x20	ldx #$6E
c46	ldy #$0C
	sta wsync		;line=134
	sta sizem
	stx hposm0
	sty colpm0
	DLINEW DLI.dli2 1 1 1

dli2
	sta regA
	stx regX
	sty regY
	lda >fnt+$400*$03
s10	ldx #$03
x21	ldy #$90
	sta wsync		;line=136
	sta chbase
	stx sizep0
	sty hposp0
	sta wsync		;line=137
	sta wsync		;line=138
	sta wsync		;line=139
s11	lda #$31
x22	ldx #$67
x23	ldy #$57
	sta wsync		;line=140
	sta sizem
	stx hposm0
	sty hposm2
c47	lda #$D8
	sta colpm2
x24	lda #$7C
	sta wsync		;line=141
	sta hposp2
	DLINEW dli22 1 1 1

dli22
	sta regA
	stx regX
	sty regY

x25	lda #$83
	sta wsync		;line=144
	sta hposp2
	sta wsync		;line=145
	sta wsync		;line=146
	sta wsync		;line=147
x26	lda #$7F
	sta wsync		;line=148
	sta hposp2
	sta wsync		;line=149
s12	lda #$11
x27	ldx #$5B
	sta wsync		;line=150
	sta sizem
	stx hposm2
	sta wsync		;line=151
c48	lda #$16
	sta wsync		;line=152
	sta color1
s13	lda #$01
x28	ldx #$4D
c49	ldy #$1C
	sta wsync		;line=153
	sta sizep1
	stx hposp1
	sty colpm1
	sta wsync		;line=154
c50	lda #$D4
	sta wsync		;line=155
	sta color3
s14	lda #$03
x29	ldx #$74
	sta wsync		;line=156
	sta sizem
	stx hposm0
	sta wsync		;line=157
	sta wsync		;line=158
x30	lda #$8C
	sta wsync		;line=159
	sta hposp0
	lda >fnt+$400*$04
x31	ldx #$6F
	sta wsync		;line=160
	sta chbase
	stx hposm0
	DLINEW dli23 1 1 1

dli23
	sta regA
	stx regX
	sty regY

x32	lda #$8D
	sta wsync		;line=168
	sta hposp0
s15	lda #$00
	sta wsync		;line=169
	sta sizep0
s16	lda #$01
x33	ldx #$A5
c51	ldy #$1A
	sta wsync		;line=170
	sta sizem
	stx hposm0
	sty colpm0
	DLINEW dli3 1 1 1

dli3
	sta regA
	stx regX
	lda >fnt+$400*$03
	sta wsync		;line=176
	sta chbase
	sta wsync		;line=177
	sta wsync		;line=178
x34	lda #$91
x35	ldx #$A8
	sta wsync		;line=179
	sta hposp0
	stx hposm0
	DLINEW dli4 1 1 0

dli4
	sta regA
	lda >fnt+$400*$04
	sta wsync		;line=184
	sta chbase
	DLINEW dli24 1 0 0

dli24
	sta regA

	sta wsync		;line=192
	sta wsync		;line=193
c52	lda #$0A
	sta wsync		;line=194
	sta color3
	DLINEW dli5 1 0 0

dli5
	sta regA
	stx regX
	sty regY
	lda >fnt+$400*$05
	sta wsync		;line=200
	sta chbase
	sta wsync		;line=201
	sta wsync		;line=202
x36	lda #$98
x37	ldx #$A9
c53	ldy #$1C
	sta wsync		;line=203
	sta hposp0
	stx hposm0
	sty colpm0
	DLINEW dli6 1 1 1

dli6
	sta regA
	stx regX
	sty regY
	lda >fnt+$400*$00
c54	ldx #$04
c55	ldy #$0E
	sta wsync		;line=208
	sta chbase
	stx color0
	sty color3
	DLINEW dli7 1 1 1

dli7
	sta regA
	stx regX
	lda >fnt+$400*$01
c56	ldx #$0E
	sta wsync		;line=216
	sta chbase
	stx color1
	DLINEW dli8 1 1 0

dli8
	sta regA
	lda >fnt+$400*$05
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
	lda #$00
	sta colbak
	sta sizep3
	sta sizem
	sta sizep1
	sta sizep0

c1	lda #$08
	sta color0
c2	lda #$FC
	sta color1
c3	lda #$18
	sta color2
c4	lda #$0E
	sta color3
	lda #$02
	sta chrctl
	lda #$04
	sta gtictl
x0	lda #$BA
	sta hposp3
x1	lda #$C2
	sta hposm3
c5	lda #$1C
	sta colpm3
x2	lda #$9B
	sta hposp0
c6	lda #$5C
	sta colpm0
s2	lda #$01
	sta sizep2
x3	lda #$9B
	sta hposp2
x4	lda #$7F
	sta hposm2
c7	lda #$1A
	sta colpm2
x5	lda #$A4
	sta hposp1
c8	lda #$5C
	sta colpm1
x6	lda #$8D
	sta hposm0
x7	lda #$A2
	sta hposm1

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
		icl 'PangWinner.fad'
		eif
	eif

	.link 'rle\rle.obx'

pmgrle	ins 'winner_pmg.rle'

	.print *

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

