
row	= 32*8
gfx1	= $a000

	opt h-
	org $4000

	create 'kula1_0.obx'

create	.macro
.def r0\ ?mem=gfx1		\.link :1
.def r1\ ?mem=gfx1+row		\.link :1
.def r2\ ?mem=gfx1+row*2	\.link :1
.def r3\ ?mem=gfx1+row*3	\.link :1
.def r4\ ?mem=gfx1+row*4	\.link :1
.def r5\ ?mem=gfx1+row*5	\.link :1
.def r6\ ?mem=gfx1+row*6	\.link :1
.def r7\ ?mem=gfx1+row*7	\.link :1
.def r8\ ?mem=gfx1+row*8	\.link :1
.def r9\ ?mem=gfx1+row*9	\.link :1
.def r10\ ?mem=gfx1+row*10	\.link :1
.def r11\ ?mem=gfx1+row*11	\.link :1
.def r12\ ?mem=gfx1+row*12	\.link :1
.def r13\ ?mem=gfx1+row*13	\.link :1
.def r14\ ?mem=gfx1+row*14	\.link :1
.def r15\ ?mem=gfx1+row*15	\.link :1
	.endm