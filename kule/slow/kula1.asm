
	org $2000

mem	= $a000

ant	dta d'ppp',$4e,a(mem)
	dta d'..............................................'
	dta $41,a(ant)



	.get 'kula1.mic'

	.get [$f000] 'maska.dat'


ile	= 5

main
	mwa #ant 560
	mva #%00111101 559

	ldx #0
	jsr $4000

	ldx #3
	jsr $4000

	jmp *



	org $4000


	?line	= 0
	?old	= $ffff
	?cycle	= 0

	:5*8 read


read	.macro
	?adres=?line*32

	byte
	byte
	byte
	byte
	byte
	
	?line++
	.endm


byte	.macro
	?v = .get[?adres]

	ift ?v<>0

	 ?p0 = ?v&$c0
	 ?p1 = ?v&$30
	 ?p2 = ?v&$0c
	 ?p3 = ?v&$03
	 
	 ift ?p0<>0 .and ?p1<>0 .and ?p2<>0 .and ?p3<>0
	  ift ?old<>?v
	   lda #?v
	   ?cycle += 2
	  eif
	  sta mem+?adres,x
	  ?cycle += 4
	  ?old=?v	 
	 eli ?p0=0 .and ?p1=0 .and ?p2=0 .and ?p3=0
	 
	 els
	  lda $a000+?adres,x
	  and #.get[$f000+?v]^$ff
	  ora #?v
	  sta mem+?adres,x
	  ?cycle += 12
	  ?old=$ffff
	 eif
	
	eif

	?adres++
	.endm

	rts

	.print 'kula1: ',*-$4000 ,' bytes, ',?cycle,' cycles'

	run main