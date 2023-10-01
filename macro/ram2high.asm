
	org Code

	lda:rne vcount

	sei
	inc nmien
	mva #$fe portb

	clc:xce

	.ia 16

	phb

	move Src Dst Len

	plb

	.ia 8

	sec:xce

	lda:rne vcount

	mva #$ff portb
	dec nmien
	cli

	rts

	ini Code

