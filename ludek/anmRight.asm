
	.get 'anmLeft.obx'

// pociski wspak

	.rept 256
	?a = #>>4
	?b = #&$0f

	?v0 = ?a>>2
	?v1 = ?a&3

	?v = ?v1<<6+?v0<<4

	?v0 = ?b>>2
	?v1 = ?b&3

	.put[$a000+#] = ?v+?v1<<2+?v0

	.endr


// gracze wspak

	.rept 256
	?a = #>>6&3
	?b = #>>4&3
	?c = #>>2&3
	?d = #&3

	.put[$b000+#] = ?d<<6+?c<<4+?b<<2+?a

	.endr


// modyfikujemy dane

	.rept 24
	?v = .get[#]
	.put[#] = .get[$a000+?v]
	.endr

	.rept 96
	?v = .get[24+#]
	.put[24+#] = .get[$b000+?v]
	.endr


	.rept 48
	?v = .get[120+#]
	.put[120+#] = .get[$a000+?v]
	.endr


	.rept 192
	?v = .get[168+#]
	.put[168+#] = .get[$b000+?v]
	.endr


	.sav 'anmRight.dat',360