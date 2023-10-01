
	:256 maska #

maska	.macro
	?v = :1

	?p0 = ?v&$c0
	?p1 = ?v&$30
	?p2 = ?v&$0c
	?p3 = ?v&$03
	
	?w = 0

	ift ?p0<>0
	 ?w=$c0
	eif

	ift ?p1<>0
	 ?w += $30
	eif

	ift ?p2<>0
	 ?w += $0c
	eif

	ift ?p3<>0
	 ?w += $03
	eif

	.put[:1] = ?w
	
	.endm


	.sav 'maska.dat',256