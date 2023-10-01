
	org $2000

main	lda:cmp:req 20

	sei
	mva #0 $d40e
	mva #$fe $d301

	move #_c000 #$c000 #16
	move #_d800 #$d800 #40

	jmp $ffe0


.proc	move (.word src+1, dst+1 .byte ile+1) .var

ile	ldx #40
	ldy #0
src	lda _d800,y
dst	sta $d800,y
	iny
	bne src

	inc src+2
	inc dst+2
	dex
	bne src
	rts
.endp


_c000	ins 'kulki.obx'

_d800	ins 'logo_2.obx'
