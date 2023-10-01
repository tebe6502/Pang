
;--- odczyt joya i przycisku

;	lda #0
;read_joy equ *-1
;	bne _skip


* ---------------------------
* ---	READ KEY VOLUME
* ---------------------------
.local	read_key_volume

	lda $d20f
	and #4
	bne dec_delay

	lda $d209
	and #%00111111				; odczyt klawisza tak¿e ze SHIFT-em

; --- escape

	ora NMI.vbltim

	cmp #$40				; kody klawiszy >=64 beda ignorowane
	bcs @key_esc.quit

	asl @
	sta jkey+1

jkey	jmp (KeyBind)


; ---	escape

.local	@key_esc

	lda #deathCode.esc_key
	sta GameEnd.reason

	lda #1
	sta objects				; wymuszamy koniec dzia³ania silnika
	sta active

quit	jmp read_key2joy

.endl


; --- sound ON/OFF

.local	@key_o

	cmp NMI.old_key
	beq dec_delay

	sta NMI.old_key

	mva #$ff on_off

	jmp read_key2joy
.endl


.local	@key_p

	cmp NMI.old_key
	beq dec_delay

	sta NMI.old_key

	mva #0 on_off
	jsr rmt2.RASTERMUSICTRACKER+9

	jmp read_key2joy
.endl


; --- space

.local	@key_space

	cmp NMI.old_key
	beq dec_delay

	sta NMI.old_key

	mwa #napis_pause LOOP.napisy

	sta wait_AND_blink.get_key		; wartoœæ <> od kodu SPACJI

	jmp read_key2joy
.endl

; --- sfx volume

.local	@key_v					; 'V' sfx volume UP

	cmp NMI.old_key
	beq dec_delay

	sta NMI.old_key

	lda sfx_vol
	cmp #$f0
	beq read_key2joy
	lda #$10
	bne _sfx

.endl

; ---

dec_delay
	dec NMI.key_delay
	bne read_key2joy

	lda #6
	sta NMI.key_delay
	sta NMI.old_key

	bne read_key2joy


.local	@key_b					; 'B' sfx volume DOWN

	cmp NMI.old_key
	beq dec_delay

	sta NMI.old_key

	lda sfx_vol
	beq read_key2joy
	lda #$f0

.endl


_sfx	add sfx_vol
	sta sfx_vol
	jmp read_key2joy


; --- msx volume

.local	@key_n					; 'N' msx volume UP

	cmp NMI.old_key
	beq dec_delay

	sta NMI.old_key

	lda msx_vol
	cmp #$f0
	beq read_key2joy
	lda #$10
	bne _msx

.endl


.local	@key_m

	cmp NMI.old_key
	beq dec_delay

	sta NMI.old_key

	lda msx_vol
	beq read_key2joy
	lda #$f0

.endl

_msx	add msx_vol
	sta msx_vol

	jmp read_key2joy


; ---	keys remaping -> joystik
; ---	SHIFT = FIRE

@key_a	lda #_left
	bne _joy

@key_d	lda #_right
	bne _joy

@key_w	lda #_up
	bne _joy

@key_s	lda #_down
	bne _joy

.endl


* ---------------------------
* ---	READ KEY
* ---------------------------
read_key2joy

	lda $d300
	and #$0f
	cmp #15
	bcs new_joy

_joy	cmp NMI.old_joy
	bne new_joy

	dec NMI.delay_joy
	bne _skip

new_joy	sta HERO.r_d300
	sta NMI.old_joy

	lda #delay_joy_default_value
	sta NMI.delay_joy

_skip	lda $d20f		; klawisz SHIFT = FIRE
	and #8
	beq _fire

	lda $d010
	bne skp

_fire	dec NMI.delay_trig
	bne wyjscie

	lda harp0.x
	sta HERO.r_d010

	lda #delay_trig_default_value
	sne

skp	lda #1

	sta NMI.delay_trig

wyjscie

* ---	RASTER MUSIC TRACKER

	lda NMI.playmusic
	and #$ff
on_off	equ *-1
	beq playmusicEnd

	lda #msx_default_volume
msx_vol	equ *-1
	sta rmt2.volslid+1

psfx	lda #0
	and #1
	asl @
	tax
	ldy NMI.sfx_stack,x
	bpl sfx

	inc psfx+1
	lda psfx+1
	and #1
	asl @
	tax
	ldy NMI.sfx_stack,x
	bmi sfx_skp

; STEREO
sfx	mva #$ff NMI.sfx_stack,x
	mva NMI.sfx_stack+1,x note
					; * 2
	sty fx				;Y = 2,4,..,16		instrument number * 2 (0,2,4,..,126)

	ldx #7				;X = 3			channel (0..3 or 0..7 for stereo module)

	lda #sfx_default_volume		;* sfx note volume*16
sfx_vol	equ *-1
	sta rmt2.trackn_volume,x

	lda #36				;A = 12			note (0..60)
note	equ *-1
	jsr rmt2.RASTERMUSICTRACKER+15	;RMT_SFX start tone (It works only if FEAT_SFX is enabled !!!)

; MONO
	ldy #0
fx	equ *-1

	ldx #3				;X = 3			channel (0..3 or 0..7 for stereo module)

	lda sfx_vol			;* sfx note volume*16
	sta rmt2.trackn_volume,x

	lda note			;A = 12			note (0..60)
	jsr rmt2.RASTERMUSICTRACKER+15	;RMT_SFX start tone (It works only if FEAT_SFX is enabled !!!)

sfx_skp	jsr rmt2.play

;	jsr rmt2.RASTERMUSICTRACKER+3	;1 play

	inc psfx+1

playmusicEnd


* ---	TIMER

	lda NMI.vbltim
	ora select
	bne VBLquit

	dec NMI.second
	bpl VBLquit

	mva #59 NMI.second

	jsr TimeUpdate

	lda NMI.timer
	bpl VBLquit

	lda #deathCode.no_time
	sta GameEnd.reason

	mwa #napis_timeout LOOP.napisy

VBLquit

	jmp NMI.bnkTmp


.local	TimeUpdate

	dec NMI.timer+2
	bpl tskp0

	mva #9 NMI.timer+2

	dec NMI.timer+1

tskp0	lda NMI.timer+1
	bpl tskp1

	mva #9 NMI.timer+1

	dec NMI.timer

tskp1	lda NMI.timer
	bpl tskp2

	rts

tskp2	;lda NMI.timer
	cmp #0
oldTim0	equ *-1
	beq skp0
	sta oldTim0

	ldy #31
	jsr Digit

skp0	lda NMI.timer+1
	cmp #0
oldTim1	equ *-1
	beq skp1
	sta oldTim1

	ldy #34
	jsr Digit

skp1	lda NMI.timer+2

	ldy #37
	jmp Digit

.endl


	.align

.array	keyBind	[64] .word = read_key2joy

	[key_esc]	= read_key_volume.@key_esc
	[key_space]	= read_key_volume.@key_space
	[key_v]		= read_key_volume.@key_v
	[key_b]		= read_key_volume.@key_b
	[key_n]		= read_key_volume.@key_n
	[key_m]		= read_key_volume.@key_m
	[key_o]		= read_key_volume.@key_o
	[key_p]		= read_key_volume.@key_p

	[key_a]		= read_key_volume.@key_a
	[key_d]		= read_key_volume.@key_d
	[key_w]		= read_key_volume.@key_w
	[key_s]		= read_key_volume.@key_s
.enda
