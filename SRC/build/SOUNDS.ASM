;;CHECK line 202 and 266 (audits and adj. stuff)
;;MUST FIX SOUND WATCHDOG - I COMMENTED IT OUT
******************************************************************************
*
* Owner:	JOHNSON
*
* Software:	Jeff Johnson/Dan Thompson
* Initiated:		
*
* Modified:	Shawn Liptak,  9/30/91	-High speed version (Total carnage)
* 		Shawn Liptak,  1/8/92	-Reserved 8 channels
* 		Shawn Liptak,  2/19/92	-Basketball (cleanup)
* 		Shawn Liptak,  10/2/92	-TUNIT mods
*		Jamie Rivett,		-NBA JAM
*		Jeff Johnson,  4/12/95	-NBA 3 support for DCS snd board
*		JBJ,DJT       11/16/95	-Make it work for NBA HANGTIME
*
* COPYRIGHT (C) 1992 WILLIAMS ELECTRONICS GAMES, INC.
*
*.Last mod - 11/16/95 18:30
******************************************************************************
	.file	"sounds.asm"
	.title	"sound processor"
	.width	132
	.option	b,d,l,t
	.mnolist


	.include	"mproc.equ"
	.include	"sys.equ"
	.include	"game.equ"
	.include	"macros.hdr"
	.include	"audit.equ"


;--------------------
; Globals defined elsewhere

	.ref	_soundirq_addr
	.ref	_coin_counter_addr
	.ref	_sound_addr
	.ref	_coin_addr

	.ref	GET_ADJ
	.ref	PUT_ADJ
	.ref	F_ADC_S

	.ref	GAMSTATE

	.ref	AUD1
	.ref	gmqrtr


;--------------------
; Globals defined here

	.def	SNDSND
;	.def	FADE_UP,FADE_DOWN,ALLOFF

	.def	organ_fx1_sc,organ_fx2_sc
	.def	crwd_blchrs_sc,crwd_goteam_sc,crwd_defnse_sc

;--------------------
; Constants

	.asg	6000,SNDBRD_RES_CNT	;Sound board reset-cycle delay cnt

send	.set	00001H			; script command --> send sound code
setpri	.set	00002H			; script command --> set priority
endtune	.set	00003H			; script command --> end of tune script
sleep	.set	00004H			; script command --> sleep next byte
send2	.set	00005H
ex	.set	08000H			; flag: extended sound call !!


;--------------------
; Channel ram table

	.bss	channel_ram,0

	BSSX	chan1pri,16		; sound channel 1 priority
	BSSX	chan1dur,16		; sound channel 1 duration (timer)
	BSSX	chan1snd,16		; sound channel 1 current sound

	BSSX	chan2pri,16		; sound channel 2 priority
	BSSX	chan2dur,16		; sound channel 2 duration (timer)
	BSSX	chan2snd,16		; sound channel 2 current sound

	BSSX	chan3pri,16		; sound channel 3 priority
	BSSX	chan3dur,16		; sound channel 3 duration (timer)
	BSSX	chan3snd,16		; sound channel 3 current sound

	BSSX	chan4pri,16		; sound channel 4 priority
	BSSX	chan4dur,16		; sound channel 4 duration (timer)
	BSSX	chan4snd,16		; sound channel 4 current sound

	BSSX	chan5pri,16		; sound channel 4 priority
	BSSX	chan5dur,16		; sound channel 4 duration (timer)
	BSSX	chan5snd,16		; sound channel 4 current sound

	BSSX	chan6pri,16		; sound channel 4 priority
	BSSX	chan6dur,16		; sound channel 4 duration (timer)
	BSSX	chan6snd,16		; sound channel 4 current sound

	.bss	script_que,(32+16)*50	;sound/speech calls que
	.bss	script_que_end,0

	.bss	script_cur,32
	.bss	script_nxt,32
	.bss	script_dly,16

	.bss	channel_ram_end,0

	.asg	chan1pri-channel_ram,CHANPRI	; priority offset
	.asg	chan1dur-channel_ram,CHANDUR	; duration offset
	.asg	chan1scp-channel_ram,CHANSCP	; script pointer offset
	.asg	chan1snd-channel_ram,CHANSND	; current sound offset
	.asg	chan2pri-channel_ram,CHANSIZ	; current sound offset


;--------------------
;

	BSSX	sound_rev,16
	BSSX	SOUNDSUP ,16		;!0=Sounds off

	BSSX	doing_dcs_reset,16

;;;;	.bss	SNDSTR,6*CHANSIZ	;RESERVE STORAGE AREA
;;;;	.bss	SNDEND,0		;END OF SOUND PROCESSOR RAM


	.text


;
; sounds
;
;   sound table ptr. name, priority:channel, duration, snd nbr.
 SX	select_snd1, 00201H,05, 0310H		;select option sound
 SX	select_snd2, 00202H,05, 0311H
 SX	select_snd3, 00203H,05, 0312H
 SX	select_snd4, 00204H,05, 0313H
 SX	cursor_snd1, 00101H,09, 030cH	;cursor movement
 SX	cursor_snd2, 00102H,09, 030dH	;
 SX	cursor_snd3, 00103H,09, 030eH	;
 SX	cursor_snd4, 00104H,09, 030fH	;
 SX	win_snd,     02504H,75, 0172H	;Winner snd/Suckup credits
 SX	bounce_snd,  00001H,27, 0260H	;Ball bounce
 SX	plaque_fall1,02501H,91, 01f6H
 SX	plaque_fall2,02502H,91, 01f7H
 SX	plaque_fall3,02503H,91, 01f8H
 SX	plaque_fall4,02504H,91, 01f9H
 SX	plaque_land1,02601H,99, 03a3H
 SX	plaque_land2,02602H,99, 03a4H
 SX	plaque_land3,02603H,99, 03a5H
 SX	plaque_land4,02604H,99, 03a6H
 SX	opt_scr_cur, 01501H,54, 01bdH	;option screen
 SX	opt_scr_sel, 01501H,30, 03fdH  ;397 (PUT ON TRACK 5)
 SX	combo_lock1, 01101H,45, 03fdH
 SX	combo_lock2, 01102H,45, 03feH
 SX	combo_lock3, 01103H,45, 03ffH
 SX	combo_lock4, 01104H,45, 0400H
 SX	adv_stats,   01001H,15, 0260H
 SX	coin_snd,    0ff04H,35, 0255H	;coin in melody snd
 SX	beep2_snd,   00001H,5,  0280H	;beep tone for diagnostics
 SX	cntdown_snd, 01505H,50, 020aH	;buyin cntdwn clang
 SX	horn_snd,    04001H,120,02fbH	;horn
 SX	atrib_snd1,  00101H,10, 03bbH
 SX	atrib_snd2,  00101H,10, 03bfH
 SX	atrib_snd3,  00101H,10, 03c3H
 SX	atrib_snd4,  00101H,10, 03c7H
 SX	atrib_snd5,  00101H,10, 03cbH
 SX	atrib_snd6,  00101H,10, 03cfH
 SX	atrib_snd7,  00101H,10, 03d3H
 SX	atrib_snd8,  00101H,10, 03d7H
 SX	atrib_snd9,  00101H,10, 03dbH
 SX	atrib_snd10, 00101H,10, 03dfH
 SX	yes_no_cur1, 01501H,15, 033bH
 SX	yes_no_cur2, 01502H,15, 033cH
 SX	yes_no_cur3, 01503H,15, 033dH
 SX	yes_no_cur4, 01504H,15, 033eH
 SX	yes_no_sel1, 01501H,20, 0268H
 SX	yes_no_sel2, 01502H,20, 0269H
 SX	yes_no_sel3, 01503H,20, 026aH
 SX	yes_no_sel4, 01504H,20, 026bH
 SX	butn_press,  00103H,15, 0399H
 SX	butn_press2, 00103H,15, 0399H
 SX	cursor_up,   00101H,10, 01bdH
 SX	cursor_dwn,  00101H,10, 01beH
 SX	cursor_lft,  00101H,10, 033bH
 SX	cursor_rgt,  00101H,10, 033bH
 SX	chkmrk0_snd, 00103H,20, 0371H
 SX	unchkmrk_snd,00103H,20, 0371H
 SX	chkmrk_snd,  01501H,20, 036fH
 SX	chkmrk_snd2, 01502H,20, 0370H
 SX	chkmrk_snd3, 01503H,20, 0371H
 SX	chkmrk_snd4, 01504H,20, 0372H
 SX	cursor_up2,  00101H,15, 033bH
 SX	cursor_dwn2, 00101H,15, 033bH
 SX	cursor_lft2, 00101H,25, 033bH
 SX	cursor_rgt2, 00101H,25, 033bH
 SX	cursor_up3,  00101H,25, 033bH
 SX	cursor_dwn3, 00101H,25, 033bH
 SX	whitsle_snd, 01504H,45, 02f3H
;DJT Start
 SX	homeaway_cur,00101H,20, 027cH
 SX	bx_slide_snd,00001H,28, 01f6H

 SX	diag_cursor, 00501H,20, 027cH
 SX	diag_select, 00501H,20, 0280H
 SX	update_adj,  00501H,18, 0278H
 SX	adj_menu_ext,00501H,20, 0280H
; SX	adj_menu_ent,00501H,27, 0280H
 SX	error_found, 00501H,20, 0260H	;367 ?

;DJT End
 SX	tm_sel_cur1, 01501H,36, 033bH
 SX	tm_sel_cur2, 01502H,36, 033cH
 SX	tm_sel_hd_l1,01501H,47, 032bH
 SX	tm_sel_hd_r1,01501H,47, 032bH
 SX	tm_sel_hd_l2,01502H,47, 032cH
 SX	tm_sel_hd_r2,01502H,47, 032cH
 SX	tm_sel_sel1, 03201H,65, 03fdH   ;397
 SX	tm_sel_sel2, 03202H,65, 03feH   ;398
 SX	tm_sel_ran1, 03001H,116,03f9H
 SX	tm_sel_ran2, 03002H,116,03faH
 SX	sel_rndmend1,03101H,45, 03a3H
 SX	sel_rndmend2,03102H,45, 03a4H
 SX	tm_sel_stats,00001H,27, 0260H
 SX	combo_but1,  01001H,32, 036bH
 SX	combo_but2,  01002H,32, 036cH
 SX	combo_but3,  01003H,32, 036dH
 SX	combo_but4,  01004H,32, 036eH
 SX	powrup_awrd1,02501H,45, 0222H
 SX	powrup_awrd2,02501H,45, 0222H	;no track two
 SX	powrup_awrd3,02503H,45, 0224H
 SX	powrup_awrd4,02504H,45, 0225H
 SX	tick_snd,    01504H,20, 01fdH
;DJT Start
 SX	warn_snd,    01504H,25, 0283H	;1fd
 SX	tfire_tcksnd,01504H,35, 0176H	;27f
 SX	tfire_outsnd,01504H,70, 0400H
;DJT End
 SX	alert_snd,   02704H,50, 015eH
 SX	ot_alert_snd,02504H,50, 03b6H
 SX	infoex_snd,  00501H,18, 0260H
 SX	sqk1_snd,    00103H,25, 08bH		;Sneaker squeek
 SX	sqk2_snd,    00103H,25, 08dH
 SX	sqk3_snd,    00103H,25, 090H
 SX	sqk4_snd,    00103H,25, 093H
 SX	sqk5_snd,    00103H,25, 097H
 SX	sqk6_snd,    00103H,25, 09aH
 SX	scuf1_snd,   00103H,25, 0b5H
 SX	scuf2_snd,   00103H,25, 0b6H
 SX	scuf3_snd,   00103H,25, 0b7H
 SX	scuf4_snd,   00103H,25, 0b8H

 SX	fball_snd,   01903H,104,02e2H
 SX	fpass_snd,   01903H,85, 0c9H	;fire ball pass sound
 SX	rim_fire_snd,0350BH,90, 0ccH
;DJT Start
 SX	netmush_snd, 03503H,80, 0ceH
 SX	aly_pass_snd,01903H,104,02e2H
 SX	aly_rcv_snd, 0200CH,20, 09bH
;DJT End

 SX	pass_snd,    01204H,20, 0bbH    	;147
; SX	pass_snd,    01201H,20, 0b9H    	;147
 SX	swipe_snd,   01401H,20, 0130H
 SX	elbow1_snd,  01601H,35, 0180H
 SX	elbow2_snd,  01601H,35, 0186H
 SX	push1_snd,   01101H,30, 0183H
 SX	flail_snd,   01501H,30, 0180H
 SX	fall1_snd,   01501H,26, 0183H
 SX	land_snd,    01401H,15, 0a2H    ;(a4-tr3)
 SX	yell_snd,    01201H,100,0198H

 SX	flsh1_snd,   00501H,19, 0177H
 SX	flsh3_snd,   00503H,19, 0179H
 SX	flsh4_snd,   00504H,19, 017aH
 SX	boo_snd,     01204H,179,01ddH	;e6
 SX	boo1_snd,    01204H,179,01ddH	;e6
 SX	tip_snd,     0200CH,23, 09eH	;19f	;9b
 SX	eat_snd,     08501H,10, 037bH	;**

 SX	organ1_snd,  00504H,75, 01a6H
 SX	organ2_snd,  00504H,60, 01a8H
 SX	organ3_snd,  00504H,50, 01aaH
 SX	organ8_snd,  00504H,135,01b4H
 SX	organ9_snd,  00504H,98, 01b6H
 SX	organ10_snd, 00504H,100,01b8H

 SX	car_pass_snd,01504H,90, 01c7H
 SX	siren_snd,   01504H,145,01c9H	;** TURN UP **
 SX	prop_ple_snd,01504H,100,020cH
 SX	chrch_bel_sp,01504H,140,0210H
 SX	car_pas2_snd,01504H,130,0212H
 SX	ambulne_snd, 01504H,120,0214H
 SX	ambulne2_snd,01504H,120,0216H
 SX	fire_trk_snd,01504H,120,0218H
; SX	train_snd,   01504H,145,021aH

 SX	crwd_blchrs, 01504H,182,01e5H	;ed
 SX	crwd_go_team,01504H,101,01f5H	;f4
 SX	crwd_defence,01504H,186,01e1H	;eb

 SX	swish_snd1,  0310BH,27, 083H	;regular net
 SX	swish_snd2,  0310BH,27, 084H
 SX	swish_snd3,  0310BH,27, 086H
 SX	swish_snd4,  0310BH,32, 0afH	;chain net (outdoor court)
 SX	swish_snd5,  0310BH,32, 0b0H
 SX	swish_snd6,  0310BH,32, 0afH

 SX	dunk_snd1,   0320BH,58, 066H
 SX	dunk_snd2,   0320BH,54, 066H
 SX	dunk_snd3,   0320BH,56, 066H
 SX	dunk_snd4,   0320BH,48, 06cH
 SX	dunk_snd5,   0320BH,53, 0adH	;outdoor court

 SX	spn_mv_snd,  01503H,30, 010fH

 SX	miss1_snd,   03103H,32, 074H
 SX	miss2_snd,   03103H,21, 075H
 SX	miss3_snd,   03103H,23, 077H
 SX	miss4_snd,   03103H,23, 077H
 SX	miss5_snd,   03103H,25, 0aeH	;outdoor court
 SX	missd1_snd,  03103H,77, 011fH

 SX	hitbkbd_snd, 01503H,20, 070H
 SX	hitbkbd2_snd,01503H,20, 082H	;outdoor court

 SX	stealsb,     0200CH,20, 09bH
 SX	swat_snd,    0200CH,20, 09bH	;a3	;slap ball sound
 SX	intercept,   03003H,33, 0169H ;16a
 SX	steal_snd,   03003H,33, 0169H ;16a	;flash ball sound

 SX     dribble_snd, 01003H,20, 06dH ;64
 SX     dribble2_snd,01004H,23, 0bfH
 SX     dribble3_snd,01003H,20, 06eH

 SX	trns1_snd,   00501H,29, 0130H
 SX	trns2_snd,   00502H,29, 0139H
 SX	trns3_snd,   00503H,29, 013eH
 SX	trns4_snd,   00504H,29, 0137H
 SX	trnd1_snd,   00601H,30, 0397H
 SX	trnd2_snd,   00602H,30, 0398H
 SX	trnd3_snd,   00603H,30, 0399H
 SX	trnd4_snd,   00604H,30, 039aH
 SX	untrns1_snd, 00901H,29, 0130H
 SX	untrns2_snd, 00902H,29, 0139H
 SX	untrns3_snd, 00903H,29, 013eH
 SX	untrns4_snd, 00904H,29, 0137H

 SX	robo_1_snd,  03401H,204, 0bb0H		;End wave snd
 SX	robo_2_snd,  03403H,109, 0ba2H		;Effect 1 - storm cloud on
 SX	robo_3_snd,  03401H,109, 0b90H		;flash ABA ball white
;DJT Start
 SX	hs_shot_snd, 01803H,50, 0b92H		;take a hotspot shot
; SX	hs_shot_snd, 01803H,50, 0b92H		;alternate? for hot hotspot
;DJT End

;dunk sounds
;DJT Start
 SX	helicptr_snd,01603H,90, 0a6H
;DJT End
 SX	jet4_snd,    01603H,70, 02f9H
 SX	jet1_snd,    01603H,80, 0108H
 SX	jet2_snd,    01603H,80, 0128H
 SX	jet3_snd,    01603H,80, 0126H
 SX	tarzan,      01603H,70, 0123H
;
;tunes
;
 SX	tm_fire_tune,00100H,100,25
 SX	buyin_tune,  00100H,100,11
 SX	pregame_tune,00100H,100,13 ;1
 SX	tunegc_snd,  00100H,100,3  	;Grand champion play tune
 SX	tuneq1_snd,  00100H,100,5
 SX	tuneq1ed_snd,00100H,100,51
 SX	tuneq2_snd,  00100H,100,14
 SX	tuneq2ed_snd,00100H,100,53
 SX	tuneq3_snd,  00100H,100,5
 SX	tuneq3ed_snd,00100H,100,51
 SX	tuneq4_snd,  00100H,100,14
 SX	tuneq4ed_snd,00100H,100,51
 SX	tuneot_snd,  00100H,100,5
 SX	tuneoted_snd,00100H,100,51

 SX	tune_wingame,00100H,100,24
 SX	tune_gmovr,  00100H,100,18
 SX	hangtime_snd,00100H,100,19

 SX	tunehalf_snd,00100H,100,39	;halftime tune
 SX	tune_cap_snd,00100H,100,7	;create-a-player tune
 SX	tuneend_snd, 00100H,100,0	;kill any tune


;
; scripts
;
organ_fx1_sc   LWLWLW   organ1_snd,75,organ2_snd,60,organ3_snd,-1
organ_fx2_sc   LWLWLW	organ8_snd,135,organ9_snd,98,organ10_snd,-1
crwd_blchrs_sc LW	crwd_blchrs,-1
crwd_goteam_sc LWLW	crwd_go_team,102,crwd_go_team,-1
crwd_defnse_sc LWLW	crwd_defence,102,crwd_defence,-1


;DJT Start
 .if 0		;not called!
;DJT End
******************************************************************************
*												*
* reset sound board										*
*												*
* this is a full reset, checksum dings and all. this is the same routine
* that was in the old (gspsnd) processor. (ed boon)
*
* NOTE: If any data are sent to the sound board within ~270msec of the
*       reset signal, diagnostics will be skipped and there won't be any
*       loud and annoying bongs.
*

 SUBR	snd_reset
	PUSH	a0,a1

	movi	SNDRSTBIT|32,a0
	move	@_coin_counter_addr,a1,L
	move	a0,*a1

	movi	SNDBRD_RES_CNT,a0		;Wait for it to catch
	dsjs	a0,$

	movi	32,a0
	move	@_coin_counter_addr,a1,L
	move	a0,*a1

	PULL	a0,a1
	rets
;DJT Start
 .endif ;0		;Not called!
;DJT End


;DJT Start
 .if 0		;Not called!
;DJT End
******************************************************************************
*
*
 SUBR	watch_snd_reset

	move	@_soundirq_addr,a8
wsr_1
 	SLEEPK	1

	move	*a8,a0
	btst	10,a0
	jrz	wsr_1			; done?
	LOCKUP
wsr_2
	SLEEPK	1

	move	*a8,a0
	btst	10,a0
	jrnz	wsr_2			; done?

	jruc	wsr_1
;DJT Start
 .endif ;0		;Not called!
;DJT End
 	

******************************************************************************
*
* Quiet sound board reset
*
* Just like snd_reset, but without the diagnostic tests and consequent chimes.
* It also sets the volume to the CMOS level.
* 
* NOTE: Don't CALLx this function, JSRP it.  It SLEEPs.
*
* Trashes everything except the reggies which get saved by default when
* you sleep...

 SUBR	QSNDRST

	movk	1,a14
	move	a14,@doing_dcs_reset

	movi	SNDRSTBIT|32,a0
	move	@_coin_counter_addr,a1,L
	move	a0,*a1

	movi	SNDBRD_RES_CNT,a0		;Wait for it to catch
	dsjs	a0,$

	movi	32,a0
	move	@_coin_counter_addr,a1,L
	move	a0,*a1

	SLEEPK	2
	move	@_sound_addr,a0,L
	movb	a14,*a0

	SLEEPK	4
;DJT Start
	clr	a14
	move	a14,@doing_dcs_reset

;DJT End
	movi	ADJVOLUME,a0
	calla	GET_ADJ

	BADCHK	a0,0,255,28			;reg, lo, hi, val if bad
	callr	set_volume			;Set master vol to CMOS level

	callr	clear_sound_ram

;DJT Start
;DJT moved doing_dcs_reset up a few lines
;DJT End
	RETP


******************************************************************************
* Sets the volume of the DCS.
* 0a0H=volume (0-255)
*
 SUBR	set_game_snd

	PUSH	a0

	movi	ADJVOLUME,a0
	calla	GET_ADJ

	BADCHK	a0,0,255,28			;reg, lo, hi, val if bad
	callr	set_volume			;Set master vol to CMOS level
	PULL	a0
 	rets

******************************************************************************
* PROCESS that quietly resets the sound board, then dies.  Useful when you
* don't feel like waiting for the reset to finish before you move on.

 SUBR	qsndrst_proc

;DJT Start
	JSRP	QSNDRST
	DIE
;DJT End


******************************************************************************
* Sets the volume of the DCS.
* 0a0H=volume (0-255)
*

 SUBR	set_volume

	PUSH	a0,a1,a3

	andi	0FFh,a0			;forces value into range
	movi	55AAh,a3
	callr	SNDSND
	
	move	a0,a3			; volume
	move	a0,a1
	not	a1			; sans volume
	sll	32-8,a1
	srl	32-8,a1
	sll	8,a3
	or	a1,a3			; a3 = [volume,sans volume]
	callr	SNDSND

	move	a0,a1
	movi	ADJVOLUME,a0
	calla	PUT_ADJ
	calla	F_ADC_S

	PULL	a0,a1,a3
	rets

;DJT Start
 .if 0		;not called!
;DJT End
******************************************************************************
* Sets the volume of the DCS (for attract mode).
* 0a0H=volume (0-255)
*

 SUBR	set_volume_for_amode
 	
	movi	ADJAVOLUME,a0
	calla	GET_ADJ
	BADCHK	a0,0,255,28		;reg, lo, hi, val if bad


 SUBR	set_volume_amode_diag

	PUSH	a0,a1,a3

	andi	0FFh,a0			;forces value into range
	movi	55AAh,a3
	callr	SNDSND
	
	move	a0,a3			; volume
	move	a0,a1
	not	a1			; sans volume
	sll	32-8,a1
	srl	32-8,a1
	sll	8,a3
	or	a1,a3			; a3 = [volume,sans volume]
	callr	SNDSND

	move	a0,a1
	movi	ADJAVOLUME,a0
	calla	PUT_ADJ
	calla	F_ADC_S

	PULL	a0,a1,a3
	rets
;DJT Start
 .endif ;0		;not called!
;DJT End


******************************************************************************
* Raw hardware sound call.
* 0a3H=sound code

 SUBR	SNDSND

	PUSH	a0,a1,a2,a3,a4
;DJT Start
;	move	@doing_dcs_reset,a0	;Still in a reset?
;	jrnz	sendx			; br=yes, don't do anything yet
;DJT End
	move	@SOUNDSUP,a0		; are we allowed ??
	jrnz	sendx			; no

	move	a3,a3			; is it a null call (negative)?
	jrn	sendx

	move	a3,a0
	sll	32-16,a3
	srl	32-8,a3			; a3 = high byte
*
* send high byte
*
	move	@_sound_addr,a4,L
	move	a3,*a4

;	movk	2,a2
	movk	5,a2
	dsj	a2,$			; time for signal to get through
 	callr	poll_sirq
*
* send low byte
*
	sll	32-8,a0
	srl	32-8,a0			; a3 = low byte
	move	@_sound_addr,a4,L
	move	a0,*a4

	callr	poll_sirq

sendx	PULL	a0,a1,a2,a3,a4
	rets


******************************************************************************
* Poll sound IRQ.  When IRQ goes high, sound board is ready for next call.
* Do timeout so sound board can't screw things up.

 SUBRP	poll_sirq

	movi	390/3,a4		; 180 micros max firq delay on snd board
poll3
	move	@_soundirq_addr,a1,L
	addi	(B_SIRQ-7),a1
	movb	*a1,a1
	jrn	poll9			; done?
	dsj	a4,poll3
poll9
	rets


	.asg	0,CHAN_PRI
	.asg	16,CHAN_DUR
	.asg	32,CHAN_SND

********************************
* Plays a sound once, overriding any current lower priority sound
* A0=* to sound data
* Trashes scratch

 SUBR	snd_play1ovrp
 SUBR	snd_play1ovr
 	rets

*******************************************************************************
* Plays a list of sounds
*
* A0=* to sound data
* Trashes scratch

 SUBR	script_play1

	PUSH	a1,a2,a3
;
;If the first sound call of script has a lower priority than the current sound
; playing..then don't que this script
;
	move	*a0,a2,L			;get first sound call ptr
	move	*a2,a1				;get priority:channel
	andi	7,a1				;get channel number
	sll	4,a1
	move	a1,a14
	add	a14,a14
	add	a14,a1
	addi	channel_ram,a1			;pt to ram to change

	move	*a1(CHAN_DUR),a14		;get time remaining
	jrz	scrpt				;br=channel clear...
	move	*a1(CHAN_PRI),a14		;priority:chnl of snd playing
	srl	8,a14				;get priority
	move	*a2,a1				;priority:chnl of script
	srl	8,a1				;get priority
	cmp	a1,a14
	jrge	spexit				;br=cant interupt snd

scrpt
	move	@script_cur,a1,L
	move	@script_nxt,a2,L
	jrnz	sp0
	movi	script_que,a14,L
	move	a14,a1	
	move	a14,a2	
	move	a1,@script_cur,L
	move	a2,@script_nxt,L
sp0
	move	a0,a3
	jruc	sp2
;will script fit in que ?
sp1
	cmpi	script_que_end,a2,L
	jrne	sp1a
	movi	script_que,a2,L
sp1a
	cmp	a2,a1
	jrne	sp2
	.if DEBUG
	LOCKUP
	.endif
	jruc	spexit
sp2
	addk	32,a3
	addi	48,a2
	move	*a3+,a14
	jrnn	sp1

	move	@script_nxt,a2,L

sp3
;copy script into que
	move	*a0+,a3,L
	jrn	dbsp1
	.if DEBUG
	LOCKUP
	.endif
	jruc	spexit
dbsp1
	move	a3,*a2+,L			;get sound call ptr

	.if DEBUG
	move	*a3,a14,W
	cmpi	0ff0AH,a14			;invalid priority:channel ?
	jrgt	dbsp2				;br=yep
	move	*a3(16),a14,W
	cmpi	314,a14				;invalid duration ?
	jrhs	dbsp2				;br=yep
	move	*a3(32),a14,W
	cmpi	0c00H,a14			;invalid sound call nbr. ?
	jrlo	dbsp3				;br=no
dbsp2
	LOCKUP
	jruc	spexit

dbsp3
	.endif
	move	*a0+,a14			;get delay (or end of script maker)			;get sound call ptr
	jrn	sp4
	move	a14,*a2+,W
	cmpi	script_que_end,a2,L
	jrne	sp3
	movi	script_que,a2,L
	jruc	sp3
sp4
	move	*a3(16),a14,W
	move	a14,*a2+,W
	cmpi	script_que_end,a2,L
	jrne	sp4a
	movi	script_que,a2,L
sp4a
	move	a2,@script_nxt,L
spexit
	PULL	a1,a2,a3
 	rets


*******************************************************************************
* Plays a sounds
*
* A0=* to sound data
* Trashes scratch

 SUBR	snd_play1

	PUSH	a0,a1,a2,a3,a4

	move	*a0+,a1			;get priority:channel
	move	*a0+,a2			;get snd duration
	move	*a0,a3			;get sound 

	move	a1,a4
	andi	7,a4			;get channel number

	cmpi	6,a4				;invalid priority:channel ?
	jrlt	valid				;br=yep
	.if DEBUG
	LOCKUP
	.endif
	jruc	done
valid
	sll	4,a4
	move	a4,a14
	add	a14,a14
	add	a14,a4
	addi	channel_ram,a4			;pt to ram to change

	move	*a4(CHAN_DUR),a14
	jrz	play_it
	move	*a4,a14				;get priority of snd playing
;	jrn	done				;br=cant interupt snd

	.if DEBUG
	cmpi	0ff0AH,a1			;invalid priority:channel ?
	jrgt	lckup				;br=yep
	cmpi	800,a2				;invalid duration ?
	jrhs	lckup				;br=yep
	cmpi	0c00H,a3				;invalid sound call nbr. ?
	jrlo	valok				;br=no
lckup
	LOCKUP
	jruc	done
valok
	.endif

	move	a1,a0
	srl	8,a0
	srl	8,a14
	cmp	a14,a0				;new snd have > priority ?
	jrlt	done				;br=no
	jrgt	play_it			;br=yep
	move	*a4,a14				;get priority of snd playing
	btst	3,a14				;is sound interuptable ?
	jrnz	done				;br=no
play_it
	move	a1,*a4+				;priority:channel
	move	a2,*a4+				;duration
	move	a3,*a4				;sound call number
 	callr	SNDSND
done
	PULL	a0,a1,a2,a3,a4
	rets


********************************
* Sound processor called every main loop (16 MSEC)
* Trashes scratch, A2-A3

 SUBR	snd_update

	move	@chan1dur,a0,W			; channel 1 timing down ?
	jrz	sup2				; nope....
	dec	a0				; yes, count this tick !!
	move	a0,@chan1dur,W			; update duration ram
sup2
	move	@chan2dur,a0,W			; channel 2 timing down ?
	jrz	sup3				; nope....
	dec	a0				; yes, count this tick !!
	move	a0,@chan2dur,W			; update duration ram
sup3
	move	@chan3dur,a0,W			; channel 3 timing down ?
	jrz	sup4				; nope....
	dec	a0				; yes, count this tick !!
	move	a0,@chan3dur,W			; update duration ram
sup4
	move	@chan4dur,a0,W			; channel 4 timing down ?
	jrz	sup5				; nope....
	dec	a0				; yes, count this tick !!
	move	a0,@chan4dur,W			; update duration ram
sup5
	move	@chan5dur,a0,W			; channel 5 timing down ?
	jrz	sup6				; nope....
	dec	a0				; yes, count this tick !!
	move	a0,@chan5dur,W			; update duration ram
sup6
	move	@chan6dur,a0,W			; channel 6 timing down ?
	jrz	sup7				; nope....
	dec	a0				; yes, count this tick !!
	move	a0,@chan6dur,W			; update duration ram
sup7
	move	@script_dly,a0,W
	jrz	sup7aa
	dec	a0
	move	a0,@script_dly,W		; update duration ram
	rets

sup7aa
     	move	@script_cur,a1,L
	move	@script_nxt,a2,L
	jrnz	sup7a
	movi	script_que,a14,L
	move	a14,@script_cur,L
	move	a14,@script_nxt,L
	rets
sup7a
	move	*a1,a0,L			;get script table ptr
	jrz	exit
	clr	a14
	move	a14,*a1+,L
	move	*a1+,a14       			;get sound table ptr
	move	a14,@script_dly
	callr	snd_play1

	cmpi	script_que_end,a1,L
	jrne	sup7b
	movi	script_que,a1,L
sup7b	
	move	a1,@script_cur,L
exit
	rets


******************************************************************************
*  nosounds
*
*  cancels all sound calls. zeros all priorities and stops all
*  currently running tunes.
*

 SUBR	nosounds

	PUSH	a0,a1
	clr	a3
	callr	SNDSND			; silence the music board

	callr	clear_sound_ram

	PULL	a0,a1
	rets


******************************************************************************
*
*

 SUBRP	clear_sound_ram

	clr	a0
	movi	channel_ram,a1
nos2
	move	a0,*a1+,W		; zero u out !!!
	cmpi	channel_ram_end,a1	; everyone cleared ??
	jrne	nos2			; nope, do more

;clear SCRIPT ram
	clr	a14
	move	a14,@script_que,L
	move	a14,@script_que+32,L
	move	a14,@script_que+64,L
	move	a14,@script_que+96,L
	move	a14,@script_que+128,L
	move	a14,@script_que+160,L

	movi	script_que,a14,L
	move	a14,@script_cur,L
	move	a14,@script_nxt,L
	rets


;**************************************************************************
;*                                                                        *
;* FADE_UP - PROCESS TO FADE THE SOUND UP				 *
;* A11 = FADE RATE							 *
;*                                                                        *
;**************************************************************************
;FADE_UP
;	MOVI	FADE_UP_TAB,A8
;	JRUC	FADER
;**************************************************************************
;*                                                                        *
;* FADE_DOWN - PROCESS TO FADE THE SOUND UP				 *
;* A11 = FADE RATE							 *
;*                                                                        *
;**************************************************************************
;FADE_DOWN
;	MOVI	FADE_DOWN_TAB,A8
;	JRUC	FADER
;
;FADER
;	MOVI	FADEPID,A0
;	CLR	A1
;	NOT	A1
;	CALLA	KILALL			;WASTE ANY OTHER FADERS
;FADE_LP
;	MOVE	*A8+,A0,L
;	JRZ	FADE_DONE
;	callr	snd_play1
;	SLOOPR	A11,FADE_LP
;FADE_DONE
;	DIE
;
;FADE_UP_TAB
;	.LONG	VOLUME0
;	.LONG	VOLUME1
;	.LONG	VOLUME2
;	.LONG	VOLUME3
;	.LONG	VOLUME4
;	.LONG	VOLUME5
;	.LONG	VOLUME6
;	.LONG	VOLUME7
;	.LONG	VOLUME8
;	.LONG	VOLUME9
;	.LONG	VOLUMEA
;	.LONG	VOLUMEB
;	.LONG	VOLUMEC
;	.LONG	VOLUMED
;	.LONG	VOLUMEE
;	.LONG	VOLUMEF
;	.LONG	0
;
;FADE_DOWN_TAB
;	.LONG	VOLUMEF
;	.LONG	VOLUMEE
;	.LONG	VOLUMED
;	.LONG	VOLUMEC
;	.LONG	VOLUMEB
;	.LONG	VOLUMEA
;	.LONG	VOLUME9
;	.LONG	VOLUME8
;	.LONG	VOLUME7
;	.LONG	VOLUME6
;	.LONG	VOLUME5
;	.LONG	VOLUME4
;	.LONG	VOLUME3
;	.LONG	VOLUME2
;	.LONG	VOLUME1
;	.LONG	VOLUME0
;	.LONG	0
;
;
;**************************************************************************
;* POPULAR SOUND CALLS
;
;*HIGH PRIORITY OFF CODES, NOTHING SHOULD BEAT THESE
;CVSDOFF		.WORD	0F0FFH|0800H,001H,08000H,0	;CVSD BACKGROUND LOOP OFF
;CVSDFOFF 	.WORD	0F0FFH|0800H,001H,08000H,0	;CVSD FOREGROUND LOOP OFF
;SOUNDOFF 	.WORD	0F0FFH|0800H,001H,08000H,0	;TURN SOUND SIDE OFF
;ALLOFF	 	.WORD	0F3FFH|0800H,001H,08000H,0	;MUSIC AND EFFECTS OFF
;MUSITOFF	.WORD	0F3FFH|0800H,001H,08040H,0	;MUSIC TRANSITION OFF
;
;VOLUME0	.WORD	0F3FEH,01H,0802FH,0
;VOLUME1	.WORD	0F3FEH,01H,0802EH,0
;VOLUME2	.WORD	0F3FEH,01H,0802DH,0
;VOLUME3	.WORD	0F3FEH,01H,0802CH,0
;VOLUME4	.WORD	0F3FEH,01H,0802BH,0
;VOLUME5	.WORD	0F3FEH,01H,0802AH,0
;VOLUME6	.WORD	0F3FEH,01H,08029H,0
;VOLUME7	.WORD	0F3FEH,01H,08028H,0
;VOLUME8	.WORD	0F3FEH,01H,08027H,0
;VOLUME9	.WORD	0F3FEH,01H,08026H,0
;VOLUMEA	.WORD	0F3FEH,01H,08025H,0
;VOLUMEB	.WORD	0F3FEH,01H,08024H,0
;VOLUMEC	.WORD	0F3FEH,01H,08023H,0
;VOLUMED	.WORD	0F3FEH,01H,08022H,0
;VOLUMEE	.WORD	0F3FEH,01H,08021H,0
;VOLUMEF	.WORD	0F3FEH,01H,08020H,0




******************************************************************************
* saves 16 bits in a3

;	.if DEBUG
;
; SUBRP	save_sound
;
;	PUSH	a1,a2
;
;	cmpi	EXTENDED_CODE,a3	;extended?
;	jreq	nosave
;
;	move	@slist_offset,a1
;	inc	a1
;	andi	31,a1
;	move	a1,@slist_offset
;	sll	4,a1		;*16
;	addi	sounds_list,a1
;	move	a3,*a1+		;save it
;
;	movi	0ffffh,a2
;	move	@slist_offset,a1
;	inc	a1
;	andi	31,a1
;	sll	4,a1		;*16
;	addi	sounds_list,a1
;	move	a2,*a1		;mark end of buffer
;
;nosave
;	PULL	a1,a2
;	rets
;
;	.endif

******************************************************************************

; SUBR	set_sound_rev
;
;
;	RETP


******************************************************************************
 SUBR	sound_watchdog

;;;;;;;;;;TEMP
	DIE
;;;;;;;;;;TEMP

;DJT Start
 .if 0		;not called!
;DJT End
	SLEEPK	1
	move	@SOUNDR,a0		;clear sound data available latch
	movi	0ffaah,a3		;Pull sound section interrupt
	move	a3,@SOUND		;Hit sound (LOW)
	SLEEPK	8
	movb	@SOUNDR,a3
	move	a3,@sound_rev		;determine snd board rev.
watchdog_loop
	SLEEP	60
	movi	0ffaah,a3		;Pull sound section interrupt
	move	a3,@SOUND		;Hit sound (LOW)
	movk	8,a14
	dsj	a14,$			;Slow it down a bit

	.if	0
	movi	390/3,a3		;180 micros max firq delay on snd board
lp1	movb	@SOUNDIRQ+B_SIRQ-7,a14
	jrn	ok1			;Done?
	dsj	a3,lp1
*		timed out, irq must be dead!
* ERROR 1
	movi	AUD_SNDERR1,a0		;log it
	calla	AUD1
	jruc	reset_board
	.endif

ok1
	move	@sound_rev,a0		;if old sound board software
	cmpi	05ah,a0			;then skip these two checks
	jrne	sound_watchdog
	SLEEPK	8			;approx 128 msec delay
	movb	@SOUNDIRQ+B_SDAV-7,a14
	jrn	ok2

*		sound data not available
* ERROR 2
	movi	AUD_SNDERR,a0		;log it
	calla	AUD1
	jruc	reset_board
ok2
	movb	@SOUNDR,a3
	cmpi	05ah,a3
	jreq	watchdog_loop

*		invalid read back value
* ERROR 3
	movi	AUD_SNDERR,a0		;log it
	calla	AUD1
reset_board

;	callr	QSNDRST			;quiet hardware sound board reset
	JSRP	QSNDRST

	SLEEP	90
	move	@gmqrtr,a0
	sll	5,a0
	addi	tune_t,a0
	move	*a0,a0,L
	calla	snd_play1ovr

	jruc	watchdog_loop


tune_t	.long	tuneq2_snd,tuneq2_snd,tuneq3_snd,tuneq4_snd,tuneot_snd
	.long	tuneot_snd,tuneot_snd,tuneot_snd,tuneot_snd
	.long	tuneot_snd,tuneot_snd,tuneot_snd,tuneot_snd
;DJT Start
 .endif ;0		;not called!
;DJT End


******************************************************************************

VOLDN	.equ	11
VOLUP	.equ	12

 SUBR	VOLBTN_PRESS

	;in diagnostics?
	move	@GAMSTATE,a0,W
	jrn	done2

	;already adjusting?
	movi	VOLADJ_PID,a0
	movi	0FFFFh,a1
	calla	EXISTP
	jrnz	done2

	;okay, adjust
	movi	VOLADJ_PID,a14
	move	a14,*a13(PROCID),W

;	move	@COINS,a0
	move	@_coin_addr,a0,L
	move	*a0,a0
	btst	VOLDN,a0
	jrz	voldn_loop
volup_loop
	;increment the volume
	movi	ADJVOLUME,a0
	calla	GET_ADJ
	BADCHK	a0,0,255,28		;reg, lo, hi, val if bad
	inc	a0
	cmpi	255,a0
	jrle	up_okay
	movi	255,a0
up_okay
	calla	set_volume
	SLEEPK	1

	;if the vol+ button is no longer down, die
;	move	@COINS,a0
	move	@_coin_addr,a0,L
	move	*a0,a0
	btst	VOLUP,a0
	jrnz	done2
	jruc	volup_loop

voldn_loop
	;decrement the volume
	movi	ADJVOLUME,a0
	calla	GET_ADJ
	BADCHK	a0,0,255,28		;reg, lo, hi, val if bad
	dec	a0
	jrnn	dn_okay
	clr	a0
dn_okay
	calla	set_volume
	SLEEPK	1

	;if the vol- button is no longer down, die
;	move	@COINS,a0
	move	@_coin_addr,a0,L
	move	*a0,a0
	btst	VOLDN,a0
	jrnz	done2
	jruc	voldn_loop
done2
	DIE

******************************************************************************
	.end
