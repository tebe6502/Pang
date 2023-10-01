
energy_len	= 12

energy_up	= $54
energy_dw	= $5d

energy_up_first	= $4d
energy_dw_first	= $56


energy_bar = $bc40+5*40+5


	org $bc40
	:40*24 dta $f


	org $2000

fnt	ins 'liczniki2.fnt'


main	mva >fnt 756

	lda #energy_up
	:energy_len sta energy_bar+#
	
	lda #energy_dw
	:energy_len sta energy_bar+40+#

	lda #energy_len*8-1
	sta power

lp	:2 lda:cmp:req 20

	jsr update_energy

	sbb power #27

	
	lda power	
	cmp #57
	bcs lp

	jsr more

	jmp *




more	adb power #5
	cmp #energy_len*8
	scc

	lda #energy_len*8

	:3 lsr @
	tay
	beq update_energy

	dey

loop	lda #energy_up				; gorny znak paska energi
	sta energy_bar,y

	lda #energy_dw				; dolny znak paska energi
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






	run main
