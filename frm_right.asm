
/*******************************************************************************************

  FRM_RIGHT (12.07.2007 - 03.12.2008)

  klatki animacji bohatera, kierunek w prawo

*******************************************************************************************/

	icl 'atari.hea'
	icl 'pang.hea'


	.extrn yB1old yB2old	.byte
	.extrn rw0 rw1 rw2 rw3 rw4 rw5 rw6 rw7 rw8 rw9 rw10 rw11 rw12 rw13 rw14 rw15 .byte
	.extrn rw16 rw17 rw18 rw19 rw20 rw21 rw22 rw23 rw24 rw25 rw26 rw27 rw28 rw29 rw30 rw31 .byte
	
	.extrn pmgB hposx hposy .byte WAIT.hposxOK WAIT.hmosxOK WAIT.hposxOK2 WAIT.hmosxOK2 PLAYER.return CLRHARP.return2 .word
	.extrn SCR1 SCR2 .word

	.public frmR


	.RELOC


;	?ofs = 89

// na pierwszej pozycji wystêpuje zawsze wartoœæ 0, dlatego mo¿emy pierwsz¹ pozycjê pomin¹æ

	opt l-

	.rept 256
	?b0=#>>7&1
	?b1=#>>6&1
	?b2=#>>5&1
	?b3=#>>4&1
	?b4=#>>3&1
	?b5=#>>2&1
	?b6=#>>1&1
	?b7=#&1
	
	.put[$100+#]=?b7<<7+?b6<<6+?b5<<5+?b4<<4+?b3<<3+?b2<<2+?b1<<1+?b0
	.endr


	.rept 256
	?b0=#>>7&1
	?b1=#>>6&1
	?b2=#>>5&1
	?b3=#>>4&1
	?b4=#>>3&1
	?b5=#>>2&1
	?b6=#>>1&1
	?b7=#&1
	
	.put[$200+#]=?b1<<7+?b0<<6+?b3<<5+?b2<<4+?b5<<3+?b4<<2+?b7<<1+?b6
	.endr

	opt l+


lhfrm	dta a(bckR._0, bckR._1, bckR._2, bckR._3)

	dta a(frmR0._0, frmR0._1, frmR0._2, frmR0._3)
	dta a(frmR1._0, frmR1._1, frmR1._2, frmR1._3)
	dta a(frmR2._0, frmR2._1, frmR2._2, frmR2._3)
	dta a(frmR3._0, frmR3._1, frmR3._2, frmR3._3)
	dta a(frmR4._0, frmR4._1, frmR4._2, frmR4._3)
	dta a(frmR5._0, frmR5._1, frmR5._2, frmR5._3)

tmul4	:8 dta #*4


incRW	:32 inc rw0+#*2+1

	clc
	rts


* --------------------------------------------------------------------------------------------
* --------------------------------------------------------------------------------------------

	.align $100,$00

// na pierwszej pozycji wystêpuje zawsze wartoœæ 0, dlatego mo¿emy pierwsz¹ pozycjê pomin¹æ

p0	.put=$00,$02,$0F,$1D,$23,$10,$2D,$18,$00,$01,$00,$80,$04,$20,$2C,$11,$0C,$66,$49,$14,$04,$19,$04,$01,$00,$00,$01,$00,$01,$02,$03,$00
	@@WSPAK
	.put=$00,$00,$02,$0F,$1D,$23,$10,$2D,$18,$00,$01,$00,$00,$84,$00,$6C,$01,$08,$62,$49,$14,$00,$0C,$01,$03,$09,$02,$01,$00,$10,$10,$18
	@@WSPAK
	.put=$00,$00,$02,$0F,$1D,$23,$10,$2D,$18,$00,$01,$00,$00,$84,$00,$6C,$01,$08,$62,$49,$14,$00,$0C,$01,$03,$09,$00,$02,$09,$00,$09,$0C
	@@WSPAK
	.put=$00,$02,$0F,$1D,$23,$10,$2D,$18,$00,$01,$00,$80,$04,$20,$2C,$11,$0C,$66,$49,$14,$04,$19,$04,$01,$00,$01,$00,$00,$04,$06,$0A,$03
	@@WSPAK
	.put=$00,$00,$02,$0F,$1D,$23,$10,$2D,$18,$00,$01,$00,$00,$84,$00,$6C,$01,$08,$62,$49,$14,$00,$0C,$01,$03,$09,$02,$04,$04,$10,$10,$18
	@@WSPAK
	.put=$00,$00,$02,$0F,$1D,$23,$10,$2D,$18,$00,$01,$00,$00,$84,$00,$6C,$01,$08,$62,$49,$14,$00,$0C,$01,$03,$09,$00,$04,$08,$01,$09,$08
	@@WSPAK

	dta $06,$05,$13,$66,$1F,$FF,$FE,$1D,$CB,$3D,$C5,$6A,$00,$2F,$55,$AF,$B7,$B2,$67,$3B,$16,$2A,$11,$3D,$00,$2A,$00,$00,$00,$00,$20,$50


	.align $100,$00

p1	.put=$00,$07,$00,$1D,$3C,$20,$00,$00,$00,$00,$00,$80,$80,$60,$11,$0B,$21,$42,$02,$00,$00,$00,$00,$03,$01,$00,$00,$00,$00,$03,$04,$00
	@@WSPAK
	.put=$00,$00,$07,$00,$1D,$3C,$20,$00,$00,$00,$00,$00,$00,$80,$80,$21,$13,$25,$46,$00,$00,$00,$00,$00,$0B,$06,$00,$00,$00,$00,$18,$20
	@@WSPAK
	.put=$00,$00,$07,$00,$1D,$3C,$20,$00,$00,$00,$00,$00,$00,$80,$80,$21,$13,$25,$46,$00,$00,$00,$00,$00,$0B,$06,$00,$00,$00,$00,$0C,$10
	@@WSPAK
	.put=$00,$07,$00,$1D,$3C,$20,$00,$00,$00,$00,$00,$80,$80,$60,$11,$0B,$21,$42,$02,$00,$00,$00,$00,$03,$00,$00,$00,$00,$00,$00,$03,$04
	@@WSPAK
	.put=$00,$00,$07,$00,$1D,$3C,$20,$00,$00,$00,$00,$00,$00,$80,$80,$21,$13,$25,$46,$00,$00,$00,$00,$00,$0B,$06,$00,$00,$00,$00,$18,$20
	@@WSPAK
	.put=$00,$00,$07,$00,$1D,$3C,$20,$00,$00,$00,$00,$00,$00,$80,$80,$21,$13,$25,$46,$00,$00,$00,$00,$00,$0B,$06,$00,$00,$00,$01,$0A,$10
	@@WSPAK

	dta $08,$16,$32,$27,$5F,$7F,$7F,$5E,$2C,$C3,$7E,$2C,$00,$00,$2F,$7F,$77,$73,$36,$2A,$2F,$04,$00,$13,$2A,$11,$00,$00,$00,$00,$40,$60


	.align $100,$00

p2	.put=$00,$00,$00,$00,$00,$00,$10,$2A,$5C,$12,$EC,$6C,$18,$50,$00,$00,$06,$02,$0A,$04,$48,$30,$00,$00,$00,$10,$00,$18,$00,$00,$00,$00
	@@WSPAK
	.put=$00,$00,$00,$00,$00,$00,$00,$10,$2A,$5C,$12,$E8,$68,$18,$50,$00,$00,$00,$06,$02,$04,$78,$00,$00,$00,$00,$20,$4C,$22,$40,$00,$00
	@@WSPAK
	.put=$00,$00,$00,$00,$00,$00,$00,$10,$2A,$5C,$12,$E8,$68,$18,$50,$00,$00,$00,$06,$02,$04,$78,$00,$00,$00,$00,$30,$00,$00,$60,$00,$00
	@@WSPAK
	.put=$00,$00,$00,$00,$00,$00,$10,$2A,$5C,$12,$E8,$68,$18,$50,$00,$00,$00,$02,$02,$04,$48,$30,$00,$00,$00,$10,$08,$10,$00,$08,$00,$00
	@@WSPAK
	.put=$00,$00,$00,$00,$00,$00,$00,$10,$2A,$5C,$12,$E8,$68,$18,$50,$00,$00,$00,$06,$02,$04,$78,$00,$00,$00,$00,$04,$48,$44,$42,$00,$00
	@@WSPAK
	.put=$00,$00,$00,$00,$00,$00,$00,$10,$2A,$5C,$12,$E8,$68,$18,$50,$00,$00,$00,$06,$02,$04,$78,$00,$00,$00,$00,$30,$08,$0C,$40,$00,$00
	@@WSPAK

	dta $00,$00,$00,$00,$00,$00,$00,$00,$04,$00,$08,$04,$08,$00,$02,$01,$03,$04,$06,$04,$00,$00,$00,$00,$00,$04,$0E,$8A,$02,$00,$00,$00


	.align $100,$00

ms	.put=$00,$00,$02,$08,$0B,$07,$00,$02,$00,$00,$02,$02,$00,$08,$2E,$15,$23,$00,$00,$01,$02,$00,$02,$08,$02,$00,$00,$00,$00,$00,$00,$00
	@@MORDER
	@@WSPAKM
	.put=$00,$00,$00,$02,$08,$0B,$07,$00,$02,$00,$00,$02,$02,$00,$08,$0E,$25,$13,$20,$00,$01,$02,$00,$08,$00,$00,$02,$00,$02,$00,$0E,$02
	@@MORDER
	@@WSPAKM
	.put=$00,$00,$00,$02,$08,$0B,$07,$00,$02,$00,$00,$02,$02,$00,$08,$0E,$25,$13,$20,$00,$01,$02,$00,$08,$00,$00,$00,$00,$00,$00,$00,$00
	@@MORDER
	@@WSPAKM
	.put=$00,$00,$02,$08,$0B,$07,$00,$02,$00,$00,$02,$02,$00,$08,$2E,$15,$23,$00,$00,$01,$02,$00,$02,$08,$08,$00,$00,$00,$00,$00,$00,$00
	@@MORDER
	@@WSPAKM
	.put=$00,$00,$00,$02,$08,$0B,$07,$00,$02,$00,$00,$02,$02,$00,$08,$0E,$25,$13,$20,$00,$01,$02,$00,$08,$00,$00,$00,$00,$00,$00,$0E,$02
	@@MORDER
	@@WSPAKM
	.put=$00,$00,$00,$02,$08,$0B,$07,$00,$02,$00,$00,$02,$02,$00,$08,$0E,$25,$13,$20,$00,$01,$02,$00,$08,$00,$00,$00,$00,$00,$08,$02,$00
	@@MORDER
	@@WSPAKM

	.put=$00,$00,$00,$01,$06,$07,$06,$09,$0A,$02,$00,$00,$00,$02,$09,$0E,$01,$08,$00,$00,$02,$00,$02,$0B,$0E,$02,$30,$20,$10,$31,$06,$00
	@@MORDER
	.sav 32

* --------------------------------------------------------------------------------------------
* --------------------------------------------------------------------------------------------


frmR	lda hposx	// !!! KONIECZNIE TEN SAM ADRES CO W 'FRML' !!!
	and #3
	add tmul4,y	; frame*4 + (hposx and 3)
;	tay

	asl @
	sta jfrm+1

	lda hposx
	sta WAIT.hposxOK2
	add #1
	sta WAIT.hmosxOK
	adc #2
	sta WAIT.hposxOK
	adc #6
	sta WAIT.hmosxOK2

;	clc

	txa
	:3 asl @
	tay
	scc
	jsr incRW

	ldx pmgB

;	ldy #0
jfrm	jmp (lhfrm)


	icl '_PC\asm-ludek\defR0.asm'
	icl '_PC\asm-ludek\defR1.asm'

	icl '_PC\asm-ludek\frmR0.asm'
	icl '_PC\asm-ludek\frmR1.asm'
	icl '_PC\asm-ludek\frmR2.asm'
	icl '_PC\asm-ludek\frmR3.asm'
	icl '_PC\asm-ludek\frmR4.asm'
	icl '_PC\asm-ludek\frmR5.asm'

	icl '_PC\asm-ludek\bckR.asm'


	?ofset = hero_pmg_offset

.local	FILLB1

	ldx yB1old
	cpx hposy
	jeq skp

	lda #0
	.rept 8
	sta pmgB1+pmHero0-31+#+?ofset,x
	sta pmgB1+pmHero1-31+#+?ofset,x
	sta pmgB1+pmHero2-31+#+?ofset,x

	sta pmgB1+pmHero0-#+?ofset,x
	sta pmgB1+pmHero1-#+?ofset,x
	sta pmgB1+pmHero2-#+?ofset,x
	.endr

	.rept 8
	lda pmgB1+$300-31+#+?ofset,x
	and #missile_mask
	sta pmgB1+$300-31+#+?ofset,x

	lda pmgB1+$300-#+?ofset,x
	and #missile_mask
	sta pmgB1+$300-#+?ofset,x
	.endr


skp	ldx hposy

	.rept 32
	mva p0+#,y pmgB1+pmHero0-31+#+?ofset,x
	mva p1+#,y pmgB1+pmHero1-31+#+?ofset,x
	mva p2+#,y pmgB1+pmHero2-31+#+?ofset,x

	lda pmgB1+$300-31+#+?ofset,x
	and #missile_mask
	ora ms+#,y
	sta pmgB1+$300-31+#+?ofset,x
	.endr

	stx yB1old

;	lda #0
;	.rept 8
;	sta pmgB1+pmHero0+1+#+?ofset,x
;	sta pmgB1+pmHero1+1+#+?ofset,x

;	sta pmgB1+$300+1+#+?ofset,x
;	.endr

	jmp PLAYER.return
.endl


FRM0	@@FILL 32*0
FRM1	@@FILL 32*1
FRM2	@@FILL 32*2
FRM3	@@FILL 32*3
FRM4	@@FILL 32*4
FRM5	@@FILL 32*5

PMBCK_R	lda hposx
	sta WAIT.hposxOK
	add #8
	sta WAIT.hmosxOK

	@@FILL 32*6


.local	FILLB2

	ldx yB2old
	cpx hposy
	jeq skp

	lda #0
	.rept 8
	sta pmgB2+pmHero0-31+#+?ofset,x
	sta pmgB2+pmHero1-31+#+?ofset,x
	sta pmgB2+pmHero2-31+#+?ofset,x

	sta pmgB2+pmHero0-#+?ofset,x
	sta pmgB2+pmHero1-#+?ofset,x
	sta pmgB2+pmHero2-#+?ofset,x
	.endr

	.rept 8
	lda pmgB2+$300-31+#+?ofset,x
	and #missile_mask
	sta pmgB2+$300-31+#+?ofset,x

	lda pmgB2+$300-#+?ofset,x
	and #missile_mask
	sta pmgB2+$300-#+?ofset,x
	.endr


skp	ldx hposy

	.rept 32
	mva p0+#,y pmgB2+pmHero0-31+#+?ofset,x
	mva p1+#,y pmgB2+pmHero1-31+#+?ofset,x
	mva p2+#,y pmgB2+pmHero2-31+#+?ofset,x

	lda pmgB2+$300-31+#+?ofset,x
	and #missile_mask
	ora ms+#,y
	sta pmgB2+$300-31+#+?ofset,x
	.endr

	stx yB2old

;	lda #0
;	.rept 8
;	sta pmgB2+pmHero0+1+#+?ofset,x
;	sta pmgB2+pmHero1+1+#+?ofset,x

;	sta pmgB2+$300+1+#+?ofset,x
;	.endr

	jmp PLAYER.return
.endl


* --------------------------------------------------------------------------------------------
* --------------------------------------------------------------------------------------------

.macro	@@MORDER
	.rept 32
	?m0=.get[#]&3
	?m1=(.get[#]>>2)&3
	?m2=(.get[#]>>4)&3

	.put[#]=?m0<<[(pmHero0-$400)/$75]+?m1<<[(pmHero1-$400)/$75]+?m2<<[(pmHero2-$400)/$75]
	.endr
.endm


@@WSPAK	.macro
	:+32 dta .get[$100+.get[#]]
	.endm

@@WSPAKM .macro
	:+32 dta .get[$200+.get[#]]
	.endm


@@INCRW	.macro
	tya
	adc #8
	tay
	scc
	jsr incRW
	.endm

@@FILL	.macro
	ldy #:1

	cpx >pmgB1
	beq FILLB2
	jmp FILLB1
	.endm
