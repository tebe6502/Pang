
/*******************************************************************************************

  FRM_DEATH (06.11.2016)

  klatki animacji bohatera kiedy ginie (prawa / lewa strona)

  PMG - MLC, 20 pixli

*******************************************************************************************/

	icl 'atari.hea'
	icl 'pang.hea'


	.extrn yB1old .byte
	.extrn rw0 rw1 rw2 rw3 rw4 rw5 rw6 rw7 rw8 rw9 rw10 rw11 rw12 rw13 rw14 rw15 .byte
	.extrn rw16 rw17 rw18 rw19 rw20 rw21 rw22 rw23 rw24 rw25 rw26 rw27 rw28 rw29 rw30 rw31 .byte

	.extrn pmgB hposx hposy .byte PLAYER.return .word
	.extrn SCR1 SCR2 dliDeath dliHeroDeath.c0 dliHeroDeath.c1 .word

	.public frmD


	.RELOC

// !!! adres musi zaczynac siê od poczatku strony !!!

* --------------------------------------------------------------------------------------------
* --------------------------------------------------------------------------------------------

// na pierwszej pozycji wystêpuje zawsze wartoœæ 0, dlatego mo¿emy pierwsz¹ pozycjê pomin¹æ

ms	.he 00 02 08 09 02 02 00 00
	.he 08 0E 27 01 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 09 2E 8F BD 9D EE EE CD BC 97 24 25 06 03 03 08
	.he 0A 08 02 09 0E 01 08 03 01 08 02 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 02 08 00 02 09 01 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 02 02 00 20 30 60
	.he 70 72 68 92 81 04 01 00 00 00 00 00 00 00 00 02
	.he 08 02 08 08 0A 02 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
p0
	.he 00 00 00 00 00 00 04 0A
	.he 0F 0C 0A 06 06 05 03 01 00 02 04 03 05 19 0C 08
	.he 1C 28 24 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 05 0E 19 16 0A 40 C0 40 C0 D2 4D 9F 25 00 25 02
	.he 02 01 01 01 00 03 04 11 04 15 0A 01 16 1D 07 00
	.he 0A 17 0F 2E 1D 1B 06 0E 0A 13 77 22 02 01 02 05
	.he 03 04 02 01 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 2B 56 34 E9 AA 55 59 26
	.he C2 B4 48 62 1D 3F 37 0B 14 0B 16 2F 16 25 00 30
	.he 28 09 13 04 0B 07 03 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
p1
	.he 00 00 00 00 00 00 00 04
	.he 04 07 06 01 03 03 01 00 01 05 02 02 09 0D 19 00
	.he 08 14 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 0D 0C 08 00 00 00 80 80 8C 9E 4E 4E 26 02 00
	.he 00 00 00 00 01 00 08 02 13 03 11 18 18 0E 0E 00
	.he 07 0F 1D 1B 06 0D 0B 04 1D 3E 25 07 00 00 01 03
	.he 07 03 01 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 13 3F 7E 7C 79 FB F3 F3
	.he 71 62 24 29 2B 0F 0F 17 17 1C 09 13 39 00 18 00
	.he 00 10 08 0B 07 02 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
p2
	.he 05 8E 6F 77 5B 0D 56 27
	.he 75 1C 8E 64 24 48 34 AA 9C 32 44 28 50 C0 00 60
	.he 80 40 00 80 40 20 C0 60 00 00 00 00 00 00 00 00
	.he 1D 46 D2 69 45 DA A9 36 34 02 C1 74 4B DF 5E 3D
	.he D2 6D 56 8F 76 6A 40 60 E1 89 4C 82 1D 0E 0C 00
	.he 00 10 60 E0 A0 00 A2 45 EF 83 15 66 46 2A CC 58
	.he 90 C4 22 4C AA 39 03 61 13 21 02 10 20 40 30 60
	.he 00 00 00 00 00 00 00 00 8A 27 B9 66 25 B0 50 C0
	.he C0 04 3B EF 2A B0 AA C4 B4 68 A8 18 E0 6C 22 68
	.he 72 1A 25 18 86 0B 0E 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
p3
	.he 0E 5F 5B 2D 36 5B 2D 72
	.he 1B 37 5A 0E C0 E0 E8 7C 7E FC F8 40 20 80 60 40
	.he 00 80 C0 C0 80 00 60 E0 00 00 00 00 00 00 00 00
	.he 8C 9F 47 83 09 2D 4C 4C 78 74 52 F9 DD CF EF FE
	.he 3E 03 B9 DC C9 20 A1 C0 C0 C0 81 0D 0E 04 00 00
	.he 00 A0 A0 40 C0 A0 40 E2 82 CE A6 08 3C 7C 78 E0
	.he E8 FA F4 24 49 1B 69 20 01 12 30 30 10 00 60 70
	.he 00 00 00 00 00 00 00 00 10 9B 23 11 00 40 20 20
	.he E0 E3 A7 F7 B7 36 74 F0 C0 00 D0 B0 38 40 51 34
	.he 3C 3C 18 01 01 07 07 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	.he 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

* --------------------------------------------------------------------------------------------
* --------------------------------------------------------------------------------------------

	:8 brk

	ert *<>$5e0

frmD			// !!! KONIECZNIE TEN SAM ADRES CO W 'FRMR' !!!

col	lda #0
	and #7
	tay

	lda tcol0,y
	sta dliHeroDeath.c0

	lda tcol1,y
	sta dliHeroDeath.c1

	inc col+1

	lda hposx
	cmp #232
	bcs skp0

	add #4
	sta hposx

skp0
	ldy #40-4

	jmp FILLB1


tcol0	:3 dta $14
	:5 dta $74

tcol1	:3 dta $18
	:5 dta $78

	?ofset = hero_pmg_offset

.local	FILLB1

;	ldx yB1old
;	cpx hposy
;	jeq skp
/*
	lda #0
	.rept 8
	sta pmgB1+pmHero0-31+#+?ofset-4,x
	sta pmgB1+pmHero1-31+#+?ofset-4,x
	sta pmgB1+pmHero2-31+#+?ofset-4,x
	sta pmgB1+pmHero3-31+#+?ofset-4,x

	sta pmgB1+pmHero0-#+?ofset,x
	sta pmgB1+pmHero1-#+?ofset,x
	sta pmgB1+pmHero2-#+?ofset,x
	sta pmgB1+pmHero3-#+?ofset,x

	sta pmgB1+$300-31+#+?ofset,x
	sta pmgB1+$300-#+?ofset,x
	.endr
*/

	lda hposy
	cmp #120
	beq jump

	lda yB1old
	add hposy

	tax

	cmp #160
	jcs clr

	adb yB1old #4

	jmp go


jump	lda yB1old
	and #3
	add hposy

	tax

	inc yB1old


	?ile = 32+4

go
	.rept ?ile+4

	ift #<?ile

	lda ms+#,y
	sta pmgB1+$300-?ile-1+#+?ofset,x
	sta pmgB2+$300-?ile-1+#+?ofset,x

	lda p0+#,y
	sta pmgB1+pmHero0-?ile-1+#+?ofset,x
	sta pmgB2+pmHero0-?ile-1+#+?ofset,x

	lda p1+#,y
	sta pmgB1+pmHero1-?ile-1+#+?ofset,x
	sta pmgB2+pmHero1-?ile-1+#+?ofset,x

	lda p2+#,y
	sta pmgB1+pmHero2-?ile-1+#+?ofset,x
	sta pmgB2+pmHero2-?ile-1+#+?ofset,x

	lda p3+#,y
	sta pmgB1+pmHero3-?ile-1+#+?ofset,x
	sta pmgB2+pmHero3-?ile-1+#+?ofset,x

	els

	lda #0
	sta pmgB1+$300-?ile-1+#+?ofset,x
	sta pmgB2+$300-?ile-1+#+?ofset,x

	sta pmgB1+pmHero0-?ile-1+#+?ofset,x
	sta pmgB2+pmHero0-?ile-1+#+?ofset,x

	sta pmgB1+pmHero1-?ile-1+#+?ofset,x
	sta pmgB2+pmHero1-?ile-1+#+?ofset,x

	sta pmgB1+pmHero2-?ile-1+#+?ofset,x
	sta pmgB2+pmHero2-?ile-1+#+?ofset,x

	sta pmgB1+pmHero3-?ile-1+#+?ofset,x
	sta pmgB2+pmHero3-?ile-1+#+?ofset,x

	eif

	.endr

	;stx yB1old

skp	jmp PLAYER.return


clr	lda #0

	.rept 16

	sta pmgB1+$300-?ile-1+#+?ofset,x
	sta pmgB2+$300-?ile-1+#+?ofset,x

	sta pmgB1+pmHero0-?ile-1+#+?ofset,x
	sta pmgB2+pmHero0-?ile-1+#+?ofset,x

	sta pmgB1+pmHero1-?ile-1+#+?ofset,x
	sta pmgB2+pmHero1-?ile-1+#+?ofset,x

	sta pmgB1+pmHero2-?ile-1+#+?ofset,x
	sta pmgB2+pmHero2-?ile-1+#+?ofset,x

	sta pmgB1+pmHero3-?ile-1+#+?ofset,x
	sta pmgB2+pmHero3-?ile-1+#+?ofset,x

	.endr

	jmp PLAYER.return

.endl


* --------------------------------------------------------------------------------------------
* --------------------------------------------------------------------------------------------

