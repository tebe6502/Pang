
; !!! UWAGA NA DYREKTYWE .PUT i .GET !!!
; !!! u¿ywane jest pierwszych 19 bajtów do zapamiêtania adresów zestawów znakowych !!!
; !!! zmiana tych adresów poprzez niew³aœciwe u¿ycie .GET lub .PUT doprowadzi od zwisu !!!

; !!! kod przerwania NMI nie mo¿e odwo³ywaæ siê do obszaru $4000..$7FFF, jedynym wyj¹tkiem jest player RMT !!!

; !!! program musi konczyc siê przed adresem TXTURE-40 !!!
; !!! procedury RamkaL, RamkaL korzystaj¹ z pamiêci od adresu TXTURE-40 !!!


* dla dwóch harpunów widoczne s¹ zbyt czêste spowolnienia gry, dlatego zdecydowa³em siê tylko na 1 harpun

// PANG (02.07.2007 - 15.12.2016) - chars mode

// 25-08-2019	usuniety blad gdy po TIME OUT nastepowal GAME OVER

* ---------------------------
* ---	CONSTANS
* ---------------------------

	icl 'atari.hea'
	icl 'pang.hea'

STEREOMODE	= 1		;0 => compile RMTplayer for mono 4 tracks

@proc_add_bank	= $2000
@tab_mem_banks	= $100

delay_trig_default_value	= $ff
delay_joy_default_value		= 1

delay_frame_player_animation	= 6

prg		= $3400

mobjects	= 32		; maksymalna liczba obs³ugiwanych obiektów

_left		= $0b
_left_up	= $0a
_left_down	= $09
_right		= $07
_right_up	= $06
_right_down	= $05
_down		= $0d
_up		= $0e

colpm0Hero	= $02		; kolory bohatera (tekstury nie powinny korzystaæ z tych kolorów)
colpm1Hero	= $78		;
colpm2Hero	= $18		;

colm3Harpun	= colpm2Hero&$0f	; kolor harpunu uzale¿niony od koloru COLPM2

mFrame		= 2		; minimalna liczba ramek opóŸnienia

	k0h	= 39		; wysokosc kuli #0 (najwiekszej)
	k1h	= 31		; wysokosc kuli #1
	k2h	= 23		; wysokosc kuli #2
	k3h	= 15		; wysokosc kuli #3
	k4h	= 7		; wysokosc kuli #4 (najmniejszej)

score_cnt = 6			; liczba cyfr SCORE
score_all = score_cnt+3+2

score	= status+6
hiscore	= status+31
sstage	= status+15


level_bar	= panel+40+25

energy_bar	= panel+40+8
energy_len	= 12
level_len	= 9

energy_up	= $54
energy_dw	= $5d

energy_up_first	= $4d
energy_dw_first	= $56


* --------------------------------------------------------------------------------

?idx	= $350		; druga po³ówka znaków nie jest u¿ywana

clridx		= .get[0]<<8+?idx	; pierwsze 40 bajty dla BUFOR-a #1, drugie 40 bajty dla BUFOR-a #2
tminy		= .get[1]<<8+?idx	; pierwsze 40 bajty dla BUFOR-a #1, drugie 40 bajty dla BUFOR-a #2
tmaxy		= .get[2]<<8+?idx	; pierwsze 40 bajty dla BUFOR-a #1, drugie 40 bajty dla BUFOR-a #2

lfillb1		= .get[3]<<8+?idx
hfillb1		= .get[4]<<8+?idx

_lfillb1	= .get[5]<<8+?idx
_hfillb1	= .get[6]<<8+?idx

lfillb2		= .get[7]<<8+?idx
hfillb2		= .get[8]<<8+?idx

_lfillb2	= .get[9]<<8+?idx
_hfillb2	= .get[10]<<8+?idx

hadr1		= .get[11]<<8+?idx
hadr2		= .get[12]<<8+?idx

linv		= .get[13]<<8+?idx
hinv		= linv+32
ldrabin		= hinv+32
hdrabin		= ldrabin+32

ypath		= .get[14]<<8+?idx	; tablica z wartoœciami przyrostu pozycji pionowej Y kul

ypath_4		= .get[15]<<8+?idx	; tablica z wartoœciami przyrostu pozycji pionowej Y kuli #4

* --------------------------------------------------------------------------------

	org $0200

ScoreBoard

ttype	.ds mobjects	; aktualny typ kuli (0..4)
switch	.ds mobjects	; jesli wartoœæ <> 0 to pomijaj detekcjê, detekcja bêdzie mo¿liwa w nastêpnym przebiegu
posx	.ds mobjects	; pozycja pozioma kuli
addx	.ds mobjects	; wartoœæ zwiêkszaj¹ca pozycje poziom¹ X
posy	.ds mobjects	; pozycja pionowa kuli
addy	.ds mobjects	; wartoœæ zwiêkszaj¹ca pozycjê pionow¹ Y
maxy	.ds mobjects	; maksymalna pionowa pozycja kuli


	org inflate_data	; $2000

; Data for building trees

literalSymbolCodeLength		.ds	256
controlSymbolCodeLength		.ds	CONTROL_SYMBOLS

; Huffman trees

nBitCode_clearFrom
nBitCode_totalCount		.ds	2*TREE_SIZE
nBitCode_literalCount		.ds	TREE_SIZE
nBitCode_controlCount		.ds	2*TREE_SIZE
nBitCode_literalOffset		.ds	TREE_SIZE
nBitCode_controlOffset		.ds	2*TREE_SIZE

codeToLiteralSymbol		.ds	256
codeToControlSymbol		.ds	CONTROL_SYMBOLS


	org $d800

scr1	.ds $400
scr2	.ds $400


	org $00

rw0	.ds 2		; zmienne RW i CH dla bohatera na znakach z PMG
rw1	.ds 2
rw2	.ds 2
rw3	.ds 2
rw4	.ds 2
rw5	.ds 2
rw6	.ds 2
rw7	.ds 2
rw8	.ds 2
rw9	.ds 2
rw10	.ds 2
rw11	.ds 2
rw12	.ds 2
rw13	.ds 2
rw14	.ds 2
rw15	.ds 2
rw16	.ds 2
rw17	.ds 2
rw18	.ds 2
rw19	.ds 2
rw20	.ds 2
rw21	.ds 2
rw22	.ds 2
rw23	.ds 2
rw24	.ds 2
rw25	.ds 2
rw26	.ds 2
rw27	.ds 2
rw28	.ds 2
rw29	.ds 2
rw30	.ds 2
rw31	.ds 2


	org $00

ln0	.ds 2
ln1	.ds 2
ln2	.ds 2
ln3	.ds 2
ln4	.ds 2
ln5	.ds 2
ln6	.ds 2
ln7	.ds 2
ln8	.ds 2
ln9	.ds 2
ln10	.ds 2
ln11	.ds 2
ln12	.ds 2
ln13	.ds 2
ln14	.ds 2
ln15	.ds 2
ln16	.ds 2
ln17	.ds 2
ln18	.ds 2
ln19	.ds 2
ln20	.ds 2
ln21	.ds 2
ln22	.ds 2
ln23	.ds 2
ln24	.ds 2
ln25	.ds 2
ln26	.ds 2
ln27	.ds 2
ln28	.ds 2
ln29	.ds 2
ln30	.ds 2
ln31	.ds 2
ln32	.ds 2
ln33	.ds 2
ln34	.ds 2
ln35	.ds 2
ln36	.ds 2
ln37	.ds 2
ln38	.ds 2
ln39	.ds 2

bs0	.ds 2		; zmienne dla znaków spod BONUS-u (source)
bs1	.ds 2
bs2	.ds 2
bs3	.ds 2
bs4	.ds 2
bs5	.ds 2

bd0	.ds 2		; zmienne dla znaków BONUS-u (destination)
bd1	.ds 2
bd2	.ds 2
bd3	.ds 2
bd4	.ds 2
bd5	.ds 2

hr0	.ds 2

hlp	.ds 2
harpun	.ds 2
dlstl	.ds 2

clrHrp.min	.ds 1
clrHrp.max	.ds 1

bonus.x		.ds 1
bonus.y		.ds 1
bonus.tim	.ds 1	; licznik czasu pokazywania bonus-u
bonus.typ	.ds 1	; typ bonusu 1..6

height	.ds 1		; zmienne przechowuj¹ce parametry kul
idx	.ds 1
type	.ds 1

frame	.ds 1
explose	.ds 1		; znacznik eksplozji = indeks do tablic obiektów
hposx	.ds 1		; pozycja pozioma bohatera
hposy	.ds 1		; pozycja pionowa bohatera
yB1old	.ds 1
yB2old	.ds 1
objects	.ds 1		; aktualna liczba przetwarzanych obiektów (wartoœæ modyfikowana dynamicznie)
wallIDX	.ds 1
wallTMP .ds 1
wallHIT	.ds 1
ymin	.ds 1
ymax	.ds 1
pmgB	.ds 1
bufor	.ds 1
joyTMP	.ds 1

_posx	.ds 1		; zmienne u¿ywane podczas detekcji kolizji kul BALL_COLLISION
_posy	.ds 1
_addx	.ds 1
_addy	.ds 1
_newMAX	.ds 1

rA	.ds 1
rX	.ds 1
rY	.ds 1

ledder	.ds 1

lbcount	.ds 1		; level balls counter	(licznik kul PANIC MODE)
lblimit	.ds 1		; level balls limit	(limit kul PANIC MODE)

@harp	.struct
	x	.byte
	y	.byte
	y_old	.byte
	start	.byte
	startDIV8 .byte
	cnt	.byte
	hook	.byte
	.ends

harp0	@harp
;harp1	@harp

inflate_zp	.ds 10

rmt_zp	.ds 19

active	.ds mobjects	; znaczniki istnienia obiektu

	.print 'vzp_end: ',*


* --------------------------------------------------------------------------------

	icl 'mem_detect.asm'


; ---	BANK SENSITIVE

	opt b+

/***************************  BANK #1  ***************************/

	LMB #1

	.link 'frm_left.obx'	// !!! KONIECZNIE OD POCZ¥TKU STRONY PAMIÊCI !!!

intro_kulki	ins 'title_2/kulki.df7'

lvl0		ins 'panic.lev'

	.print 'BANK #1 (FRM_LEFT, INTRO_KULKI): $4000..',*,', free: ',$8000-*


/***************************  BANK #2  ***************************/

	NMB

	.link 'frm_right.obx'	// !!! KONIECZNIE OD POCZ¥TKU STRONY PAMIÊCI !!!

texture3	ins '_PC/texture/g2f/PangJapanVers2.df7'

	.print 'BANK #2 (FRM_RIGHT): $4000..',*,', free: ',$8000-*


/***************************  BANK #3  ***************************/

	NMB

	lhinv48

	.link 'harpuns.obx'	// !!! KONIECZNIE OD POCZ¥TKU STRONY PAMIÊCI !!!

	.align
	.link '_PC\asm-kule_HP\ckula2.obx'	; korzysta z LHINV48

	.align
	.link 'bonus.obx'	// !!! KONIECZNIE OD POCZ¥TKU STRONY PAMIÊCI !!!


	.print 'BANK #3 (HARPUNS, BONUS, CKULA 2): $4000..',*,', free: ',$8000-*


/***************************  BANK #4  ***************************/

	NMB

; modul RMT zostaje rozpakowany od adresu $4000

	org $5200

rmt_title	ins 'msx-5\pang tytulowa stripped.df7'
rmt_gover	ins 'msx-5\pang koniec gry - przegrana stripped.df7'
rmt_win		ins 'msx-5\pang gra wygrana stripped.df7'

rmt_game_1	ins 'msx-5\song0_strip.df7'
rmt_game_2	ins 'msx-5\song1_strip.df7'
rmt_game_3	ins 'msx-5\song2_strip.df7'
rmt_game_4	ins 'msx-5\song3_strip.df7'

jingle_1	ins 'msx-5\song4_strip.df7'
jingle_2	ins 'msx-5\song5_strip.df7'
jingle_3	ins 'msx-5\song6_strip_OK.df7'


	.align			; RMT PLAYER with SFX

.local	RMT2
rmt_PLAYER	= *+$400
GLOBAL_VOLUME	= $f0

play	asl ntsc		; =0 PAL, =4 NTSC
	bcc @+
	lda #%00000100
	sta ntsc
	rts
@	jmp RASTERMUSICTRACKER+3

ntsc	brk

	icl 'msx-5/feat.hea'

	icl 'rmtplayr.a65'

read_KeyJoy_playRMT_timer
	icl 'read_KeyJoy_playRMT.asm'
.endl

	.print 'BANK #4 (RMT MSX): $4000..',*,', free: ',$8000-*


/***************************  BANK #5  ***************************/

	NMB

intro_logo	ins 'title_2/logo_2.df7'

texture4	ins '_PC/texture/g2f/PangCaves_G2F_Powrooz.df7'
texture10	ins '_PC/texture/g2f/PangPark_Vers2.df7'
texture12	ins '_PC/texture/g2f/PangLions2011ooz.df7'

	.print 'BANK #5 (INTRO_LOGO, TEXTURES): $4000..',*,', free: ',$8000-*


/***************************  BANK #6  ***************************/

	NMB

texture5	ins '_PC/texture/g2f/PangStreet_G2F_Powrooz.df7'
texture6	ins '_PC/texture/g2f/PangShrine_G2F_Powrooz_2Final.df7'
texture7	ins '_PC/texture/g2f/PangCityVers2AA.df7'
texture9	ins '_PC/texture/g2f/PangMostVer3Clean.df7'
texture11	ins '_PC/texture/g2f/PangWinter_G2F_Powrooz.df7'

	.print 'BANK #6 (TEXTURES): $4000..',*,', free: ',$8000-*


/***************************  BANK #7  ***************************/

	NMB

	.link 'frm_updw.obx'	// !!! KONIECZNIE OD POCZ¥TKU STRONY PAMIÊCI !!!

texture1	ins '_PC/texture/g2f/PangLight_G2F_Powrooz.df7'
texture2	ins '_PC/texture/g2f/PangAtlas_G2F_Powrooz.df7'
texture8	ins '_PC/texture/g2f/PangMansion_G2F_Powrooz.df7'

mapa_fnt	ins 'tour_map\mapa_2_fnt.df7'

	.print 'BANK #7 (TEXTURES): $4000..',*,', free: ',$8000-*


/***************************  BANK #8  ***************************/

	NMB

	lhinv48

	.link '_PC\asm-kule_HP\ckula0.obx'	; korzysta z LHINV48

	.align
	.link '_PC\asm-kule_HP\ckula1.obx'

	.align
	.link '_PC\asm-kule_HP\ckula3.obx'

	.align
	.link '_PC\asm-kule_HP\ckula4.obx'

	.print 'BANK #8 (CKULA 0,1,3,4): $4000..',*,', free: ',$8000-*


/***************************  BANK #9  ***************************/

	NMB

ground_buf	.ds 3730

ground0		ins '_PC/texture/g2f-ground/groundDino.df7'
ground1		ins '_PC/texture/g2f-ground/groundMaya.df7'
ground2		ins '_PC/texture/g2f-ground/groundMeteo.df7'
ground3		ins '_PC/texture/g2f-ground/groundIce.df7'

over_fnt	ins 'game_over_winner\over_fnt.df7'

	.link 'init_2.obx'

	.print 'BANK #9 (GROUND): $4000..',*,', free: ',$8000-*


/**************************  BANK #10  ***************************/

	NMB

lvl_temp	.ds $300

lvla	ins 'levels\lvl_01_04.df7'
lvlb	ins 'levels\lvl_05_08.df7'
lvlc	ins 'levels\lvl_09_12.df7'

	.print 'BANK #10 (LEVELS): $4000..',*,', free: ',$8000-*

/**************************  BANK #11  ***************************/

	NMB

mapa	ins 'tour_map\mapa_2.df7'
over	ins 'game_over_winner\gameover.df7'
cong	ins 'game_over_winner\pangwinner.df7'

dmtx	ins 'datamatrix\example-atari.df7'

.local	hi_tour
	dta 0,0,3,9,4,0, d'tbe', 0,9
	dta 0,0,3,5,5,5, d'paj', 0,7
	dta 0,0,2,3,1,5, d'rck', 0,5
	dta 0,0,1,2,4,5, d'aur', 0,3
	dta 0,0,0,7,8,0, d'vdl', 0,1

_new	dta 0,0,0,0,0,0, d'   ', 0,0		; na podstawie pustego wpisu inicjalow zostanie ustalona pozycja na tablicy
.endl

.local	hi_panic
	dta 0,0,2,9,0,5, d'tbe', 0,5
	dta 0,0,1,8,8,5, d'rck', 0,4
	dta 0,0,1,7,1,0, d'vdl', 0,3
	dta 0,0,1,3,9,5, d'paj', 0,2
	dta 0,0,1,2,4,5, d'emi', 0,1

_new	dta 0,0,0,0,0,0, d'   ', 0,0		; na podstawie pustego wpisu inicjalow zostanie ustalona pozycja na tablicy
.endl


.local	UpdateScoreBoard

	ldx <hi_tour				; kopiujemy tablice wynikow
	ldy >hi_tour
	lda select
	beq skp

	ldx <hi_panic
	ldy >hi_panic

skp	stx hlp
	sty hlp+1

	ldy #score_all*6-1
	mva:rpl (hlp),y ScoreBoard,y-

	ldy #score_cnt-1			; dopisujemy nowy wynik
	mva:rpl score,y ScoreBoard+score_all*5,y-

	lda #" "
	:3 sta ScoreBoard+score_all*5+score_cnt+#

	lda select
	beq tour

	lda level_bar-40+6
	cmp #10
	scc
	lda #0
	sta ScoreBoard+score_all*5+score_cnt+3

	mva level_bar-40+7 ScoreBoard+score_all*5+score_cnt+4

	rts

tour	ldx level?
	inx

.nowarn	div #10
	tax

	lda div.ACC
	sta ScoreBoard+score_all*5+score_cnt+3
	stx ScoreBoard+score_all*5+score_cnt+4

	rts


reset	.local

	lda #0
	ldx #score_cnt-1				; zeruj SCORE
	sta:rpl score,x-

	ldx #score_cnt-1

	lda select
	beq tour

panic	mva:rpl hi_panic,x hiscore,x-			; uaktualnij hi-score
	rts

tour	mva:rpl hi_tour,x hiscore,x-
	rts

	.endl

.endl

	.print 'BANK #11 (LEVELS): $4000..',*,', free: ',$8000-*

/**************************  BANK #12  ***************************/

	NMB

	.link 'frm_death.obx'	// !!! KONIECZNIE OD POCZ¥TKU STRONY PAMIÊCI !!!

	.print 'BANK #12 (FRM_DEATH): $4000..',*,', free: ',$8000-*


/***************************  BANK #0  ***************************/

	LMB #0			; wymuszamy w³¹czenie pamiêci podstawowej $d301=$ff

	opt b-


	ert frmL<>frmR

* --------------------------------------------------------------------------------

	org prg

* ---------------------------
* ---	ANTIC PROGRAM
* ---------------------------

tmpINVERS .ds $400


	ert <*<>0

; adresy procedur kolizji dla kul

lckula	dta l(ck0.main, ck1.main, ck2.main, ck3.main, ck4.main)
hckula	dta h(ck0.main, ck1.main, ck2.main, ck3.main, ck4.main)
bckula	dta [=ck0.main], [=ck1.main], [=ck2.main], [=ck3.main], [=ck4.main]

lmul48	:20 dta l(#*48)
hmul48	:20 dta h(#*48)

;ply_hb1	:40 dta h(#*8+.get[12]<<8)
;ply_hb2	:40 dta h([64+#]*8+.get[12]<<8)

theight	dta k0h,k1h,k2h,k3h,k4h

tDY	dta >ypath, >ypath, >ypath, >ypath, >ypath_4

tmul4	:5 dta #*4

tmul5	:10 dta #*5

ljoy	.array [16] .byte = .lo(HERO.zeruj)
	[_left]		= .lo(HERO.lhero)
	[_left_up]	= .lo(HERO.lhero)
	[_left_down]	= .lo(HERO.lhero)

	[_right]	= .lo(HERO.rhero)
	[_right_up]	= .lo(HERO.rhero)
	[_right_down]	= .lo(HERO.rhero)

	[_up]		= .lo(HERO.uhero)
	[_down]		= .lo(HERO.dhero)
	.enda

Digits0	ins 'panel/liczniki2.scr',5*48,30
Digits1	ins 'panel/liczniki2.scr',6*48,30
Digits2	ins 'panel/liczniki2.scr',7*48,30

cellx8	:20 dta #*8
	:20 dta #*8

bcd	dta 0,10,20,30,40,50,60,70,80,90

stage_bar ins 'panel/liczniki2.scr',25,10

level?	dta 0

l_lvl	dta l(lvla, lvlb, lvlc)
h_lvl	dta h(lvla, lvlb, lvlc)

	:3 nop				; wyrównanie do pocz¹tku nowej strony pamiêci

	ert <*<>0,*

lh_lk	.word BALL.lk0, BALL.lk1, BALL.lk2, BALL.lk3, BALL.lk4
	.word BALL.lk0_, BALL.lk1_, BALL.lk2_, BALL.lk3_, BALL.lk4_

panel	.ds 40*3

tenergy	dta 0,4,8,16,32			; wartoœci o jakie wytracana jest wysokoœæ odbicia kul

mul60	dta 0,60,120,180

tmulHig	:5 dta #*scrhig

theightm1	.by -1 k0h,k1h,k2h,k3h,k4h
twidthm1	.by -1 20,16,12,8+1,4+1

yPosMAX		.by +19 0,16,48,64,86	; maksymalna pozycja pionowa kuli
// !!! ustalana na podstawie yPosMAX_tmp !!!

yPosMAX_tmp	.by +19 0,16,48,64,86	; maksymalna pozycja pionowa kuli

_yPosMAX	.by +0 128,112,80,64,44

energy0	ins 'panel/liczniki2.scr',11*48,14
energy1	ins 'panel/liczniki2.scr',12*48,14
energy2	ins 'panel/liczniki2.scr',13*48,14

time0	ins 'panel/liczniki2.scr',19*48,7
time1	ins 'panel/liczniki2.scr',20*48,7
time2	ins 'panel/liczniki2.scr',21*48,7

level0	ins 'panel/liczniki2.scr',15*48,14

;	:14 nop				; wyrównanie do pocz¹tku nowej strony pamiêci


	ert <*<>0,*

dlist1	dta $40,$70
	dta $42,a(panel),2,$82,$70|$80
	dta $44,a(umurek)

	dta $44+$80,a(scr1)
	:scrhig-2 dta $84
	dta 4

	dta $44+$80,a(umurek)
	dta $70,$43,a(status)
	dta $41,a(dlist1)


dlist2	dta $40,$70
	dta $42,a(panel),2,$82,$70|$80
	dta $44,a(umurek)

	dta $44+$80,a(scr2)
	:scrhig-2 dta $84
	dta 4

	dta $44+$80,a(umurek)
	dta $70,$43,a(status)
	dta $41,a(dlist2)

umurek	:3 dta pustak
	:42 dta okalajacy
	:3-1 dta pustak

status	ins 'panel\liczniki2.scr',10,40

ladr	:20 dta #&7
ladr_	:20 dta #&7+20*8

tmul8	:40 dta l(#*8)

	:5 nop				; wyrównanie do pocz¹tku nowej strony pamiêci

	ert <*<>0,*

	.pages

lhkula	.word k0._0, k0._1, k0._2, k0._3
	.word k1._0, k1._1, k1._2, k1._3
	.word k2._0, k2._1, k2._2, k2._3
	.word k3._0, k3._1, k3._2, k3._3
	.word k4._0, k4._1, k4._2, k4._3

lminmax dta l(MINMAX5, MINMAX6, MINMAX6, MINMAX6)
	dta l(MINMAX4, MINMAX5, MINMAX5, MINMAX5)
	dta l(MINMAX3, MINMAX4, MINMAX4, MINMAX4)
	dta l(MINMAX3, MINMAX3, MINMAX3, MINMAX3)	; wyjatek, o 1 pixel szersza kula
	dta l(MINMAX1, MINMAX2, MINMAX2, MINMAX2)

	dta l(MINMAX5, MINMAX6, MINMAX6, MINMAX6)
	dta l(MINMAX4, MINMAX5, MINMAX5, MINMAX5)
	dta l(MINMAX3, MINMAX4, MINMAX4, MINMAX4)
	dta l(MINMAX3, MINMAX3, MINMAX3, MINMAX3)	; wyjatek, o 1 pixel szersza kula
	dta l(MINMAX1, MINMAX2, MINMAX2, MINMAX2)

ltxt	:10 dta l(txture+18*320-#*320)
htxt	:10 dta h(txture+18*320-#*320)

tgrnd_b	dta [=ground3], [=ground2], [=ground1], [=ground0]
tgrnd_l	dta <ground3, <ground2, <ground1, <ground0
tgrnd_h	dta >ground3, >ground2, >ground1, >ground0

	.endpg


* ---------------------------
* ---	MAIN PROGRAM
* ---------------------------

main
	ldx #15			; inicjujemy tablice @TAB_MEM_BANKS
ibnk	lda @TAB_MEM_BANKS,x
	and #$fe
	sta @TAB_MEM_BANKS,x
	dex
	bpl ibnk


	INIT_VECTORS

//**********************************************************************

again	jsr INTRO

	jsr MAPTOUR

	sta INTRO.nxtLvl

	jsr INTRO.start

//**********************************************************************

lets_go
	
	lda #0
nmsx	equ *-1
	and #3
	add #msxCode.game0
	tay

	inc nmsx

	RMT_MODUL @

	mwa #dlist1 dlstl	; koniecznie nalezy zaincjowac (DLSTL=$230)

	mva #$fe portb
	sta NMI.playmusic

	mva #$c0 $d40e


// LET'S GO

LOOP	.local

	ADD_PANIC_BALL

* ---	BUF #1
	WAIT <dlist1 >pmgB1	; wyswietlamy BUFOR #1, modyfikujemy BUFOR #2

	CLEARB2

 	mva #2 bufor

	ENGINE #BALL.BALLB2
	COLLISIONS
	CLRHARP	#40^40
wall0	jsr CLRWALL

	HERO	#40

	PLAYERB2	;<ply_hb2 #40

	GO_BONUS

	ldx objects		; liczba obiektów mo¿e byæ krótsza
	lda active-1,x
	bmi skp
	dex

	beq gamEnd2
	stx objects
skp

* ---	BUF #2
	WAIT <dlist2 >pmgB2	; wyswietlamy BUFOR #2, modyfikujemy BUFOR #1

	CLEARB1

	mva #0 bufor

	ENGINE #BALL.BALLB1
	COLLISIONS
	CLRHARP	#0^40
wall1	jsr CLRWALL

	HERO	#0

	PLAYERB1	;<ply_hb1 #0

	ldx objects		; liczba obiektów mo¿e byæ krótsza
	lda active-1,x
	bmi sLOOP
	dex

	beq gamEnd0
	stx objects

sLOOP	jmp LOOP
napisy	equ *-2


* ---	GAME END

gamEnd2	CLRMISSILE
	jsr JingleDeath.prepare

	jmp GameEnd.gamEnd2

gamEnd0	CLRMISSILE
	jsr JingleDeath.prepare

	jmp GameEnd.gamEnd0

	.endl

level1	ins 'panel/liczniki2.scr',16*48,14
level2	ins 'panel/liczniki2.scr',17*48,14

;	:2 nop


	ert *>$3fff,*		; !!! ten warunek musi zostaæ koniecznie spe³niony !!!


* ---------------------------
* ---	BALL
* ---------------------------
.proc	BALL

	ldy type

	tya
	asl @
	tay

	lda posx,x
	cmp #80
	bcc ok

cell2	tya
	adc #10-1
	tay

;	mva l_lk__,y _setLK	; prawa strona ekranu
;	mva h_lk__,y _setLK+1

ok	sty _setLK+1

	lda posy,x
	tay
	and #7
	tax

	tya		; nasza aktualna minimalna pozycja pionowa YMIN, regY = POSY
	sta ymin
	add height
	sta ymax	; nasza aktualna maksymalna pozycja pionowa YMAX

_setLK	jmp (lh_lk)


lsetb1	dta l(BALLB1.set, BALLB1.set+40, BALLB1.set+80, BALLB1.set+120, BALLB1.set+160)
;hsetb1	dta h(BALLB1.set,BALLB1.set+40,BALLB1.set+80,BALLB1.set+120,BALLB1.set+160)

lsetb2	dta l(BALLB2.set, BALLB2.set+40, BALLB2.set+80, BALLB2.set+120, BALLB2.set+160)
;hsetb2	dta h(BALLB2.set,BALLB2.set+40,BALLB2.set+80,BALLB2.set+120,BALLB2.set+160)

/*
l_lk	dta l(lk0, lk1, lk2, lk3, lk4)
h_lk	dta h(lk0, lk1, lk2, lk3, lk4)

l_lk__	dta l(lk0_, lk1_, lk2_, lk3_, lk4_)
h_lk__	dta h(lk0_, lk1_, lk2_, lk3_, lk4_)
*/

lk4	:8 mva ladr+#,x ln0+#*2
	jmp bjmpGo

lk0	.rept 8
	lda ladr+#,x
	sta ln0+#*2
	sta ln8+#*2
	sta ln16+#*2
	sta ln24+#*2
	sta ln32+#*2
	.endr

bjmpGo	ldx type

	jmp BALLB1
bjmp	equ *-2


MINMAX	ldy ymax		; tutaj wracamy po wykonaniu procedur BALLB1 i BALLB2
	jmp MINMAX6
_minmax	equ *-2


* ------------------ *
* ---	BALLB1	 --- *
* ------------------ *
BALLB1	.local

;	ldy posy

;	ldx type
	mva	lsetb1,x	_set
;	mva	hsetb1,x	_set+1

	jmp set
_set	equ *-2

	.pages

set	:40 mva hadr1+39-#,y ln0+39*2-#*2+1

	.endpg

	ldy idx

;	ldx type
	lda posx,y
	and #3
	add tmul4,x	; type*4 + (posx and 3)
	tax		; obliczyliœmy indeks do adresu programu tworz¹cego kule

	asl @
	sta _kul+1

;	mva	lkula,x	_kul
;	mva	hkula,x	_kul+1

	mva	lminmax,x	_minmax

	lda posx,y
	:2 lsr @
	tax		; TMINX+0, TMAXY+0

	ldy cellx8,x

	clc
_kul	jmp (lhkula)

	.endl


* ------------------ *
* ---	BALLB2	 --- *
* ------------------ *
BALLB2	.local

;	ldy posy

;	ldx type
	mva	lsetb2,x	_set
;	mva	hsetb2,x	_set+1

	jmp set
_set	equ *-2

	.pages

set	:40 mva hadr2+39-#,y ln0+39*2-#*2+1

	.endpg

	ldy idx

;	ldx type
	lda posx,y
	and #3
	add tmul4,x	; type*4 + (posx and 3)
	tax		; obliczyliœmy indeks do adresu programu tworz¹cego kule

	asl @
	sta _kul+1

;	mva	lkula,x	_kul
;	mva	hkula,x	_kul+1

	mva	lminmax,x	_minmax

	lda posx,y
	:2 lsr @
	tax		; TMINX+40, TMAXY+40

	ldy cellx8,x

	txa
	add #40
	tax

;	clc
_kul	jmp (lhkula)

	.endl


lk3	.rept 8
	lda ladr+#,x
	sta ln0+#*2
	sta ln8+#*2
	.endr
	jmp bjmpGo

lk2	.rept 8
	lda ladr+#,x
	sta ln0+#*2
	sta ln8+#*2
	sta ln16+#*2
	.endr
	jmp bjmpGo

lk1	.rept 8
	lda ladr+#,x
	sta ln0+#*2
	sta ln8+#*2
	sta ln16+#*2
	sta ln24+#*2
	.endr
	jmp bjmpGo

lk4_	:8 mva ladr_+#,x ln0+#*2
	jmp bjmpGo

lk3_	.rept 8
	lda ladr_+#,x
	sta ln0+#*2
	sta ln8+#*2
	.endr
	jmp bjmpGo

lk2_	.rept 8
	lda ladr_+#,x
	sta ln0+#*2
	sta ln8+#*2
	sta ln16+#*2
	.endr
	jmp bjmpGo

lk1_	.rept 8
	lda ladr_+#,x
	sta ln0+#*2
	sta ln8+#*2
	sta ln16+#*2
	sta ln24+#*2
	.endr
	jmp bjmpGo

lk0_	.rept 8
	lda ladr_+#,x
	sta ln0+#*2
	sta ln8+#*2
	sta ln16+#*2
	sta ln24+#*2
	sta ln32+#*2
	.endr
	jmp bjmpGo

.endp


;	icl '_PC\asm-kule_2\kula0.asm'		; procedury tworzenia kul
;	icl '_PC\asm-kule_2\kula1.asm'
	icl '_PC\asm-kule_2\kula2.asm'
	icl '_PC\asm-kule_2\kula3.asm'
	icl '_PC\asm-kule_2\kula4.asm'


* ---------------------------
* ---	CLEARB1
* ---------------------------
.proc	CLEARB1

	ldx #5+2

	.pages

_clr	ldy clridx+32,x
	beq _next

	ldy	tminy+32,x
	mva	_lfillb1,y	fjsr
	mva	_hfillb1,y	fjsr+1

	ldy	tmaxy+32,x
	mva	_lfillb1+1,y	hlp
	mva	_hfillb1+1,y	hlp+1

	ldy #0
	lda #{rts}
	sta (hlp),y

	ldy tmul8,x

	jsr $ffff
fjsr	equ *-2

	ldy #0
	mva	#{lda $ffff,x}	(hlp),y
	mva	#{rts}		_fillqb1

	tya
	sta clridx+32,x
	sta tmaxy+32,x

	mva	#scrhig*8-1	tminy+32,x

_next	dex
	bpl _clr


	ldx #31

clr	ldy clridx,x
	beq next

	ldy	tminy,x
	mva	lfillb1,y	_jsr
	mva	hfillb1,y	_jsr+1

	ldy	tmaxy,x
	mva	lfillb1+1,y	hlp
	mva	hfillb1+1,y	hlp+1

	ldy #0
	lda #{rts}
	sta (hlp),y

	ldy tmul8,x

	jsr $ffff
_jsr	equ *-2

	ldy #0
	mva	#{lda $ffff,x}	(hlp),y
	mva	#{rts}		fillqb1

	tya
	sta clridx,x
	sta tmaxy,x

	mva	#scrhig*8-1	tminy,x

next	dex
	bpl clr

	.endpg

	mva #scr40	NMI._dmactl

	jmp CLRHARP.clrPMB2


fillb1	:scrhig*8 mva txture+#*40,x .get[#>>3]<<8+#&7,y
fillqb1	rts

_fillb1	:scrhig*8 mva txture+#*40+32,x .get[#>>3]<<8+#&7+256,y
_fillqb1 rts

.endp


* ---------------------------
* ---	CLEARB2
* ---------------------------
.proc	CLEARB2

	ldx #5+2

	.pages

_clr	ldy clridx+40+32,x
	beq _next

	ldy	tminy+40+32,x
	mva	_lfillb2,y	fjsr
	mva	_hfillb2,y	fjsr+1

	ldy	tmaxy+40+32,x
	mva	_lfillb2+1,y	hlp
	mva	_hfillb2+1,y	hlp+1

	ldy #0
	lda #{rts}
	sta (hlp),y

	ldy tmul8,x

	jsr $ffff
fjsr	equ *-2

	ldy #0
	mva	#{lda $ffff,x}	(hlp),y
	mva	#{rts}		_fillqb2

	tya
	sta clridx+40+32,x
	sta tmaxy+40+32,x

	mva	#scrhig*8-1	tminy+40+32,x

_next	dex
	bpl _clr


	ldx #31

clr	ldy clridx+40,x
	beq next

	ldy	tminy+40,x
	mva	lfillb2,y	_jsr
	mva	hfillb2,y	_jsr+1

	ldy	tmaxy+40,x
	mva	lfillb2+1,y	hlp
	mva	hfillb2+1,y	hlp+1

	ldy #0
	lda #{rts}
	sta (hlp),y

	ldy tmul8,x

	jsr $ffff
_jsr	equ *-2

	ldy #0
	mva	#{lda $ffff,x}	(hlp),y
	mva	#{rts}		fillqb2

	tya
	sta clridx+40,x
	sta tmaxy+40,x

	mva	#scrhig*8-1	tminy+40,x

next	dex
	bpl clr

	.endpg

	jmp CLRHARP.clrPMB1


fillb2	:scrhig*8 mva txture+#*40,x .get[#>>3]<<8+#&7+512,y
fillqb2	rts

_fillb2	:scrhig*8 mva txture+32+#*40,x .get[#>>3]<<8+#&7+512+256,y
_fillqb2 rts

.endp


	icl '_PC\asm-kule_2\kula0.asm'
	icl '_PC\asm-kule_2\kula1.asm'

	icl 'collisions.asm'

* ---------------------------
* ---	INIT
* ---------------------------
.proc	INIT

	mwa #LOOP LOOP.napisy	; wy³¹czenie napisów PAUSE i TIME OUT

	jsr CLRHARP.setPMClear	; wywo³aæ przed zerowaniem strony zerowej

	CLRPAGES >$000 #1 #0	; koniecznie zerujemy ca³¹ stronê zerow¹

.nowarn	CLRPAGES >$200 #1	; strone 2 te¿ czyœcimy (regA = 0)

	mva #48+4+72	hposx	; inicjalizacja pozycji poziomej i pionowej
	mva #scrhig*8-32 hposy	; bohatera wymagana dla PANIC MODE

	sta yB1old
	sta yB2old

;	mva #$ff	HERO.blkh1	; harpun #1 zablokowany

	jsr SetDLI.init

	mva #{bit}	dliDeath

	mva #=frmR	PLAYER.direct

	mva #$00	HERO.blkh0		; harpun #0 odblokowany

	sta NMI._dmactl

	sta NMI.old_joy
	sta NMI.starsExplosion			; animacja gwiazdek zablokowana
	sta NMI.vbltim				; uruchamiamy zegar
	sta NMI.second
	sta NMI.timer+1
	sta NMI.timer+2

	sta CLRHARP.clrPMB1+1
	sta CLRHARP.clrPMB2+1

	sta ledder

	sta hr0

	sta bonus.x

	sta COLLISIONS.tnt+1			; wy³¹czenie TNT

	sta BALL_COLLISION.stop+1		; wy³¹czenie blokady ruchu kul
	sta BALL_COLLISION_PANIC.stop+1

	sta PLAYERB1.blink			; wy³¹czamy mruganie

	sta clrWALL.skip+1			; umo¿liwienie testu rozbijanego murku


;	mva #1 harp0.hook

	lda #100
	sta stars.dataStar[0].py		; inicjujemy poprzednia pozycje Y gwiazdek
	sta stars.dataStar[1].py
	sta stars.dataStar[2].py
	sta stars.dataStar[3].py

	sta HERO.r_d010				; FIRE nie zosta³ naciœniêty

	mva #$ff explose			; wartosc =$ff wylacza animacje eksplozji kuli

	sta COLLISIONS.DETECT.old_bonus		; reset OLD_BONUS, ka¿da wartoœæ > 6

	mva #delay_joy_default_value	NMI.delay_joy
	mva #delay_trig_default_value	NMI.delay_trig

;	mva	#defaultPrior	gtia+1
	mva	#colm3Harpun	__colpm3	; przywracamy kolor harpunu

	mva	<stars.frm1	stars.anm+1

	mva #colpm0Hero	chero0+1			; przywracamy kolory bohatera
	mva #colpm1Hero	chero1+1
	mva #colpm2Hero	chero2+1

	mva #{lda posy,x}	COLLISIONS.DETECT.HERO
	mwa #posy		COLLISIONS.DETECT.HERO+1

// liczba ¿yæ na znakach

	lda #0				;lives
lives	equ *-1
	bne lskp

	jsr ResetScore

	mva #3 lives			; pocz¹tkowa liczba zyc

lskp
;		mva #$f2 $00	; dla testow


// czyœcimy pamiêæ $D800..$DFFF, PMG+$0300..$07FF

	CLRPAGES	>scr1		#4 #pustak
	CLRPAGES	>scr2		#4 #pustak

	CLRPAGES	>pmgB1+$300	#5 #0	; regA = 0
.nowarn	CLRPAGES	>pmgB2+$300	#5	; regA = 0

.nowarn	CLRPAGES	>killWall	#1	; regA = 0

.nowarn	CLRPAGES	>clrWallIDX	#1	; regA = 0

.nowarn	CLRPAGES	>drabin		#4	; regA = 0


	ldx #mobjects-1
fact	txa
	add #1
	sta active,x
	dex
	bpl fact


	jsr COLLISIONS.DETECT.ENERGY.init

	:6 mva <(bonus0+#)*8 bd0+#*2	; sta³e wartoœci m³odszych bajtów adresu (BD)

	jsr init2


// inicjujemy tablice LINV, HINV, LDRABIN, HDRABIN

	mwa #invers+4 ln0
	mwa #drabin+4 ln1

	ldx #0
iinv	mva	ln0	linv,x
	mva	ln0+1	hinv,x

	mva	ln1	ldrabin,x
	mva	ln1+1	hdrabin,x

	adw ln0 #scrwid
	adw ln1 #scrwid

	inx
	cpx #32
	bne iinv


// inicjujemy tablice CLRIDX, TMINY, TMAXY

	ldx #79
f0	mva	#$ff		clridx,x
	mva	#$00		tminy,x
	mva	#scrhig*8-1	tmaxy,x
	dex
	bpl f0


// inicjujemy tablice YPATH

	ldy #0
	sty oldpthy

ipth	ldx _ypath,y

	txa
	sub #0
oldpthy	equ *-1

	stx oldpthy

ilp	sta ypath,x		; przyrost pozycji Y dla najmniejszych kul (#4)
	pha
	cmp #7
	scc
	lda #7-1

	sta ypath_4,x		; przyrost pozycji Y kuli #4
	pla
	inx
	cpx #scrhig*8
	bne ilp

	iny
	cpy #.len(_ypath)
	bne ipth

	mva ypath+1 ypath
	mva ypath_4+1 ypath_4


// inicjujemy tablice HADR1, HADR2

	ldy #0
fntlp	tya
	:3 lsr @
	tax

tf	lda tfonts,x

	sta hadr1,y
	add #2
	sta hadr2,y

	iny
	cpy #scrhig*8
	bne fntlp


// inicjujemy tablice LFILLB1, HFILLB1, _LFILLB1, _HFILLB1, LFILLB2, HFILLB2, _LFILLB2, _HFILLB2

	mwa #CLEARB1.FILLB1	ln0
	mwa #CLEARB1._FILLB1	ln1

	mwa #CLEARB2.FILLB2	ln2
	mwa #CLEARB2._FILLB2	ln3

	ldy #0
lplh	mva	ln0	lfillb1,y
	mva	ln0+1	hfillb1,y

	mva	ln1	_lfillb1,y
	mva	ln1+1	_hfillb1,y

	mva	ln2	lfillb2,y
	mva	ln2+1	hfillb2,y

	mva	ln3	_lfillb2,y
	mva	ln3+1	_hfillb2,y

	adw ln0 #6
	adw ln1 #6
	adw ln2 #6
	adw ln3 #6

	iny
	cpy #scrhig*8+1
	bne lplh


	PLAYFIELD		; tworzymy pole gry


// rozpoznajemy tryb rozgrywki

	ldx #40*3-1
	lda #spacja
	sta:rpl panel,x-

	ldx #13
ebar	mva energy0,x energy_bar-40-1,x
	mva energy1,x energy_bar-1,x
	mva energy2,x energy_bar+40-1,x
	dex
	bpl ebar


	lda lives
	ldy #1
	jsr Digit

	lda select
	jeq arcade

/*	---------------------
	 P A N I C   M O D E
	---------------------
*/

panic
	ldx #13
lbar	mva level0,x level_bar-40-1,x
	mva level1,x level_bar-1,x
	mva level2,x level_bar+40-1,x
	dex
	bpl lbar

	ldx #1
level_panic equ *-1

.nowarn	div #10
	tax

	ldy #0

	lda div.ACC
	beq s0

	sta level_bar-40+7,y
	iny
s0
	txa
	sta level_bar-40+7,y


	lda #spacja
	ldy #9
	sta:rpl sstage,y-

	mva #0 COLLISIONS.DETECT.hitBall.level

	lda #0
ground	equ *-1

.nowarn	GROUND_MOVEUP		; przesuniecie pod³ogi do góry (max #9)

	lda #16			; 16 = najwieksza kula
	sta lbcount

	lda #40
	sub lbcount
	sta lblimit

	mva #deathCode.panic_stop GameEnd.reason

	mva #127 ADD_PANIC_BALL.delay

	sta INTRO.nxtLvl
	

	lda #{bit*}
	sta LOOP.wall0
	sta LOOP.wall1
;	sta LOOP.wall2
;	sta LOOP.wall3

	mwa #BALL_COLLISION_PANIC	ENGINE.mode+1
	
	lda INIT.level_panic		; stopien trudnosci dla PANIC
	asl @
	add <COLLISIONS.typ_bonus_panic
	sta COLLISIONS.DETECT.mode+1
	lda #0
	adc >COLLISIONS.typ_bonus_panic
	sta COLLISIONS.DETECT.mode+2

	mva #{jsr*} COLLISIONS.DETECT.panic
	
	GET_LEVEL	; #0

	jmp skip


/*	---------------------
	 T O U R     M O D E
	---------------------
*/

arcade

// inicjowanie obiektów, w obszarze INVERS zapiszemy informacje o grupach obiektów

; t[0]:=objList[i].g;
; t[1]:=objList[i].o;

; t[0]:=objList[i].x;
; t[1]:=objList[i].y;
; t[2]:=objList[i].p;

	lda #0			; time 000
	ldy #31
	jsr Digit

	lda #0
	ldy #34
	jsr Digit

	lda #0
	ldy #37
	jsr Digit

	ldx #6
tbar	mva time0,x energy_bar-40-1+16,x
	mva time1,x energy_bar-1+16,x
	mva time2,x energy_bar+40-1+16,x
	dex
	bpl tbar

	GROUND_MOVEUP #0	; przesuniecie pod³ogi do góry (max #9)

	lda #{jsr*}
	sta LOOP.wall0
	sta LOOP.wall1
;	sta LOOP.wall2
;	sta LOOP.wall3

	mwa #BALL_COLLISION	ENGINE.mode+1

	mwa #COLLISIONS.typ_bonus	COLLISIONS.DETECT.mode+1

	mva #{bit*} COLLISIONS.DETECT.panic

;	ldx level?

.nowarn	GET_LEVEL

;	@prawy_nawias #4

/*	zdekodowanie levelu	*/

skip	mwa #inflate_data hlp

	ldx #0

	jmp cpLVL

kula_	inw hlp

kula	ldy #0
	lda (hlp),y
	bmi next

	sta ttype,x

	lda active,x
	ora #$80
	sta active,x

	mva #$01 addy,x

	ldy #3		; parametr kuli, czyli kierunek ruchu w poziomie
	lda (hlp),y
	sta addx,x

	ldy #1		; pozycja poziomia kuli
	lda (hlp),y
	:2 asl @
	sta posx,x

	iny		; pozycja pionowa kuli
	lda (hlp),y
	:3 asl @
	sta posy,x

	inx

	adw hlp #4
	jmp kula


next	inw hlp

cpLVL	ldy #0
	lda (hlp),y
	beq kula_

	cmp #$ff
	jeq CPlvlQ

	inw hlp

	sta group

others	ldy #0		; obiekt inny ni¿ kula (5..)
	lda (hlp),y
	sta testObj

oskp3	cmp #6
	bne oskp0

	lda #murek1
	bne oskp2

oskp0	cmp #7
	bne oskp1

	lda #murek2
	bne oskp2

oskp1	add #murek0-5
oskp2	sta char

	inw hlp

othLOOP	ldy #0
	lda (hlp),y
	bmi next

	iny		; Y
	lda (hlp),y
	tay

	mva lmul48,y ln39
	mva hmul48,y ln39+1

	lda #0
testObj	equ *-1
	cmp #8			; kod obiektu odpowiadaj¹cy DRABINCE
	beq drabinka
	bcc skp

	add #murL0-9
	sta char

skp	adw ln39 #scr1 ln0
	adw ln39 #scr2 ln1
	adw ln39 #invers ln2

	ldy #0		; X
	lda (hlp),y
	add #4
	tay

	lda testObj
	cmp #25
	bcc skpChar

	add #120-25
	sta group

	cmp #124	; OBJECT 29
	beq invOK
	lda #0
	dta {bit*}
invOK	lda #$80

	sta cinv

	lda (ln0),y
	and #$7f
	ora #0
cinv	equ *-1
;	sta (ln0),y
;	sta (ln1),y

	jmp cskp

skpChar	lda #0
char	equ *-1
cskp	sta (ln0),y
	sta (ln1),y

	lda #0
group	equ *-1
	sta (ln2),y
continue
	adw hlp #2
	jmp othLOOP

drabinka
	stx oldX

	mva lmul40,y	ln0
	mva hmul40,y	ln0+1

	adw ln39 #drabin ln1

	ldy #0		; X
	lda (hlp),y

	add ln0
	sta ln0
	scc
	inc ln0+1

; obliczymy adresy 3-ech kolejnych znaków

	mwa #inflate_data+$2e8	chr0+1		// !!! w INFLATE_DATA znajduje siê tak¿e aktualny level !!!
	mwa #inflate_data+$2f0	chr1+1		// !!! dane levelu nie mog¹ byæ d³u¿sze ni¿ $2e8 bajtów !!!
	mwa #inflate_data+$2f8	chr2+1

	mwa ln0 ln2

	ldx #0
cpChr	ldy #0
	mva (ln2),y	inflate_data+$2e8,x
	iny
	mva (ln2),y	inflate_data+$2f0,x
	iny
	mva (ln2),y	inflate_data+$2f8,x

	adw ln2 #40
	inx
	cpx #8
	bne cpChr

	adw ln39 #scr1 ln2

	ldy #0
	lda (hlp),y	; X

	add ln2
	sta ln2
	scc
	inc ln2+1

	adw ln39 #invers+4 ln8

	sta ledSkip

	lda (hlp),y
	tay
	lda (ln8),y
	bmi skp2		; jeœli murek miêkki to drabinka pod nim

	mva #0 ledSkip

	ldy #4
	lda (ln2),y
	and #$7f
	cmp #pustak
	bcc skp0
	jsr charAdr
	stx chr0+1
	sta chr0+2

skp0	ldy #5
	lda (ln2),y
	and #$7f
	cmp #pustak
	bcc skp1
	jsr charAdr
	stx chr1+1
	sta chr1+2

skp1	ldy #6
	lda (ln2),y
	and #$7f
	cmp #pustak
	bcc skp2
	jsr charAdr
	stx chr2+1
	sta chr2+2

skp2	ldx #0

dlp	ldy #0
chr0	lda $ffff,x
	and mdrabin,x
	ora ddrabin,x
	sta (ln0),y

	iny
chr1	lda $ffff,x
	and mdrabin+8,x
	ora ddrabin+8,x
	sta (ln0),y

	iny
chr2	lda $ffff,x
	and mdrabin+16,x
	ora ddrabin+16,x
	sta (ln0),y

	adw ln0 #40

	inx
	cpx #8
	bne dlp


	ldy #0		; X
	lda (hlp),y
	add #4
	tay

	lda group
	sta (ln1),y
	iny
	sta (ln1),y
	iny
	sta (ln1),y

	lda #0
ledSkip	equ *-1
	bne _skLD

	adw ln39 #scr1 ln8		; wstawienie znaków reprezentujacych drabinke
	adw ln39 #scr2 ln9

	ldy #0		; X
	lda (hlp),y
	sta putChar.px
	add #4
	tay

	:3 jsr putChar
_skLD
	ldx #0
oldX	equ *-1

	jmp continue


.local	putChar

	ldx #0
	lda (ln8),y
	spl
	ldx #$80

	stx inv

	lda px
	ora #0
inv	equ *-1
	sta (ln8),y
	add #64
	sta (ln9),y

	inc px
	iny
	rts

px	brk
.endl

*---
CPlvlQ
	stx objects		; aktualna liczba obiektów

	lda select
	jne lvlCol		; dla PANIC MODE pozosta³e parametry nie istotne

	lda #0
	ldx #15
clrbon	sta COLLISIONS.typ_bonus,x
	sta COLLISIONS.cnt_bonus,x
	dex
	bpl clrbon

	iny
	lda (hlp),y
	eor #$ff

	spl
	mvx #bonusCode.heart	COLLISIONS.typ_bonus+1

	asl @
	spl
	mvx #bonusCode.shield	COLLISIONS.typ_bonus+6

	asl @
	spl
	mvx #bonusCode.clock	COLLISIONS.typ_bonus+4

	asl @
	spl
	mvx #bonusCode.harpun_h	COLLISIONS.typ_bonus+14

	asl @
	spl
	mvx #bonusCode.harpun	COLLISIONS.typ_bonus+11

	asl @
	spl
	mvx #bonusCode.tnt	COLLISIONS.typ_bonus+9

	iny
	lda (hlp),y
	:2 asl @
	add #48	;+4
	sta hposx		; pozycja pozioma bohatera

	iny
	lda #scrhig
	sub (hlp),y
	:3 asl @
	sta _sb+1

	lda #scrhig*8
	sec
_sb	sbc #0
	sta hposy		; pozycja pionowa bohatera

	sta yB1old
	sta yB2old

	iny
	lda (hlp),y		; limit czasu
	pha
	and #3
	tax			; minuty
	lda mul60,x
	sta tim

	pla			; sekundy
	:2 lsr @
	add #0
tim	equ *-1

	sty tY

	ldy #$ff		; digit
	ldx #10
	sec
@	iny
	sbc #100
	bcs @-
@	dex
	adc #10
	bmi @-

	sty NMI.timer
	stx NMI.timer+1
	sta NMI.timer+2

	ldy #0
tY	equ *-1

	iny
	lda (hlp),y

	sta OverlayHeight

	beq lvlCol		; brak Overlaya

	and #$0f
	tax

	sta OverlayHeight

	iny
	lda (hlp),y
	sta OvrCol0+1
	iny
	lda (hlp),y
	sta OvrCol1+1
	iny
	lda (hlp),y
	sta OvrCol2+1

	iny
	lda (hlp),y
	sta OvrPly0+1
	iny
	lda (hlp),y
	sta OvrPly1+1
	iny
	lda (hlp),y
	sta OvrPly2+1

	iny
	lda (hlp),y
	sta OvrMis0+1
	iny
	lda (hlp),y
	sta OvrMis1+1
	iny
	lda (hlp),y
	sta OvrMis2+1

	lda >pmgB1+pmHero0
	jsr fillOverlay
	lda >pmgB1+pmHero1
	jsr fillOverlay
	lda >pmgB1+pmHero2
	jsr fillOverlay
	lda >pmgB1+$300
	jsr fillOverlay

	iny
	lda (hlp),y		; zmiany kolorów podestów

	sta OverlayChange

	beq lvlCol

	iny

	ldx #0
mOvr	lda (hlp),y
	sta ovrColors,x
	iny
	inx
	cpx #14*3
	bne mOvr

	stx OverlayChange

// inicjowanie kolorów
lvlCol
	ldx #scrhig-1		; zapisujemy wartoœci domyœlne dla przerwañ DLI0..DLI15 (st? $d01e)

iniDLI	mva lDli,x hlp
	mva hDli,x hlp+1

	lda <$d01e
	ldy #@sdli._stx+1
	sta (hlp),y
;	ldy #@sdli._sta2+1
;	sta (hlp),y

	dex
	bpl iniDLI


	ldy #@sdli._ldx+1
	mva colors dli0,y
	sta oldCol

	ldy #@sdli._stx+1
	mva <colbak dli0,y

	mva colors+1 c0
	sta oldCol+1

	mva colors+2 c1
	sta oldCol+2

	mva colors+3 c2
	sta oldCol+3

	mva colors+4 c3
	sta oldCol+4


// zmodyfikujemy przerwanie jesli wystapi³a ró¿nica kolorów

	mwa #colors+5 cols

	ldy #1
lpc
	mva lDli,y hlp
	mva hDli,y hlp+1

	ldx #4
nc	lda colors,x
cols	equ *-2
	cmp oldCol,x
	beq nxt

	sta ln0
	sty ln1

	ldy #@sdli._stx+1
	lda (hlp),y
	cmp <$d01e
	bne sk0

	lda treg,x
	sta (hlp),y

	ldy #@sdli._ldx+1
	lda ln0
	sta (hlp),y
	sta oldCol,x

;	jmp cont

sk0
/*	ldy #@sdli._sta2+1
	lda (hlp),y
	cmp <$d01e
	bne cont

	lda treg,x
	sta (hlp),y

	ldy #@sdli._lda2+1
	lda ln0
	sta (hlp),y
	sta oldCol,x
*/
cont	ldy ln1

nxt	dex
	bpl nc

	adw cols #5

	iny
	cpy #scrhig
	bne lpc


// -------------------------------------------------------
// modyfikacja DLI 0..14
// -------------------------------------------------------

	jsr SetDLI

	ldx #0
OverlayHeight equ *-1
	beq _skp

	jsr SetDLI.overlay	; regX musi zostaæ zachowany

	lda #0
OverlayChange equ *-1
	beq _skp

	mwa #ovrColors chngOverlay.ovr+1

	lda <[colpm0+(pmHero0-$400)/$100]
	ldy OvrCol0+1
	jsr chngOverlay
	lda <[colpm0+(pmHero1-$400)/$100]
	ldy OvrCol1+1
	jsr chngOverlay
	lda <[colpm0+(pmHero2-$400)/$100]
	ldy OvrCol2+1
	jsr chngOverlay

// -------------------------------------------------------
// dorysowanie czarnych obwódek wokó³ twardych murków
// -------------------------------------------------------

_skp	mwa #invers+4 hlp
	mwa #drabin+4 rw3

	ldx #0

tlpS	ldy #0
tlp	lda (hlp),y
	beq tlp_
	bmi tlp_

	cmp #120                     // GROUP ID = 120..127
	bcs solidColor

	jmp ramkaU

tlp_	iny
	cpy #40
	bne tlp

	adw hlp #scrwid
	adw rw3 #scrwid

	inx
	cpx #19
	bne tlpS

	rts

// murki wypelniane jednolitym kolorem
.local	solidColor
	stx _x+1

	tax
	lda tcol-120,x
	sta color+1

	lda teor-120,x
	sta cleor+1

_x	ldx #0

	mva lmul40,x ln0
	mva hmul40,x ln0+1

	mva #1 ln1

color	lda #0
	sta (ln0),y

cleor	eor #0
	sta color+1

	adw ln0 #40

	asl ln1
	bne color

	jmp ramkaU

tcol	dta $00,$55,$aa,$ff,$ff,%01100110,%01000100
teor	dta $00,$00,$00,$00,$00,%01100110^%10011001,%01000100^%00010001
.endl


.local	ramkaU
	cpx #0
	beq ramkaD

	sty _y+1

	sbw hlp #scrwid tmp+1
	sbw rw3 #scrwid tmpD+1

tmp	lda $ffff,y
	smi			; jeœli murek miêkki to rysuj obwódke
	bne tlQ

tmpD	lda $ffff,y		; jeœli drabinka to nie rysuj obwódki
	bne tlQ

	lda lmul40-1,x
	add <40*7
	sta ln0
	lda hmul40-1,x
	adc >40*7
	sta ln0+1

_y	ldy #0

	lda #$aa
	sta (ln0),y

tlQ	ldy _y+1
.endl


.local	ramkaD
	cpx #19
	beq ramkaL

	sty _y+1

	mwa rw3 tmpD+1

	tya
	add #48
	tay

	lda (hlp),y
	smi
	bne tlQ

tmpD	lda $ffff,y
	bne tlQ

	mva lmul40+1,x	ln0
	mva hmul40+1,x	ln0+1

_y	ldy #0

	lda #$aa
	sta (ln0),y

tlQ	ldy _y+1
.endl


.local	ramkaL
	cpy #0
	beq ramkaR
;	cpx #0
;	beq ramkaR

	sty _y+1
	stx _x+1

	dey

	lda (hlp),y
	smi
	bne tlQ

	lda lmul40,x
	sub <40
	sta ln0
	lda hmul40,x
	sbc >40
	sta ln0+1

	ldx #7+2	;-1
lp	lda (ln0),y
	and #$fc
	ora #%10
	sta (ln0),y

	adw ln0 #40

	cpw ln0 #txture+19*(40*8)	; !!! nie mo¿na przekraczaæ dolnej krawêdzi pola gry !!!
	bcs tlQ

	dex
	bpl lp

tlQ
_y	ldy #0
_x	ldx #0
.endl


.local	ramkaR
	cpy #40-1
	beq ramkaX
;	cpx #0
;	beq ramkaX

	sty _y+1
	stx _x+1

	iny

	lda (hlp),y
	smi
	bne tlQ

	sbw hlp #invers-drabin ln1

	lda (ln1),y
	bne tlQ

	lda lmul40,x
	sub <40
	sta ln0
	lda hmul40,x
	sbc >40
	sta ln0+1

	ldx #7+2	;-1
lp	lda (ln0),y
	and #$3f
	ora #$80
	sta (ln0),y

	adw ln0 #40

	cpw ln0 #txture+19*(40*8)
	bcs tlQ

	dex
	bpl lp

tlQ
_y	ldy #0
_x	ldx #0
.endl

ramkaX	jmp tlp_


.local	charAdr

	.var tmp .word

	sta tmp
	lda #0

	asl tmp
	rol @
	asl tmp
	rol @
	asl tmp
	rol @

	sta tmp+1

	ldy #1
	lda (hlp),y
	tay

	adb tmp+1 tfonts,y

	ldx tmp
	rts
.endl


.local	chngOverlay

	stx rX+1

	sta pcol+1

	sty old+1

	mva #0 loop+1

loop	ldy #0

	mva lDli,y hlp
	mva hDli,y hlp+1

	ldy #@sdli._stx+1
	lda (hlp),y

	cmp <$d01e
	bne skip

ovr	lda ovrColors
old	cmp #0
	beq skip

	sta old+1

pcol	mva #0 (hlp),y

	ldy #@sdli._ldx+1
	mva old+1 (hlp),y

skip	inw ovr+1

	inc loop+1
	dex
	bne loop

rX	ldx #0
	rts
.endl


.local	fillOverlay

	stx rX+1

	sta fill1+2
	add >[pmgB2-pmgB1]
	sta fill2+2

	lda #pmg_overlay
	sta fill1+1
	sta fill2+1

loop	iny
	mva #1 ln1

	lda (hlp),y

fill1	sta pmgB1+$300		; !!! uwaga 'pmgB1' = 0 wiêc bez '+$300' powstanie rozkaz strony zerowej
fill2	sta pmgB2+$300

	inc fill1+1
	inc fill2+1

	asl ln1
	bne fill1

	dex
	bne loop

rX	ldx #0
	rts

.endl


lmul40	:20 dta l(txture+#*40*8)
hmul40	:20 dta h(txture+#*40*8)

ddrabin	ins 'objects.fnt',55*8,8*3	; kszta³t drabinki
mdrabin ins 'objects.fnt',74*8,8*3	; maska drabinki

oldCol	:5 brk

lDli	dta l(dli0, dli1, dli2, dli3, dli4, dli5, dli6, dli7, dli8, dli9, dli10, dli11, dli12, dli13, dli14, dli15, dli16, dli17, dli18)
hDli	dta h(dli0, dli1, dli2, dli3, dli4, dli5, dli6, dli7, dli8, dli9, dli10, dli11, dli12, dli13, dli14, dli15, dli16, dli17, dli18)

treg	dta <colbak, <color0, <color1, <color2, <color3

	:16 dta >tmpINVERS

tfonts	.sav scrhig

_ypath	.local
	dta 1,2,3,4,6,8,11,14,18,22,26,31,36,42,48,54,61,68,76,84,92,101,110,121,134	; trajektoria lotu kuli
	.endl

ovrColors :3*14 brk

.endp


* ---------------------------
* ---	PLAYFIELD
* ---------------------------
.proc	PLAYFIELD

// tworzymy pole gry, dodatkowo na podstawie tablicy INVERS wprowadzamy 5-ty kolor znaków

	lda >scr1	; wype³niamy pamiec obrazu SCR1
	ldx #0
	jsr FIELD

	lda >scr2	; wype³niamy pamiec obrazu SCR2
	ldx #$40
	jsr FIELD

// czyœcimy obszar INVERS, informacja o inwersie znaków nie bêdzie nam juz potrzebna
// od teraz w tablicy INVERS zapisana bêdzie informacja o obiektach i krawedziach bocznych pola gry
// w pliku INIT2.ASM dokonywane jest przepisanie INVERS -> TMPINVERS

	CLRPAGES	>invers		#4 #0

	mwa #invers hlp

	ldx #scrhig-1

	ldy #3+40+1

border	lda #$ff	; dodajemy lew¹ i praw¹ krawedŸ pola gry
;	ldy #3
;	sta (hlp),y
;	ldy #3+40
	sta (hlp),y

	adw hlp #scrwid

	dex
	bpl border

	rts


FIELD	sta hlp+1	; wype³niamy pamiêæ zadanym zakresem wartoœci
			; SCR1 -> znaki w wierszach 0..39
			; SCR2 -> znaki w wierszach 64..103

	mwa #invers+3 ln0

	mva #3 hlp	; zwiêkszamy o 4 bajty, omijaj¹c ramke obrazu

	stx val

	ldx #scrhig-1

l0		ldy #0
		lda #okalajacy
		sta (hlp),y

		inw hlp
		inw ln0

	l1:	lda (ln0),y
		and #$80
		sta inv

		tya
		ora #0
	val:	equ *-1

		ora #0
	inv:	equ *-1

	 	sta (hlp),y

		iny
		cpy #40
		bne l1

		lda #okalajacy
		sta (hlp),y

	adw hlp #scrwid-1
	adw ln0 #scrwid-1

	dex
	bpl l0
	rts

.endp


.local	GameEnd

TheEnd
	lda reason
	beq skp
	cmp #deathCode.no_time+1
	bcc restart
;	cmp #deathCode.no_power
;	beq restart
	cmp #deathCode.panic_stop
	bne skp

	inc INIT.level_panic		; panic level up
	inc INIT.ground

	mva #0 INTRO.nxtLvl
	adb level? #6

skp	ldx #{bit}
	lda reason
	sne
	ldx #{jsr}

	stx _map

	mva #0 reason

	jsr INIT_VECTORS

	lda INIT.level_panic
	cmp #10
	bcs youWin

	lda INIT.lives
	bne skp2

again_	jsr DATAMATRIX
	jsr GAMEOVER			; ekran GAME OVER i potencjalnie wpisanie inicjalow

	jmp again

restart	sta INTRO.nxtLvl
	dec INIT.lives
	jmp skp

skp2	lda sstage+3
	cmp #6
	bne skp3

	lda level?
	cmp #71
	bcs youWin

_map	jsr MAPTOUR

skp3	jsr INTRO.start

	jmp lets_go

youWin	jsr CONGRATS
	jmp again_

.endl

	ert *>$7FFF

	.print 'prg_end: ',*,'..$8000'



// przerwanie DLI, VBL i procedura HERO wywo³ywana z poziomy VBL-a
// koniecznie znajduje siê poza obszarem $4000..$7FFF

	org $8000

* ---------------------------
* ---	MINMAX
* ---------------------------
; MINMAX realizuje uaktualnienie tablic TMINY, TMAXY i CLRIDX
; tablice te s¹ potrzebne podczas czyszczenia obrazu przez procedury CLEARB1, CLEARB2

	.pages

MINMAX6	lda ymin
	cmp tminy+5,x
	scs
	sta tminy+5,x

	tya
	cmp tmaxy+5,x
	scc
	sta tmaxy+5,x

	sta clridx+5,x

MINMAX5	lda ymin
	cmp tminy+4,x
	scs
	sta tminy+4,x

	tya
	cmp tmaxy+4,x
	scc
	sta tmaxy+4,x

	sta clridx+4,x

MINMAX4	lda ymin
	cmp tminy+3,x
	scs
	sta tminy+3,x

	tya
	cmp tmaxy+3,x
	scc
	sta tmaxy+3,x

	sta clridx+3,x

MINMAX3	lda ymin
	cmp tminy+2,x
	scs
	sta tminy+2,x

	tya
	cmp tmaxy+2,x
	scc
	sta tmaxy+2,x

	sta clridx+2,x

MINMAX2	lda ymin
	cmp tminy+1,x
	scs
	sta tminy+1,x

	tya
	cmp tmaxy+1,x
	scc
	sta tmaxy+1,x

	sta clridx+1,x

MINMAX1	lda ymin
	cmp tminy,x
	scs
	sta tminy,x

	tya
	cmp tmaxy,x
	scc
	sta tmaxy,x

	sta clridx,x

	rts
	.endpg


* ---------------------------
* ---	DLI
* ---------------------------
// przerwanie DLI u¿ywa tylko rejestrów regA i regX

@sdli	.struct
	_lda	.word
	_ldx	.word
	_d40a	.long
	_chbase	.long
	_stx	.long
;	_lda2	.word
;	_sta2	.long
	.ends


	?old_dli = *
/*
dliS	lda #$0e
	ldx #$00
	sta wsync		;line=16
	sta color2
	stx color1
	dli_quit dliPly


pdli0	sty rY

c10	lda #$74
	ldx #$57
	ldy #$7D
	sta wsync		;line=24
	sta color3
	stx hposm0
	sty hposm3
c11	lda #$18
	sta colpm0
	ldy rY
	dli_quit pdli1


pdli1	sty rY

	lda >fntPnl+$400
c12	ldx #$C8
	ldy #$79
	sta wsync		;line=32
	sta chbase
	stx color3
	sty hposm3
c13	lda #$18
	sta colpm1
	ldy rY
	dli_quit pdli2

pdli2
c14	lda #$F8
c15	ldx #$A8
	sta wsync		;line=40
	sta color2
	stx color3
	dli_quit dliPly
*/


dliPly	lda #0		; kolory pola gry
c0	equ *-1

	ldx #0
c1	equ *-1

	sta wsync
	sta color0
	stx color1

	lda #0
c2	equ *-1

	ldx #0
c3	equ *-1

	sta color2
	stx color3

gtia	mva	#defaultPrior	gtictl

	lda #0
	sta sizep0+(pmStar-$400)/$100

	lda #0
__hposp3 equ *-1
	sta hposp0+(pmStar-$400)/$100		; pozycja ducha #3 reprezentuj¹cego gwiazdki wybuchu

	lda #0
__hposm3 equ *-1
	sta hposm0+(pmStar-$400)/$100		; pozycja pocisku #3 podbarwiaj¹cego harpun

	lda #colm3Harpun			; kolor harpunu / gwiazdek
__colpm3 equ *-1
	sta colpm0+(pmStar-$400)/$100

	mva	#scr48	dmactl

	jmp dliHero
__dliBegin equ *-2


dli0	dta @sdli [0] (.get[0]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli1

dli1	dta @sdli [0] (.get[1]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli2

dli2	dta @sdli [0] (.get[2]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli3

dli3	dta @sdli [0] (.get[3]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli4

dli4	dta @sdli [0] (.get[4]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli5

dli5	dta @sdli [0] (.get[5]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli6

dli6	dta @sdli [0] (.get[6]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli7

dli7	dta @sdli [0] (.get[7]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli8

dli8	dta @sdli [0] (.get[8]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli9

dli9	dta @sdli [0] (.get[9]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli10

dli10	dta @sdli [0] (.get[10]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli11

dli11	dta @sdli [0] (.get[11]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli12

dli12	dta @sdli [0] (.get[12]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli13

dli13	dta @sdli [0] (.get[13]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli14

dli14	dta @sdli [0] (.get[14]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli15

dli15	dta @sdli [0] (.get[15]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli16

dli16	dta @sdli [0] (.get[16]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli17

dli17	dta @sdli [0] (.get[17]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli18

dli18	dta @sdli [0] (.get[18]<<8+{lda#}, {ldx#}, $d40a8d, $d4098d, $d01e8e/*, {lda#}, $d01e8d*/)
	dli_quit dli19


dli19	lda >fntPnl
	sta wsync
	sta chbase

	mva #@dmactl(normal|dma)	dmactl
	mva #$0c color1

	lda #0
	sta pmcntl

	sta colbak
	sta color2

	jsr dliHeroDeath.hpos		; ustawia duchy za lew¹ krawedzi¹ obrazu

	lda rA
	ldx rX
	rti


* ---------------------------
* ---	NMI
* ---------------------------
.proc NMI
	bit $d40f
	bpl VBL

	sta rA
	stx rX

	jmp dli0
vdli	equ *-2


VBL	sta rA
	stx rX
	sty rY

	sta	$d40f

	inc	frame

	mwa	dlstl	dlptr

	lda	#scr40
_dmactl	equ *-1
	sta 	dmactl

	mva	>fntPnl	chbase

	lda #$00
	sta colbak
	sta color2

	lda #$0c
	sta color1

;	lda #$04
;	sta gtictl

	mwa	#dliPly	vdli

	mva #@pmcntl(players|missiles) pmcntl		; enable players and missiles


* ---	READ KEY AND JOY, PLAY RMT

	mva $d301 bnkTmp+1

	mva @TAB_MEM_BANKS+(=rmt2) portb

	jmp rmt2.read_KeyJoy_playRMT_timer

bnkTmp	mva #0 portb


* ---	STARS EXPLOSION

	lda #0
starsExplosion equ *-1
	beq starsExplosionEnd

	jsr stars.anm

	sty stars.anm+1
	sta __hposp3

	lda $d20a
	ora #starsBright
	sta __colpm3

	dec starsExplosion
	sne
	jsr stars.zeruj

starsExplosionEnd


	lda harp0.hook
	cmp #hook_time_limit-32		; zaczynamy mrugaæ harpunem z hakiem, zaraz zniknie
	scc
	adb __colpm3 #$10


	lda PLAYERB1.blink		; !!! PLAYERB1 koniecznie poza obszarem $4000..$7FFF !!!
	beq quit

	adb chero0+1 #$10
	adb chero1+1 #$10
	adb chero2+1 #$10

quit	lda rA
	ldx rX
	ldy rY
	rti


playmusic	brk
vbltim		brk
old_joy		brk
old_key		brk
key_delay	brk

delay_joy	dta delay_joy_default_value
delay_trig	dta delay_trig_default_value

second	dta 0

timer	dta 0,0,0

sfx_stack dta $ff,0,$ff,0

	.endp


* ---------------------------
* ---	ADD PANIC BALL
* ---------------------------
.proc	ADD_PANIC_BALL

	lda select
	sne
	rts

	lda COLLISIONS.tnt+1		; gdy kule wybuchaj¹
	ora BALL_COLLISION.stop+1	; gdy kule stoj¹
	seq
	rts

	ldy	explose			; if EXPLOSE <> $FF then RTS
	iny
	seq
	rts

	dec delay
	smi
	rts

	lda random
	spl
quit	rts

	lda lbcount		; aktualna liczba kul
	cmp #balls_limit
	bcs quit

	lda #balls_limit
	sub lbcount		; dopuszczalna liczba kuli

	cmp lblimit		; limit kul dla tego levelu
	scc
	lda lblimit

	tax
	beq quit

	ldy #0
search	lda active,y
	bpl found
	iny
	cpy #mobjects-2
	bne search

	jmp quit

found	ora #$80
	sta active,y

	mva ball_no,x	ttype,y
	tax

	sbb lblimit no,x

	adb lbcount no,x

	lda random
	and #$7f
	adc #8
	sta		posx,y

	mva #0		posy,y

	sta		maxy,y

	lda #$ff
	ldx random
	spl
	lda #1

	sta		addx,y

	mva #1		addy,y

	sta		switch,y

	mva #127	delay

	iny
	cpy objects
	scc
	sty objects	; nowa liczba obiektów na liœcie

	rts


.array	ball_no	[32] .byte
	[8] = 1,1,1,1,1,1,1,1
	[4] = 2,2,2,2
	[2] = 3,3
	[1] = 4
.enda

no	dta 16,8,4,2,1

delay	dta 127
.endp


* ---------------------------
* ---	PLAY SOUND FX
* ---------------------------
// dopisujemy efekt do listy

.proc	PlaySfx (.byte note, fx) .var

	lda	NMI.sfx_stack
	bpl	_1

	lda	fx
	asl
	sta	NMI.sfx_stack
	mva	note	NMI.sfx_stack+1
	rts
_1
	lda	NMI.sfx_stack+2
	bpl	_rts

	lda	fx
	asl
	sta	NMI.sfx_stack+2
	mva	note	NMI.sfx_stack+3

_rts	rts

note	brk
fx	brk

.endp

* --------------------------------------------------------------------------------------
* --------------------------------------------------------------------------------------

zerujLedder
	lda ledder
	beq nLedder

	lda hposy
	and #$f8
	sta hposy

	mva #0 ledder
	sta PLAYER.updw
	jmp HERO.zerujDU

nLedder	txa

	jmp HERO.skip

	:8 nop

rndMinus	.he FD FD FA FB FD FA FC FB FB FD FD FA FB FB FA FA

* ---------------------------
* ---	HERO
* ---------------------------
// wystêpuj¹ odwo³ania do procedury PLAYER, procedura HERO musi znajdowaæ sie poza obszarem $4000..$7FFF
.proc	HERO (.byte a) .reg

	sta ofset

	lda #$0f
r_d300	equ *-1
	sta joyTMP

	mva #$0f r_d300

	@@testSpadania

	ldy #0
joyTMP	equ *-1

	mva	ljoy,y	jmpJoy+1
;	mva	hjoy,y	jmpJoy+2

	.pages

jmpJoy	jmp lhero

zerujRL	lda hposx		; normalizacja pozycji poziomej bohatera
	and #%11111100
	sta hposx

zeruj	mva #0 PLAYER.klatka
	jmp readFire

zerujDU	mva #0 PLAYER.klatka
	sta blkh0
	sta ledder
	jmp readFire

* ---------------------------
* ---	LEFT
* ---------------------------
lhero	.local

	lda hposx
	cmp #48+4-4
	beq zerujRL

	sub #2
	sta hposx

	jsr testCOL
	beq l_skp

	:2 inc hposx		; !!! przywracamy poprzedni¹ wartoœæ HPOSX !!!

	jmp zerujRL

l_skp	ldx #=frmL

	jmp zerujLedder
	.end


* ---------------------------
* ---	 RIGHT
* ---------------------------
rhero	.local

	lda hposx
	cmp #142+48+2+8
	beq zerujRL

	add #2
	sta hposx

	adc #2*4+2

	jsr testCOL
	beq r_skp

	:2 dec hposx		; !!! przywracamy poprzedni¹ wartoœæ HPOSX !!!

	jmp zerujRL

r_skp	ldx #=frmR

	jmp zerujLedder
	.end

* ---------------------------
* ---	DOWN
* ---------------------------
dhero	lda hposy
;	cmp #scrhig*8-32
;	beq zerujDU

	and #7
	bne d_skp

	jsr heroDOWN
	bne zerujDU

	lda hposx
	and #3^$ff
	sta hposx

d_skp	:2 inc hposy
	inc PLAYER.updw

	mva #$ff blkh0		; blokujemy harpun
	sta HERO.r_d010		; blokujemy FIRE

	sta ledder

	bne readFire

* ---------------------------
* ---	UP
* ---------------------------
uhero	lda hposy
	beq zerujDU

	.endpg

	and #7
	bne u_skp

	jsr heroUP
	bne zerujDU

;	lda hposx
;	and #3^$ff
;	sta hposx

u_skp	:2 dec hposy
	inc PLAYER.updw

	mva #$ff blkh0		; blokujemy harpun
	sta HERO.r_d010		; blokujemy FIRE

	sta ledder

	bne readFire

* ---------------------------

skip	sta PLAYER.direct

readFire
	lda #1
r_d010	equ *-1
	bne harps

;	ldy #dolnakrawedz

	lda hposy
	and #%11111000	; /8]*8
	clc
harpY	adc #120
	tay

	lda hposx
	add #4
	tax

	lda harp0.hook		; IF HARP0.HOOK>=HOOK_DELAY to aktualnie harpun z hakiem gdzies zaczepiony
	cmp #hook_delay
	bcc hskp

	lda blkh0
	bne _hps

	mva harp0.x harpun	; IF czyœcimy HARPUN #0 na ca³ej wysokoœci ekranu
	mva #0 harp0.x
	mva #1 harp0.hook
	bne _hps

hskp	lda harp0.x
	ora CLRHARP.clrPMB1+1
	ora CLRHARP.clrPMB2+1

	ora #$ff
blkh0	equ *-1
	beq h0

;	lda harp1.x
;	ora #$ff
;blkh1	equ *-1
;	beq h1

_hps	jmp harps

;----------------------------

h0	stx harp0.x
	sty harp0.y

	tya
	sub #88
	sta harp0.start
	:3 lsr @
	sta harp0.startDIV8

	PlaySfx #ton_G4 #sfxHrp		; odg³os harpunu

cont	mva #1 r_d010

; -----------------------------------

harps	ldy harp0.x
	sne
	rts

	lda @TAB_MEM_BANKS+(=HARPUNS)
	sta portb

	jmp HARPUNS


return	ldx harp0.x		; ustawiamy czyszczenie harpunu w aktualnym buforze (aktualny bufor w OFSET)
	lda min52div4,x
	add #0
ofset	equ *-1
	tax

	mva #$fe portb

	sbb harp0.y_old #88 ymin
	ldy harp0.start
	dey

	jmp MINMAX1

quit	mva #$fe portb
	rts
.endp


* ---------------------------
* ---	PLAYERB1
* ---------------------------
// korzysta z banków pamiêci, musi znajdowaæ sie poza obszarem $4000..$7FFF
.proc	PLAYERB1

; ----------------------------------------------------------------------------

	ert *<$8000

	lda #0
blink	equ *-1
	beq skp

	dec blink
	bne skp

	lda #0
	sta	BALL_COLLISION.stop+1		; przywracamy ruch kul
	sta	BALL_COLLISION_PANIC.stop+1
	sta	blink
	sta	NMI.vbltim			; przywracamy dzia³anie zegara

	mva #colpm0Hero	chero0+1		; przywracamy kolory bohatera
	mva #colpm1Hero	chero1+1		; przywracamy kolory bohatera
	mva #colpm2Hero	chero2+1		; przywracamy kolory bohatera

	mva #{lda posy,x}	COLLISIONS.DETECT.HERO
	mwa #posy		COLLISIONS.DETECT.HERO+1

; ----------------------------------------------------------------------------

skp	lda hposx
	sub #48+4-4
	:2 lsr @
;	tay

	sta PLAYER.px

	sta PLAYER.ofset


	ldx hposy

	:32 mva hadr1+31-#,x rw0+31*2-#*2+1

	jmp PLAYER
.endp


* ---------------------------
* ---	PLAYERB2
* ---------------------------
// korzysta z banków pamiêci, musi znajdowaæ sie poza obszarem $4000..$7FFF
.proc	PLAYERB2

	lda hposx
	sub #48+4-4
	:2 lsr @
;	tay

	sta PLAYER.px

	add #40
	sta PLAYER.ofset


	ldx hposy

	:32 mva hadr2+31-#,x rw0+31*2-#*2+1

;	jmp PLAYER
.endp


* ---------------------------
* ---	PLAYER
* ---------------------------
// korzysta z banków pamiêci, musi znajdowaæ sie poza obszarem $4000..$7FFF
.proc	PLAYER

	txa
	and #7
	tax

	.rept 8
	lda ladr+#,x
	sta rw0+#*2
	sta rw8+#*2
	sta rw16+#*2
	sta rw24+#*2
	.endr

	lda ledder
	beq RIGHT_LEFT

;---------------------------
	UP_DOWN:
;---------------------------
	ldy #0
updw	equ *-1		; bohater chodzi po drabinie
;	cpy #3
;	sne
;	mvy #0 updw


	lda @TAB_MEM_BANKS+(=frmUD)
	sta portb

	ldx px
	jmp frmUD

;---------------------------
	RIGHT_LEFT:
;---------------------------
	ldy #0
klatka	equ *-1
	cpy #7		; 7 ró¿nych klatek animacji bohatera
	bcc skp

	mvy #1 klatka
skp

	lda @TAB_MEM_BANKS+(=frmL)
direct	equ *-2
	sta portb

	ldx #0
px	equ *-1

	jmp frmL

; ---

return	mva #$fe portb


	ldx #0
ofset	equ *-1

;	ldy #127

	lda hposy
	sta ymin
	add #31
	tay

	lda hposx
	and #3
	sne
	jmp MINMAX3	; zaznaczaczmy obszar do czyszczenie w którym znajduje siê bohater
	jmp MINMAX4

.endp


* ---------------------------
* ---	WAIT
* ---------------------------
.proc	WAIT (.byte x,y) .reg

_wai	lda:cmp:req frame
	cmp #mframe-1
	bcc _wai

	stx dlstl
	stx dlptr

	sty pmbase
	sty pmgB

	adc #0
frmPlay equ *-1
	sta frmPlay

	cmp #delay_frame_player_animation
	bcc skp

	inc PLAYER.klatka

	mva #0 frmPlay
skp
	lda #0
	sta frame

	lda #0
hposxOK	equ *-1
	sta __hposp0
	sta __hposp1

	lda #0
hposxOK2 equ *-1
	sta __hposp2

	lda #0
hmosxOK	equ *-1
	sta __hposm0
	sta __hposm1

	lda #0
hmosxOK2 equ *-1
	sta __hposm2

	rts
.endp


* ---------------------------
* ---	CLRHARP
* ---------------------------
// CLRHARP koniecznie poza obszarem banku pamiêci ($4000..$7FFF)
.proc	CLRHARP (.byte a) .reg

	ldy harpun		; czy kasowac harpun
	sne
	rts

	add min52div4,y		; ustawiamy czyszczenie harpunu w aktualnym buforze
	tax

	sbb harp0.y_old #88 ymin
	ldy harp0.start
	dey

	jsr MINMAX1


// ustawiamy parametry potrzebne do wyczyszczenia grafiki PM dla harpunu i grotu
// harpun i grot zostan¹ wyczyszczony przez procedury CLEARB1 i CLEARB2

setPMClear
	lda @TAB_MEM_BANKS+(=clrHARP1)
	sta clrPMB1+1
	sta clrPMB2+1

	sta portb

	mva #{bne} hak

	jsr stars.zeruj2

;	mva	#defaultPrior	gtia+1
;	mva	#colm3Harpun	__colpm3	; przywracamy kolor harpunu

	lda #0
;	sta NMI.starsExplosion			; wy³¹czenie gwiazdek
	sta harp0.x
	sta harpun

	sta __hposm3		; chowamy pocisk podbarwiaj¹cy harpun za krawêdzi¹ ekranu

	lda harp0.hook		; zmniejszamy wartosc HARP0.HOOK aby nie mruga³ kolorem harpunu
	seq
	mva #1 harp0.hook

	ldy harp0.y_old

	lda min88div8,y		; dostêp do MIN88DIV8 tylko przy w³¹czonym banku
	sta clrHrp.min

	lda harp0.startDIV8
	clc			; dodatkowe -1
	sbc min88div8,y
	sta clrHrp.max

return	mva #$fe portb
	rts


clrPMB1	lda #0
	beq return

;	lda @TAB_MEM_BANKS+(=clrHARPB1)
	sta portb

	mva #0 clrPMB1+1

	jmp clrHARP1


clrPMB2	lda #0
	beq return

;	lda @TAB_MEM_BANKS+(=clrHARPB1)
	sta portb

	mva #0 clrPMB2+1

	jmp clrHARP2

.endp


* ---------------------------
* ---	CLRPAGES
* ---------------------------
.proc	CLRPAGES (.byte y .byte x .byte a) .reg

	sty clr+2

	ldy #0
clr	sta:rne $ff00,y+
	inc clr+2
	dex
	bne clr
	rts

.endp


* ---------------------------
* ---	HERODOWN
* ---------------------------
heroDOWN .local
	lda hposy
	:3 lsr @
	tax

	mva linv+4,x ln0
	mva hinv+4,x ln0+1

	mva ldrabin+4,x ln1
	mva hdrabin+4,x ln1+1

test	ldx hposx
	ldy min52div4,x

	ldx #0

	lda (ln1),y
	iny
	cmp (ln1),y
	bne skp0

	cmp #0
	seq
	ldx #2

skp0	lda (ln1),y
	beq skp1
	iny
	cmp (ln1),y
	sne
	inx

skp1	cpx #3
	beq ok
	cpx #1
	beq okR
	cpx #2
	beq okL

quit	lda #$ff
	rts

ok	lda #0
	beq skp

okL	lda #-4
	sne

okR	lda #4
skp	add hposx
	and #3^$ff
	sta hposx

;	lda #0
;	rts
	jsr testROW
	beq freeWay
;	bmi freeWay

	cmp #120
	scc
	rts

freeWay	lda #0
	rts

	.end


* ---------------------------
* ---	HEROUP
* ---------------------------
heroUP	.local
	lda hposy
	:3 lsr @
	tax

	mva linv-1,x ln0
	mva hinv-1,x ln0+1

	mva ldrabin+3,x ln1
	mva hdrabin+3,x ln1+1

	jmp heroDOWN.test

	.end


* ---------------------------
* ---	TESTROW
* ---------------------------
testROW	ldx hposx
	ldy min52div4,x

	lda (ln0),y
	iny
	ora (ln0),y
	iny
	ora (ln0),y
	rts


* ---------------------------
* ---	TESTCOL
* ---------------------------
testCOL	tay

	lda hposy
	:3 lsr @
	tax

	lda linv,x
	clc
	adc min52div4,y
	sta ln0
	lda hinv,x
	adc #0
	sta ln0+1

	ldy #0
	lda (ln0),y

	ldy #scrwid
	ora (ln0),y

	ldy #scrwid*2
	ora (ln0),y

	ldy #scrwid*3
	ora (ln0),y

	rts


* ---------------------------
* ---	TESTSPADANIA
* ---------------------------
.macro	@@testSpadania

;	lda hposx
;	and #3
;	bne quit

	lda hposy
	cmp #scrhig*8-32
	beq quit

	lsr @
	lsr @
	lsr @
	tax

	mva linv+4,x ln0
	mva hinv+4,x ln0+1

	mva ldrabin+4,x ln1
	mva hdrabin+4,x ln1+1

	ldx hposx
	ldy min52div4,x

v0	lda (ln1),y
	beq v1			; nie ma go na drabince, albo nie jest ca³kowicie na drabince
	iny
;	cmp (ln1),y
;	beq quit
	iny
	cmp (ln1),y
	beq quit		; jeœli jest na drabince to nie spada
	bne next

v1	iny
	lda (ln1),y
	beq next	;v2
	iny
	cmp (ln1),y
	beq quit

next	jsr testROW
	beq leciii

	lda hposy		; normalizacja pozycji pionowej bohatera
	and #%11111000
	sta hposy

	mva #$00 blkh0		; odblokuj harpun #0, koniec spadania
	beq quit

leciii	mva #$ff blkh0		; zablokuj harpun #0
	sta HERO.r_d010		; skoro spada to nie dzia³a przycisk FIRE

	adb hposy #4
	cmp #scrhig*8-32
	bcc skp

	mva #scrhig*8-32 hposy

	mva #$00 blkh0		; odblokuj harpun #0, spadliœmy na sam dó³ pola gry

skp	lda joyTMP

	cmp #_left
	beq lhero
	cmp #_right
	beq rhero

	bne zerujDU
quit
	ldy min52div4,x

	iny
	lda (ln0),y		; musimy stac na czyms aby wystrzelic harpun
	ora (ln1),y
;	sne
;	sty HERO.r_d010		; fireOFF ??? powodowal zablokowanie wystrzelenia harpunu !!!
.endm


* ---------------------------
* ---	CLRWALL
* ---------------------------
.local	clrWALL

skip	lda #0		; jeœli <>0 to usuwamy murki i czyœcimy clrWallIDX[0..wallIDXold]
	bne CLEAR

	ldx wallTMP	; jeœli wallTMP<wallIDX to usuwamy murek clrWallPOS[wallTMP]
	cpx wallIDX
	scc
	rts

	ldy clrWallPOS,x
	sty LEFT.clr+1
	iny
	sty RIGHT.clr+1

	sty skip+1

CLEAR
side	lda #0
	eor #1
	sta side+1
	bne RIGHT


LEFT	.local
clr	ldx #0
	bmi RIGHT

	jsr CWALL

	lda wallHIT
	beq skp

	sta clr+1
	bne TEST

skp	dec clr+1

	jmp TEST
	.endl


RIGHT	.local
clr	ldx #0
	cpx #40
	bcs TEST

	jsr CWALL

	lda wallHIT
	beq skp

	sta clr+1
	bne TEST

skp	inc clr+1
	.endl

TEST
	lda LEFT.clr+1
	bpl quit		; jeszcze nie skoñczy³ testowaæ lewej strony
	lda RIGHT.clr+1
	cmp #40
	bcc quit		; jeszcze nie skoñczy³ testowaæ prawej strony

	lda #0
	ldx wallTMP
	ldy clrWallIDX,x
	sta killWall,y		; usuwamy informacje o murze który usun¹æ

	sta skip+1		; SKIP = 0

	inc wallTMP		; nastepny murek z listy

quit	rts

CWALL	mva #$ff wallHIT

	:16 @@cwall #

	rts
.endl


.macro	@@cwall
	ldy invers+4+:1*scrwid,x
	lda killWall,y
	beq _skp
	txa
	ora tmpINVERS+4+:1*scrwid,x
	sta scr1+4+:1*scrwid,x		; znaki z przedzia³u 0..37
	ora #$40
	sta scr2+4+:1*scrwid,x		; znaki z przedzia³u 64..101
	lda #0
	sta invers+4+:1*scrwid,x
	sta wallHIT
_skp
.endm

* ---------------------------

.local	ResetScore

	mva @TAB_MEM_BANKS+(=over) portb

	jsr UpdateScoreBoard.reset

	mva #$fe portb

	rts
.endl


.local	JingleDeath

	mva @TAB_MEM_BANKS+(=rmt2) portb

	mva #$00 NMI.playmusic
	jsr rmt2.RASTERMUSICTRACKER+9

	lda GameEnd.reason
	beq _2
	cmp #deathCode.panic_stop
	beq _2

	mva #=frmD PLAYER.direct

	RMT_MODUL #msxCode.jingle1

	mva #{jmp} dliDeath
	mva #0 yB1old

	jmp _skp

_2	RMT_MODUL #msxCode.jingle2

_skp	mva #$fe portb
	sta NMI.playmusic

	rts


prepare	mva #$ff NMI.vbltim		; zatrzymujemy zegar

	mva #0 PLAYERB1.blink		; koniec mrugania kolorem ubranka bohatera

	mva #colpm0Hero	chero0+1	; przywracamy kolory bohatera
	mva #colpm1Hero	chero1+1	; przywracamy kolory bohatera
	mva #colpm2Hero	chero2+1	; przywracamy kolory bohatera

	lda GameEnd.reason		; gdy bohater ginie stoi (frmD), gdy zwycieza kroczy
	beq walk
	cmp #deathCode.panic_stop
	beq walk

	mva #0 ledder
;	sta NMI.starsExplosion

	lda #{sta*}
	sta GameEnd.klat0
	sta GameEnd.klat1

	mva #=frmL PLAYER.direct

	rts

walk
	lda #{bit}
	sta GameEnd.klat0
	sta GameEnd.klat1

	rts

.endl


.proc	depack (.word xa .byte y) .reg

	sta inputPointer
	stx inputPointer+1

	sty outputPointer+1
	mva #0 outputPointer

	jmp inflate
.endp


.local	CONGRATS

	lda @TAB_MEM_BANKS+(=cong)
	sta portb

;	mwa #cong inputPointer
;	mwa #$d800 outputPointer
;	jsr inflate
	depack #cong >$d800
;
	RMT_MODUL #msxCode.Congratulations
	tay

	jsr mainIntro			; show G2F, fade in

	jmp INIT_VECTORS
.endl


.local	DATAMATRIX

	lda @TAB_MEM_BANKS+(=dmtx)
	sta portb

;	mwa #cong inputPointer
;	mwa #$d800 outputPointer
;	jsr inflate
	depack #dmtx >$d800
;

	ldx <score
	ldy >score

	lda select
	jsr mainIntro			; show G2F, fade in

	jmp INIT_VECTORS
.endl


.local	GAMEOVER

	lda @TAB_MEM_BANKS+(=over_fnt)
	sta portb

;	mwa #over_fnt inputPointer
;	mwa #$bc00 outputPointer
;	jsr inflate
	depack #over_fnt >$bc00

	lda @TAB_MEM_BANKS+(=over)
	sta portb

	jsr UpdateScoreBoard

;	mwa #over inputPointer
;	mwa #$d800 outputPointer
;	jsr inflate
	depack #over >$d800
;
	RMT_MODUL #msxCode.GameOver
	tay

	lda select
	jsr mainIntro			; show G2F, fade in

	lda @TAB_MEM_BANKS+(=over)
	sta portb

	ldx <hi_tour			; kopiujemy tablice wynikow
	ldy >hi_tour
	lda select
	beq skp

	ldx <hi_panic
	ldy >hi_panic
skp
	stx hlp
	sty hlp+1

	ldy #score_all*6-1
	mva:rpl ScoreBoard,y (hlp),y-

	jmp INIT_VECTORS
.endl


.local	MAPTOUR

	lda select
	seq
	rts

	lda @TAB_MEM_BANKS+(=mapa_fnt)
	sta portb

;	mwa #mapa_fnt inputPointer
;	mwa #$bc00 outputPointer
;	jsr inflate
	depack #mapa_fnt >$bc00

	lda @TAB_MEM_BANKS+(=mapa)
	sta portb

;	mwa #mapa inputPointer
;	mwa #$d800 outputPointer
;	jsr inflate
	depack #mapa >$d800
;
	RMT_MODUL #msxCode.jingle2
	tay

	lda level?
	jsr mainIntro			; show G2F, fade in

	jmp INIT_VECTORS
.endl


INTRO	.local

	lda @TAB_MEM_BANKS+(=intro_kulki)
	sta portb

;	mwa #intro_kulki inputPointer
;	mwa #$c000 outputPointer
;	jsr inflate
	depack #intro_kulki >$c000

	lda @TAB_MEM_BANKS+(=intro_logo)
	sta portb

;	mwa #intro_logo inputPointer
;	mwa #$d800 outputPointer
;	jsr inflate
	depack #intro_logo >$d800

	RMT_MODUL #msxCode.title

	jsr mainIntro			; show G2F, fade in

	beq next

	INIT_VECTORS
	jsr GAMEOVER
	jmp again

next
	INIT_VECTORS

	mvy #0 INIT.ground
	sty level?

	iny
	sty INIT.level_panic		; = 1

;	mva #70  level?

	inc GROUND_MOVEUP.ground	; zmiana tekstury pod³ogi

	rts

start

* zwiêkszamy SUBLEVEL 0..5, nastêpnie LEVEL 1..12 (ka¿dy nowy level to nowa tekstura t³a)

	ldy #9
slop	lda stage_bar,y
	sta sstage,y
	dey
	bpl slop

	lda #0
nxtLVL	equ *-1
	bne skp_

	inc level?
	lda level?
	cmp #72
	sne
	mva #0 level?

skp_	ldx level?

.nowarn	div #6

	add #1
	sta sstage+3

	ldx #spacja		; spacja

	lda div.ACC
	add #1
	cmp #10
	bcc lt10

	sub #10
	ldx #1

lt10	sta sstage+1
	stx sstage

skp	mva #0 nxtLVL

	jsr DEPACK_LVL

	ldx level?
.nowarn	div #6

	lda div.ACC		; 0..11 !!!
txtLP	cmp #12
	bcc txtOK

	sub #12
	jmp txtLP

txtOK	tay

	ldx txt_bnk,y
	lda @TAB_MEM_BANKS,x
	sta portb

	mva txtLadr,y	inputPointer
	mva txtHadr,y	inputPointer+1

	mwa #txture	outputPointer
	jsr inflate

	mva #$fe portb

	jmp INIT

	.endl


* ---------------------------
* ---	EXPLOSIONS
* ---------------------------
EXPLOSIONS

;	lda	harp0.x		; synchronizujemy sie z harpunem
;	seq			; jeœli nie zosta³ skasowany to nie poka¿emy gwiazdek z wybuchu
;	rts

	ldx	explose		; pokazujemy pierwsz¹ eksplozjê w kolejnoœci
	cpx	#$ff
	sne
	rts

	mva 	#$ff	explose	; wy³¹czamy eksplozje dla tego ducha

	lda	#0
	ldy	ttype,x
	cpy	#4		; wyj¹tkowo dla najmniejszej kuli nie zwiêkszamy pozycji poziomej o jej szerokoœæ
	seq
	lda	twidthm1,y
	adc	posx,x
	adc	#48		; nowa pozycja pozioma gwiazdek

	sta	stars.dataStar[0].x
	sta	stars.dataStar[1].x
	sta	stars.dataStar[2].x
	sta	stars.dataStar[3].x

	lda	theight,y
	lsr @
	adc	posy,x		; nowa pozycja pionowa gwiazdek
	adc	#dolnakrawedz-scrhig*8-24

	sta	stars.dataStar[0].y
	sta	stars.dataStar[1].y
	sta	stars.dataStar[2].y
	sta	stars.dataStar[3].y

	ldx	#10+5		; licznik klatek animacji

* ---------------------------
* ---	STARS
* ---------------------------
stars	.local

	lda $d20a			; star #0
	and #15
	tay
	mva rndMinus,y	dataStar[0].dx
	mva rndMinus,y	dataStar[0].dy

	lda $d20a			; star #2
	and #15
	tay
	mva rndPlus,y	dataStar[2].dx
	mva rndPlus,y	dataStar[2].dy

	lda $d20a			; star #1
	and #15
	tay
	mva rndMinus,y	dataStar[1].dx
	mva rndPlus,y	dataStar[1].dy

	lda $d20a			; star #3
	and #15
	tay
	mva rndPlus,y	dataStar[3].dx
	mva rndMinus,y	dataStar[3].dy

	stx NMI.starsExplosion			; licznik klatek animacji, !!! koniecznie na koncu procki !!!
	rts

* ---------------------------

zeruj	mva	#$ff	explose			; czyœæ informacje o eksplozji kul
zeruj2
	mva	#$00	NMI.starsExplosion	; zeruj licznik animacji dla gwiazdek (blokada animacji)

;	mva	#defaultPrior	gtia+1
	mva	#colm3Harpun	__colpm3	; przywracamy kolor harpunu

	mva	<frm1	anm+1

	jmp	stars1.clr			; usuwamy ostatni¹ gwiazdkê

// -----------------------------------------------------------------------------------------------------

;	:17 nop

rndPlus		.he 06 06 02 03 05 03 04 03 03 06 06 03 03 04 03 05

	.pages

anm	jmp frm1

; -----------------------------------------------------------
; -----------------------------------------------------------

frm1	stars1	#.len(@@shape)*0

	ldy <frm2
	lda dataStar+@@shape.x+.len(@@shape)*0
	rts

; -----------------------------------------------------------
; -----------------------------------------------------------

frm2	stars1	#.len(@@shape)*2

	ldy <frm3
	lda dataStar+@@shape.x+.len(@@shape)*2
	rts

; -----------------------------------------------------------
; -----------------------------------------------------------

frm3	stars1	#.len(@@shape)*1

	ldy <frm4
	lda dataStar+@@shape.x+.len(@@shape)*1
	rts

; -----------------------------------------------------------
; -----------------------------------------------------------

frm4	stars1	#.len(@@shape)*3

	ldy <frm1
	lda dataStar+@@shape.x+.len(@@shape)*3
	rts

	.endpg

	icl 'gwiazdki\stars_2.asm'

	.endl


txt_bnk	dta l(=texture1, =texture11, =texture10, =texture6, =texture9, =texture12)
	dta l(=texture2, =texture8, =texture5, =texture4, =texture3, =texture7)

txtLadr	dta l(texture1, texture11, texture10, texture6, texture9, texture12)
	dta l(texture2, texture8, texture5, texture4, texture3, texture7)

txtHadr	dta h(texture1, texture11, texture10, texture6, texture9, texture12)
	dta h(texture2, texture8, texture5, texture4, texture3, texture7)


.proc	INIT_VECTORS

	;lda:cmp:req 20
	lda:rne vcount

	sei:cld
	lda #$00
	sta nmien
	sta irqen
	sta dmactl
;	sta 559

	mva #$fe portb

	mva >pmgB1 pmbase	; missiles and players data address

	mwa #nmi nmivec

	rts
.endp


/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////
//
//  detekcja kolizji kul musi sk³adaæ siê z dwóch faz
//
//  1. modyfikacja pozycji poziomej i pionowej
//  2. test przekroczenia zakresu wartoœci dla pozycji poziomej i pionowej
//
//  jeœli kule zostan¹ zatrzymane i bêdziemy je rozbijaæ PKT1 jest pomijany, PKT2 jest wykonywany
//
/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////


* ---------------------------
* ---	BALL COLLISION PANIC
* ---------------------------
// !!! regX = IDX !!!
; -------------------------------------------------
; test pozycji X:Y kul dla rozgrywki typu PANIC
; nie jest potrzebna detekcja z murkami
; -------------------------------------------------
.proc	BALL_COLLISION_PANIC

	ldx	idx

stop	ldy	#0
	bne	_stop

// ----	test pozycji pionowej kuli

	lda	posy,x
	cmp	maxy,x
	bcc	_mi		; przekroczony limit ruchu w górê
	bne	_s

_mi	mva	#1	addy,x	; kierunek w dó³
	bne	plus		; !!! regY = 0

_s	;lda	posy,x
	sub	maxy,x
	tay

	lda	addy,x
	bpl	plus

; -----------------------------------

minus	lda	posy,x
	sub	ypath,y
	sta	posy,x
	jmp	_x

; -----------------------------------

plus	lda	posy,x
	add	ypath,y
	sta	posy,x

	adc	height
fminY	cmp	#scrhig*8
	bcc	_x

	lda	fminY+1		; uwzglêdniamy podnosz¹cy siê grunt
	sbc	height
	sta	posy,x

	mva	#$ff	addy,x	; kula w górê

	ldy	type		; kula 0 nie ma modyfikowanej si³y odbicia
	beq	_x

	lda	maxy,x		; modyfikacja si³y odbicia kuli
	adc	tenergy,y

	cmp	yPosMAX,Y
	scc
	lda	yPosMAX,Y

	sta	maxy,x		; zapisujemy now¹ si³ê odbicia kuli

// ----	modyfikacja pozycji poziomej kuli

_x	lda	posx,x
	add	addx,x
	sta	posx,x

_stop	jmp BALL_COLLISION.testX
.endp


* ---------------------------
* ---	BALL COLLISION
* ---------------------------
// test przekroczenia zakresu wartoœci X,Y kuli koniecznie na koñcu procedury
// !!! regX = IDX !!!
.proc	BALL_COLLISION

	ldx	type

	lda	tDY,x
	sta	BALL_COLLISION.dy0+2
	sta	BALL_COLLISION.dy1+2

	ldx	idx

stop	ldy	#0
	bne	_stop

; --------------------------------------------
; ------ modyfikacja pozycji pionowej Y ------
; --------------------------------------------

	lda	posy,x
	cmp	maxy,x
	bcc	_minus		; przekroczony limit ruchu w górê
	bne	_s

_minus	mva	#1	addy,x	; kierunek w dó³
	bne	plus		; !!! regY = 0

_s	;lda	posy,x
	sub	maxy,x
	tay

	lda	addy,x
	bpl	plus

;; MINUS - ruch w górê

minus	lda	posy,x
	sec
dy0	sbc	ypath,y

	jmp	_ny

;; PLUS  - ruch w dó³

plus	lda	posy,x
	clc
dy1	adc	ypath,y
	sta	posy,x

	adc	height
	cmp	#scrhig*8
	bcc	_x

	lda	#scrhig*8	; wymuszamy kolizje z dolna krawedzia aby obliczyæ now¹ energiê kuli
	sbc	height

_ny	sta	posy,x

; --------------------------------------------
; ------ modyfikacja pozycji poziomej X ------
; --------------------------------------------

_x	lda	posx,x
	add	addx,x
	sta	posx,x

; ---------------------------

_stop	ldy	type

	lda	lckula,y	; adres programu detekcji kolizji
	sta	_jck0+1
	sta	_jck1+1
	sta	_jck2+1

	lda	hckula,y
	sta	_jck0+2
	sta	_jck1+2
	sta	_jck2+2

	lda	bckula,y	; bank z programem detekcji kolizji kuli
	tay
	lda	@TAB_MEM_BANKS,y
	sta	portb

// -------------------------------------------------------------------
//	test kolizji kul z murkami
// -------------------------------------------------------------------

	mva posx,x	_posx
	mva posy,x	_posy
	mva addx,x	_addx
	mva addy,x	_addy

	lda	type		// specjalny test dla najmniejszej kuli
	cmp	#4
	bne	_jck0

	mva	#0	_addy

_jck0	jsr	$ffff		; wyrównaj jedoczeœnie POSX i POSY do krawêdzi murku, !!! koniecznie jednoczeœnie !!!
				; jeœli wyrównamy oddzielnie POSX i POSY, wówczas kule bêd¹ siê "zacina³y" na murkach

	lda	_addy		// specjalny test dla najmniejszej kuli
	bne	_sk

	sta	_addx
	mva	addy,x	_addy

	bne	_jck0
_sk

// test zmiany pozycji poziomej

	lda	posx,x
	cmp	_posx
	beq	_sk1

	sta	_posx		; test starej pozycji poziomej
	mva	addx,x	_addx	; w³¹cz test pozycji poziomej
	mva	#0	_addy	; wy³¹cz test pozycji pionowej
_jck1	jsr	$ffff

	lda	_posx
	cmp	posx,x
	beq	_sk1

_sk0

// test zmiany pozycji pionowej

	lda	posy,x
	cmp	_posy
	beq	_sk1

	sta	_posy		; test starej pozycji pionowej
	mva	addy,x	_addy	; w³¹cz test pozycji pionowej
	mva	#0	_addx	; wy³¹cz test pozycji poziomej
_jck2	jsr	$ffff

_sk1

// teraz pozostaje odpowiednio zinterpretowaæ zmiany wartoœci _POSX i _POSY

	lda _posx		; IF _posx <> posx,x then NOWA POZYCJA POZIOMA, ZMIANA KIERUNKU
	cmp posx,x
	beq skp0

	sta posx,x

	lda addx,x
	eor #$fe
	sta addx,x

skp0	lda _posy		; jeœli pozycja pionowa przekroczy³a limit wysokoœci
	cmp maxy,x
	bcc skp1
;	lda _posy		; IF _posy <> posy,x then NOWA POZYCJA PIONOWA, ZMIANA KIERUNKU
	cmp posy,x
	beq quit

	sta posy,x

skp1	lda addy,x
	eor #$fe
	sta addy,x

// modyfikacja si³y odbicia

	bpl	quit

	ldy	type
	beq	quit

	lda	yPosMAX,y	; domyœlna energia kuli
	cmp	maxy,x
	bcc	_quit

	lda	posy,x
	add	theight,y
	sbc	_yPosMAX,y
	bmi	quit		; jeœli wynik ujemny to koñczymy

	sta	_newMAX		; nowy maksymalny zakres pozycji pionowej kuli
	cmp	maxy,x
	bcc	quit		; jeœli jest wiêkszy od dotychczasowego to koñczymy

	lda	maxy,x		; modyfikujemy aktualny maksymalny zakres pozycji pionowej (si³ê odbicia)
	adc	tenergy,y

	cmp	_newMAX
	scc
	lda	_newMAX

_quit	sta	maxy,x		; zapisujemy now¹ si³ê odbicia kuli

quit

; -------------------------------------
; ------ test pozycji poziomej X ------
; -------------------------------------

testX	lda	posx,x		; test lewej krawedzi
	cmp	#240
	bcc	_rb

	mva	#0	posx,x
	mva	#1	addx,x
	bne	testy

_rb	ldy	type		; test prawej krawedzi
	adc	twidthm1,y
	cmp	#160
	bcc	testy

	lda	#160-1
	sbc	twidthm1,y
	sta	posx,x

	mva	#$ff	addx,x

; -------------------------------------
; ------ test pozycji pionowej Y ------
; -------------------------------------

testy	lda	posy,x		; test górnej krawêdzi
	cmp	#240
	bcc	_db

	mva	#0	posy,x
	mva	#1	addy,x
	bne	_end

_db	adc	height		; test dolnej krawêdzi
	cmp	#scrhig*8
	bcc	_end

	lda	#scrhig*8-1
	sbc	height
	sta	posy,x

	mva	#$ff	addy,x

_end	jmp	ENGINE._nxt
.endp


* ---------------------------
* ---	ENGINE
* ---------------------------
.proc	ENGINE (.word xa) .reg

	sta BALL.bjmp
	stx BALL.bjmp+1

	ldx objects
	dex

lp	lda active,x
	bpl _nxt

	lda switch,x
	bne _nxt

	stx idx

	ldy ttype,x	; typ kuli 0..4
	sty type

	lda theight,y	; wysokoœæ kuli 0..4
	sta height

	BALL

mode	jmp BALL_COLLISION

; ---------------------------

_nxt	mva #$fe portb

	dex
	bpl lp

	jmp EXPLOSIONS

.endp


* ----------------------
* ---	GO BONUS
* ----------------------
.proc	GO_BONUS

	lda bonus.x
	sne
	rts

;	lda bufor
;	sne
;	rts

	lda @TAB_MEM_BANKS+(=BONUS)
	sta portb

	jsr BONUS

	mva #$fe portb

	lda bonus.typ
	smi
_rts	rts

.pages

	and #7
;	asl @
	tax

	mva ebon,x	jbon+1
;	mva ebon+1,x	jbon+2

jbon	jmp exec_bonus_1_heart

ebon	dta l(exec_rts)
	dta l(exec_bonus_1_heart)
	dta l(exec_bonus_2_shield)
	dta l(exec_bonus_3_clock)
	dta l(exec_bonus_4_Xharpun)
	dta l(exec_bonus_5_harpun)
	dta l(exec_bonus_6_tnt)
	dta l(exec_rts)

exec_bonus_1_heart
	jmp COLLISIONS.DETECT.ENERGY.more

exec_bonus_3_clock
	sta BALL_COLLISION.stop+1
	sta BALL_COLLISION_PANIC.stop+1
	sta NMI.vbltim			; zatrzymujemy zegar

	lda #clock_time_limit
	sne

exec_bonus_2_shield

	lda #shield_time_limit

	sta PLAYERB1.blink		; mrugamy kolorem ubranka bohatera

	mva #colpm0Hero	chero0+1	; przywracamy kolory bohatera
	mva #colpm1Hero	chero1+1	; przywracamy kolory bohatera
	mva #colpm2Hero	chero2+1	; przywracamy kolory bohatera

	mva #{jmp*}				COLLISIONS.DETECT.HERO
	mwa #COLLISIONS.DETECT.HERO._nxt	COLLISIONS.DETECT.HERO+1
exec_rts
	rts

exec_bonus_4_Xharpun
	mva #1 harp0.hook
	rts

exec_bonus_5_harpun
	mva #0 harp0.hook
	rts

exec_bonus_6_tnt
	mva #128-17	COLLISIONS.tnt+1
	rts

.endpg

* ---
* ---	TEST XY BONUS POSITION
* ---

testXY	lda @TAB_MEM_BANKS+(=BONUS_TEST)
	sta portb

	jsr BONUS_TEST
	tay

	mva #$fe portb
	rts
.endp


* ---------------------------
* ---	RMT MODUL
* ---------------------------
.proc	RMT_MODUL (.byte y) .reg

	mva @TAB_MEM_BANKS+(=rmt2) portb

	mva rmt_l,y	inputPointer
	mva rmt_h,y	inputPointer+1

	mwa	#$4000	outputPointer
	jsr	inflate

	mwa #rmt2.play			msxPlay+1
	mwa #rmt2.RASTERMUSICTRACKER+9	msxStop+1

	ldx #0
	lda pal
	cmp #15
	sne
	ldx #4

	stx rmt2.ntsc

;	ldx #<modul_title			;low byte of RMT module to X reg
;	ldy #>modul_title			;hi byte of RMT module to Y reg
	ldx <$4000
	ldy >$4000
	txa
;	lda #0				;starting song line 0-255 to A reg
	jmp rmt2.RASTERMUSICTRACKER	;Init

rmt_l	dta l(rmt_title, rmt_gover, rmt_win, rmt_game_1, rmt_game_2, rmt_game_3, rmt_game_4, jingle_1, jingle_2, jingle_3)
rmt_h	dta h(rmt_title, rmt_gover, rmt_win, rmt_game_1, rmt_game_2, rmt_game_3, rmt_game_4, jingle_1, jingle_2, jingle_3)
.endp


* ---------------------------
* ---	ADD NEW BALL
* ---------------------------
.proc	ADD_NEW_BALL

	stx rX+1
	sty rY+1

	lda @TAB_MEM_BANKS+(=BALL_TEST)
	sta portb

	jsr BALL_TEST		; w regA wartoœæ #0 lub #? jeœli przesuniêcie kuli w prawo jest mo¿liwe

rX	ldx #0
rY	ldy #0

	add	posx,x
	sta	posx,y

	mva	#$fe	portb

	mva	posy,x	posy,y
	mva	ttype,x	ttype,y

	lda	posy,x
	sec
new0	sbc	#0		; dodatkowa energia wybuchu kuli, kula podskakuje wy¿ej
	spl
	lda	maxy,x

	sta	maxy,x
	sta	maxy,y

	lda	posy,x
new1	sbc	#0
	smi
	sta	maxy,y

	lda addx,x
	sta addx,y
	beq ok

	bpl right

	eor #$fe
	sta addx,y
	bne ok

right	eor #$fe
	sta addx,x

ok	lda #$ff
	sta addy,x
	sta addy,y

	sta switch,y

	lda active,y
	ora #$80
	sta active,y

	rts
.endp


* ---------------------------
* ---	NEW SCORE
* ---------------------------
.proc	NewScore (.byte _10,_1) .var

; jednoœci
	lda #0
_1	equ *-1
	beq s_10
	add score+4+1
	cmp #10
	bcc _1skp

	sub #10
	inc _10

_1skp	sta score+4+1

; dziesi¹tki

s_10	lda #0
_10	equ *-1
	beq s_100
	add score+3+1
	cmp #10
	bcc _10skp

	sub #10
	inc score+2+1

_10skp	sta score+3+1

; setki
s_100	lda score+2+1
	cmp #10
	bcc _100skp

	sub #10
	inc score+1+1

_100skp	sta score+2+1

; tysi¹ce
	lda score+1+1
	cmp #10
	bcc _1000

	sub #10
	inc score+1

_1000	sta score+1+1

; dziesi¹tki tysiêcy
	lda score+1
	cmp #10
	bcc _10000

	sub #10
	inc score

_10000	sta score+1


// -------------- HI SCORE

	sec

	.rept score_cnt
	lda hiscore+score_cnt-1-#
	sbc score+score_cnt-1-#
	.endr

	bmi new_hiscore

	rts

new_hiscore
	:score_cnt mva score+# hiscore+#
	rts
.endp


* ---------------------------
* ---	FLOOR MOVE UP
* ---------------------------
.proc	GROUND_MOVEUP (.byte a) .reg

	.var tmp tmp2  .byte	floor .word

	cmp #10
	scc
	lda #9

	sta tmp
	:3 asl @
	sta tmp2

	lda #3
ground	equ *-1
	and #3
	sta ground

	tax

	ldy tgrnd_b,x
	lda @TAB_MEM_BANKS,y
	sta portb

	mva tgrnd_l,x	inputPointer
	mva tgrnd_h,x	inputPointer+1

	lda <ground_buf
	sta outputPointer
	sta floor

	lda >ground_buf
	sta outputPointer+1
	sta floor+1

	jsr inflate

/*
	mva tgrnd_l,x	floor
	add <40*80
	sta finv+1
	mva tgrnd_h,x	floor+1
	adc >40*80
	sta finv+2

	adw finv+1 #48*10 rw3
*/

	mwa #ground_buf+40*80		finv+1
	mwa #ground_buf+40*80+48*10	rw3

	ldx tmp

	lda <colors+19*5	; adres w tablicy COLORS+[19-tmp]*5
	sub tmul5,x
	sta rw2
	lda >colors+19*5
	sbc #0
	sta rw2+1

	lda #19
	sub tmp
	tax

	lda lmul48,x
	add <scr1
	sta rw0
	sta rw1
	lda hmul48,x
	adc >scr1
	sta rw0+1
	adc #4
	sta rw1+1

	lda lmul48,x
	add <invers
	sta dst+1
	lda hmul48,x
	adc >invers
	sta dst+2

	ldx #47
	lda #1
dst	sta:rpl $ffff,x-		; wstawienie murku

;	lda tmp
;	:3 asl @
;	sta tmp2

	lda #scrhig*8-32		; nowa pozycja pionowa bohatera
	sub tmp2
	sta hposy

	lda #scrhig*8			; minimalna pozycja Y kul
	sub tmp2
	sta BALL_COLLISION_PANIC.fminY+1
;	sta BALL.fminY_0+1
;	sbc #1
;	sta BALL.fminY_1+1

	ldx #4
lp	lda yPosMAX_tmp,x
	sub tmp2
	spl
	lda #0
	sta yPosMAX,x
	dex
	bpl lp

; ---	przepisanie textury do odpowiednich zestawów znaków

	dec tmp
	bmi quit

	ldx tmp
	ldy tmul5+1,x
	dey

lc	lda (rw3),y
	sta (rw2),y
	dey
	bpl lc

_lp	jsr move
	dec tmp
	bpl _lp

quit	mva #$fe portb
	rts


move	ldx tmp

	mwa floor flo+1

	mva ltxt,x txt+1
	mva htxt,x txt+2

	ldx #0
	ldy #0

loop	cpy <320
	bne flo
	cpx >320
	beq stop

flo	lda $ffff,y
txt	sta $ffff,y

	iny
	bne loop

	inc flo+2
	inc txt+2

	inx
	bne loop

stop	adw floor #320

	.var inv .byte

;	ldy #3
;;	lda #pustak
;	sta (rw0),y
;	sta (rw1),y
;	iny

	ldy #4

finv	lda $ffff
	and #$7f
	sta inv

	lda (rw0),y
	and #$7f
	ora inv
	sta (rw0),y

	lda (rw1),y
	and #$7f
	ora inv
	sta (rw1),y

	iny
	cpy #44
	bne finv

	adw rw0 #48
	adw rw1 #48

	adw finv+1 #48

	rts
.endp


inflate
	icl 'inflate.asm'


* ---------------------------
* ---	WAIT AND BLINK
* ---------------------------
.proc	wait_AND_blink (.word xa) .reg

	sta src+1
	stx src+2

	stx NMI.vbltim		; zatrzymujemy zegar

	ldx #10
copy	mva	status+14,x stage,x
src	mva	$ffff,x status+14,x
	dex
	bpl copy

	lda $d209
	sta get_key
	sta NMI.old_key
	sta _key

	mva #0 frame

	mva #6 NMI.key_delay

wait	lda:cmp:req frame

	lda consol		; START
	and #1
	beq quit
	lda trig0		; FIRE
	beq quit

	lda $d20f
	and #8
	beq quit

	lda frame
	and #7
	bne skip

	lda #2
inv	equ *-1
	eor #2
	sta inv
	sta chrctl

skip	lda #0
get_key	equ *-1
	cmp #$ff
_key	equ *-1
	beq wait

quit	ldx #10
	mva:rpl stage,x status+14,x-

	mwa #LOOP LOOP.napisy
	sta HERO.r_d010

	mva #0	NMI.vbltim		; wznawiamy zegar

	mva #15 NMI.key_delay

	rts

stage	:11 brk
.endp


* ---------------------------
* ---	INIT 2
* ---------------------------
; czêœæ kodu inicjalizuj¹cego przeniesiona do dodatkowego banku
; m.in. kszta³ty klocków
init2	.local

	mva @TAB_MEM_BANKS+(=init_2) portb

	jsr init_2

	mva #$fe portb
	rts
.endl


* ---------------------------
* ---	PAUSE
* ---------------------------
.local	napis_pause

	wait_AND_blink #pause

	jmp LOOP

pause	ins 'panel\liczniki2.scr'*,1*48+24,11
.endl

* ---------------------------
* ---	TIME OUT
* ---------------------------
.local	napis_timeout

	lda #1
	sta objects		; wymuszamy koniec dzia³ania silnika
	sta active

;	lda #0
;	sta INIT.lives

	wait_AND_blink #timeout

	jmp LOOP

timeout	ins 'panel\liczniki2.scr'*,2*48+24,11
.endl


* ---------------------------
* ---	DLI HERO
* ---------------------------
// !!! tylko rejestry A,X
dliHero
	lda #$00
	sta sizep0+(pmHero0-$400)/$100
	sta sizep0+(pmHero1-$400)/$100
	sta sizep0+(pmHero2-$400)/$100

dliDeath bit dliHeroDeath

	lda #%01000000
	sta sizem

	lda #0
__hposp0 equ *-1
	sta hposp0+(pmHero0-$400)/$100

	lda #0
__hposp1 equ *-1
	sta hposp0+(pmHero1-$400)/$100

	lda #0
__hposp2 equ *-1
	sta hposp0+(pmHero2-$400)/$100


	lda #0
__hposm0 equ *-1
	sta hposm0+(pmHero0-$400)/$100

	lda #0
__hposm1 equ *-1
	sta hposm0+(pmHero1-$400)/$100

	lda #0
__hposm2 equ *-1
	sta hposm0+(pmHero2-$400)/$100

chero0	mva #colpm0Hero	colpm0+(pmHero0-$400)/$100	; kolory bohatera
chero1	mva #colpm1Hero	colpm0+(pmHero1-$400)/$100
chero2	mva #colpm2Hero	colpm0+(pmHero2-$400)/$100

ldliHero mva <dli0 NMI.vdli
hdliHero mva >dli0 NMI.vdli+1

	lda rA
	ldx rX
	rti


* ---------------------------
* ---	DLI OVERLAY
* ---------------------------
// !!! tylko rejestry A,X
dliOverlay
	lda #3
	sta sizep0+(pmHero0-$400)/$100
	sta sizep0+(pmHero1-$400)/$100
	sta sizep0+(pmHero2-$400)/$100

	lda #%01111111
	sta sizem

OvrCol0	mva #0 colpm0+(pmHero0-$400)/$100
OvrCol1	mva #0 colpm0+(pmHero1-$400)/$100
OvrCol2	mva #0 colpm0+(pmHero2-$400)/$100

OvrPly0	mva #0 hposp0+(pmHero0-$400)/$100
OvrPly1	mva #0 hposp0+(pmHero1-$400)/$100
OvrPly2	mva #0 hposp0+(pmHero2-$400)/$100

OvrMis0	mva #0 hposm0+(pmHero0-$400)/$100
OvrMis1	mva #0 hposm0+(pmHero1-$400)/$100
OvrMis2	mva #0 hposm0+(pmHero2-$400)/$100

ldliOvr	mva <dli0 NMI.vdli
hdliOvr	mva >dli0 NMI.vdli+1

	lda rA
	ldx rX
	rti


.local	SetDLI

	ldx #0

loop	jsr setHlp

	mva #{lda<0} (hlp),y
	iny
	mva INIT.ldli+1,x (hlp),y
	iny
	mva #{sta*} (hlp),y

	inx
	cpx #15
	bne loop

	mva <dli0 ldliHero+1
	mva >dli0 hdliHero+1

init	mwa #dliHero __dliBegin
	rts


overlay	jsr setHlp

	mva INIT.ldli+1,x ldliHero+1
	mva INIT.hdli+1,x hdliHero+1

	mva #{jmp*} (hlp),y
	iny
	mwa #dliHero (hlp),y

	mva <dli0 ldliOvr+1
	mva >dli0 hdliOvr+1

	mwa #dliOverlay __dliBegin
	rts


setHlp	mva INIT.ldli,x hlp
	mva INIT.hdli,x hlp+1

	ldy #.len(@sdli)
	rts
.endl


* ---------------------------
* ---	GET LEVEL
* ---------------------------
// kopiuje dane levelu z banku pod adres INFLATE_DATA
.proc	GET_LEVEL

	lda select
	bne panic

	mva @TAB_MEM_BANKS+(=lvl_temp) portb

	lda <lvl_temp
	ldx >lvl_temp

	bne copy

panic	mva @TAB_MEM_BANKS+(=lvl0) portb

	lda <lvl0
	ldx >lvl0

copy	sta src+1
	stx src+2

	mwa #inflate_data dst+1

	ldx #3
	ldy #0
src	lda $ffff,y
dst	sta $ffff,y		; inflate_data
	iny
	bne src

	inc src+2
	inc dst+2
	dex
	bne src

	mva #$fe portb

	rts

.endp


.proc	DEPACK_LVL	; trzy paczki po 24 levele kazda

	ldx level?

.nowarn	div #24		; nLvl / 24
	sta mod24

	mva @TAB_MEM_BANKS+(=lvla) portb

	ldx div.ACC	; 0..2 !!!
	cpx #3
	scc
	ldx #0

	mva l_lvl,x inputPointer
	mva h_lvl,x inputPointer+1

	mwa #txture outputPointer

	jsr inflate

	lda #0		; nLvl mod 24
mod24	equ *-1
	asl @
	tax

	lda txture,x
	add <txture+48
	sta src+1
	lda txture+1,x
	adc >txture+48
	sta src+2

	mwa #lvl_temp dst+1

	ldx #3
	ldy #0
src	lda $ffff,y
dst	sta $ffff,y
	iny
	bne src

	inc src+2
	inc dst+2
	dex
	bne src

	mva #$fe portb
	rts
.endp



/*
 DIVIDE ROUTINE
 ACC/AUX -> ACC, remainder in EXT
*/

.proc	div  (.byte a,x) .reg

ACC	= inflate_zp	; A
AUX	= ACC+1		; X

	stx ACC
	sta AUX

	LDA #0
	LDY #$08
LOOP	ASL ACC
	ROL @
	CMP AUX
	BCC DIV2
	SBC AUX
	INC ACC
DIV2
	DEY
	BNE LOOP
;	STA EXT
	RTS

.endp


.local	Digit

	sta _add
	asl @
	add #0
_add	equ *-1
	tax

	jsr digit
	jsr digit
digit
	mva Digits0,x	panel,y
	mva Digits1,x	panel+40,y
	mva Digits2,x	panel+80,y

	inx
	iny
	rts

;	mva Digits0+1,x	panel+1,y
;	mva Digits1+1,x	panel+40+1,y
;	mva Digits2+1,x	panel+80+1,y
;
;	mva Digits0+2,x	panel+2,y
;	mva Digits1+2,x	panel+40+2,y
;	mva Digits2+2,x	panel+80+2,y
;
	rts
.endl

.proc	CLRMISSILE

	ldx #60
loop	lda pmgB1+$300,x
	and #missile_mask^$ff
	sta pmgB1+$300,x

	lda pmgB2+$300,x
	and #missile_mask^$ff
	sta pmgB2+$300,x

	inx
	cpx #212
	bne loop
	rts
.endp


.local	GameEnd

gamEnd2	WAIT <dlist2 >pmgB2

	CLEARB1
	mva #0 bufor

klat0	sta PLAYER.klatka

	ENGINE #BALL.BALLB1

	CLRHARP	#0^40

;	HERO	#0
	PLAYERB1


gamEnd0	WAIT <dlist1 >pmgB1

	CLEARB2
 	mva #2 bufor

	lda #0
klat1	sta PLAYER.klatka

	ENGINE #BALL.BALLB2

	CLRHARP	#40^40

;	HERO	#40
	PLAYERB2

	GO_BONUS

	lda end_delay
	cmp #@end_delay-10
	sne
	jsr JingleDeath

	lda NMI.starsExplosion
	bne gamEnd2

	dec end_delay
	bpl gamEnd2

	mva #@end_delay end_delay

	lda @TAB_MEM_BANKS+(=rmt2)
	sta portb

	mva #$00 NMI.playmusic
	jsr rmt2.RASTERMUSICTRACKER+9

	lda select
	bne skip			; dla PANIC nie mamy naliczania bonusu
	
	lda #0
reason	equ *-1
	bne skip_no

	lda #$ff-(_bpl-adScore)-1
	dta {bit*}
skip_no
	lda #$ff-(_bpl-noScore)-1

	sta _bpl+1

	bne sclp

adScore	lda:cmp:req frame

	NewScore #0 #5			; dodatkowe punkty za pozostaly czas

noScore	jsr rmt2.TimeUpdate

sclp	lda NMI.timer
_bpl	bpl adScore


skip	mva #$fe portb

	jmp GameEnd.TheEnd

end_delay dta @end_delay
.endl


	.print 'prg_end: ',*,'..',txture-40

	ert *>=txture-40, '> ',txture-40

//**********************************************************************

	org fntPnl
	ins 'panel/liczniki2.fnt',0,118*8


.local	dliHeroDeath

	sta sizep0+(pmHero3-$400)/$100

	sta sizem

	mva #$21 gtictl

	lda hposx
	jsr hpos

	lda #$14
c0	equ *-1
	sta colpm0
	sta colpm2

	lda #$18
c1	equ *-1
	sta colpm1
	sta colpm3

	jmp ldliHero


hpos	sub #5

	sta hposp0
	sta hposp1

	add #8
	sta hposp2
	sta hposp3

	adc #8
	sta hposm0
	sta hposm1

	adc #2
	sta hposm2
	sta hposm3

	rts

.endl

	ert *>fntPnl+$400,*

//**********************************************************************

	run main


* ---------------------------
* ---	MACRO definitions
* ---------------------------

	opt l-

@@INC	.macro
	tya
	adc #8
	tay
	.endm


.macro	dli_quit

	mva	<:1	NMI.vdli

	.if .hi(?old_dli)<>.hi(:1)
	mva	>:1	NMI.vdli+1
	.endif

	lda rA
	ldx rX
	rti

	.def	?old_dli
.endm


.macro	lhinv48
	.align

	.def linv48
	.rept 256
	ift #>scrhig*8
	dta l(invers+4)
	els
	dta l(invers+4+[#/8]*48)
	eif
	.endr

	.def hinv48
	.rept 256
	ift #>scrhig*8
	dta h(invers+4)
	els
	dta h(invers+4+[#/8]*48)
	eif
	.endr
.endm

	icl '@bank_add.mac'

