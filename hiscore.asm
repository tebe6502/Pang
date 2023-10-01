/*
	SortScore zwraca w regY numer wpisu dla ktorego mamy wprowadzic 3 literowy 'ksywke' 0..4
*/


score_cnt = 6

scr	= $bc40

hlp	= $80

	org $2000

fnt	ins 'panel\liczniki2.fnt'


main	mva >fnt 756

	lda #15
	ldy #0
	ldx #4
clr	sta scr,y
	iny
	bne clr
	inc clr+2
	dex
	bne clr

	jsr SortScore
	sty $600

	mwa #scr hlp

	.rept 5
	ldx #9*#
	ldy #40*#
	jsr showScore
	.endr

	jmp *
	
	
showScore
	:6 mva scoreBoard+#,x (hlp),y+

	adw hlp #80
	rts
	
	
.local	SortScore

	ldy #0
lp2
	ldx #0
lp
	sec

	.rept score_cnt
	lda scoreBoard+score_cnt-1-#,x
	sbc scoreBoard+score_cnt-1-#,y
	.endr

	bpl skp

	jsr swap

skp	txa
	add #9
	tax

	cpx #6*9
	bne lp

	tya
	add #9
	tay

	cpy #6*9
	bne lp2

	ldy #0
	ldx #6

find	lda scoreBoard,x
	beq stop

	txa
	add #9
	tax

	iny
	cpy #5
	bne find
	

stop	rts
	
swap	:score_cnt+3 mva scoreBoard+#,y scoreTemp+#
	:score_cnt+3 mva scoreBoard+#,x scoreBoard+#,y
	:score_cnt+3 mva scoreTemp+# scoreBoard+#,x

	rts
	
scoreTemp :score_cnt+3 brk

.endl
	

// po posortowaniu pierwsze 5 miejsc zajma najwyzsze wyniki
// ostatni wpis _NEW jest niewidoczny na tablicy
// wpis _NEW sluzy do wprowadzenia nowego wyniku, jesli wejdzie na tablice to uzupelniamy 3 literowa ksywke

.local	scoreBoard
	dta 0,1,0,0,0,0, d'aaa'
	dta 0,2,0,0,0,0, d'bbb'
	dta 0,4,0,0,3,0, d'ccc'
	dta 0,4,0,0,4,0, d'ddd'
	dta 0,0,5,0,0,0, d'eee'

_new	dta 0,3,0,0,0,0, d'   '
.endl

	run main

