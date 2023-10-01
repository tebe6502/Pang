
// w 1 ramce wyswietlana jest gwiazdka #0 i #2
// w 2 ramce wyswietlana jest gwiazdka #1 i #3

.struct	@@shape
x	.byte
y	.byte
py	.byte

dx	.byte
dy	.byte
.ends


.macro	@updateXY
	lda dataStar+@@shape.y,y
	tax
	sta dataStar+@@shape.py,y

	add dataStar+@@shape.dy,y

;	bcs skp
	cmp #240
	bcs skp

	sta dataStar+@@shape.y,y

skp	lda dataStar+@@shape.x,y
	add dataStar+@@shape.dx,y
	sta dataStar+@@shape.x,y
.endm


.proc	stars1 (.byte y) .reg

	@updateXY

	ldy #0

	.rept 10
	lda shapeStar+#,y
	sta pmgB1+pmStar0+#,x
	sta pmgB2+pmStar0+#,x
	.endr

	rts


clr	ldx dataStar+@@shape.py,y

	lda #0

	.rept 10
	sta pmgB1+pmStar0+#,x
	sta pmgB2+pmStar0+#,x
	.endr

	rts
.endp


.proc	stars2 (.byte y) .reg

	@updateXY

	ldy #0

	.rept 10
	lda shapeStar+#,y
	sta pmgB1+pmStar1+#,x
	sta pmgB2+pmStar1+#,x
	.endr

	rts


clr	ldx dataStar+@@shape.py,y

	lda #0

	.rept 10
	sta pmgB1+pmStar1+#,x
	sta pmgB2+pmStar1+#,x
	.end

	rts
.endp


// parametry gwiazdek
dataStar	dta @@shape [3]

// kszta³t gwiazdki
shapeStar
	dta %00010000
	dta %00010000
	dta %00010000
	dta %00111000
	dta %11111110
	dta %00111000
	dta %01111100
	dta %01111100
	dta %11000110
	dta %10000010
