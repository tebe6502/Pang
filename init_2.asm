
; ------------------------------------------------------------------------------------------------------
; ---	tutaj kod inicjalizuj¹cy który nie wymaga dostêpu do obszaru $4000..$7FFF pamiêci podstawowej
; ------------------------------------------------------------------------------------------------------

	icl 'pang.hea'

	.extrn tmpINVERS, inflate .word
	.extrn inputPointer, outputPointer .byte

	.public init_2

	.RELOC

init_2	mwa #volume inputPointer
	mwa #volume_slide outputPointer
	jsr inflate

// przepisanie danych PMG dla panelu
/*
	mva >pmgB1+$700 p0+2
	mva >pmgB2+$700 p1+2

	ldx #5*32-1
cp_lp	ldy #$1f
cp	lda pmgPan,x
p0	sta pmgB1+$700+panel_pmg_offset,y
p1	sta pmgB2+$700+panel_pmg_offset,y
	dex
	dey
	bpl cp

	dec p0+2
	dec p1+2

	cpx #$ff
	bne cp_lp
*/	
	
/*
	ldy #$1f
pmgP	.rept 5
	lda pmgPan+#*32,y
	sta pmgB1+$300+#*$100+panel_pmg_offset,y
	sta pmgB2+$300+#*$100+panel_pmg_offset,y
	.endr
	dey
	bpl pmgP
*/


// do pierwszego zestawów znaków dodajemy sta³e definicje elementów pola gry
// nastepnie tworzymy 19-e pozosta³ych zestawów jako kopie pierwszego zestawu

	ldx #7
copy	mva	dpustak,x	.get[0]<<8+(pustak&$7f)*8,x
	mva	dmurek,x	.get[0]<<8+(murek0&$7f)*8,x
	mva	dmurek+8,x	.get[0]<<8+(murek1&$7f)*8,x
	mva	dmurek+16,x	.get[0]<<8+(murek2&$7f)*8,x

	:16 mva	dmurek2+#*8,x	.get[0]<<8+(murL0&$7f)*8+#*8,x

	dex
	bpl copy


?idx	= (pustak&$7f)*8
?idx2	= $2c0			; ?2c0 + $100 obejmie znaki 'murek1' (104) i 'murek2' (105)

	ldy #0

cp0	jsr first
	jsr second

	tya
	sub #52-4
	:2 lsr @
	sta min52div4,y

	mva invers+$000,y	tmpINVERS+$000,y	; przepiszemy invers do tmpINVERS
	mva invers+$100,y	tmpINVERS+$100,y	; tmpINVERS dla detekcji murków miêkkich
	mva invers+$200,y	tmpINVERS+$200,y
	mva invers+$300,y	tmpINVERS+$300,y

;	mva volume,y	volume_slide,y

	iny
	bne cp0

	rts

first	lda .get[0]<<8+?idx,y
	sta .get[1]<<8+?idx,y
	sta .get[2]<<8+?idx,y
	sta .get[3]<<8+?idx,y
	sta .get[4]<<8+?idx,y
	sta .get[5]<<8+?idx,y
	sta .get[6]<<8+?idx,y
	sta .get[7]<<8+?idx,y
	sta .get[8]<<8+?idx,y
	sta .get[9]<<8+?idx,y
	sta .get[10]<<8+?idx,y
	sta .get[11]<<8+?idx,y
	sta .get[12]<<8+?idx,y
	sta .get[13]<<8+?idx,y
	sta .get[14]<<8+?idx,y
	sta .get[15]<<8+?idx,y
	sta .get[16]<<8+?idx,y
	sta .get[17]<<8+?idx,y
	sta .get[18]<<8+?idx,y
	rts

second	lda .get[0]<<8+?idx2,y
	sta .get[1]<<8+?idx2,y
	sta .get[2]<<8+?idx2,y
	sta .get[3]<<8+?idx2,y
	sta .get[4]<<8+?idx2,y
	sta .get[5]<<8+?idx2,y
	sta .get[6]<<8+?idx2,y
	sta .get[7]<<8+?idx2,y
	sta .get[8]<<8+?idx2,y
	sta .get[9]<<8+?idx2,y
	sta .get[10]<<8+?idx2,y
	sta .get[11]<<8+?idx2,y
	sta .get[12]<<8+?idx2,y
	sta .get[13]<<8+?idx2,y
	sta .get[14]<<8+?idx2,y
	sta .get[15]<<8+?idx2,y
	sta .get[16]<<8+?idx2,y
	sta .get[17]<<8+?idx2,y
	sta .get[18]<<8+?idx2,y
	rts

dpustak	:8 dta $aa
dmurek	ins 'objects.fnt',48*8,8*3	; 3x klocek murku #1
dmurek2	ins 'objects.fnt',58*8,8*16	; klocki murku poziomego i pionowego

/*
pmgPan	dta $00,$00,$00,$40,$00,$40,$00,$40,$00,$00,$00,$02
	dta $00,$02,$42,$00,$00,$00,$00,$00,$00,$80,$00,$40,$00,$00,$00,$00
	dta $00,$00,$00,$00

	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$3E,$41,$80
	dta $00,$00,$00,$00,$00,$00,$00,$06,$00,$00,$00,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00

	dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$28,$3C
	dta $24,$60,$7C,$76,$42,$81,$80,$00,$18,$1E,$0C,$2C,$18,$5C,$5C,$3C
	dta $0C,$38,$38,$00

	dta $00,$00,$00,$00,$00,$30,$00,$00,$30,$10,$F8,$78
	dta $30,$FC,$FC,$FC,$F8,$FC,$F8,$78,$FC,$FC,$FC,$7C,$78,$78,$30,$38
	dta $60,$10,$00,$00

	dta $08,$7C,$F4,$BC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$7C
	dta $7C,$78,$78,$78,$38,$30,$38,$30,$10,$10,$10,$00,$00,$00,$00,$00
	dta $00,$00,$00,$00
*/
;	.get [$100] 'volume.dat'
;volume	:256 dta .get[$100+#]<<4

volume	ins 'volume.df7'
