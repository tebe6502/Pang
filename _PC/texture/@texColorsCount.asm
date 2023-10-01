
// test wystêpowania kolorów COLPM0HERO, COLPM1HERO, COLPM2HERO w teksturach

colpm0Hero	= $02		; kolory bohatera (tekstury nie powinny korzystaæ z tych kolorów)
colpm1Hero	= $78		;
colpm2Hero	= $18		;

colm3Harpun	= colpm2Hero&$0f	; kolor harpunu uzale¿niony od koloru COLPM2


.macro	file
	.get :1.tex',?len,?col

	?c0 = 0
	?c1 = 0
	?c2 = 0
	?c3 = 0

	.rept ?col
	ift .get[#]=colpm0Hero
	?c0=1
	eli .get[#]=colpm1Hero
	?c1=1
	eli .get[#]=colpm2Hero
	?c2=1
	eli .get[#]=colm3Harpun
	?c3=1
	eif
	.endr

	ift ?c0||?c1||?c2||?c3
	.echo :1',',',?c0,',',?c1,',',?c2,',',?c3
	.exitm
	eif

.endm

	?len = 152*40+1024
	?col = 5*19

	file "'g2f\PangPark_Vers2"
	file "'g2f\PangMostVers2_G2F_Powrooz"
	file "'g2f\PangAtlas_G2F_Powrooz"
	file "'g2f\PangCaves_G2F_Powrooz"
	file "'g2f\PangJapanVers2"
	file "'g2f\PangStreet_G2F_Powrooz"
	file "'g2f\PangShrine_G2F_Powrooz_2Final"
	file "'g2f\PangLight_G2F_Powrooz"
	file "'g2f\PangCityVers2AA"
	file "'g2f\PangMansion_G2F_Powrooz"
	file "'g2f\PangWinter_G2F_Powrooz"
	file "'g2f\PangLions2011ooz"
;	file "'g2f\PangSzlam_G2F_Replay"
;	file "'g2f\PangCastle_G2F_Replay"

	?len = 80*40+480
	?col = 5*10

	file "'g2f-ground\groundDino"
	file "'g2f-ground\groundMaya"
	file "'g2f-ground\groundMeteo"

