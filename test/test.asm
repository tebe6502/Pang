
	;icl '..\pang.hea'

	pmstar = $a000

	.extrn tmpINVERS, inflate .word
	.extrn inputPointer, outputPointer .byte

	.public init_2

	.reloc

	.print volume

init_2
;	lda <volume
;	sta $80
	lda >volume
	sta $81

;	lda <pmStar
;	sta $82
	lda >pmStar
	sta $83

	brk

	:$2a5-9-1 nop

volume	ins 'volume.df7'
;pmStar	brk
