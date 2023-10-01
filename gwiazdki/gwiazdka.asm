
scr48	= %00111111	;screen 48b
scr40	= %00111110	;screen 40b
scr32	= %00111101	;screen 32b

cloc	= $0014		;(1)

pmgB1	= $0
pmgB2	= $a000

hposp0	= $D000
hposp1	= $D001
hposp2	= $D002
hposp3	= $D003
hposm0	= $D004
hposm1	= $D005
hposm2	= $D006
hposm3	= $D007
sizep0	= $D008
sizep1	= $D009
sizep2	= $D00A
sizep3	= $D00B
sizem	= $D00C

colpm0	= $D012
colpm1	= $D013
colpm2	= $D014
colpm3	= $D015
color0	= $D016
color1	= $D017
color2	= $D018
color3	= $D019
colbak	= $D01A
gtictl	= $D01B

chbase	= $D409

* ---	MAIN PROGRAM
	org $2000

ant	dta $44,a(scr)
	:20 dta 4
	dta $41,a(ant)

scr


main
* ---	init PMG
	mva >pmgB1 $d407		;missiles and players data address
	mva #3 $d01d		;enable players and missiles

	lda:cmp:req 20		;wait 1 frame

	sei			;stop IRQ interrupts
	mva #0 $d40e		;stop NMI interrupts
	mva #$fe $d301		;switch off ROM to get 16k more ram

	mwa #NMI $fffa		;new NMI handler

	mva #$c0 $d40e		;switch on NMI+DLI again


gogo
	lda $d20a		; init wartosci poczatkowych
	and #$7f
	add #40
	sta dataStar[0].x
	sta dataStar[1].x
	sta dataStar[2].x
	sta dataStar[3].x

	lda $d20a
	and #$7f
	add #30
	sta dataStar[0].y
	sta dataStar[1].y
	sta dataStar[2].y
	sta dataStar[3].y

	lda $d20a			; star #0
	and #15
	tax
	mva rndMinus,x	dataStar[0].dx
	mva rndMinus,x	dataStar[0].dy

	lda $d20a			; star #2
	and #15
	tax
	mva rndPlus,x	dataStar[2].dx
	mva rndPlus,x	dataStar[2].dy

	lda $d20a			; star #1
	and #15
	tax
	mva rndMinus,x	dataStar[1].dx
	mva rndPlus,x	dataStar[1].dy

	lda $d20a			; star #3
	and #15
	tax
	mva rndPlus,x	dataStar[3].dx
	mva rndMinus,x	dataStar[3].dy


	mva #10 starsCnt

loop	jsr wait					; #1

	ldy #@@shape
	jsr stars1.clr

	ldy #@@shape*3
	jsr stars2.clr

	ldy #0
	mva dataStar+@@shape.x,y	$d002
	jsr stars1

	ldy #@@shape*2
	mva dataStar+@@shape.x,y	$d003
	jsr stars2

* --------------------------------------------------

	jsr wait					; #2

	ldy #0
	jsr stars1.clr

	ldy #@@shape*2
	jsr stars2.clr

	ldy #@@shape
	mva dataStar+@@shape.x,y	$d002
	jsr stars1

	ldy #@@shape*3
	mva dataStar+@@shape.x,y	$d003
	jsr stars2

	dec starsCnt
	bne loop

	jmp gogo


rndMinus	dta rnd($fa,$fe,16)

rndPlus		dta rnd(2,6,16)

starsCnt brk

wait	lda:cmp:req cloc
	rts


.PROC NMI
	bit $d40f
	bpl VBL

	rti
dliv	equ *-2

VBL	phr
	sta $d40f		;reset NMI flag

	inc cloc		;little timer

	mwa #ant $d402		;ANTIC address program

	mva #scr32 $d400	;set new screen's width

;--- first line of screen initialization


c0	lda #$00
	sta colbak
c1	lda #$04
	sta color0
c2	lda #$06
	sta color1
c3	lda #$08
	sta color2
c4	lda #$0E
	sta color3
	lda #$04
	sta gtictl


	lda cloc
	sta colpm2
	sta colpm3

;	mwa #dli_start dliv	;set the first address of DLI interrupt

;this area is for yours routines

	plr
	rti

.ENDP


	icl 'stars.asm'


	run main
