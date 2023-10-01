
/* ----------------------------------------------------------------------- */
/* 				COLLISIONS                                 */
/* ----------------------------------------------------------------------- */

.proc	COLLISIONS

	mva #{ldy ttype,x}	DETECT.HARP0		; przywracamy test kolizji HARPUN/KULE
	mwa #ttype		DETECT.HARP0+1

tnt	lda #0
	beq _no

	inc tnt+1
	bpl __tnt

	mva #0 tnt+1
	beq _no

__tnt	and #$0f
	bne _no

	mva #{jmp*}		DETECT.HARP0
	mwa #DETECT._splash	DETECT.HARP0+1
_no

// wspó³rzêdne A,B,C,D okreœlaj¹ czworok¹t wpisany w bohatera

	lda hposx
	sub #48+2-4-2

	sta DETECT.hero.dx0
	sta DETECT.hero.dx1
	add #10-4			; szerokosc bohatera
	sta DETECT.hero.cx0
	sta DETECT.hero.cx1

	lda hposy			; górna krawedz bohatera
;	sta DETECT.ay0
	adc #3
	sta DETECT.hero.ay1
	sta DETECT.hero.ay2

	adc #31-3			; wysokosc bohatera
;	sta DETECT.dy0
	sta DETECT.hero.dy1
	sta DETECT.hero.dy2


// wspó³rzêdne A,B,C,D okreœlaj¹ czworok¹t wpisany w harpun #0

	lda harp0.x
	beq DETECT

	sub #48+4-2-4

	sta DETECT.harp0.dx0
	sta DETECT.harp0.dx1
	add #1				; szerokosc harpunu
	sta DETECT.harp0.cx0
	sta DETECT.harp0.cx1

	lda harp0.y			; górna krawedz harpunu
	sub #dolnakrawedz-scrhig*8+2	; +2 aby trafiæ najmniejsz¹ kulê przyleg³¹ do sufitu
;	sta DETECT.ay0
	sta DETECT.harp0.ay1
	sta DETECT.harp0.ay2

	lda harp0.start			; dolna krawedz harpunu
;	sta DETECT.dy0
	sta DETECT.harp0.dy1
	sta DETECT.harp0.dy2

	lda #0
	sta harpun

/* ------------------------------------------- */
/*		     DETECT		       */
/* ------------------------------------------- */
DETECT	.local

	ldx objects
	dex

LOOP	lda active,x
	bpl nxt

	lda switch,x
	beq HARP0

	lda #0
	sta switch,x

nxt	dex
	bpl LOOP
	rts

/* ------------------------------------------- */
/*	DETEKCJA KOLIZJI KUL Z HARPUNEM #0     */
/* ------------------------------------------- */
HARP0	.local

	ldy ttype,x		; typ kuli 0..4

	lda harp0.x
	beq _nxt

	lda posy,x		; = g.y

	cmp #0			; if g.y < d.y
dy2	equ *-1
	bcs skip

	cmp #0			; if g.y >= a.y
ay2	equ *-1
	bcs _OK_


skip	adc theightm1,y		; = e.y

	cmp #0			; if e.y < d.y
dy1	equ *-1
	bcs _nxt

	cmp #0			; if e.y >= a.y
ay1	equ *-1
	bcc _nxt


_OK_	lda posx,x
	adc twidthm1,y		; = f.x
				; if f.x >= d.x
	cmp #0
dx0	equ *-1
	bcc _nxt

	cmp #0			; if f.x < c.x
cx0	equ *-1
	bcc KOLIZJA

	lda posx,x		; = e.x
	cmp #0			; if e.x < d.x
dx1	equ *-1
	bcc KOLIZJA

	cmp #0			; if e.x < c.x
cx1	equ *-1
	bcs _nxt

KOLIZJA	jmp SPLASH

_nxt
	.endl

/* ------------------------------------------- */
/*	DETEKCJA KOLIZJI KUL Z BOHATEREM       */
/* ------------------------------------------- */

HERO	.local

	lda posy,x		; = g.y

;	ldy ttype,x		; typ kuli 0..4

// !!! rejestr Y musi byæ odpowiednio ustawiony (LDY TTYPE,X) zanim nast¹pi skok do HERO !!!

	cmp #0			; if g.y < d.y
dy2	equ *-1
	bcs skip

	cmp #0			; if g.y >= a.y
ay2	equ *-1
	bcs _OK_


skip	adc theightm1,y

	cmp #0
dy1	equ *-1
	bcs _nxt

	cmp #0
ay1	equ *-1
	bcc _nxt

_OK_	lda posx,x
	adc twidthm1,y

	cmp #0
dx0	equ *-1
	bcc _nxt

	cmp #0
cx0	equ *-1
	bcc ENERGY

	lda posx,x
	cmp #0
dx1	equ *-1
	bcc ENERGY

	cmp #0
cx1	equ *-1
	bcc ENERGY

_nxt
	.endl


_nxt	dex
	bpl LOOP
	rts

;----------------------------------------------------------------------
// trafienie gracza kul¹ (!!! nie modyfikowaæ rejestru X !!!)

energy_max	dta 6,5,4,3,2

ENERGY	.local

	ldy ttype,x		; typ kuli 0..4

	lda power
	cmp energy_max,y
	bcc nopower

;	lda power
	sub energy_max,y
	sta power
	bne skip

nopower
;	ldy INIT.lives
;	seq
;	dey
;	sty INIT.lives		; zmniejszamy liczbe zyc

	PlaySfx #ton_g4 #sfxDie

	lda #deathCode.no_power
	sta GameEnd.reason

	ldy #1
	sty objects		; wymuszamy koniec dzia³ania silnika
	sty active

	dey			; Y = 0
	sty power
skip
	jsr update_energy

	jmp _nxt

/* -------------------------------------------- */
/*			MORE			*/
/* -------------------------------------------- */

more	adb power #25
	cmp #energy_len*8
	scc
	lda #energy_len*8

	:3 lsr @
	tay
	beq update_energy

	dey

loop	lda #energy_up				; gorny znak paska energii
	sta energy_bar,y

	lda #energy_dw				; dolny znak paska energii
	sta energy_bar+40,y
	dey
	bpl loop

update_energy

	ldy #0
power	equ *-1
	beq null

	cpy #energy_len*8
	bcs stop

	tya

	:3 lsr @

	tay

	lda power
	and #7
	pha

	add #energy_up_first
	sta energy_bar,y

	pla
	add #energy_dw_first
	sta energy_bar+40,y

plop	iny
	cpy #energy_len
	bcs stop
null
	lda #energy_up_first-1
	sta energy_bar,y

	lda #energy_dw_first-1
	sta energy_bar+40,y

	jmp plop

stop	rts


/* -------------------------------------------- */
/*			INIT			*/
/* -------------------------------------------- */
init	mva #energy_len*8 power

	lda #energy_up				; gorny znak paska energi
	:energy_len sta energy_bar+#

	lda #energy_dw				; dolny znak paska energi
	:energy_len sta energy_bar+40+#

	rts

	.endl

;----------------------------------------------------------------------

.local	hitBall

	lda #0
level	equ *-1

	cmp #level_len*8
	bcs stop

	:3 lsr @

	tay

	lda level
	and #7
	pha

	add #energy_up_first
	sta level_bar,y

	pla
	add #energy_dw_first
	sta level_bar+40,y

stop	inc level
	rts
.endl

;----------------------------------------------------------------------
// trafienie harpunu w kule (!!! nie modyfikowaæ rejestru X !!!)

_kill	lda tnt+1
	bne no_hit

	lda t_note,y

	PlaySfx @ #sfxBum
	NewScore #0 #5

	lda active,x
	and #$7f
	sta active,x

	dec lbcount		; licznik kul levelu	(PANIC MODE)

no_hit	jmp HERO

t_note	dta ton_C4, ton_C5, ton_G4, ton_G3, ton_G2
h_score	dta 0,1,1,2
l_score	dta 5,0,5,0

add_energy dta 48,48,32,32

SPLASH	lda harp0.x
	sta harpun	; zaznaczamy u¿yty harpun aby potem móc go usun¹æ z obrazu

panic	jsr hitBall

	lda explose	; zapamiêtujemy tylko pierwsz¹ wykryt¹ eksplozje, dla pozostalych nie mamy tyle gwiazdek
	cmp #$ff
	sne
	stx explose

_splash	ldy ttype,x

	cpy #4
	bcs _kill	; kula musi znikn¹æ

	mva h_score,y	NewScore._10
	mva l_score,y	NewScore._1
	jsr NewScore

	inc ttype,x

	lda $d20a
	bpl lewa

prawa	mva add_energy,y ADD_NEW_BALL.new0+1	; dodatkowa energia kul po trafieniu harpunem
	sbc #5
	sta ADD_NEW_BALL.new1+1

	jmp skip

lewa	mva add_energy,y ADD_NEW_BALL.new1+1	; dodatkowa energia kul po trafieniu harpunem
	sbc #7
	sta ADD_NEW_BALL.new0+1

skip
	lda t_note,y

	PlaySfx @ #sfxBum

	.rept mobjects
	ldy active+#
	bpl found
	.endr

;	lda active+63
;	bne _skp				; i to w³aœciwie nie ma prawa siê wydarzyæ
	ldy #mobjects
found	cpy objects
	scc
	sty objects

	dey

	ADD_NEW_BALL			; dodajemy now¹ kulê pod indeksem z rejestru Y

/* ---------------------------------------- */
/*	      losujemy BONUS               */
/* ---------------------------------------- */
; rejestry X, Y pozostaj¹ nienaruszone

	lda bonus.x			; jeœli jakiœ bonus jest w u¿yciu to BONUS.X > 0
	ora tnt+1			; gdy kule wybuchaj¹ nie bêdzie bonusów
	ora BALL_COLLISION.stop+1	; gdy kule stoj¹ nie bêdzie bonusów
	bne quit

	sta bonus.tim		; = 0

	lda $d20a
	lsr @
	and #$0f
	tay

	lda cnt_bonus,y		; ograniczona liczba wyst¹pieñ bonusu
	cmp #max_bonus_counter
	bcs quit

	add #1
	sta cnt_bonus,y

mode	lda typ_bonus,y
	beq quit
	cmp #$ff		; bonusy nie bêd¹ siê powtarza³y
old_bonus equ *-1
	beq quit

	sta bonus.typ

	sta old_bonus

	lda posy,x
	:3 lsr @
	sne
	add #1

	cmp #scrhig-2
	scc
	lda #scrhig-3

	sta bonus.y

	ldy harp0.x
	lda min52div4,y
	sta bonus.x

	jsr GO_BONUS.testXY
	cpy #0
	beq quit

	mva #0 bonus.x

quit
	ldy ttype,x

	jmp HERO

	.endl DETECT

cnt_bonus	.ds 16

	.array	typ_bonus [16] .byte
	[1]	= bonusCode.heart
	[4]	= bonusCode.clock
	[6]	= bonusCode.shield
	[9]	= bonusCode.tnt
	[11]	= bonusCode.harpun
	[14]	= bonusCode.harpun_h
	.enda

	.array	typ_bonus_panic [36] .byte
	[2]	= bonusCode.heart
	[5]	= bonusCode.shield
	[7]	= bonusCode.heart
	[10]	= bonusCode.shield
	[12]	= bonusCode.shield
	[13]	= bonusCode.heart
	[14]	= bonusCode.heart
	[17]	= bonusCode.heart
	.enda

.endp COLLISIONS
