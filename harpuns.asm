
/*******************************************************************************************

  HARPUNS (08.12.2008)

*******************************************************************************************/

	icl 'pang.hea'


	.extrn clrHrp.min clrHrp.max pmgB hr0 bufor .byte

	.extrn harp0.x harp0.y harp0.y_old hinv0 hinv1 wallIDX .byte
	.extrn harp0.cnt harp0.startDIV8 harp0.hook harpun hrpA hrpY .byte

	.extrn scr1 scr2 HERO.return HERO.quit CLRHARP.return CLRHARP.setPMClear __hposm3 .word
	.extrn nmi.sfx_effect nmi.note gtia clrWall.skip .word

	.extrn PlaySfx .proc (.byte PlaySfx.note, PlaySfx.fx) .var
	.extrn PlaySfx.note PlaySfx.fx .word

	.public HARPUNS clrHARP1 clrHARP2 min88div8 hak


	.RELOC

min88div8	:256 dta b([#-88]/8)

	.pages

lhclrpm1	:scrhig dta a(clrHARP1.clrpmB1+#*pmLen)		; !!! koniecznie od pocz¹tku strony pamiêci

hposp	:40 dta #*4+52-4

mul4	:40 dta #*4

tfonts	.sav scrhig

tfontsAdd :scrhig dta b(.get[#+1]-.get[#])

mul8	:scrhig dta #*8

tdolna	:scrhig dta [dolnakrawedz-[scrhig-#]*8]

ltest	:scrhig dta l(invers+#*scrwid+4)
htest	:scrhig dta h(invers+#*scrwid+4)

	.endpg


	.align $100,0

lhclrpm2	:scrhig dta a(clrHARP2.clrpmB2+#*pmLen)


* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------


	?ofs = harpun_pmg_offset	; ofset dla zapisywanych danych PMG

	.put[$100] = %00000000		; kszta³t danych PMG dla grotu
	.put[$101] = %00010000
	.put[$102] = %00011000
	.put[$103] = %00000000
	.put[$104] = %00000000
	.put[$105] = %00001000
	.put[$106] = %00000100
	.put[$107] = %00000000

	.put[$110] = %00000000		; dla harpunu
	.put[$111] = %00000000
	.put[$112] = %00100000
	.put[$113] = %00100000
	.put[$114] = %00100000
	.put[$115] = %00011000
	.put[$116] = %00000100
	.put[$117] = %00000000

* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------

* ----------------------------
* ---	HARPUN #0
* ----------------------------
HARPUNS
	ldx min52div4,y		; HARPUN #0

	lda hposp,x
	sta __hposm3
;	add #2
;	sta hposm2

	ldy harp0.y
	lda min88div8,y
	tay
	dey

	sty quit+1
	sty harp0.cnt

	lda	#$ff	;defaultPrior
;	sta	gtia+1		; przywróæ piorytet inaczej harpun bêdzie kiepsko wygl¹daæ

//-----------------------------------------------------------------------------

hak	bne skip

	inc harp0.hook
;	lda harp0.hook
;	cmp #hook_time_limit
;	bcc __s
	bpl __s

	mva #{bne} hak

	mva #hook_delay harp0.hook
	bne hookOff

__s	lda mul4,x
	asl @		; tutaj dokonujemy sztuczki z bitem C
	sta hr0

	lda tfonts,y
	adc bufor	; tutaj wykorzystujemy bit C
	sta hr0+1

	jmp cnt

//-----------------------------------------------------------------------------

killH0	tax
	bpl killH0.clrPM

	ldy clrWall.skip+1		; jeœli aktualnie usuwamy murek to nie dopiszemy nastêpnego
	bne killH0.clrPM

	sta killWall,x			; HARPUN #0 trafi³ w miêkki murek

	ldx wallIDX
	sta clrWallIDX,x

	PlaySfx #ton_G3 #sfxHrpS	; odg³os harpunu trafiaj¹cego w miêkki murek

	ldy harp0.x
	lda min52div4,y
	sta clrWallPOS,x

	inc wallIDX

hookOff	mva harp0.x harpun		; czyœcimy HARPUN #0 na ca³ej wysokoœci ekranu
	mva #0 harp0.x			; blokujemy dalsze tworzenie tego harpunu
	jmp HERO.quit

killH0.clrPM

	lda harp0.hook
	beq hskp

	PlaySfx #ton_G2 #sfxHrpX	; odg³os harpunu z hakiem zaczepianego o twardy murek

	mva #hook_delay harp0.hook
	mva #{beq} hak
	jmp HERO.quit

hskp	PlaySfx #ton_G2 #sfxHrpH	; odg³os harpunu trafiaj¹cego w twardy murek

	jmp CLRHARP.setPMClear

//-----------------------------------------------------------------------------

skip	mva ltest,y _test+1
	mva htest,y _test+2

_test	lda $ffff,x
	bne killH0

//-----------------------------------------------------------------------------
//	obs³uga GROTU harpunu #0
//-----------------------------------------------------------------------------

	lda mul8,y
	sta pmgGROT1.py+1

	lda mul4,x
	asl @		; tutaj dokonujemy sztuczki z bitem C
	sta hr0

	lda tfonts,y
	adc bufor	; tutaj wykorzystujemy bit C

	sta hr0+1

	lda tdolna,y
	sta harp0.y_old

;	ldy bufor
;	sne
	sta harp0.y

	ldy #0

	@@GROT

.local	pmgGROT1

py	ldy #0

	lda pmgB
	cmp >pmgB1
	beq FILLB2

FILLB1
	@@pmgGROT pmgB1

	bne cnt

FILLB2
	@@pmgGROT pmgB2

.endl


//-----------------------------------------------------------------------------


cnt	inc harp0.cnt
	ldy harp0.cnt
	cpy harp0.startDIV8
	bcs quit

//-----------------------------------------------------------------------------
//	obs³uga harpunu #0
//-----------------------------------------------------------------------------

hloop	lda mul8,y
	sta pmgHARP1.py+1

	lda hr0+1
	add tfontsADD-1,y
	sta hr0+1
/*
	lda mul4,x
	asl @		; tutaj dokonujemy sztuczki z bitem C

	lda tfonts,y
	adc bufor	; tutaj wykorzystujemy bit C

	sta hr0+1
*/

	ldy #0

	@@HARP

	jsr pmgHARP1

	inc harp0.cnt
	ldy harp0.cnt
	cpy harp0.startDIV8
	bcc hloop

* -----------------------------------------------------------------------------

quit	lda #$ff
	bne skp

	lda harp0.y
	cmp harp0.y_old
	bne skp
/*
	lda harp0.hook
	beq _hskp
	
	PlaySfx #ton_G2 #sfxHrpX	; odg³os harpunu z hakiem trafiaj¹cy w twardy murek

	mva #hook_delay harp0.hook
	mva #{beq} hak
	jmp HERO.quit

_hskp
*/
	PlaySfx #ton_G2 #sfxHrpH	; odg³os harpunu trafiaj¹cego w twardy murek

	mva harp0.x harpun	; czyœcimy HARPUN #0 na ca³ej wysokoœci ekranu
	mva #0 harp0.x		; blokujemy dalsze tworzenie tego harpunu

;	sta __hposm3
	jmp HERO.quit

skp	jmp HERO.return


* -----------------------------------------------------------------------------

.local	pmgHARP1

py	ldy #0

	lda pmgB
	cmp >pmgB1
	beq FILLB2

FILLB1
	@@pmgHARP pmgB1
	rts

FILLB2
	@@pmgHARP pmgB2
	rts
.endl


* -----------------------------------------------------------------------------

.macro	@@pmgGROT
	lda :1+$300+2+?ofs,y
	ora #%01<<[(pmStar-$400)/$75]
	sta :1+$300+2+?ofs,y

	lda :1+$300+3+?ofs,y
	ora #%01<<[(pmStar-$400)/$75]
	sta :1+$300+3+?ofs,y

	lda :1+$300+4+?ofs,y
	ora #%11<<[(pmStar-$400)/$75]
	sta :1+$300+4+?ofs,y

	lda :1+$300+5+?ofs,y
	ora #%01<<[(pmStar-$400)/$75]
	sta :1+$300+5+?ofs,y
.endm


@@GROT	.macro
	lda (hr0),y
	and #%11110011
;	ora #%00001000
	sta (hr0),y

	iny
	lda (hr0),y
	and #%11110011
	ora #%00001000
	sta (hr0),y

	iny
	lda (hr0),y
	and #%11000000
	ora #%00000010
	sta (hr0),y

	iny
	lda (hr0),y
	and #%11000000
	ora #%00100110
	sta (hr0),y

	iny
	lda #%00010100
	sta (hr0),y

	iny
	lda #%10010001
	sta (hr0),y

	iny
	lda #%10101010
	sta (hr0),y

	iny
	lda (hr0),y
	and #%11000011
	ora #%00100000
	sta (hr0),y
	.endm

* -----------------------------------------------------------------------------

.macro	@@pmgHARP
	lda :1+$300+1+?ofs,y
	and #missile_mask
	bne skip

	lda :1+$300+1+?ofs,y	
	ora #%01<<[(pmStar-$400)/$75]
	sta :1+$300+1+?ofs,y

	lda :1+$300+2+?ofs,y
	and #missile_mask^$ff
	ora #%10<<[(pmStar-$400)/$75]
	sta :1+$300+2+?ofs,y

	lda :1+$300+3+?ofs,y
	ora #%11<<[(pmStar-$400)/$75]
	sta :1+$300+3+?ofs,y

	lda :1+$300+4+?ofs,y
	ora #%11<<[(pmStar-$400)/$75]
	sta :1+$300+4+?ofs,y

	lda :1+$300+5+?ofs,y
	and #missile_mask^$ff
	ora #%01<<[(pmStar-$400)/$75]
	sta :1+$300+5+?ofs,y

	lda :1+$300+6+?ofs,y
	ora #%01<<[(pmStar-$400)/$75]
	sta :1+$300+6+?ofs,y
skip
.endm


@@HARP	.macro
	lda (hr0),y
	and #%11110000
	ora #%00001010
	sta (hr0),y

	iny
	lda (hr0),y
	and #%11000000
	ora #%00101000
	sta (hr0),y

	iny
	lda (hr0),y
	and #%00000011
	ora #%10011000
	sta (hr0),y

	iny
	lda #%00010010
	sta (hr0),y

	iny
	lda #%10000100
	sta (hr0),y

	iny
	lda (hr0),y
	and #%11000000
	ora #%00101000
	sta (hr0),y

	iny
	lda (hr0),y
	and #%11110000
	ora #%00000010
	sta (hr0),y

	iny
	lda (hr0),y
	and #%11111100
	ora #%00000010
	sta (hr0),y
	.endm

* -----------------------------------------------------------------------------

pmLen	= 6*8+6		; @@MIS=8

@@mis1	.macro
	lda pmgB1+$300+#*8+?ofs+:1
	and #missile_mask^$ff
	sta pmgB1+$300+#*8+?ofs+:1
	.endm

@@mis2	.macro
	lda pmgB2+$300+#*8+?ofs+:1
	and #missile_mask^$ff
	sta pmgB2+$300+#*8+?ofs+:1
	.endm


.local	clrHARP1

	ldy clrHrp.max

	lda clrHrp.min
	asl @
	sta jclrpm+1

jclrpm	jmp (lhclrpm1)


clrpmB1	.rept scrhig

;	@@mis1 0
	@@mis1 1
	@@mis1 2
	@@mis1 3
	@@mis1 4
	@@mis1 5
	@@mis1 6
;	@@mis1 7

	dey
	spl
	jmp CLRHARP.return

	.endr

	jmp CLRHARP.return
.endl



.local	clrHARP2

	ldy clrHrp.max

	lda clrHrp.min
	asl @
	sta jclrpm+1

jclrpm	jmp (lhclrpm2)


clrpmB2	.rept scrhig

;	@@mis2 0
	@@mis2 1
	@@mis2 2
	@@mis2 3
	@@mis2 4
	@@mis2 5
	@@mis2 6
;	@@mis2 7

	dey
	spl
	jmp CLRHARP.return

	.endr

	jmp CLRHARP.return
.endl
