

TEST	= 1

PMG	= 0


	icl 'atari.hea'

 cloc	= $14

	org $80

fcnt	.ds 2
fadr	.ds 2
fhlp	.ds 2
regA	.ds 1
regX	.ds 1
regY	.ds 1


	org $2000

fnt	ins 'pmg_bmp.fnt'

ant	dta d'ppp'
	dta $44
adr	dta a(frm)
	dta 4,4,4,4

	dta $41,a(ant)



frm	ins 'pmg_bmp.scr'




tabpp  dta 156,78,52,39			;line counter spacing table for instrument speed from 1 to 4

main
; ---	init PMG

	ift !TEST
	lda tabpp-1,y
	sta acpapx2+1				;sync counter spacing
	lda #86+0
	sta acpapx1+1
	eif

	lda:rne vcount

	ift TEST
	sei			;stop IRQ interrupts
	mva #$00 nmien		;stop NMI interrupts
	sta dmactl
	mva #$fe portb		;switch off ROM to get 16k more ram
	els
	mva #$00 nmien		;stop NMI interrupts
	eif

	mwa #NMI $fffa		;new NMI handler

	mva >pmg pmbase		;missiles and players data address
	mva #$03 pmcntl		;enable players and missiles

	:3 mva #4+#*4 color0+#

	mva #$40 nmien		;switch on NMI+DLI again


	wait #12

	mwa #frm+5*40 adr

	jmp *


.proc	wait (.byte x) .reg

loop	lda:cmp:req 20
	dex
	bne loop

	rts

.endp


.proc	NMI

	bit nmist
	bpl VBL

	rti

VBL
	sta regA
	stx regX
	sty regY

	sta nmist		;reset NMI flag

	mwa #ant dlptr		;ANTIC address program

	mva #scr40 dmactl	;set new screen width

	inc cloc		;little timer

; Initial values

	lda >fnt+$400*$00
	sta chbase

;this area is for yours routines

	lda regA
	ldx regX
	ldy regY
	rti

.endp









	run main
