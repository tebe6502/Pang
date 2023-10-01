
	org $2000

invers = $a000

	icl 'ckula0.asm'
	icl 'ckula1.asm'
	icl 'ckula2.asm'
	icl 'ckula3.asm'
	icl 'ckula4.asm'

eorX	lda addx,x
	eor #$fe
	sta addx,x
	rts

eorY	lda addcnt,x
	eor #$fe
	sta addcnt,x
	rts

addx
addcnt
