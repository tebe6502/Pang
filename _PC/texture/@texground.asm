
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

	:+80 copyLine
.endm

.macro cutS
	:+10 .get [$c000+#*48+4] :1,#*40,40

	.def ?dst = $4000+80*40

	.rept 48*10
	ift .get[$c000+.r]<$80
	.put[?dst+.r]=0
	els
	.put[?dst+.r]=$80
	eif
	.endr
.endm

.macro	cutC
	.get :1

	.def ?dst=$4000+80*40+480

	.rept 10

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

	.sav [$4000] :1.tex',80*40+480+5*10
.endm

	file "'g2f-ground\groundDino"
	file "'g2f-ground\groundMaya"
	file "'g2f-ground\groundMeteo"
	file "'g2f-ground\groundIce"
