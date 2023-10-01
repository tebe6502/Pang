
; The current TV line may be determined by reading the vertical counter (VCOUNT). This register gives the line count divided by 2.
; There are 262 lines per frame so VCOUNT runs from 0 to 130 (0 to 155 on the PAL system). The 0 point occurs near the end of vertical blank.
; Vertical blank (VBLANK) is the time during which the electron beam returns back to the top of the screen in preparation for the next frame.
; The ANTIC and GTIA do not do interlacing, so each frame is identical unless the program which is being executed changes the display.
; Vertical sync (VSYNC) occurs during the fourth through sixth lines of vertical blank (VCOUNT hex 7D through 7F).
; This tells the TV set where each frame starts. After VSYNC, there are 16 more lines of VBLANK for a total of 22 lines of VBLANK.
; The display list jump and wait instruction (to be described later) causes the display list graphics to start at the end of VBLANK.
; http://krap.pl/mirrorz/atari/homepage.ntlworld.com/kryten_droid/Atari/800XL/atari_hw/antic.htm

.proc	pause

	lda vcount
	cmp #$7d
	bne pause

	rts
.endm