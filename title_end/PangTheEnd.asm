/***************************************/
/*  Use MADS http://mads.atari8.info/  */
/*  Mode: DLI (char mode)              */
/***************************************/

pmg	= 0

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

* ---	MAIN PROGRAM
	org $2000

fnt	ins 'PangTheEnd.fnt'

scr	ins 'PangTheEnd.scr'

ant	dta $C4,a(scr),$84,$04,$84,$04,$84,$84,$04,$84,$04,$04,$04,$84,$84
	dta $84,$84,$84,$04,$84,$84,$04,$04,$84,$04,$04,$04,$04,$04,$04,$04
	dta $41,a(ant)


main
* ---	init PMG
	mva >pmg $d407		;missiles and players data address
	mva #3 $d01d		;enable players and missiles

	jsr save_color		;then save all colors and set value 0 for all colors


	lda:cmp:req 20		;wait 1 frame

	sei			;stop IRQ interrupts
	mva #0 $d40e		;stop NMI interrupts
	mva #$fe $d301		;switch off ROM to get 16k more ram

	mwa #pmg+$300 q1+1
	lda >sprites-1
	ldx <sprites-1
	jsr depacker

	mwa #NMI $fffa		;new NMI handler

	mva #$c0 $d40e		;switch on NMI+DLI again


	jsr fade_in		;fade in colors

_lp	lda $d20f		;wait to press any key; here you can put any own routine
	and #4
	bne _lp

	jsr fade_out		;fade out colors

pmgKill
	mva #0   $d01d		;PMG disabled
	ldx #$0c\ sta:rpl $d000,x-
	rts


* ---	DLI PROGRAM

 ?old_dli = *


dli_start
dli8
	sta $d40a		;line=8
	sta $d40a		;line=9
	sta $d40a		;line=10
	sta $d40a		;line=11
	sta $d40a		;line=12
c9	lda #$46
	sta $d40a		;line=13
	sta color1
	DLINEW dli9

dli9

c10	lda #$78
	sta $d40a		;line=16
	sta colbak
	DLINEW dli10

dli10

	sta $d40a		;line=32
	sta $d40a		;line=33
	sta $d40a		;line=34
	sta $d40a		;line=35
	sta $d40a		;line=36
	sta $d40a		;line=37
c11	lda #$2E
	sta $d40a		;line=38
	sta color1
c12	lda #$78
	sta $d40a		;line=39
	sta color1
	sta $d40a		;line=40
	sta $d40a		;line=41
c13	lda #$FC
	sta $d40a		;line=42
	sta colbak
	DLINEW dli2


dli2
	lda >fnt+$400*$01
	sta $d40a		;line=48
	sta chbase
	sta $d40a		;line=49
	sta $d40a		;line=50
	sta $d40a		;line=51
	lda #$03
	ldx #$69
	sta $d40a		;line=52
	sta sizep2
	stx hposp2
	lda #$01
	ldx #$35
	sta $d40a		;line=53
	sta sizep3
	stx hposp3
	DLINEW dli11

dli11

c14	lda #$2E
	sta $d40a		;line=56
	sta color1
	lda #$4D
	sta $d40a		;line=57
	sta hposm1
	lda #$4C
	sta $d40a		;line=58
	sta hposm1
	lda #$4A
	sta $d40a		;line=59
	sta hposm1
	lda #$48
	sta $d40a		;line=60
	sta hposm1
	lda #$47
	sta $d40a		;line=61
	sta hposm1
	lda #$32
	ldx #$45
	sta $d40a		;line=62
	sta hposp3
	stx hposm1
	sta $d40a		;line=63


	sta $d40a		;line=64
	sta $d40a		;line=65
	sta $d40a		;line=66
	sta $d40a		;line=67
	sta $d40a		;line=68
	lda #$00
	ldx #$95
c15	ldy #$0E
	sta $d40a		;line=69
	sta sizep1
	stx hposp1
	sty colpm1
	DLINEW dli12

dli12

	sta $d40a		;line=72
	sta $d40a		;line=73
	sta $d40a		;line=74
	sta $d40a		;line=75
	sta $d40a		;line=76
	lda #$55
	sta $d40a		;line=77
	sta hposm3
	sta $d40a		;line=78
	lda #$30
	sta $d40a		;line=79
	sta hposp3
	lda >fnt+$400*$02
	ldx #$57
	sta $d40a		;line=80
	sta chbase
	stx hposm3
	sta $d40a		;line=81
	sta $d40a		;line=82
	sta $d40a		;line=83
	sta $d40a		;line=84
	sta $d40a		;line=85
	lda #$F0
	ldx #$50
	sta $d40a		;line=86
	sta sizem
	stx hposm3
	lda #$70
	sta $d40a		;line=87
	sta sizem
	sta $d40a		;line=88
	sta $d40a		;line=89
	sta $d40a		;line=90
	sta $d40a		;line=91
	sta $d40a		;line=92
	sta $d40a		;line=93
	lda #$03
	ldx #$6F
c16	ldy #$0E
	sta $d40a		;line=94
	sta sizep0
	stx hposp0
	sty colpm0
	lda #$33
	sta $d40a		;line=95
	sta hposp3
	sta $d40a		;line=96
	lda #$86
	sta $d40a		;line=97
	sta hposm1
	sta $d40a		;line=98
c17	lda #$F6
	sta $d40a		;line=99
	sta color2
	lda #$01
	sta $d40a		;line=100
	sta sizep1
	DLINEW dli13

dli13

	sta $d40a		;line=104
	lda #$85
	sta $d40a		;line=105
	sta hposm1
	lda #$84
	sta $d40a		;line=106
	sta hposm1
	sta $d40a		;line=107
	sta $d40a		;line=108
	sta $d40a		;line=109
	lda #$7B
	sta $d40a		;line=110
	sta hposm1
	DLINEW dli3

dli3
	lda >fnt+$400*$03
	sta $d40a		;line=112
	sta chbase
	sta $d40a		;line=113
	lda #$01
	ldx #$53
c18	ldy #$0E
	sta $d40a		;line=114
	sta sizep2
	stx hposp2
	sty colpm2
	DLINEW dli14

dli14

	lda #$A7
c19	ldx #$EA
	sta $d40a		;line=120
	sta hposp0
	stx colpm0
	sta $d40a		;line=121
	sta $d40a		;line=122
	lda #$00
	ldx #$3B
	sta $d40a		;line=123
	sta sizep3
	stx hposp3
	DLINEW dli15

dli15

	sta $d40a		;line=128
	sta $d40a		;line=129
	sta $d40a		;line=130
	sta $d40a		;line=131
	sta $d40a		;line=132
	lda #$40
	sta $d40a		;line=133
	sta hposp3
	DLINEW dli16

dli16

	sta $d40a		;line=136
	sta $d40a		;line=137
	sta $d40a		;line=138
	sta $d40a		;line=139
	sta $d40a		;line=140
	sta $d40a		;line=141
	sta $d40a		;line=142
	lda #$44
	sta $d40a		;line=143
	sta hposp3
	DLINEW dli17

dli17

	sta $d40a		;line=152
	sta $d40a		;line=153
	sta $d40a		;line=154
	lda #$03
	ldx #$7A
c20	ldy #$28
	sta $d40a		;line=155
	sta sizep3
	stx hposp3
	sty colpm3
	DLINEW dli4

dli4
	lda >fnt+$400*$04
	sta $d40a		;line=160
	sta chbase
	sta $d40a		;line=161
	sta $d40a		;line=162
	sta $d40a		;line=163
	sta $d40a		;line=164
	lda #$03
	ldx #$56
c21	ldy #$46
	sta $d40a		;line=165
	sta sizep1
	stx hposp1
	sty colpm1
	lda #$03
	ldx #$36
c22	ldy #$46
	sta $d40a		;line=166
	sta sizep2
	stx hposp2
	sty colpm2
	sta $d40a		;line=167
	sta $d40a		;line=168
	sta $d40a		;line=169
	sta $d40a		;line=170
	sta $d40a		;line=171
	sta $d40a		;line=172
	sta $d40a		;line=173
c23	lda #$EA
	sta $d40a		;line=174
	sta color1
	lda #$03
	ldx #$82
	sta $d40a		;line=175
	sta sizem
	stx hposm0
	sta $d40a		;line=176
	sta $d40a		;line=177
	lda #$33
	ldx #$7E
	ldy #$76
	sta $d40a		;line=178
	sta sizem
	stx hposm1
	sty hposm2
	DLINEW dli5

dli5
	lda >fnt+$400*$00
	sta $d40a		;line=184
	sta chbase
	sta $d40a		;line=185
c24	lda #$26
	sta $d40a		;line=186
	sta color2
	jmp NMI.quit

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

	lda >fnt+$400*$00
	sta chbase

c0	lda #$FC
	sta colbak
c1	lda #$00
	sta color0
c2	lda #$2E
	sta color1
c3	lda #$26
	sta color2
c4	lda #$8C
	sta color3
	lda #$04
	sta gtictl
	lda #$03
	sta sizep3
	lda #$32
	sta hposp3
c5	lda #$EE
	sta colpm3

	lda #$01
	sta sizep2
;	lda #$01
	sta sizep1
;	lda #$01
	sta sizep0

	lda #$53
	sta hposp2
;	lda #$53
	sta hposm2

c6	lda #$EE
	sta colpm2

	lda #$98
	sta hposp1
c7	lda #$78
	sta colpm1
	lda #$4F
	sta hposm1

	lda #$99
	sta hposp0
c8	lda #$EE
	sta colpm0
	lda #$3C
	sta sizem

	lda #$59
	sta hposm3
	lda #$71
	sta hposm0

	mwa #dli_start dliv	;set the first address of DLI interrupt

;this area is for yours routines

quit
	lda regA
	ldx regX
	ldy regY
	rti

.ENDP

;---
	icl 'PangTheEnd.fad'


depacker
        sta adr+2

loop    jsr get
        beq stop
        lsr @

        tay
q0      jsr get
q1      sta $ffff
        inc q1+1
        bne skip0
        inc q1+2
skip0
        dey
_bpl    bmi loop

        bcs q0
        bcc q1

get     inx
        bne skip1
        inc adr+2
skip1
adr     lda $ff00,x

stop    rts


sprites	ins 'pmg.rle'

	.print 'end: ',*

	run main

;---

	opt l-

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
