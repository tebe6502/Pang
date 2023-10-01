
/*******************************************************************************************

  FRM_UD (09.04.2009 - 10.04.2009)

  klatki animacji bohatera, kierunek góra/dó³ - chodzenie po drabinie

*******************************************************************************************/

	icl 'atari.hea'
	icl 'pang.hea'


	.extrn yB1old yB2old	.byte
	.extrn rw0 rw1 rw2 rw3 rw4 rw5 rw6 rw7 rw8 rw9 rw10 rw11 rw12 rw13 rw14 rw15 .byte
	.extrn rw16 rw17 rw18 rw19 rw20 rw21 rw22 rw23 rw24 rw25 rw26 rw27 rw28 rw29 rw30 rw31 .byte

	.extrn pmgB hposx hposy .byte WAIT.hposxOK WAIT.hmosxOK WAIT.hposxOK2 WAIT.hmosxOK2 PLAYER.return .word
	.extrn SCR1 SCR2 .word

	.public frmUD


	.RELOC

* --------------------------------------------------------------------------------------------
* --------------------------------------------------------------------------------------------

// na pierwszej pozycji wystêpuje zawsze wartoœæ 0, dlatego mo¿emy pierwsz¹ pozycjê pomin¹æ

p0	dta $00,$1E,$2D,$7F,$2D,$DE,$7F,$FB,$75,$EB,$51,$BB,$5E,$61,$33,$1E,$69,$B5,$CE,$77,$2D,$52,$6F,$22,$55,$6A,$33,$00,$06,$01,$58,$20
	dta $00,$1E,$2D,$7F,$2D,$DE,$7F,$FB,$75,$EB,$51,$BB,$5E,$61,$33,$1E,$6B,$B5,$CE,$77,$2D,$52,$6F,$22,$55,$6A,$32,$06,$01,$00,$58,$20
	dta $00,$1E,$2D,$7F,$2D,$DE,$7F,$FB,$75,$EB,$51,$BB,$5E,$61,$33,$1E,$69,$B5,$CC,$77,$35,$52,$6F,$22,$55,$6A,$33,$00,$06,$01,$58,$20
	dta $00,$1E,$2D,$7F,$2D,$DE,$7F,$FB,$75,$EB,$51,$BB,$5E,$61,$33,$5E,$B5,$2B,$DC,$3B,$6B,$52,$3D,$51,$2A,$55,$13,$58,$20,$00,$06,$01

p1	dta $00,$00,$1E,$21,$5E,$3F,$BF,$BB,$B5,$AB,$B1,$5A,$6D,$21,$12,$00,$16,$7F,$4E,$37,$6D,$3F,$30,$19,$3B,$22,$00,$00,$02,$03,$30,$70
	dta $00,$00,$1E,$21,$5E,$3F,$BF,$BB,$B5,$AB,$B1,$5A,$6D,$21,$12,$00,$16,$7F,$4E,$37,$6D,$3F,$30,$19,$3B,$22,$01,$02,$03,$00,$30,$70
	dta $00,$00,$1E,$21,$5E,$3F,$BF,$BB,$B5,$AB,$B1,$5A,$6D,$21,$12,$00,$16,$7F,$4C,$37,$75,$3F,$30,$19,$3B,$22,$00,$00,$02,$03,$30,$70
	dta $00,$00,$1E,$21,$5E,$3F,$BF,$BB,$B5,$AB,$B1,$5A,$6D,$21,$12,$00,$5A,$BF,$5C,$7B,$2B,$3F,$03,$26,$77,$11,$20,$10,$70,$00,$03,$03

p2	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$00,$80,$80,$00,$00,$00,$00,$33,$10,$20,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$00,$80,$80,$00,$00,$00,$00,$30,$10,$20,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$00,$00,$00,$00,$00,$00,$00,$33,$10,$20,$00,$00
	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$03,$02,$01,$00,$00

ms	.put=$00,$00,$00,$02,$08,$03,$06,$06,$07,$06,$07,$09,$0A,$02,$00,$00,$02,$09,$0B,$18,$02,$02,$00,$02,$08,$02,$00,$00,$02,$08,$00,$00
	@@MORDER
	.put=$00,$00,$00,$02,$08,$03,$06,$06,$07,$06,$07,$09,$0A,$02,$00,$12,$09,$04,$0B,$08,$02,$02,$00,$02,$08,$02,$00,$02,$08,$00,$00,$00
	@@MORDER
	.put=$00,$00,$00,$02,$08,$03,$06,$06,$07,$06,$07,$09,$0A,$02,$00,$00,$02,$09,$0B,$18,$02,$02,$00,$02,$08,$02,$00,$00,$02,$08,$00,$00
	@@MORDER
	.put=$00,$00,$00,$02,$08,$03,$06,$06,$07,$06,$07,$09,$0A,$02,$00,$00,$02,$09,$0B,$12,$08,$12,$12,$00,$02,$02,$00,$00,$00,$00,$02,$08
	@@MORDER


* --------------------------------------------------------------------------------------------

	ert <*<>0

udfrm	dta a(drab0._0)
	dta a(drab1._0)
	dta a(drab2._0)
	dta a(drab3._0)


incRW	:32 inc rw0+#*2+1

	clc
	rts

* --------------------------------------------------------------------------------------------
* --------------------------------------------------------------------------------------------

frmUD	tya
;	and #7
;	lsr @
;	asl @
	and #%110

	sta jfrm+1

	lda hposx
	add #1
	sta WAIT.hposxOK
	sta WAIT.hposxOK2
	adc #8
	sta WAIT.hmosxOK
	sta WAIT.hmosxOK2

;	clc

	txa
	:3 asl @
	tay
	scc
	jsr incRW

	ldx pmgB

;	ldy #0
jfrm	jmp (udfrm)


	icl '_PC\asm-ludek\drab0.asm'
	icl '_PC\asm-ludek\drab1.asm'
	icl '_PC\asm-ludek\drab2.asm'
	icl '_PC\asm-ludek\drab3.asm'

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


pm_drab0	@@FILL 32*0
pm_drab1	@@FILL 32*1
pm_drab2	@@FILL 32*2
pm_drab3	@@FILL 32*3


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
