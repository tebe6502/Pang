
// zapisz plik MIC i SCR z poziomu G2F, tekstura ma szerokoœæ 40 bajtów, jest bez górnego murka

.macro	copyLine
	:+40 .put[?dst+#] = .get[?l+#]

	.def ?dst += 40
	.def ?l += 40
.endm

.macro cutM
	.get :1

	.def ?l=0
	.def ?dst=$4000

	:+152 copyLine
.endm

.macro cutS
	:+19 .get [$c000+#*48+4] :1,#*40,40

	:+16 .put [$c000+#*48] = 0,0,0,0
	:+16 .put [$c000+#*48+44] = 0,0,0,0

	.def ?dst = $4000+152*40

	.rept 48*19
	ift .get[$c000+.r]<$80
	.put[?dst+.r]=0
	els
	.put[?dst+.r]=$80
	eif
	.endr
.endm

.macro	cutC
	.get :1

	.def ?dst=$4000+152*40+1024

	.rept 19

	.put[?dst] = .get[#*8]
	.def ?dst++
	.put[?dst] = .get[256+#*8]
	.def ?dst++
	.put[?dst] = .get[256*2+#*8]
	.def ?dst++
	.put[?dst] = .get[256*3+#*8]
	.def ?dst++
	.put[?dst] = .get[256*4+#*8]
	.def ?dst++

	.endr
.endm


.macro	file
	cutM :1.mic'
	cutS :1.scr'
	cutC :1.col'

	.sav [$4000] :1.tex',152*40+1024+5*19
.endm

	file "'g2f\default"
	file "'g2f\PangPark_Vers2"
	file "'g2f\PangMostVers2_G2F_Powrooz"
	file "'g2f\PangMostVer3"
	file "'g2f\PangMostVer3Clean"
	file "'g2f\PangAtlas_G2F_Powrooz"
	file "'g2f\PangCaves_G2F_Powrooz"
	file "'g2f\PangJapan_G2F_Powrooz"
	file "'g2f\PangStreet_G2F_Powrooz"
	file "'g2f\PangShrine_G2F_Powrooz_2Final"
	file "'g2f\PangLight_G2F_Powrooz"
	file "'g2f\PangCityVers2AA"
	file "'g2f\PangCity_G2F_Powrooz"
	file "'g2f\PangMansion_G2F_Powrooz"
	file "'g2f\PangWinter_G2F_Powrooz"
	file "'g2f\PangLions2011ooz"
	file "'g2f\PangSzlam_G2F_Replay"
	file "'g2f\PangCastle_G2F_Replay"
	file "'g2f\PangJapanVers2"
