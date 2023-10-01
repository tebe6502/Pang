
* !!! UMIESZCZAæ KONIECZNIE OD POCZ¥TKU STRONY PAMIÊCI !!!

// wyswietlamy BUFOR #1, modyfikujemy BUFOR #2

	icl 'pang.hea'

// -----------------------------------------------------------------------------------------------
//	BONUS
// -----------------------------------------------------------------------------------------------

	.extrn bonus.x bonus.y bonus.tim bonus.typ bonus.use hposx hposy	.byte
	.extrn bs0 bs1 bs2 bs3 bs4 bs5 bd0 bd1 bd2 bd3 bd4 bd5 hlp	.byte

	.extrn scr1 scr2 NMI.sfx_effect NMI.note ttype posx posy	.word

	.extrn NewScore .proc (.byte NewScore._10, NewScore._1) .var
	.extrn NewScore._10 NewScore._1 .word

	.extrn PlaySfx .proc (.byte PlaySfx.note, PlaySfx.fx) .var
	.extrn PlaySfx.note PlaySfx.fx .word

	.public BONUS BONUS_TEST BALL_TEST

// -----------------------------------------------------------------------------------------------

	.RELOC

lchr	:256 dta l([#&$7f]*8)
hchr	:256 dta h([#&$7f]*8)

//	JBON - procedury relizuj¹ce spadanie BONUS-u

jbon	:18 dta a(row:1)

//	JCLR - przywrócenie starej zawartoœci obrazu pod BONUS-em

	.align $40,0

jclr	dta a(rowclr0)		; koniecznie dodatkowy adres

	:18 dta a(rowclr:1)

//	JSHP - procedury realizuj¹ce modyfikacjê znaków, tworz¹ce kszta³t ikony BONUS-a

	.align $80,0

jshp	dta a(DETECT)		; typ0 nie istnieje
	dta a(btyp1)
	dta a(btyp2)
	dta a(btyp3)
	dta a(btyp4)
	dta a(btyp5)
	dta a(btyp6)

//	JTST - procedury testuj¹ce obecnoœæ znaków na pozycji X:Y BONUS-a
//	taki test zapobiega "wbiciu" siê ikony BONUS-a w murek

	.align $c0,0

jtst	:18 dta a(tst:1)

// -----------------------------------------------------------------------------------------------

.macro	TST
	lda invers+4+:1*48-48,y
	ora invers+5+:1*48-48,y
	ora invers+6+:1*48-48,y

	ora invers+4+:1*48,y
	ora invers+5+:1*48,y
	ora invers+6+:1*48,y

	ora invers+4+:1*48+48,y
	ora invers+5+:1*48+48,y
	ora invers+6+:1*48+48,y

	rts
.endm

.macro	ROWCLR
	lda scr1+4+:1*48,y
	add #64
	sta scr2+4+:1*48,y

	lda scr1+5+:1*48,y
	adc #64
	sta scr2+5+:1*48,y

	lda scr1+6+:1*48,y
	adc #64
	sta scr2+6+:1*48,y


	lda scr1+4+:1*48+48,y
	adc #64
	sta scr2+4+:1*48+48,y

	lda scr1+5+:1*48+48,y
	adc #64
	sta scr2+5+:1*48+48,y

	lda scr1+6+:1*48+48,y
	adc #64
	sta scr2+6+:1*48+48,y

	rts
.endm

.macro	ROW
	lda invers+4+:1*48+48,y
	ora invers+5+:1*48+48,y
	ora invers+6+:1*48+48,y
	beq ok

	dec bonus.y
	jmp SHAPE

ok	ift :1>0		; !!! :2 = :1-1
	jsr rowclr:2
	eif

	ldx scr1+4+:1*48,y
	mva lchr,x	bs0
	mva lchr+1,x	bs1
	mva lchr+2,x	bs2

	lda hchr+64,x
	add #.get[:1]
	sta bs0+1
	txa
	and #$80
	ora #bonus0
	sta scr2+4+:1*48,y

	ldx scr1+5+:1*48,y
	lda hchr+64,x
	add #.get[:1]
	sta bs1+1
	txa
	and #$80
	ora #bonus1
	sta scr2+5+:1*48,y

	ldx scr1+6+:1*48,y
	lda hchr+64,x
	add #.get[:1]
	sta bs2+1
	txa
	and #$80
	ora #bonus2
	sta scr2+6+:1*48,y

	ldx scr1+4+:1*48+48,y
	mva lchr,x	bs3
	mva lchr+1,x	bs4
	mva lchr+2,x	bs5

	lda hchr+64,x
	add #.get[:1+1]
	sta bs3+1
	txa
	and #$80
	ora #bonus3
	sta scr2+4+:1*48+48,y

	ldx scr1+5+:1*48+48,y
	lda hchr+64,x
	add #.get[:1+1]
	sta bs4+1
	txa
	and #$80
	ora #bonus4
	sta scr2+5+:1*48+48,y

	ldx scr1+6+:1*48+48,y
	lda hchr+64,x
	add #.get[:1+1]
	sta bs5+1
	txa
	and #$80
	ora #bonus5
	sta scr2+6+:1*48+48,y

	lda hchr+bonus0
	add #.get[:1]
	sta bd0+1
	sta bd1+1
	sta bd2+1

	adc #.get[:1+1]-.get[:1]
	sta bd3+1
	sta bd4+1
	sta bd5+1

	jmp SHAPE
.endm

// -----------------------------------------------------------------------------------------------

	.rept 18,#
tst:1	TST #
	.endr

	.rept 18,#
rowclr:1	ROWCLR #
	.endr

	.rept 18,#,#-1
row:1	ROW #,:2
	.endr

// -----------------------------------------------------------------------------------------------

BONUS	lda bonus.y

	cmp #scrhig-1
	bcs SHAPE

	asl @
	sta _jbon+1

	ldy bonus.x

	inc bonus.y

_jbon	jmp (jbon)

// -----------------------------------------------------------------------------------------------

SHAPE	lda bonus.typ
	asl @
	ora #$80

	sta _jshp+1

_jshp	jmp (jshp)

// -----------------------------------------------------------------------------------------------

* ---
* ---	DETEKCJA KOLIZJI > BONUS / BOHATER <
* ---
.local	DETECT

	lda hposx
	sub #48+4

	sta left+1

	add #12-2	; szerokoœæ bohatera
	sta right+1

	lda hposy	; górna krawêdŸ bohatera
	adc #10

	sta top+1

	adc #21		; wysokoœæ bohatera
	sta bottom+1

* ---	DETEKCJA KOLIZJI Z BOHATEREM
* ---
	lda bonus.x
	:2 asl @

left	cmp #0
	bcc NOTHIT
right	cmp #0
	bcs NOTHIT

	lda bonus.y
	:3 asl @
	sub #6

top	cmp #0
	bcc NOTHIT
bottom	cmp #0
	bcs NOTHIT

	jmp HIT
.endl


NOTHIT	:2 inc bonus.tim
	smi
	rts

HIT	lda bonus.tim		; jeœli czas siê skoñczy³ to NIE bêdzie aktywowany bonus
	bmi skp

	lda bonus.typ
	ora #$80
	sta bonus.typ		; bonus zosta³ zebrany

	PlaySfx #12 #sfxBon	; odg³os zbieranego bonusu
	NewScore #5 #0

skp	lda bonus.y
	asl @
	ora #$40

	sta _jclr+1

	ldy bonus.x

	mva #0 bonus.x

_jclr	jmp (jclr)


// -----------------------------------------------------------------------------------------------
//	BONUS TEST
// -----------------------------------------------------------------------------------------------
// sprawdzenie czy na pozycji X:Y BONUS-a znajduj¹ siê murki

BONUS_TEST
	lda bonus.y
	asl @
	ora #$c0
	sta _jtst+1

	ldy bonus.x

_jtst	jmp (jtst)


// -----------------------------------------------------------------------------------------------
//	BALL TEST
// -----------------------------------------------------------------------------------------------
// sprawdzenie czy na pozycji X:Y mo¿na postawiæ kulê
// w A zwróci wartoœæ #0 lub #? jeœli przesuniêcie kuli w prawo jest mo¿liwe
// !!! wartoœæ rejestrów X, Y musi zostaæ zachowana !!!

	.align $100,0

jball	dta a(__rts)
	dta a(ball1)
	dta a(ball2)
	dta a(ball3)
	dta a(ball4)

linv	:scrhig dta l(invers+4+#*scrwid)
hinv	:scrhig dta h(invers+4+#*scrwid)

twidth	dta 20,16,12,8,4

width	brk

BALL_TEST
	ldy ttype,x
	mva twidth,y width

	tya
	asl @
	sta _jball+1

	lda posy,x
	:3 lsr @
	tay

	lda posy,x
	and #7
	cmp #4
	scc
	iny

	lda posx,x
	add width

	cmp #160		; jeœli krawêdŸ kuli przekracza praw¹ krawêdŸ
	bcs __rts

	:2 lsr @

	add linv,y
	sta hlp
	lda #0
	adc hinv,y
	sta hlp+1

	lda posx,x
	and #3
	cmp #2
	scc
	inw hlp

	ldy #0

_jball	jmp (jball)


__rts	lda #0
	rts

ball1	.local
	lda (hlp),y
	iny
	ora (hlp),y
	iny
	ora (hlp),y
	iny
	ora (hlp),y
	bne __rts

	ldy #scrwid*1
	ora (hlp),y
	iny
	ora (hlp),y
	iny
	ora (hlp),y
	iny
	ora (hlp),y
	bne __rts

	ldy #scrwid*2
	ora (hlp),y
	iny
	ora (hlp),y
	iny
	ora (hlp),y
	iny
	ora (hlp),y
	bne __rts

	ldy #scrwid*3
	ora (hlp),y
	iny
	ora (hlp),y
	iny
	ora (hlp),y
	iny
	ora (hlp),y
	bne __rts

	lda width
	rts
	.endl

ball2	.local
	lda (hlp),y
	iny
	ora (hlp),y
	iny
	ora (hlp),y
	bne __rts

	ldy #scrwid*1
	ora (hlp),y
	iny
	ora (hlp),y
	iny
	ora (hlp),y
	bne __rts

	ldy #scrwid*2
	ora (hlp),y
	iny
	ora (hlp),y
	iny
	ora (hlp),y
	bne __rts

	lda width
	rts
	.endl

ball3	.local
	lda (hlp),y
	iny
	ora (hlp),y
	bne __rts

	ldy #scrwid*1
	ora (hlp),y
	iny
	ora (hlp),y
	bne __rts

	lda width
	rts
	.endl

ball4	.local
	lda (hlp),y
	bne __rts

	lda width
	rts
	.endl

// -----------------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------------

; tablica AND [$100], ORA [$200]

	.rept 256
	?p0 = #&$03
	?p1 = #&$0c
	?p2 = #&$30
	?p3 = #&$c0

	?x=#
	?y=#

	ift ?p0<>$03
	?x=?x&%11111100
	els
	?y=?y&%11111100
	eif

	ift ?p1<>$0c
	?x=?x&%11110011
	els	
	?y=?y&%11110011
	eif

	ift ?p2<>$30
	?x=?x&%11001111
	els
	?y=?y&%11001111
	eif

	ift ?p3<>$c0
	?x=?x&%00111111
	els
	?y=?y&%00111111
	eif

	.put [$100+#] = ?x
	.put [$200+#] = ?y
	
	.endr


.macro	ikona
	?i=:4

	ldy #0

	.rept 8

	ift .get[?i]=$ff
	mva (bs:1),y (bd:1),y
	els
	lda (bs:1),y
	and #.get[$100+.get[?i]]
	ora #.get[$200+.get[?i]]
	sta (bd:1),y
	eif

	ift .get[?i+1]=$ff
	mva (bs:2),y (bd:2),y
	els
	lda (bs:2),y
	and #.get[$100+.get[?i+1]]
	ora #.get[$200+.get[?i+1]]
	sta (bd:2),y
	eif

	ift .get[?i+2]=$ff
	mva (bs:3),y (bd:3),y
	els
	lda (bs:3),y
	and #.get[$100+.get[?i+2]]
	ora #.get[$200+.get[?i+2]]
	sta (bd:3),y
	eif

	?i+=3
	iny
	.endr

.endm


* ----------------------------
; ---	BONUS #1 / HEART
* ----------------------------
	:16 .get[#*3] 'ikonki.mic',#*40,3

btyp1	ikona 0 1 2	0
	ikona 3 4 5	24
	jmp DETECT

* ----------------------------
; ---	BONUS #2 / SHIELD
* ----------------------------
	:16 .get[#*3] 'ikonki.mic',24*40+#*40,3

btyp2	ikona 0 1 2	0
	ikona 3 4 5	24
	jmp DETECT

* ----------------------------
; ---	BONUS #3 / CLOCK
* ----------------------------
	:16 .get[#*3] 'ikonki.mic',48*40+#*40,3

btyp3	ikona 0 1 2	0
	ikona 3 4 5	24
	jmp DETECT

* ----------------------------
; ---	BONUS #4 / X-HARPUN
* ----------------------------
	:16 .get[#*3] 'ikonki.mic',72*40+#*40,3

btyp4	ikona 0 1 2	0
	ikona 3 4 5	24
	jmp DETECT

* ----------------------------
; ---	BONUS #5 / HARPUN
* ----------------------------
	:16 .get[#*3] 'ikonki.mic',96*40+#*40,3

btyp5	ikona 0 1 2	0
	ikona 3 4 5	24
	jmp DETECT

* ----------------------------
; ---	BONUS #6 / TNT
* ----------------------------
	:16 .get[#*3] 'ikonki.mic',144*40+#*40,3

btyp6	ikona 0 1 2	0
	ikona 3 4 5	24
	jmp DETECT
