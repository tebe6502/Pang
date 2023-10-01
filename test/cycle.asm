
byt2	= $80

	org $2000

main	;inc byt2
	;nop

	pha
	pla

	brk


	run main
