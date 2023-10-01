
/*******************************************************************************************

  FRM_LEFT (12.07.2007 - 03.12.2008)

  klatki animacji bohatera, kierunek w lewo

*******************************************************************************************/

	icl 'atari.hea'
	icl 'pang.hea'


	.extrn yB1old yB2old	.byte
	.extrn rw0 rw1 rw2 rw3 rw4 rw5 rw6 rw7 rw8 rw9 rw10 rw11 rw12 rw13 rw14 rw15 .byte
	.extrn rw16 rw17 rw18 rw19 rw20 rw21 rw22 rw23 rw24 rw25 rw26 rw27 rw28 rw29 rw30 rw31 .byte

	.extrn pmgB hposx hposy .byte WAIT.hposxOK WAIT.hmosxOK WAIT.hposxOK2 WAIT.hmosxOK2 PLAYER.return .word
	.extrn SCR1 SCR2 .word

	.public frmL


	.RELOC


;	?ofs = 89


lhfrm	dta a(bckL._0, bckL._1, bckL._2, bckL._3)

	dta a(frmL0._0, frmL0._1, frmL0._2, frmL0._3)
	dta a(frmL1._0, frmL1._1, frmL1._2, frmL1._3)
	dta a(frmL2._0, frmL2._1, frmL2._2, frmL2._3)
	dta a(frmL3._0, frmL3._1, frmL3._2, frmL3._3)
	dta a(frmL4._0, frmL4._1, frmL4._2, frmL4._3)
	dta a(frmL5._0, frmL5._1, frmL5._2, frmL5._3)

tmul4	:8 dta #*4


incRW	:32 inc rw0+#*2+1

	clc
	rts


* --------------------------------------------------------------------------------------------
* --------------------------------------------------------------------------------------------

	.align $100,$00

// na pierwszej pozycji wystêpuje zawsze wartoœæ 0, dlatego mo¿emy pierwsz¹ pozycjê pomin¹æ

p0	dta $00,$02,$0F,$1D,$23,$10,$2D,$18,$00,$01,$00,$80,$04,$20,$2C,$11,$0C,$66,$49,$14,$04,$19,$04,$01,$00,$00,$01,$00,$01,$02,$03,$00
	dta $00,$00,$02,$0F,$1D,$23,$10,$2D,$18,$00,$01,$00,$00,$84,$00,$6C,$01,$08,$62,$49,$14,$00,$0C,$01,$03,$09,$02,$01,$00,$10,$10,$18
	dta $00,$00,$02,$0F,$1D,$23,$10,$2D,$18,$00,$01,$00,$00,$84,$00,$6C,$01,$08,$62,$49,$14,$00,$0C,$01,$03,$09,$00,$02,$09,$00,$09,$0C
	dta $00,$02,$0F,$1D,$23,$10,$2D,$18,$00,$01,$00,$80,$04,$20,$2C,$11,$0C,$66,$49,$14,$04,$19,$04,$01,$00,$01,$00,$00,$04,$06,$0A,$03
	dta $00,$00,$02,$0F,$1D,$23,$10,$2D,$18,$00,$01,$00,$00,$84,$00,$6C,$01,$08,$62,$49,$14,$00,$0C,$01,$03,$09,$02,$04,$04,$10,$10,$18
	dta $00,$00,$02,$0F,$1D,$23,$10,$2D,$18,$00,$01,$00,$00,$84,$00,$6C,$01,$08,$62,$49,$14,$00,$0C,$01,$03,$09,$00,$04,$08,$01,$09,$08

	dta $18,$28,$32,$99,$7E,$FF,$5F,$AE,$74,$6F,$28,$15,$00,$7D,$AA,$7D,$BB,$13,$39,$37,$5A,$15,$62,$EF,$40,$55,$00,$00,$00,$80,$41,$02


	.align $100,$00

p1	dta $00,$07,$00,$1D,$3C,$20,$00,$00,$00,$00,$00,$80,$80,$60,$11,$0B,$21,$42,$02,$00,$00,$00,$00,$03,$01,$00,$00,$00,$00,$03,$04,$00
	dta $00,$00,$07,$00,$1D,$3C,$20,$00,$00,$00,$00,$00,$00,$80,$80,$21,$13,$25,$46,$00,$00,$00,$00,$00,$0B,$06,$00,$00,$00,$00,$18,$20
	dta $00,$00,$07,$00,$1D,$3C,$20,$00,$00,$00,$00,$00,$00,$80,$80,$21,$13,$25,$46,$00,$00,$00,$00,$00,$0B,$06,$00,$00,$00,$00,$0C,$10
	dta $00,$07,$00,$1D,$3C,$20,$00,$00,$00,$00,$00,$80,$80,$60,$11,$0B,$21,$42,$02,$00,$00,$00,$00,$03,$00,$00,$00,$00,$00,$00,$03,$04
	dta $00,$00,$07,$00,$1D,$3C,$20,$00,$00,$00,$00,$00,$00,$80,$80,$21,$13,$25,$46,$00,$00,$00,$00,$00,$0B,$06,$00,$00,$00,$00,$18,$20
	dta $00,$00,$07,$00,$1D,$3C,$20,$00,$00,$00,$00,$00,$00,$80,$80,$21,$13,$25,$46,$00,$00,$00,$00,$00,$0B,$06,$00,$00,$00,$01,$0A,$10

	dta $04,$1A,$13,$39,$BE,$BF,$BF,$5E,$4D,$30,$1F,$0D,$00,$00,$7D,$FF,$3B,$73,$1B,$15,$3D,$08,$00,$72,$D5,$22,$00,$00,$00,$00,$80,$01


	.align $100,$00

p2	dta $00,$00,$00,$00,$00,$00,$10,$2A,$5C,$12,$EC,$6C,$18,$50,$00,$00,$06,$02,$0A,$04,$48,$30,$00,$00,$00,$10,$00,$18,$00,$00,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$10,$2A,$5C,$12,$E8,$68,$18,$50,$00,$00,$00,$06,$02,$04,$78,$00,$00,$00,$00,$20,$4C,$22,$40,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$10,$2A,$5C,$12,$E8,$68,$18,$50,$00,$00,$00,$06,$02,$04,$78,$00,$00,$00,$00,$30,$00,$00,$60,$00,$00
	dta $00,$00,$00,$00,$00,$00,$10,$2A,$5C,$12,$E8,$68,$18,$50,$00,$00,$00,$02,$02,$04,$48,$30,$00,$00,$00,$10,$08,$10,$00,$08,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$10,$2A,$5C,$12,$E8,$68,$18,$50,$00,$00,$00,$06,$02,$04,$78,$00,$00,$00,$00,$04,$48,$44,$42,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$10,$2A,$5C,$12,$E8,$68,$18,$50,$00,$00,$00,$06,$02,$04,$78,$00,$00,$00,$00,$30,$08,$0C,$40,$00,$00

	dta $00,$00,$00,$00,$00,$00,$00,$00,$20,$00,$10,$20,$10,$00,$40,$80,$C0,$20,$60,$20,$00,$00,$00,$00,$00,$20,$70,$51,$40,$00,$00,$00


	.align $100,$00

ms	.put=$00,$00,$02,$08,$0B,$07,$00,$02,$00,$00,$02,$02,$00,$08,$2E,$15,$23,$00,$00,$01,$02,$00,$02,$08,$02,$00,$00,$00,$00,$00,$00,$00
	@@MORDER
	.put=$00,$00,$00,$02,$08,$0B,$07,$00,$02,$00,$00,$02,$02,$00,$08,$0E,$25,$13,$20,$00,$01,$02,$00,$08,$00,$00,$02,$00,$02,$00,$0E,$02
	@@MORDER
	.put=$00,$00,$00,$02,$08,$0B,$07,$00,$02,$00,$00,$02,$02,$00,$08,$0E,$25,$13,$20,$00,$01,$02,$00,$08,$00,$00,$00,$00,$00,$00,$00,$00
	@@MORDER
	.put=$00,$00,$02,$08,$0B,$07,$00,$02,$00,$00,$02,$02,$00,$08,$2E,$15,$23,$00,$00,$01,$02,$00,$02,$08,$08,$00,$00,$00,$00,$00,$00,$00
	@@MORDER
	.put=$00,$00,$00,$02,$08,$0B,$07,$00,$02,$00,$00,$02,$02,$00,$08,$0E,$25,$13,$20,$00,$01,$02,$00,$08,$00,$00,$00,$00,$00,$00,$0E,$02
	@@MORDER
	.put=$00,$00,$00,$02,$08,$0B,$07,$00,$02,$00,$00,$02,$02,$00,$08,$0E,$25,$13,$20,$00,$01,$02,$00,$08,$00,$00,$00,$00,$00,$08,$02,$00
	@@MORDER

	.put=$00,$00,$00,$02,$08,$0B,$0B,$08,$03,$0C,$0B,$02,$00,$00,$02,$09,$09,$09,$02,$00,$00,$00,$00,$00,$00,$00,$30,$10,$20,$30,$08,$0A
	@@MORDER


* --------------------------------------------------------------------------------------------
* --------------------------------------------------------------------------------------------


frmL	lda hposx	// !!! KONIECZNIE TEN SAM ADRES CO W 'FRMR' !!!
	and #3
	add tmul4,y	; frame*4 + (hposx and 3)
;	tay

	asl @
	sta jfrm+1

	lda hposx
	add #1
	sta WAIT.hposxOK
	sta WAIT.hmosxOK2
	adc #3
	sta WAIT.hposxOK2	
	adc #5
	sta WAIT.hmosxOK

;	clc

	txa
	:3 asl @
	tay
	scc
	jsr incRW

	ldx pmgB

;	ldy #0
jfrm	jmp (lhfrm)



	icl '_PC\asm-ludek\defL0.asm'
	icl '_PC\asm-ludek\defL1.asm'

	icl '_PC\asm-ludek\frmL0.asm'
	icl '_PC\asm-ludek\frmL1.asm'
	icl '_PC\asm-ludek\frmL2.asm'
	icl '_PC\asm-ludek\frmL3.asm'
	icl '_PC\asm-ludek\frmL4.asm'
	icl '_PC\asm-ludek\frmL5.asm'

	icl '_PC\asm-ludek\bckL.asm'


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

PMBCK_L	lda hposx
	add #2
	sta WAIT.hposxOK
	adc #8
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

.macro	@@MORDER
	.rept 32
	?m0=.get[#]&3
	?m1=(.get[#]>>2)&3
	?m2=(.get[#]>>4)&3

	dta ?m0<<[(pmHero0-$400)/$75]+?m1<<[(pmHero1-$400)/$75]+?m2<<[(pmHero2-$400)/$75]
	.endr
.endm
