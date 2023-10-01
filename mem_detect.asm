
/*--------------------------------------------------------------------------------*/
/*	MEM DETECT
/*--------------------------------------------------------------------------------*/

.macro	@print
	jsr printf

	.rept 40
	ift .get[$100+#]<>"*"

	?a=.get[$100+#] & $7f
	?i=.get[$100+#] & $80

	ift ?a<=63
	?a=?a+32
	eli ?a<=95
	?a=?a-64
	eif

	ift ?i<>0
	?a=?a | $80
	eif

	dta ?a

	eif
	.endr

	dta ?end
	ift ?end=$9b
	dta 0
	eif
.endm

.local	___loader

	org $0480

	.link '\stdio\printf.obx'

	org $0600		; nowa Display List-a

dl_load	dta d'ppp'
	dta $42,a($bc40)
	:23 dta 2
	dta $41,a(dl_load)


initDe	jsr printf
	dta $9b,c'#',$9b,0
	dta a(build+1)

	lda #'-'
	ldx #36
	sta:rpl build,x-

	jsr printf
	dta c'#',$9b,0
	dta a(build+1)

	rts
/*
clrMem	ldx #$a0
	ldy #0
	tya
clr	sta $2000,y
	iny
	bne clr
	inc clr+2
	dex
	bne clr

	rts
*/
build	dta c'*PANG '
	:40 dta $9b

;	.print *

	ini initDe

	opt h-
	ins 'detect_pang.obx'

	opt h+
	org $2000

	ldy #0
	tya
	sta:rne $d000,y+

;	sta lmargn
	sta 623

;	sta colcrs
;	sta rowcrs		; kursor na górze ekranu

	mwa #dl_load 560

	mva #scr40 559
	sta dmactl

	jsr @mem_detect

	cmp #banks
	scs
	jmp no_mem

	jsr presKey

	mva #0 lmargn
	sta colcrs
	sta colcrs+1

	.rept 24
	?end=0

	ift #<>23
	?end=$9b
	eif
	.get [$100] 'loading.scr',4*40+#*40,40
	@print
	.endr

	mva #$ff portb

	rts

kwait
	lda consol		; START
	and #1
	beq i_stop
	lda trig0		; FIRE
	beq i_stop

	lda $d20f
	and #8
	beq i_stop

	lda $d20f
	and #4
	bne kwait

i_stop	mva #$ff 764

	rts

no_mem
;	mva #23 rowcrs
;
;	jsr printf
;	dta $9b,$9b,0

	jsr printf
	dta $9b,$9b,c'PANG required 192 kB extended memory',$9b
	:36 dta c'-'
	dta 0

;	mva #2 colcrs

	jsr presKey

	pla
	pla

	jmp ($a)

presKey	jsr printf
	dta $9b,$9b,c'Press any key',$9b,0

	jmp kwait

	icl 'proc\@mem_detect.asm'

;	org $bc40
;	ins 'loading.scr',4*40,24*40

	ini $2000
.endl