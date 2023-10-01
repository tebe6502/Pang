
// w 1 ramce wyswietlana jest tylko jedna gwiazdka

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
	cmp #dolnakrawedz-32
	bcs skp

	sta dataStar+@@shape.y,y

skp	lda dataStar+@@shape.x,y
	add dataStar+@@shape.dx,y
	sta dataStar+@@shape.x,y
.endm


.proc	stars1 (.byte y) .reg

	sty _y+1

// ---------------------------------------

	jsr clr

// ---------------------------------------

_y	ldy #0
	sty clr+1

	@updateXY

;	ldy #0

.put[$100] = %00010000,%00010000,%00010000,%00111000,%11111110,%00111000,%01111100,%01111100,%11000110,%10000010

	.rept 10
;	lda shapeStar+#	;,y
	lda #.get[$100+#]
	sta pmgB1+pmStar+#,x
	sta pmgB2+pmStar+#,x
	.endr

	rts


clr	ldy #0

	ldx dataStar+@@shape.py,y

	lda #0

	.rept 10
	sta pmgB1+pmStar+#,x
	sta pmgB2+pmStar+#,x
	.endr

	rts

.endp


// parametry gwiazdek
dataStar	dta @@shape [3]

/*
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
*/