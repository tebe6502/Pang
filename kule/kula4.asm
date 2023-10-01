
;	clear = 0
;	k = 0

txt	 = $a000

	ift k=0
		.get 'mic\kula_0.mic',[32*8]*12
	eli k=1
		.get 'mic\kula_1.mic',[32*8]*12
	eli k=2
		.get 'mic\kula_2.mic',[32*8]*12
	els
		.get 'mic\kula_3.mic',[32*8]*12
	eif


	.get [$f000] 'mask\maska.dat'

	.extrn	?mem	.word

	.reloc

	?line	= 0
	?old	= $ffff
	?cycle	= 0

	:2 read

read	.macro
	?adres=?line*32
	char

	?adres=?line*32+1
	char

	?adres=?line*32+2
	char

	?line += 8
	.endm


char	.macro

	 byte
	 byte
	 byte
	 byte
	 byte
	 byte
	 byte
	 byte
	 
	.endm

	rts

	.print ?cycle,' cycles'


* ---
	ift clear=0
	 icl 'macro\make.mac'
	els
	 icl 'macro\clear.mac'
	eif
