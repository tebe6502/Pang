
rw0	= $80

	org $4000

addx
addy
posx
posy

BALL_COLLISION.chngX
BALL_COLLISION.chngY

	.link 'ckula0.obx'
	.link 'ckula1.obx'
	.link 'ckula2.obx'
	.link 'ckula3.obx'
	.link 'ckula4.obx'

	.print *,',',*-$4000
