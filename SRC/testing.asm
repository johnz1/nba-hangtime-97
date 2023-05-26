**************************************************************
*
* Owner:	TURMELL
*
* Software:		Shawn Liptak, Mark Turmell
* Initiated:		9/17/92
*
* Modified:		Shawn Liptak, 9/17/92	-Split from BB.asm
*
* COPYRIGHT (C) 1992 WILLIAMS ELECTRONICS GAMES, INC.
*
*.Last mod - 3/24/93 16:21
**************************************************************

	.file	"plyr.asm"
	.title	"basketball player code"
	.width	132
	.option	b,d,l,t
	.mnolist


	.include	"mproc.equ"		;Mproc equates
	.include	"disp.equ"		;Display proc equates
	.include	"gsp.equ"		;Gsp asm equates
	.include	"sys.equ"
	.include	"audit.equ"
	.include	"world.equ"		;Court-world defs
	.include	"game.equ"
	.include	"macros.hdr"		;Macros

	.include	"imgtbl.glo"
	.include	"imgtbl7.glo"
	.include	"credturb.glo"

	.asg		0,SEQT
	.include	"plyr.equ"


;sounds external

	.ref	tunehalf_snd
	.ref	brush20_ascii
	.ref	swat_snd,sqk1_snd,sqk2_snd,sqk3_snd,sqk4_snd
	.ref	airball_sp,sht_stunk_sp,misd_mile_sp,way_shrt_sp,misd_evry_sp
	.ref	scuf1_snd,scuf2_snd,scuf3_snd,scuf4_snd
	.ref	sqk5_snd,sqk6_snd,pass_snd,fpass_snd
	.ref	fball_snd,overtime_sp,rainbow_sp
	.ref	whitsle_snd,baddec_sp,tuneend_snd


;symbols externally defined

	.ref	print_string2b,kern_chars,mess_justify,mess_cursx,mess_cursy
	.ref	mess_cursx2
	.ref	shadow1,shadow2,shadow3,shadow4,shadow5,shadow6
	.ref	shadow7,shadow8,shadow9,shadow10,shadow11,shadow12
	.ref	shadow13,shadow14,shadow15,shadow16,shadow17,shadow18
	.ref	ballshad2,ballshad4,ballshad5,ballshad7

;!!AM!! external because of the split. def them in the second part.
    	.ref 	seekdirdist_obob128,seekdir_xyxy128,seekdirdist_obxz128
    	.ref 	plyr_headalign,plyr_startpass,plyr_airballsnd,plyr_referee
    	.ref 	plyr_setballxyz,plyr_showshotpercent,plyr_setshadow,plyr_tryrebound
    	.ref 	anipt_getsclxy,anipt2_getsclxy,make_ssp_ptrs,rndrng0



;	.ref	p1taps
;	.ref	fatality
;	.ref	seq_stopfire
	.ref	brick_count
	.ref	last_power
	.ref	qtr_purchased
	.ref	call_scores
	.ref	last_name_time
	.ref	bast18_ascii
	.ref	player1_data
	.ref	player2_data
	.ref	player3_data
	.ref	player4_data
	.if DRONES_2MORE
	.ref	player5_data
	.ref	player6_data
	.endif

	.ref	plyr_onfire
	.ref	pushed_speech

	.ref	grand_champs_screen
	.ref	show_hiscore

	.ref	rebound_delay
	.ref	def_play_reward,flash_reward,sinecos_get,slamming
	.ref	start_animate,pass_off,steals_off,idiot_box

	.ref	GET_ADJ
	.ref	HANGF_R_P,HANGF_W_P

	.ref	pass_to_speech
	.ref	shoots_speech
	.ref	shot_type,shot_percentage,shot_distance

	.ref	plyr_getattributes,snd_play1ovr

	.ref	scores,prt_top_scores
	.ref	score_add,score_showtvpanel2
	.ref	score_showtvpanel,tvpanelon
	.ref	gmqrtr
	.ref	clock_active
	.ref	crplate_ptr
	.ref	shot_clock,shotimer
	.ref	arw_on1plyr
	.ref	pushing_delay
	.ref	cntrs_delay
	.ref	game_time
	.ref	sc_proc
	.ref	stick_number
	.ref	doalert_snd
	.ref	flash_bigtxt

	.ref	player_data
	.ref	inc_player_stat
	.ref	stats_page,hint_page
	.ref	stats_page2
	.ref	rank_screen
;	.ref	result_screen
	.ref	save_player_records
	.ref	game_purchased
	.ref	team1,team2
	.ref	show_ot_msg,scr1

	.ref	winner_stays_on
	.ref	print_string_C2
	.ref	mess_objid
	.ref	setup_message
;	.ref	omlgmd_ascii

	.ref	pal_clean
	.ref	pal_getf,pal_set
	.ref	fade_down_half,fade_up_half

	.ref	SCRTST
	.ref	IRQSKYE
	.ref	PCNT
	.ref	GAMSTATE,HALT
	.ref	gndx
	.ref	AUD,AUD1,GET_AUD,STORE_AUDIT
	.ref	PSTATUS2
	.ref	RNDPER
	.ref	game_over
	.ref	TWOPLAYERS

	.ref	scalebaby_t,scalehead_t,scalebighead_t,scalehugehead_t
	.ref	scale63_t,scale66_t

	.ref	ball_convfmprel
	.ref	ballobj_p
	.ref	ballpnum,ballpnumlast,ballpnumshot,ballfree
	.ref	my_ballpnumlast
	.ref	ballrimhitcnt,ballbbhitcnt
	.ref	ballpasstime
	.ref	ballscorezhit
	.ref	ballptsforshot
	.ref	ballprcv_p
	.ref	ballgoaltcnt
	.ref	ballsclastp
	.ref	ballshotinair		;Shooter  if shot in air, else -1
	.ref	inbound
	.ref	ballflash
	.ref	t1dunkcnt
	.ref	plyr_setptsdown

	.ref	halftime_showclips

;	.ref	plyr_smoketrail

	.ref	drone_main,drone_adjskill
;	.ref	drone2on
	.ref	w3run1
	.ref	w3stand1,w4stand1,w5stand1

	.ref	_switch_addr
	.ref	_switch2_addr

	.ref	SHOTPER
	.ref	scale_t_size
	.ref	hangfnt38_ascii
	.ref	mess_line_spacing
	.ref	aly_pass_snd
	.ref	swith_hnd_sp,spn_shtup_sp
	.ref	dronesmrt
;symbols defined in this file


;uninitialized ram definitions
	BSSX	reduce_3ptr,16
	BSSX	kp_scores	,32
	BSSX	kp_team1	,16
	BSSX	kp_team2	,16

	BSSX	pleasewt	,16
	BSSX	PSTATUS		,16	;Player in game bits (0-3)
					;/Must be in order!
	BSSX	P1CTRL		,16	;P1 joy/but bits (0-3=UDLR, 4-6=B1-B3)
	BSSX	P2CTRL		,16	;P2 (^ 8-14 are on for a on transition
	BSSX	P3CTRL		,16	;P3 of 0-6)
	BSSX	P4CTRL		,16	;P4
	.if DRONES_2MORE
	BSSX	P5CTRL		,16	;P5
	BSSX	P6CTRL		,16	;P6
	.endif

	BSSX	P1DATA		,PDSIZE	;Player 1 data
	BSSX	P2DATA		,PDSIZE	;P2
	BSSX	P3DATA		,PDSIZE	;P3
	BSSX	P4DATA		,PDSIZE	;P4
	.if DRONES_2MORE
	BSSX	P5DATA		,PDSIZE	;D5	;always a drone
	BSSX	P6DATA		,PDSIZE	;D6	;always a drone
	.endif

	.bss	pld		,PLDSZ*NUMPLYRS	;Plyr secondary data
	BSSX	plyrobj_t	,32*NUMPLYRS	;*player obj
	BSSX	plyrproc_t	,32*NUMPLYRS	;*player process

	BSSX	plyrcharge	,16	;!0=Dunker rammed an opponent
	BSSX	plyrpasstype	,16	;!0=Turbo pass
	BSSX	plyrairballoff	,16	;!0=No airball sound

	.bss	plyrinautorbnd	,16	;!0=A plyr is in auto rebound
;	.bss	drnzzcnt	,16	;Drone zigzag mode cntdn
;	.bss	drnzzmode	,16	;Drone zigzag mode (0-?)

	BSSX	plyrpals_t 	,256*16*NUMPLYRS ;Assembled palette for each plyr
	BSSX	assist_delay	,16
	BSSX	assist_plyr	,16
	BSSX	kp_qscrs	,(2*16)*7   ;Keep scores during game play
	BSSX	kp_qscrs2	,(2*16)*7   ;Keep scores for attract mode
;
;Ram for secret power-ups (if add any, also add to 'clear_secret_powerup_ram')
;
	BSSX	pup_lockcombo	,16	;Flag for locking power-up combos

	BSSX	pup_bighead	,16	;Bit 0-3 on = plyr 0-3 has big head
	BSSX	pup_hugehead	,16	;Bit 0-3 on = plyr 0-3 has huge head
	BSSX	pup_showshotper	,16
	BSSX	pup_notag	,16	;Bit 0-3 on = dont show plyr 0-3 arrow
	BSSX	pup_nodrift	,16	;Bit 0-3 on = no drift for block jumps
	BSSX	pup_noassistance,16	;1=turn help off
	BSSX	pup_aba		,16	;0=regular ball, !0=ABA ball
	BSSX	pup_court	,16	;0=indoor, !0=outdoor
	BSSX	pup_showhotspots,16	;Bit 0-3 on = show plyr 0-3 hotspots

	BSSX	pup_tournament	,16	;*4

	BSSX	pup_baby	,16	;Flag for baby size mode
	BSSX	pup_nomusic	,16	;Flag for no game-time music
	BSSX	pup_goaltend	,16	;Bit 0-3 on = plyr 0-3 has powerup g.t.
	BSSX	pup_maxblock	,16	;Bit 0-3 on = plyr 0-3 has stl power
	BSSX	pup_maxsteal	,16	;Bit 0-3 on = plyr 0-3 has stl power
	BSSX	pup_maxpower	,16	;Powerup power - can't be pushed down
	BSSX	pup_maxspeed	,16	;Bit 0-3 on = plyr 0-3 max runing speed
	BSSX	pup_hypspeed	,16	;Bit 0-3 on = plyr 0-3 max runing speed
	BSSX	pup_trbstealth	,16	;Bit 0-3 on = plyr 0-3 shoes dont change color
	BSSX	pup_trbinfinite	,16	;Bit 0-3 on = plyr 0-3 always has turbo
	BSSX	pup_nopush	,16	;Bit 0-3 on = plyr 0-3 can't push
	BSSX	pup_fastpass	,16	;Bit 0-3 on = plyr 0-3 has fast passing

	BSSX	pup_strongmen	,16	;Grnd champ flag 0,1 or 2 for team 

;For moving during inbound!
;	.bss	inbound_lead	,16	;Leading inbound pass flag
	.bss	drone_attempt	,16	;Alley oop jump up attempts
;	BSSX	drone_alley_cnt	,16	;3 successful drone alley oops/period


;equates for this file

;DJT Start
	.asg	15,HOTSPOTX_RNG
	.asg	22,HOTSPOTZ_RNG

;DJT End
IBX_INB		.equ	345
IBZ_INB		.equ	CZMID+10
IBX_OOB		.equ	415
IBZ_OOB		.equ	CZMID-15
IBX_CRT		.equ	395
IBZ_CRT		.equ	CZMID-15

IBX_DEF		.equ	230
IBZ_DEF1	.equ	CZMID-50
IBZ_DEF2	.equ	CZMID+70

	.text

;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
 SUBR	clear_secret_powerup_ram

	clr	a0
	move	a0,@pup_lockcombo
	move	a0,@pup_bighead
	move	a0,@pup_hugehead
	move	a0,@pup_showshotper
;DJT Start
	move	a0,@pup_showhotspots
;DJT End

	move	a0,@pup_nomusic

 SUBR	clear_secret_powerup_tmode

	clr	a0
	move	a0,@pup_notag
	move	a0,@pup_nodrift
	move	a0,@pup_noassistance

	move	a0,@pup_baby
	move	a0,@pup_goaltend
	move	a0,@pup_maxblock
	move	a0,@pup_maxsteal
	move	a0,@pup_maxpower
	move	a0,@pup_maxspeed
	move	a0,@pup_hypspeed
	move	a0,@pup_trbstealth
	move	a0,@pup_trbinfinite
	move	a0,@pup_nopush
	move	a0,@pup_fastpass

;DJT Start
;DJT made showhotspots work in tourney-mode
;DJT End
	move	a0,@pup_strongmen
 	rets

;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
;	.if DRONES_2MORE
; SUBR	add_drone_to_each_team
;;
;; First add a drone to team 1
;;
;	move	@PSTATUS2,a1
;	ori	4,a1			;Set bit
;	move	a1,@PSTATUS
;
;	move	@PSTATUS2,a1
;	ori	4,a1			;Set bit saying this guy has started
;	move	a1,@PSTATUS2		;and 50 cent buyin has happened!
;
;;
;; Now add a drone to team 2
;;
;	move	@PSTATUS2,a1
;	ori	5,a1			;Set bit
;	move	a1,@PSTATUS
;
;	move	@PSTATUS2,a1
;	ori	5,a1			;Set bit saying this guy has started
;	move	a1,@PSTATUS2		;and 50 cent buyin has happened!
;	rets
;	.endif


********************************
* Start player processes

 SUBR	plyr_start

;	movk	1,a0
;	move	a0,@0fff80000H,L

	callr	joy_read2

	clr	a0
	move	a0,@plyrinautorbnd
	move	a0,@plyrcharge
	move	a0,@plyrairballoff
;	move	a0,@pup_maxsteal
;DJT Start
;	move	a0,@pup_strongmen			;Grand champion playing flag

;	movk	1,a2
	clr	a3
	move	@player1_data+PR_TEAMSDEF,a0,L
	cmpi	ALL_TMS_DEFEATD,a0
	jreq	set1
	move	@player2_data+PR_TEAMSDEF,a0,L
	cmpi	ALL_TMS_DEFEATD,a0
	jrne	ck1
set1
	addk	1,a3
ck1
	move	@player3_data+PR_TEAMSDEF,a0,L
	cmpi	ALL_TMS_DEFEATD,a0
	jreq	set2
	move	@player4_data+PR_TEAMSDEF,a0,L
	cmpi	ALL_TMS_DEFEATD,a0
	jrne	easy0
set2
	addk	2,a3
easy0
	move	a3,@pup_strongmen			;Grand champion playing flag

;	jruc	easy

nea
;DJT End

;	clr	a2
;	movk	ADJDIFF,a0		;Get difficulty level
;	calla	GET_ADJ
;;Which drone code do we use?
;;Level 1 uses old, above uses new shit...
;	subk	1,a0			;3
;	jrle	regdrn
;	movk	1,a2
;regdrn
;	move	@PSTATUS2,a0
;	cmpi	1,a0
;	jrz	hard
;	cmpi	2,a0
;	jrz	hard
;	cmpi	4,a0
;	jrz	hard
;	cmpi	8,a0
;	jrnz	easy
;hard
;	movi	200,a0
;	calla	RNDPER
;	jrhi	easy
;	movk	1,a2			;Give hard drones 70% of time
;
;easy	move	a2,@drone2on



;	move	@pup_bighead,a0
;	zext	a0
;	cmpi	0eaeaH,a0
;	jrnz	no_3d
;	movk	0fH,a2
;	move	a2,@pup_maxsteal
;	jruc	adjoff
;no_3d

	movk	ADJHEADSZ,a0		;Get head size
	calla	GET_ADJ			;1-2
	subk	1,a0
	jrle	adjoff			;No big heads?
	move	@pup_bighead,a2
	movk	0fH,a14
	xor	a14,a2
	move	a2,@pup_bighead
;	clr	a2
;	move	a2,@pup_hugehead
adjoff

	.if  DEBUG
	move	@QUICK_TIP,a14
	jrz	refon
	clr	a0
	callr	plyr_setac
	jruc	refoff
refon
	CREATE0	plyr_referee
refoff
	.else
	CREATE0	plyr_referee
	.endif

	movi	plyrproc_t+32*NUMPLYRS,a2	;Set ptrs & cnt to make plyrs
	movi	plyrobj_t+32*(NUMPLYRS-1),a9
	movk	NUMPLYRS-1,a8			;-1 to fall thru for last one
strtp1
	CREATE0	plyr_main
	move	a0,-*a2,L		;Save *proc
	subk	32,a9
	dsj	a8,strtp1

	move	a13,-*a2,L
;	jruc	plyr_main		;0


********************************
* Main player control code (Process)
* A8=Plyr  (0-3)
* A9=*plyrobj_t for plyr 
* A13=*PDATA for plyr 


 SUBR	plyr_main

	move	a13,a1			;0CHlr PDATA & PSDATA areas
	addi	PDATA,a1
	movi	(PRCSIZ-PDATA)/16,a2
	clr	a0
clrpd	move	a0,*a1+
	dsj	a2,clrpd

;	.ref	inmatchup
;	move	@inmatchup,a0
;	jrnz	nohdcng		;br=no powerups on matchup screen
;
;	move	a8,a0			;Chk powerup seqs
;	sll	4,a0
;	addi	P1CTRL,a0
;	move	*a0,a0
;	sll	32-7,a0			;Mask to just stick & 3 buttons
;	srl	32-7,a0

;	cmpi	BUT1_M|JOYD_M,a0	;Shoot, Down
;	jrne	nostl
;	move	a8,a0
;	sll	4,a0
;	addi	p1taps,a0
;	move	*a0,a0
;	cmpi	5,a0			;At least 5 taps?
;	jrlt	nostl
;	move	@pup_maxsteal,a0		;Powerup intercepts (Quick hands)
;	movk	1,a14
;	sll	a8,a14
;	xor	a14,a0			;Flip bit
;	move	a0,@pup_maxsteal
;nostl
;	cmpi	BUT3_M|BUT2_M|JOYU_M,a0	;Turbo, Pass, Up
;	jrne	nohdcng
;	move	@pup_bighead,a0		;Headsize override
;	movk	1,a14
;	sll	a8,a14
;	xor	a14,a0			;Flip bit
;	move	a0,@pup_bighead

nohdcng
	movi	-1,a1
	move	a1,*a13(plyr_newdir)
	movk	1,a0
	move	a0,*a13(plyr_shtbutn)

	movk	30,a0
	move	a0,*a13(plyr_turndelay)

	move	a8,*a13(plyr_num)
	move	a8,a11

	movk	1,a7
	xor	a8,a7
	sll	5,a7			;*32
	addi	plyrproc_t,a7
	move	*a7,a7,L
	move	a7,*a13(plyr_tmproc_p),L

	movi	P2DATA-P1DATA,a7,W
	mpyu	a8,a7
	addi	P1DATA,a7
	move	a7,*a13(plyr_PDATA_p),L

	calla	plyr_getattributes	;Set attribute_p
					;A10=*Uniform attr (ignores spechds)
;----------
; setup tip-off img

;	move	@inmatchup,a0
;	jrz	nmtch_1
;	movk	1,a14
;	move	a14,*a13(plyr_nojoy)
;	move	a14,*a13(plyr_autoctrl)
;
;	movi	pm1-pmatch_t,a7,W	;set ptr to tip-off init table for
;	mpyu	a8,a7			; this plyr
;	addi	pmatch_t,a7
;	jruc	mtch_2
;nmtch_1

	movi	pd1-pdat_t,a7,W	;set ptr to tip-off init table for
	mpyu	a8,a7			; this plyr
	addi	pdat_t,a7

mtch_2
	move	*a7+,a0			;Plyr PID
	move	a0,*a13(PROCID)
	move	*a7+,a1			;Dir
	move	a1,*a13(plyr_dir)
	move	*a7+,a0			;X offset
	move	@WORLDTLX+16,a1
	add	a1,a0

;LOOK!!!
	move	@gmqrtr,a3		;if not 1st qrtr, push them all over
	jrz	not2			; to the rgt side inbound
	addi	400,a0			;!!!
not2
	sll	16,a0			;X
	clr	a1			;Y
	move	*a7+,a3			;Z
	move	*a7,a2,L		;OIMG
	movi	DMAWNZ|M_3D,a4
;	cmpi	1,a8
;	jrnz	qkfix2
;	movi	DMAWNZ|M_3D|M_FLIPH,a4
;qkfix2
	movi	CLSPLYR|TYPPLYR,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,*a9,L		;Save *obj

	movi	scale63_t,a0		;Temp size
	move	a0,*a8(ODATA_p),L

	SLEEPK	2			;Wait for other plyrs init

;----------
; set up player attribute

	move	a10,a6			;A10=*Uniform attr (ignores spechds)

	move	*a13(plyr_attrib_p),a7,L
	move	*a7,a0,L		;*scale_t
	move	a0,*a8(ODATA_p),L
	move	*a7(PAT_BVEL),a0	;speed
	move	a0,*a13(plyr_bvel)
;DJT Start

	move	*a7(PAT_HOTSPOT),a0	;Hotspot
	sll	    5,a0
	addi	hotspot_xz_t,a0,L
	move	*a0+,a14
	cmpi	NUMPLYRS/2,a11			
	jrlt	hs_px
	subi	WRLDMID,a14
	neg	a14
	addi	WRLDMID,a14
hs_px
	move	a14,*a13(plyr_hotspotx)
	move	*a0,a14
	move	a14,*a13(plyr_hotspotz)
;
; see if & how we might want to screw with PAT_SKILL
;
	move	@PSTATUS2,a1

	movk	1100b,a2		;Team2 wants to
	movk	0011b,a3		; chk team1
	cmpi	2,a11
	jrhs	chktm
	movk	0011b,a2		;Team1 wants to
	movk	1100b,a3		; chk team2
chktm
	clr	    a0			;Drone skill if human or human tm
	and	    a1,a2
	jrnz	setskl			; br=is human or human tm

	move	*a7(PAT_SKILL),a0	;Drone skill if drone team
	and	    a1,a3
	jrz	    setskl			; br=other team is also all drones!

	clr	    a2
	clr	    a3
	clr	    a4

	movk	2,a14
	xor	    a11,a14
	btst	a14,a1
	jrz	attri_noth1
	sll	    5,a14
	addi	player_data,a14
	move	*a14,a14,L
	move	*a14(PR_COUNT),a5	;- if no entry
	or	    a5,a2			;<No effect on N bit!
	jrn	    attri_noth1
	move	*a14(PR_NUMDEF),a5	; teams defeated (0 to 29)
	add	    a5,a3
	move	*a14(PR_WINSTREAK),a5	;Winning streak (0 to ??)
	add	    a5,a4
attri_noth1
	movk	3,a14
	xor	    a11,a14
	btst	a14,a1
	jrz	    attri_noth2
	sll	    5,a14
	addi	player_data,a14
	move	*a14,a14,L
	move	*a14(PR_COUNT),a5	;- if no entry
	or	    a5,a2			;<No effect on N bit!
	jrn	    attri_noth2
	move	*a14(PR_NUMDEF),a5	; teams defeated (0 to 29)
	add	    a5,a3
	move	*a14(PR_WINSTREAK),a5	;Winning streak (0 to ??)
	add	    a5,a4
attri_noth2
	move	a2,a2
	jrn	    attri_notboth		; br=not both human opponents
	srl	    1,a3			;Avg the defeated/streaks totals
	srl	    1,a4
attri_notboth
	srl	    1,a3			;!!! Process  teams defeated
	subk	5,a3			;!!!

;	srl	1,a4			;!!! Process winning streak
	cmpi	16,a4	;10		;!!!
	jrls	anotmax			;!!!
	movk	16,a4			;!!!
anotmax
	add	a3,a0			;Factor results into drone skill
	add	a4,a0
setskl
	move	a0,*a13(plyr_d_skill)
;DJT End

;----------
; check for conflicting team pals
;
; dont check for conflicting pals when a created palyer
;
	move	a11,a14				;player number
	sll	    5,a14
	addi	player_data,a14
	move	*a14,a14,L
	move	*a14(PR_CREATED_PLYR),a3
	jrle	t1a				;br=not a created player
	move	*a14(PR_UNIFORM_NBR),a3
	btst	6,a3
	jrnz	altc				;br=home team pal.
	jruc	keepc
t1a
	movi	team1,a14
	move	*a14+,a3		;get team 's & determine which one
	move	*a14,a4			; we are now
	btst	1,a11
	jrz	    t1b
	SWAP	a3,a4
t1b
	sll	3,a3
	sll	3,a4
	addi	teampal_t,a3
	addi	teampal_t,a4
	movb	*a3,a3
	jrn	keepc			;I always keep? yes if neg
	movb	*a4,a4
	move	a4,a14
	sll	32-4,a3
	sll	32-4,a14
	cmp	a3,a14
	jrne	keepc			;Different colors?
	move	a4,a4
	jrn	altc			;Other team always keeps?
	btst	1,a11
	jrnz	keepc			;2nd team?
altc	addk	32,a6			;use alternates
keepc

;----------
; Build plyr palette

	move	a11,a2
	sll	8+4,a2
	addi	plyrpals_t,a2
	PUSH	a2

;	movi	255,a0
	movi	128,a0
	move	a0,*a2+			;Set  colors

	.ref	SHT11			;MK SPECIAL FLAG
	move	*a7(PAT_SHOTSKILL),a1	;Check for special pals
	cmpi	SHT11,a1
	jrne	reg1		;Stay with defined pals if !=
	move	a7,a6
reg1

	move	*a7(PAT_PALF_p),a1,L	;Copy flesh
;	.ref	NFL55_p
;	movi	NFL55_p,a1

	move	*a1+,a0
;	addk	16,a1
;	subk	1,a0
plflp	move	*a1+,*a2+
	dsjs	a0,plflp


	move	*a6(PAT_PALT_p),a1,L	;Copy trim
;	.ref	TR2_p
;	movi	TR2_p,a1

	move	*a1+,a0
	addk	16,a1
	subk	1,a0 
pltlp	move	*a1+,*a2+
	dsjs	a0,pltlp


	move	*a6(PAT_PALU_p),a1,L	;Copy uniform
	move	*a1+,a0
	addk	16,a1
	subk	1,a0 
plulp	move	*a1+,*a2+
	dsjs	a0,plulp


	movi	ltshoepal_t,a1		;Copy shoes
	movk	13,a0
plslp	move	*a1+,*a2+
	dsjs	a0,plslp


	move	*a6(PAT_PALSW_p),a1,L	;Copy trim
;	.ref	SW2_p
;	movi	SW2_p,a1

	move	*a1+,a0
	addk	16,a1
	subk	1,a0
pltlpa	move	*a1+,*a2+
	dsjs	a0,pltlpa


	move	*a6(PAT_PALVP_p),a1,L	;Copy trim
;	.ref	VP2_p
;	movi	VP2_p,a1

	move	*a1+,a0
	addk	16,a1
	subk	1,a0
pltlpb	move	*a1+,*a2+
	dsjs	a0,pltlpb

;
;;Use this color to flash player white
;	movi	31<<10+31<<5+31,a0	;White
;	move	a0,*a2+
;
;;Use this color to flash player black
;	clr	a0			;Black
;	move	a0,*a2+

	PULL	a0
	calla	pal_getf
	move	a0,*a8(OPAL)

;----------
; Get head

	PUSH	a8			;save plyr *obj

	clr	a0
	clr	a1
	move	*a7(PAT_HEADT_p),a2,L
	addi	5*32,a2			;POINT at 6th head (straight ahead)
	move	*a2,a2,L

	movi	CZMID,a3
	movi	DMAWNZ|M_3D|M_NOCOLL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2

;If Rodman, change hair color according to player choice!
	move	*a13(plyr_num),a14
	srl	1,a14
	move	*a8(OIMG),a2,L
	move	*a2(ICMAP),a0,L		;Get *palette
	.ref	check_rodman2
	calla	check_rodman2
	calla	pal_getf
	move	a0,*a8(OPAL),L		;Set palette & constant

	move	a8,*a13(plyr_headobj_p),L

;----------
; setup head size

	movi	scalebighead_t,a0,L	;assume big
	move	*a13(plyr_num),a1

	move	@pup_bighead,a2
	btst	a1,a2
	jrnz	chkhd

	move	a1,a3			;plyr  to chk
	movk	2,a2			;privilege bit to chk
	move	@PSTATUS2,a14
	btst	a1,a14
	jrnz	ndrnh				;br=human
	move	*a13(plyr_tmproc_p),a3,L
	move	*a3(plyr_num),a3	;plyr  to chk
	movk	4,a2			;privilege bit to chk
ndrnh
	sll	5,a3
	addi	player_data,a3,L
	move	*a3,a3,L
	move	*a3(PR_PRIVILEGES),a3
	jrle	reghd			; br=not a created player
	btst	a2,a3			;BIG HEAD privilege?
	jrnz	sethd			; br=yes
reghd
	movi	scalehead_t,a0,L	;set default *scale_t
chkhd
	move	@pup_hugehead,a2
	btst	a1,a2
	jrz	sethd
	movi	scalehugehead_t,a0,L	;really big!
sethd
	move	a0,*a8(ODATA_p),L

	move	*a13(plyr_num),a1
	sll	5,a1
	addi	player_data,a1,L
	move	*a1,a1,L
	move	*a1(PR_PRIVILEGES),a1
	jrle	nsmrt			; br=not a created player
	btst	6,a1			;smarter drone ?
	jrz	nsmrt			;br=no
	
	move	@dronesmrt,a0
	move	*a13(plyr_num),a1
	movk	1,a14
	xor	a14,a1
	movk	1,a14
	sll	a1,a14
	or	a14,a0
	move	a0,@dronesmrt
nsmrt	


;----------
; Get shadow

	clr	a0
	clr	a1
	movi	shadow1,a2
	move	*a8(OZPOS),a3
	subi	50,a3				;stupid K!!!
	movi	DMAWNZ|M_3D|M_SHAD|M_NOCOLL,a4
	calla	BEGINOBJ2
	move	a8,*a13(plyr_shadobj_p),L
	movi	50,a0				;stupid K!!!
	move	a0,*a8(OMISC)			;save Z offset

	PULL	a8			;retrieve plyr *obj

;	.if	DEBUG
;	callr	plyr_getgndaligndot
;	.endif

;----------
; init secondary data structure

	clr	a0
	movi	PLDSZ,a9
	mpyu	a11,a9
	addi	pld,a9			;A9=*Plyr secondary data struc
	move	a9,a1
	movi	PLDSZ/16,b0
cpldlp	move	a0,*a1+
	dsj	b0,cpldlp

	sll	4,a11			;*16
	addi	P1CTRL,a11		;A11=*PxCTRL
	move	a0,*a11

;----------
; set initial sequence

;	move	@inmatchup,a0
;	jrz	pn02
;	movk	STND_SEQ,a0
;	jruc	pn03
;
;pn02
	movk	STND_SEQ,a0
	move	@gmqrtr,a14
	jrnz	goa
	movi	TIPSTND_SEQ,a0
goa


	move	*a13(plyr_num),a14	;plyrs 0 & 3 will be standing
	jrz	pn03
	subk	3,a14
	jrge	pn03
	move	@gmqrtr,a14		;so will plyrs 1 & 2 if not 1st qrtr
	jrnz	pn03
	movi	TIP_SEQ,a0		;set game start tip-off seq

pn03

	.if	DEBUG
	move	@QUICK_TIP,a14
	jrz	skipq1
	movk	STND_SEQ,a0
skipq1
	.endif

	move	*a13(plyr_dir),a7
	callr	plyr_setseq		;Rets: A10=Ani cntdn

;	move	@inmatchup,a0
;	jrz	pn03b
;pn03a	SLEEP	1
;	dsj	a10,noa
;	move	*a13(plyr_ani_p),a14,L		;>Set new ani
;	move	*a14+,a10			;Delay
;	jrnz	moses
;	move	*a13(plyr_ani1st_p),a14,L	;Head of list
;	move	*a14+,a10
;
;moses	move	*a14+,a0,L			;*Img
;	move	*a14+,a1			;Flags (OCTRL)
;	move	a14,*a13(plyr_ani_p),L
;	callr	plyr_ani
;
;	move	*a13(plyr_aniy),a1
;	neg	a1
;	move	a1,*a8(OYPOS)			;Set on gnd
;
;noa	callr	plyr_headalign
;	jruc	pn03a
;
;pn03b

;----------
; set appropriate team hoop target

	movi	HOOPLX,a0
	movi	HOOPRX,a1
	move	*a13(plyr_num),a14
	subk	2,a14
	jrlt	sethp
	SWAP	a0,a1
sethp	move	a0,*a13(plyr_myhoopx)
	move	a1,*a13(plyr_ohoopx)

;	move	*a13(plyr_num),a0	;DEBUG
;	subk	2,a0
;	jreq	num2
;	SLEEP	30000
;num2

	SLEEPK	2			;Wait for others to establish data

	.bss	plyr_main_initdone,16	;Plyr init done flag (0=not, !0=is)
	movk	1,a0
	move	a0,@plyr_main_initdone
;For moving during inbound!
;	clr	a14
;	move	a14,@inbound_lead

;------------------------------
; Top of main player proc loop

main_lp                             ;top of main player loop
	move	@HALT,a0
	jrnz	halted

;	clr	a9

	.if	IMGVIEW
	move	*a13(plyr_num),a0
	cmpi	0,a0
	jrz	yesx
	cmpi	3,a0
	jrne	halted
yesx
	movk	1,a2			;+=Me
	jruc	nobl2
	.endif
;
;This could be a dipswitch setting for our home games
;FIX
;	move	@DIPSWITCH,a0
;	btst	0,a0			;UJ2 switch 8
;	jrnz	notfair		;OFF?
;	clr	a0
;	move	a0,*a13(plyr_ptsdown)
;notfair
;

;--------------------
; Plyr ball-ownership handling

	clr	a2			;Clr owner flag (0=neither teammate)
	move	@ballpnum,a1
	move	*a13(plyr_num),a0
	cmp	a1,a0			;Plyr have the ball?
	jreq	has_ball		;br=yes
	XORK	1,a0			;No. Does his teammate?
	cmp	a1,a0
	jrne	not_tm			;br=no, other team or free
	subk	1,a2			;-=Teammate
not_tm
	move	a2,*a13(plyr_ownball)	;Save owner flag
	jruc	hadball

has_ball
	move	*a13(plyr_seqflgs),a14
	btst	NOBALL_B,a14		;Can plyr current seq hold the ball?
	jrz	can_hold		;br=yes
no_hold
	move	a2,@ballbbhitcnt	;No. Drop the ball
	move	a2,*a13(plyr_ownball)	;Save owner flag (0=neither teammate)
	subk	1,a2
	move	a2,@ballpnum		;Set to -1 for no plyr owner
	move	a2,@ballpnumlast
	calla	ball_convfmprel		;Yank ball from plyr-relative coord
	jruc	hadball

can_hold
	move	*a13(plyr_ownball),a0	;Yes. Did plyr already have it?
	jrgt	hadball		;br=yes

	move	@ballobj_p,a1,L		;No. Plyr just got the ball
	move	*a1(OYPOS),a0
	cmpi	-28,a0                  ;!!!Ball above dribble Y vel flip pnt?
	jrlt	chk_rbnd		;br=yes, chk if rebound
	move	*a1(OYVEL),a0,L		;No. Chk Y vel to see if rebound
	abs	a0
	cmpi	0c000H,a0                ;!!!Ball rolling on the floor?
	jrge	chk_rbnd		;br=no, chk if rebound

	move	*a13(plyr_jmpcnt),a0	;Yes. Is plyr in the air?
	jrnz	no_hold		;br=yes, don't pick-up rolling ball
;	calla	seq_stopfire
	movi	PICKUP_SEQ,a0		;No. Pick-up ball
	move	*a13(plyr_dir),a7
	callr	plyr_setseq
	jruc	own_ball

chk_rbnd
	move	@rebound_delay,a0	;Ball just come off the boards?
	jrz	own_ball		;br=no
	move	a2,@rebound_delay	;Yes, but was it a basket?
	move	@inbound,a0
	jrnn	own_ball		;br=yes, not a rebound

	movi	PS_OFF_REB,a0		;Assume offensive rebound
	move	*a13(plyr_num),a1
	move	@ballpnumlast,a14	;Plyr on the same team as plyr who
	srl	1,a1			; missed the basket?
	srl	1,a14
	cmp	a1,a14
	jrz	offrb			;br=yes
	movi	PS_DEF_REB,a0		;No. Defensive rebound
offrb
	move	*a13(plyr_num),a1	;Inc plyr rebound stat
	calla	inc_player_stat

own_ball
	movk	1,a2
	move	a2,*a13(plyr_ownball)	;Save owner flag (+=plyr)
;added this to hopefully fix the ignoring of the pass button after pass
	move	a2,*a13(plyr_rcvpass)
	move	*a13(plyr_num),a14
	move	a14,@my_ballpnumlast
 	PUSH	a10
	move	a13,a10
	calla	arw_on1plyr		;Guy who picks up ball gets arw
	PULL	a10

	move	*a13(plyr_num),a0
	move	@ballsclastp,a1
	srl	1,a0			;Do team s for shot clock compare
	srl	1,a1
	cmp	a0,a1			;Need to reset the shot clock?
	jreq	hadball		;br=no, same team has ball

	move	*a13(plyr_num),a14
	move	a14,@ballpnumshot
	move	a14,@ballsclastp
	calla	shot_clock		;New 24

;--------------------
; Set turbo flag per button & availability

hadball
	clr	a0			;>Setup turbo flag
	move	*a13(plyr_nojoy),a6
	jrn	newjoy			;Override plyr input?
	move	*a11,a6
newjoy	btst	BUT3_B,a6		;Turbo but
	jrz	turboff
	move	*a13(plyr_PDATA_p),a1,L
	move	*a1(ply_turbo),a1
	jrz	turboff		;No turbo left?
	movk	1,a0
turboff
	move	a0,*a13(plyr_turbon)

;--------------------
; Calc dirs/dists to plyrs/hoops/ball

	move	*a13(plyr_num),a4	;0DHo 1 in 4 ticks
	move	@PCNT,a0
	move	a4,a1
	sll	32-2,a0
	sll	32-2,a1
	cmp	a0,a1
	jrne	skip

	movk	1,a14			;>Get teammates dir/dist
	xor	a4,a14
	sll	5,a14			;*32
	addi	plyrobj_t,a14
	move	*a14,a0,L
	callr	seekdirdist_obob128
	move	a0,*a13(plyr_tmdir)
	move	a1,*a13(plyr_tmdist)

	srl	1,a4			;>Get opponents dir/dist
	movk	1,a14
	xor	a14,a4
	sll	6,a4			;*64
	addi	plyrobj_t,a4
	move	*a4+,a0,L
	callr	seekdirdist_obob128
	move	a0,*a13(plyr_o1dir)
	move	a1,*a13(plyr_o1dist)

	move	*a4+,a0,L
	callr	seekdirdist_obob128
	move	a0,*a13(plyr_o2dir)
	move	a1,*a13(plyr_o2dist)

	move	@ballobj_p,a0,L
	callr	seekdirdist_obob128
	move	a0,*a13(plyr_balldir)
	move	a1,*a13(plyr_balldist)

	move	*a13(plyr_myhoopx),a6
	movi	CZMID,a7
	callr	seekdirdist_obxz128
	move	a0,*a13(plyr_hpdir)
	move	a1,*a13(plyr_hpdist)

	move	*a13(plyr_ohoopx),a6
	movi	CZMID,a7
	callr	seekdirdist_obxz128
	move	a0,*a13(plyr_ohpdir)
	move	a1,*a13(plyr_ohpdist)
skip

;--------------------
; Set plyr defensive flag

	clr	a14			;>Setup defensive flag
	move	@ballpnum,a0
	jrn	setdef			;No owner?
	move	*a13(plyr_ownball),a0
	jrnz	setdef			;My team has?

	move	*a13(plyr_hpdist),a0

	move	*a13(plyr_num),a1
	move	@PSTATUS2,a2
	btst	a1,a2
	jrz	drn
	cmpi	220*DIST_ADDITION,a0	;stupid K!!!
    	jruc	ndrn
drn
	cmpi	310*DIST_ADDITION,a0			;stupid K!!!
ndrn	jrge	setdef			;Too far from my hoop?

	move	*a13(plyr_hpdir),a0	;Find dir difference
	move	*a13(plyr_balldir),a1
	sub	a1,a0
	abs	a0
	cmpi	040H,a0			;stupid K!!!
	jrle	dsmla
	subi	080H,a0			;stupid K!!!
	abs	a0
dsmla	subk	24,a0			;stupid K!!!
	jrle	setdef			;Not between ball and hoop?

	move	*a13(plyr_seq),a2
	cmpi	RUNDRIBTURB_SEQ,a2
	jrhi	setdef
	move	*a13(plyr_o1dist),a1
	cmpi	7ch,a1
	jrlt	defon
	move	*a13(plyr_o2dist),a1
	cmpi	7ch,a1
	jrge	setdef
defon	movk	1,a14
setdef	move	a14,*a13(plyr_indef)

;--------------------
; Handle stagger/fall seqs

	move	*a13(plyr_autoctrl),a0
	jrnz	tcc			;Temp computer control?

	move	*a13(plyr_seqflgs),a0
	btst	NOCOLLP_B,a0
	jrnz	nocol			;No collide?
	callr	plyr_chkpcollide
nocol
	move	*a13(plyr_stagcnt),a2
	jrle	nostag
	subk	1,a2
	move	a2,*a13(plyr_stagcnt)
	subk	15,a2			;stupid K!!!
	jrle	nostag

	move	*a13(plyr_seq),a14
	subk	30-15,a2		;stupid K!!!
	jrle	chkstag		;Chk stag?

;	move	@plyr_onfire,a1
;	jrz	noflm1
;	move	@fatality,a2		;bit 0=tm1, bit 1=tm2
;	jrz	noflm1
;	sll	3,a1
;	addi	pbit_tbit,a1,L
;	movb	*a1,a1			;Assume valid plyr_onfire
;	move	*a13(plyr_num),a3
;	srl	1,a3			;make tm  0 or 1
;	btst	a3,a1
;	jrnz	noflm1			;br=on the on-fire tm
;	and	a1,a2
;	jrz	noflm1			;br=on-fire tm fatality not set
;	movi	500,a0			;
;	calla	RNDPER
;	jrls	noflm1
;;Yes, this will be a flaming fall!
;	movk	1,a9
;noflm1
;
	move	*a13(plyr_seq),a14

	movi	FLYBACK_SEQ,a0
;	move	a9,a9
;	jrz	noflm2
;	movi	FFLYBACK_SEQ,a0
;noflm2
	cmp	a0,a14
	jreq	cstag

;	cmpi	FALL_SEQ,a14
;	jrge	cstag
;	cmpi	FFLYBACKWB2_SEQ,a14
;	jrgt	cstag

	cmpi	FLYBACKWB_SEQ,a14
	jreq	cstag
	cmpi	FLYBACKWB2_SEQ,a14
	jreq	cstag
	cmpi	FLYBACK2_SEQ,a14
	jreq	cstag

	move	*a13(plyr_ownball),a1
	jrgt	haveball

	move	*a13(plyr_attrib_p),a1,L
	move	*a1(PAT_POWER),a1
	move	@last_power,a2		;Player pushing has this power
	sub	a1,a2
	abs	a2

;	movi	FLYBACK_SEQ,a0		;If similar power, always do flyback
;	move	a9,a9
;	jrz	noflm3
;	movi	FFLYBACK_SEQ,a0
;noflm3
	cmpi	1,a2
	jrle	fall
	
	sll	4,a1
	PUSH	a14
	addi	noblflail_t,a1		;Powerful guys flail more often
	move	*a1,a0
	calla	RNDPER
	PULL	a14
	movi	FLYBACK_SEQ,a0		;If similar power, always do flyback
;	move	a9,a9
;	jrz	noflm4
;	movi	FFLYBACK_SEQ,a0
;noflm4

; Will this work?
	jrls	fall
	jruc	flail

haveball

;If toward rear edge of court and is being pushed back into crowd, always do
;normal flyback and never keep ball!

	movi	FLYBACK_SEQ,a0		;If similar power, always do flyback
;	move	a9,a9
;	jrz	noflm5
;	movi	FFLYBACK_SEQ,a0
;noflm5

	move	*a8(OZPOS),a1
	cmpi	CZMIN+40,a1		;stupid K!!!
	jrgt	not_rear
	move	*a8(OZVEL),a1,L
	jrn	fall			;Heading over scores table?

not_rear
	move	@pushing_delay,a1
	jrnz	keepball
;DJT Start
;	move	@pup_strongmen,a1
;	jrz	notchamp		; br=no grand champs in game
;;A grand champion is playing!
;	move	*a13(plyr_num),a0
;	srl	1,a0			; =team  (0,1)
;	addk	1,a0			; =team  (1,2)
;	and	a0,a1
;	jrz	notchamp		; br=plyr not on a grand champ team
;	movi	900,a0			;
;	calla	RNDPER
;	jrhi	keepball
;		
;notchamp
;DJT End

;	move	*a13(plyr_ptsdown),a1
;	jrle	fall			;I'm winning?

;If player is in elbo mode, have him keep ball more often!

	movi	500,a0			; 40% chance of keeping ball if in
	cmpi	ELBO_SEQ,a14		; ELBO; could also do ELBO2_SEQ
	jrz	fbnorm

	move	*a13(plyr_attrib_p),a14,L
	move	*a14(PAT_POWER),a0

	move	@last_power,a2		;Player pushing has this power
	sub	a0,a2
	abs	a2
	cmpi	1,a2
	jrgt	norm
	movi	200,a0
	jruc	norm2a

norm
	sll	4,a0
	addi	kpball_t,a0		;Powerful guys, keep ball more often
	move	*a0,a0
norm2a
	move	*a13(plyr_ptsdown),a1
	jrle	fbnorm			;losing? no if <=
	cmpi	15,a1			; < this many down?
	jrle	fbmok
	movk	15,a1			; no, set max
fbmok	sll	4,a1
	addi	flyb_t,a1
	move	*a1,a14
	add	a14,a0
	cmpi	1000,a0			;
	jrge	keepball
fbnorm
	calla	RNDPER
	jrls	fb

keepball
;Yes, keep ball even though I've been pushed.

	clr	a0
	move	a0,*a13(plyr_dribmode)	;Allow dribble when he gets up

;Rules for using short flyback/WITH BALL sequence:
;If in dunk, don't do short flybacks
;If in jump shot, 50%
;If losing, 50%
;What else?

	calla	pushed_speech

	movi	FLYBACKWB_SEQ,a0	;If similar power, always do flyback
;	move	a9,a9
;	jrz	noflm6
;	movi	FFLYBACKWB_SEQ,a0
;noflm6

	move	*a13(plyr_seqflgs),a14
	btst	DUNK_B,a14
	jrnz	fall			;In dunk?


	move	*a13(plyr_seq),a14
	subk	SHOOT_SEQ,a14		;Am I shooting?
	jrz	_50_50

	movi	50,a0			;
	move	*a13(plyr_ptsdown),a1
	jrle	i5050
;	jrle	fall			;I'm winning?

_50_50
;I'm losing or shooting, 25% of time don't fly all the way back.

	move	*a13(plyr_attrib_p),a14,L
	move	*a14(PAT_POWER),a0

	move	@last_power,a2		;Player pushing has this power
	sub	a0,a2
	abs	a2
	cmpi	1,a2
	jrgt	norm3
	movi	250,a0			;
	jruc	i5050

norm3
	sll	4,a0
	addi	shortfly_t,a0		;Powerful guys keep ball more often
	move	*a0,a0
;	movi	250,a0
i5050
	calla	RNDPER
	jrhi	nofall

	movi	FLYBACKWB_SEQ,a0	;If similar power, always do flyback
;	move	a9,a9
;	jrz	noflm7
;	movi	FFLYBACKWB_SEQ,a0
;noflm7
	jruc	fall
nofall

;	move	@HCOUNT,a1
;	andi	3,a1			;andi 1
;	jrz	fall

;He lucked out, fly short distance

flail	move	*a8(OZVEL),a0,L
;	sra	2,a0
	sra	1,a0
	move	a0,*a8(OZVEL),L
	move	*a8(OXVEL),a0,L
;	sra	2,a0
	sra	1,a0
	move	a0,*a8(OXVEL),L

	movi	FLYBACKWB2_SEQ,a0	;If similar power, always do flyback
;	move	a9,a9
;	jrz	noflm8
;	movi	FFLYBACKWB2_SEQ,a0
;noflm8
	jruc	fall

fb
;Rules for using short flyback/NO BALL sequence:
;If in dunk, don't do short flybacks
;If losing, 35%
;What else?
	calla	pushed_speech
	movi	FLYBACK_SEQ,a0		;If similar power, always do flyback
;	move	a9,a9
;	jrz	noflm9
;	movi	FFLYBACK_SEQ,a0
;noflm9

	move	*a13(plyr_seqflgs),a14
	btst	DUNK_B,a14
	jrnz	fall			;In dunk?

;If big guy, do short flyback more often!
	move	*a13(plyr_attrib_p),a14,L
	move	*a14(PAT_POWER),a0

	move	@last_power,a2		;Player pushing has this power
	sub	a0,a2
	abs	a2
	cmpi	1,a2
	jrgt	norm5

	movi	FLYBACK_SEQ,a0		;If similar power, always do flyback
;	move	a9,a9
;	jrz	noflm10
;	movi	FFLYBACK_SEQ,a0
;noflm10

	jruc	fall
norm5

	sll	4,a0
	move	*a13(plyr_ptsdown),a1
	jrle	winshortfly			;Br= I'm winning!
;I'm losing
	addi	shortfly_t,a0
	move	*a0,a0
	jruc	flyout
winshortfly			;Br= I'm winning!
	addi	winshortfly_t,a0
	move	*a0,a0


flyout
;	move	*a13(plyr_ptsdown),a1
;	jrle	fall			;Br= I'm winning!

;I'm losing, 35% of time don't fly all the way back.
;	addi	150,a0
;fbnorm2
	calla	RNDPER
	jrhi	fly_short

	movi	FLYBACK_SEQ,a0		;If similar power, always do flyback
;	move	a9,a9
;	jrz	noflm11
;	movi	FFLYBACK_SEQ,a0
;noflm11
	jruc	fall

fly_short
;He lucked out, make him fly short distance
	move	*a8(OZVEL),a0,L
;	sra	2,a0
	sra	1,a0
	move	a0,*a8(OZVEL),L
	move	*a8(OXVEL),a0,L
;	sra	2,a0
	sra	1,a0
	move	a0,*a8(OXVEL),L

	movi	FLYBACK2_SEQ,a0		;If similar power, always do flyback
;	move	a9,a9
;	jrz	noflm12
;	movi	FFLYBACK2_SEQ,a0
;noflm12

	jruc	fall

chkstag
	move	*a13(plyr_jmpcnt),a1
	jrz	stag			;On gnd?

	movi	FALL_SEQ,a0		;If similar power, always do flyback
;	move	a9,a9
;	jrz	noflm13
;	movi	FFALL_SEQ,a0
;noflm13

	cmp	a14,a0
	jrne	fall
	jruc	cstag

stag	subi	STAGGER_SEQ,a14
	jreq	nostag
	subk	FALL_SEQ-STAGGER_SEQ,a14
	jreq	cstag

	movk	3,a0
	callr	rnd
	jrnz	nostag
	movi	STAGGER_SEQ,a0

fall
	move	*a13(plyr_dir),a7
	callr	plyr_setseq
cstag	clr	a2
	move	a2,*a13(plyr_stagcnt)
nostag

;--------------------
; Eval plyr controls

	move	@PSTATUS2,a0		;Plyr start bits 0-3
	move	*a13(plyr_num),a1
	btst	a1,a0
	jrnz	human1
	calla	drone_main
human1
tcc
	move	*a13(plyr_indef),a14
	jrz	nodef
	move	*a13(plyr_balldir),*a13(plyr_newdir)

nodef
	move	*a11,a6			;A6=Ctrl bits

;	move	*a13(plyr_jmpcnt),a0
;	jrnz	clrsb			;In air?

	movb	*a13(plyr_seqflgs+NOJOY_B-7),a0
	jrn	clrsb			;Joy off?

	move	*a13(plyr_nojoy),a0
	jrz	joyon			;Joystick on?
	jrgt	clrsb
;dont allow a jump or steal when NOJOY is set, I expecting a pass!!

	btst	BUT1_B,a0
	jrnz	lock1
	btst	BUT2_B,a0
	jrnz	lock1
;	andni	BUT1_M|BUT2_M,a0
	move	a0,a6
	jruc	joyon

lock1
	.if	DEBUG
	LOCKUP
	.endif
	move	a0,a6
	jruc	joyon

clrsb
	srl	4,a6			;Clr stick bits
	sll	4,a6

joyon
	move	*a13(plyr_dir),a7	;A7=Dir

	move	*a13(plyr_newdir),a0
	jrn	stick			;No forced dir?
	sub	a7,a0
	jrnz	turn
	movi	-1,a0
	move	a0,*a13(plyr_newdir)

;--------------------
; Clr joy bits that make us go out of bounds

stick
	move	*a13(plyr_autoctrl),a1	;No chk if under auto ctrl
	jrnz	chkturn

	movk	1,a3			;Generic K
	move	*a13(plyr_rcvpass),a1
	move	*a13(plyr_seq),a2
	subi	RUN_SEQ,a2		;Set seq match (0) or nomatch (!0)
	jrz	sldin
	subi	RUNTURB_SEQ-RUN_SEQ,a2
	jrz	sldin
	subi	RUNDRIB_SEQ-RUNTURB_SEQ,a2
	jrz	sldin
	subi	RUNDRIBTURB_SEQ-RUNDRIB_SEQ,a2
sldin
	move	*a8(OZPOS),a0

	cmpi	CZMIN+8,a0		;stupid K!!! ;Is Z ok? Yes if >
	jrgt	upoka
	movk	JOYU_M,a14		;No. Clr stick UP bit
	andn	a14,a6

	move	a1,a1			;Receiving a pass? No if 0
	jrz	nowait
	move	a3,*a13(plyr_nojoy)	;Tell player recieving a leading pass
	move	a3,*a13(plyr_turndelay)	; to turn and wait for pass
nowait
	cmpi	CZMIN+6,a0		;stupid K!!!
	jrgt	upoka

	move	a2,a2			;Match 1 of the seqs? No if !0
	jrnz	upoka
	addk	1,a0			;Yes
upoka
	cmpi	CZMAX-6,a0		;stupid K!!! ;Is Z ok? Yes if <
	jrlt	dnoka
	movk	JOYD_M,a14		;No. Clr stick DN bit
	andn	a14,a6

	move	a1,a1			;Receiving a pass? No if 0
	jrz	nowait1
	move	a3,*a13(plyr_nojoy)	;Tell player recieving a leading pass
	move	a3,*a13(plyr_turndelay)	; to turn and wait for pass
nowait1

dnoka
	move	a0,*a8(OZPOS)

	move	*a8(OXPOS),a0
	move	*a8(OXANI+16),a14
	add	a14,a0

	cmpi	PLYRMINX,a0		;Is X ok? Yes if >
	jrgt	lok
	movk	JOYL_M,a14		;No. Clr stick LF bit
	andn	a14,a6

	move	a1,a1			;Receiving a pass? No if 0
	jrz	nowait2
	move	a3,*a13(plyr_nojoy)	;Tell player recieving a leading pass
	move	a3,*a13(plyr_turndelay)	; to turn and wait for pass
nowait2
	cmpi	PLYRMINX-15,a0
	jrgt	lok

	move	a2,a2			;Match 1 of the seqs? No if !0
	jrnz	lok
	addk	1,a0			;Yes
lok
	cmpi	PLYRMAXX,a0		;Is X ok? Yes if <
	jrlt	rok
	movk	JOYR_M,a14		;No. Clr stick RG bit
	andn	a14,a6

	move	a1,a1			;Receiving a pass? No if 0
	jrz	nowait3
	move	a3,*a13(plyr_nojoy)	;Tell player recieving a leading pass
	move	a3,*a13(plyr_turndelay)	; to turn and wait for pass
nowait3
	cmpi	PLYRMAXX+15,a0
	jrlt	rok

	move	a2,a2			;Match 1 of the seqs? No if !0
	jrnz	rok
	subk	1,a0			;Yes
rok
	move	*a8(OXANI+16),a14
	sub	a14,a0
	move	a0,*a8(OXPOS)

;--------------------
; Change dir plyr img is facing

chkturn
	move	a6,a0
	sll	    32-4,a0
	jrz	    setdt			;No stick?

	srl	    32-4-3,a0		;0CHonvert to dir 0-127
	addi	dirc_t,a0
	movb	*a0,a0

	sub	    a7,a0			;A0=Difference
	jrz	    samedir

turn	
    move	a0,a1			;>Turn the shortest way
	abs	a0

;	subk	6,a0
	subk	8,a0			;Turn faster

	jrge	i340			;Far?
	add	    a1,a7			;Make exact
	jruc	i380

i340	
    cmpi	64-6,a0
	jrle	i350
	neg	a1
i350	
    move	a1,a1
	jrnn	i360
;	subk	12,a7			;-6
	subk	16,a7			;-8

i360
;	addk	6,a7			;+6
	addk	8,a7			;+8

i380	
    sll	    32-7,a7			;Make 0-127
	srl	    32-7,a7
	move	a7,*a13(plyr_dir)

	movk	01fH,a0
	callr	rnd
	jrnz	nosq			;No squeak?
	move	@PCNT,a0
	movk	3,a1
	and	    a1,a0
	sll	    5,a0
	move	@pup_court,a14
;	jrnz	nosq0			;br=outdoor court
	addi	sqsnds,a0
	jruc	nosq1
nosq0
	addi	sqsnds2,a0
nosq1
	move	*a0,a0,L
	calla	snd_play1
nosq

	move	*a13(plyr_seqflgs),a0
	btst	WALK_B,a0
	jrnz	nodir
	move	*a13(plyr_seqdir),a0
	move	a7,a1			;Dir
	addk	8,a1
	sll	    32-7,a1
	srl	    32-7+4,a1		;Kill frac
	cmp	    a0,a1
	jreq	nodir			;Already in this dir?
	move	*a13(plyr_seq),a0
	callr	plyr_setseq
nodir	
    clr	a0
	jruc	setdt

samedir
	move	*a13(plyr_dirtime),a0
	addk	1,a0
setdt	
    move	a0,*a13(plyr_dirtime)

;----------
; Movement/boundary check

;LOOK!!!
	move	*a8(OXVEL),a2,L
	move	*a8(OZVEL),a3,L

	move	*a13(plyr_jmpcnt),a0
	jrnz	drift			;Jumping?

	move	*a13(plyr_seqflgs),a4	;No, but still on the way down?
	btst	DRIFT_B,a4
	jrz	nodrift		;No if 0

drift	move	*a8(OXPOS),a4		;>Put drag on vel if we drift too far
	move	*a8(OXANI+16),a0
	add	a0,a4
	move	*a8(OZPOS),a5

	move	a3,a3
	jrge	zvpos
	cmpi	CZMIN+8,a5
	jrgt	chkx			;OK?
	jruc	ydrag

zvpos	cmpi	GZMAX-6,a5
	jrlt	chkx			;OK?
ydrag	move	a3,a0			;-1/4 from vel
	sra	2,a0
	sub	a0,a3
chkx
	move	a2,a2
	jrge	xvpos
	cmpi	PLYRMINX2,a4
	jrgt	setvel			;OK?
	jruc	xdrag
xvpos
	cmpi	PLYRMAXX2,a4
	jrlt	setvel			;OK?
xdrag	move	a2,a0			;-1/4 from vel
	sra	2,a0
	sub	a0,a2
	jruc	setvel


nodrift
	move	a2,a0			;>-1/4 from XZVEL
	sra	2,a0
	sub	a0,a2
	move	a3,a0
	sra	2,a0
	sub	a0,a3

	btst	NOMV_B,a4
	jrnz	setvel			;No moving?


	move	*a13(plyr_autoctrl),a1
	jrz	noautoc
	movi	01a000H,a14
	jruc	noturb1

noautoc
	move	*a13(plyr_bvel),a14
	sll	4,a14

	move	*a13(plyr_num),a0
	move	@pup_hypspeed,a1
	btst	a0,a1
	jrz	nohyper


;Double turbo mode
	addi	05800H,a14
nohyper

	move	*a13(plyr_ownball),a1
	jrle	nobal			;Have ball?

;I own ball, if shot clock down to 10, and am over
;half court, slow down!  I am trying to burn out the clock!

	move	*a13(plyr_ohpdist),a1
;This is approximately half court!
	cmpi	0174H*DIST_ADDITION,a1
	jrlt	nobal
	move	@shotimer,a1,L
	jrz	nobal
	cmpi	[1,0],a1
	jrz	nobal

	move	*a13(plyr_ptsdown),a1
	jrgt	nobal			;If losing, don't slow down

;	subi	03000H,a14		;Slow him down
	subi	04000H,a14		;Slow him down more!

nobal
	move	@game_time,a1,L
	cmpi	050000h,a1
	jrge	noxtraspd

;Under 50 seconds, speed up losing players!

;	move	*a13(plyr_ptsdown),a1	;0AdHjust shot %
;	jrle	noxtraspd

	move	*a13(plyr_num),a1
	cmpi	2,a1
	jrge	tm2
	move	@scores,a0
	move	@scores+16,a1
	cmp	    a0,a1
	jrle	noxtraspd
	jruc	yes50

tm2	move	@scores,a0
	move	@scores+16,a1
	cmp	a0,a1
	jrge	noxtraspd
yes50
	addi	01c00H,a14
noxtraspd

;This offscrn flag gets set only when on defense!
	move	*a13(plyr_offscrn),a1
	jrz	onscrn
;We want to speed guy up when offscrn...  But go even faster if he is trying
;to get back on the screen!
;	addi	0e000H,a14		;Speedup when offscrn
	addi	08000H,a14		;Speedup when offscrn

;Trying to come back?
	move	@WORLDTLX+16,a0
	addi	200,a0
	move	*a8(OXPOS),a1
	cmp	a1,a0
	jrgt	offlft
;Player is off screen to right
	btst	JOYL_B,a6
	jrz	conta
	jruc	add

offlft
	btst	JOYR_B,a6
	jrz	conta
add	addi	08000H,a14		;Coming back!
conta


	clr	a1
	move	a1,*a13(plyr_offscrn)
onscrn

	move	*a13(plyr_ownball),a1
	jrz	chkturb
;	subi	0e00H,a14		;Slow offense down
	subi	0e80H,a14		;Slow offense down
	move	a1,a1
	jrn	chkturb		;Buddy has ball?
;	subi	01000H,a14		;Slow him down
	subi	01100H,a14		;Slow him down
chkturb
	move	*a13(plyr_turbon),a0
	jrz	noturb1
;	addi	03e00H,a14
	addi	03f00H,a14

noturb1
	movk	11b,a0
	and	a6,a0
	jrz	nodiag			;Neither up or dn?
	movk	1100b,a0
	and	a6,a0
	jrz	nodiag			;Neither lft or rgt?
	move	a14,a0
	sra	3,a0
	sub	a0,a14			;-12%
nodiag

;	btst	4,a6			;3point DEBUG
;	jrz	DEBUG
;	movi	02000H,a14
;DEBUG

	move	*a8(OXPOS),a4
	move	*a8(OXANI+16),a0
	add	a0,a4
	move	*a8(OZPOS),a5
;DJT Start
;;
;;show hotspot when plyr runs across
;;;	move	@pup_showhotspots,a0	;Bit 0-3 on = show plyr 0-3 hotspots
;;;	btst	,a0
;;;	jrz	hsnoshow
;;	move	*a13(plyr_hotspotx),a1
;;	sub	a4,a1
;;	abs	a1
;;	subk	HOTSPOTX_RNG,a1
;;	jrnn	hsnoshow
;;	move	*a13(plyr_hotspotz),a1
;;	sub	a5,a1
;;	abs	a1
;;	subk	HOTSPOTZ_RNG,a1
;;	jrnn	hsnoshow
;;	PUSH	a1,a7,a14
;;	.ref	show_hotspot_plyr_coor
;;	CREATE0	show_hotspot_plyr_coor
;;	move	a13,*a0(PA10),L
;;	PULL	a1,a7,a14
;;
;;hsnoshow
;DJT End
	btst	JOYU_B,a6
	jrz	noup1
	cmpi	CZMIN+8,a5
	jrle	noup1			;Min?
	sub	a14,a3
noup1
	btst	JOYD_B,a6
	jrz	nodn
	cmpi	GZMAX-6,a5
	jrge	nodn			;Max?
	add	a14,a3
nodn
	btst	JOYL_B,a6
	jrz	chkr
	sub	a14,a2
	cmpi	PLYRMINX,a4
	jrgt	setvel			;In bounds?
	move	*a13(plyr_autoctrl),a0
	jrnz	setvel
	add	a14,a2
	jruc	setvel
chkr
	btst	JOYR_B,a6
	jrz	setvel
	add	a14,a2
	cmpi	PLYRMAXX,a4
	jrlt	setvel			;In bounds?
	move	*a13(plyr_autoctrl),a0
	jrnz	setvel
	sub	a14,a2

setvel	move	a2,*a8(OXVEL),L
	move	a3,*a8(OZVEL),L
nomv


;-------

					;0DHo turbo meters
	btst	BUT3_B,a6		;Turbo but
	jrz	turdone


;Allow guy with ball to throw elbows if turbo button pressed twice quickly
	btst	BUT3_B+8,a6
	jrz	noelbo

	move	*a13(plyr_tbutn),a14
	clr	a0
	move	a0,*a13(plyr_tbutn)
	subk	1,a14
	jrlt	noelbo			;Too quick?
	subk	8-1,a14
	jrgt	noelbo			;Too late?

	move	*a13(plyr_seq),a14
	cmpi	STNDWB_SEQ,a14
	jreq	elbo_ok
	cmpi	STNDWB2_SEQ,a14
	jreq	elbo_ok
	cmpi	STNDDRIB2_SEQ,a14
	jreq	elbo_ok
	cmpi	RUNDRIB_SEQ,a14
	jreq	elbo_ok
	cmpi	RUNDRIBTURB_SEQ,a14
	jreq	elbo_ok
	subk	STNDDRIB_SEQ,a14
	jrne	noelbo
elbo_ok
;	move	*a13(plyr_num),a0
;	move	@PSTATUS2,a2
;	btst	a0,a2
;	jrz	notingame

	move	@gmqrtr,a0
	jrnz	s1

	move	@game_time,a0,L
;This check is here because we don't want accidental elbows when people
;are trying to win jump ball!
	cmpi	02040906H,a0
	jrge	noelbo

s1
	move	*a13(plyr_PDATA_p),a2,L	;Shrink turbo meter for this plyr
	move	*a2(ply_turbo),a1
	subk	TURBO_CNT/7*2,a1		;!!! Min cnt for elbow
	jrle	noelbo			;Turbo too low?
	move	a1,*a2(ply_turbo)
	sll	5,a1
	addi	TURBO_52,a1
	move	*a2(ply_meter_imgs+32),a0,L
	move	*a1(0),*a0(OSAG),L

;	move	*a2(ply_meter_imgs+40h),a0,L
;	move	*a0(OFSET),a1		;Shrink meter
;	addk	4,a1
;	move	a1,*a0(OFSET)

notingame
	movi	60,a0
	move	a0,@steals_off		;Don't allow steals for 60 ticks

	movi	ELBO2_SEQ,a0
	move	*a13(plyr_dribmode),a14
	jrn	elbw			;br=cant dribble...do elbows
	move	*a13(PA8),a14,L


	move	*a14(OZVEL),a1
	abs	a1
	cmpi	0000100h,a1
	jrge	spin
	move	*a14(OXVEL),a14
	abs	a14
	cmpi	00002700h,a14
	jrle	elbw
spin

;Don't allow consecutive spins
	.ref	last_spin
	move	@last_spin,a1
	move	@PCNT,a14
	move	a14,@last_spin
	sub	a1,a14
	abs	a14
	cmpi	2*60,a14
	jrgt	norms

;If spin, allow steals/pushes occasionally!
;	movi	500,a0
;	calla	RNDPER
;	jrls	norms

	clr	a0
	move	a0,@steals_off		;Don't allow steals for 10 ticks
norms
	movi	SPIN_MOVE_SEQ,a0
elbw
	callr	plyr_setseq
	jruc	turdone

noelbo
;	move	*a13(plyr_num),a0	;Don't allow drones to mess with
;	move	@PSTATUS2,a2		;img ofsets!
;	btst	a0,a2
;	jrz	turdone

	move	*a13(plyr_num),a0	;If on fire, don't use turbo on run
	move	@plyr_onfire,a1
;;	cmp	a0,a1
;;	jrz	turdone
	btst	a0,a1
	jrnz	turdone		;br=on-fire

	.ref	refill_turbo
	move	@pup_trbinfinite,a1
	btst	a0,a1
	jrz	doturb
	move	a11,a14
	move	*a13(plyr_PDATA_p),a11,L
	calla	refill_turbo
	move	a14,a11
	jruc	turdone
doturb
	move	*a13(plyr_PDATA_p),a0,L
	move	*a0(ply_turbo),a1	;Turbo info in PxDATA (0...TURB_CNT-1)
	jrz	turdone		;No turbo left?
	move	*a0(ply_turbo_dl),a2	;Cnt for delaying dec of ply_turbo
	subk	1,a2
	move	a2,*a0(ply_turbo_dl)
	jrnz	turdone

	subk	1,a1
	move	a1,*a0(ply_turbo)	;Turbo meter size to get smaller

	movk	390/TURBO_CNT,a2	;!!! Rate of decline
	move	a2,*a0(ply_turbo_dl)
	movk	200/TURBO_CNT,a2	;!!! Rate of replenish
	move	a2,*a0(used_turbo)
	move	*a0(ply_idiot_use),a2
	inc	a2
	move	a2,*a0(ply_idiot_use)

	sll	5,a1
	addi	TURBO_52,a1
	move	*a0(ply_meter_imgs+32),a2,L
	move	*a1(0),*a2(OSAG),L

;	move	*a0(ply_meter_imgs+40h),a0,L	;LITUP img 
;	move	*a0(OFSET),a1		;Need to shrink LITUP img
;	addk	1,a1
;	move	a1,*a0(OFSET)

turdone
	move	*a13(plyr_tbutn),a0	;Ticks since turbo button last hit
	addk	1,a0
	move	a0,*a13(plyr_tbutn)





	move	*a13(plyr_shtdly),a0
	jrle	nodly			;No delay?

;Is Ball near ground, and player has high shtdly?
	.if	DEBUG
	cmpi	30,a0
	jrlt okz
	
	move	@ballobj_p,a14,L

	move	*a14(OYPOS),a14
	cmpi	-40,a14
	jrle	okz			;Ball close to gnd?
	move	@inbound,a14
	jrnn	okz
	move	@ballpnum,a14		;Plyr  who owns (0-3) or Neg
	jrnn	okz
;Ball without owner, can't pick it up!	
;	LOCKUP
okz
	.endif

	subk	1,a0
	move	a0,*a13(plyr_shtdly)
nodly

;----------

	move	*a13(plyr_rcvpass),a0	;>Pass receiving
	jrle	norcvp			;No pass?
	subk	1,a0
	move	a0,*a13(plyr_rcvpass)
	jrgt	norcvp			;Not yet?
;	move	*a13(plyr_nojoy),a1
	move	a0,*a13(plyr_nojoy)
;	move	@ballobj_p,a2,L
;	move	*a2(OYVEL+16),a0
;	jrge	balllow
;	move	*a8(OYPOS),a0
;	subk	10,a0
;	move	*a2(OYPOS),a1
;	cmp	a0,a1
;	jrgt	balllow
;	subk	REBOUND_SEQ,a1
;	jrne	noreb
;	movk	REBOUND_SEQ,a0
;	callr	plyr_setseq
;noreb

norcvp
	move	*a13(plyr_seq),a2
	cmpi	RUNDRIBTURB_SEQ,a2
	jrhi	anicnt

	move	a6,a1			;0CHhange ani if no joy
	sll	32-4,a1
	jrz	nojoy			;Joy neutral?

	movi	38,a14			;stupid K!!!Delay before auto zturn toward ball
	move	*a13(plyr_ownball),a0
	jrz	indef
	movi	60,a14			;stupid K!!!^
indef
	move	a14,*a13(plyr_turndelay)

	move	*a13(plyr_indef),a14
	jrz	nodef2

	move	*a13(plyr_seqflgs),a0
	btst	WALK_B,a0
	jrnz	anicnt

	srl	32-4-3,a1		;0CHonvert to dir 0-127
	addi	dirc_t,a1
	movb	*a1,a1

	sub	a7,a1
	move	a1,a14			;Calc dir dist
	abs	a14
	cmpi	040H,a14
	jrle	diffsml
	neg	a1
	subi	080H,a14
	abs	a14
diffsml
	movk	WALKFDEF_SEQ,a0
	cmpi	16,a14
	jrlt	setseq
	movk	WALKBDEF_SEQ,a0
	cmpi	030H,a14
	jrgt	setseq
	movk	WALKLDEF_SEQ,a0
	move	a1,a1
	jrn	setseq
	movk	WALKRDEF_SEQ,a0
	jruc	setseq

nodef2
;
;	clr	a0
;	move	a0,*a13(plyr_keeppal)
;
	movk	RUN_SEQ,a0		;>Setup run sequence
	move	*a13(plyr_ownball),a14
	jrle	nobl
	move	*a13(plyr_dribmode),a14
	jrn	stndwb			;Can't drib?
	movk	RUNDRIB_SEQ,a0
nobl
	move	a0,a1
	move	*a13(plyr_turbon),a14
	jrz	slow
;This points to turbo runs
	addk	1,a0			;Turbo version
slow
	addk	1,a1
	sub	a2,a1
	subk	1,a1
	jrhi	setseq			;Different type?

	move	*a13(plyr_ani_p),a14,L
	move	*a14+,a14
	jrnz	anicnt			;!At end?
	jruc	setseq

nojoy
	move	*a13(plyr_seqflgs),a0
	btst	WALK_B,a0
	jrnz	anicnt

	movk	STNDDEF_SEQ,a0		;>Setup stand sequence
	movk	STNDDRIBDEF_SEQ,a1
	move	*a13(plyr_indef),a14
	jrnz	chkb

	movk	STND2_SEQ,a0
	movk	STNDDRIB_SEQ,a1

	move	*a13(plyr_turndelay),a14
	jrz	turnok1
	subk	1,a14
	move	a14,*a13(plyr_turndelay)
	subk	20,a14
	jrgt	chkb
turnok1
	move	*a13(plyr_o1dist),a14
	cmpi	155*DIST_REDUCTION,a14
	jrlt	stnd0
	move	*a13(plyr_o2dist),a14
	cmpi	155*DIST_REDUCTION,a14
	jrgt	stnd1
stnd0
	movk	STND_SEQ,a0
	movk	STNDDRIB2_SEQ,a1
stnd1

	move	*a13(plyr_ownball),a14
	jrle	chka
	move	*a13(plyr_turndelay),a14
	jrz	turnok0
	dec 	a14
	move	a14,*a13(plyr_turndelay)
	jruc	chkb

turnok0
	move	*a13(plyr_ohpdir),a14
	move	a14,*a13(plyr_newdir)
	jruc	chkb
chka
	move	*a13(plyr_turndelay),a14
	jrz	turnok
	dec 	a14
	move	a14,*a13(plyr_turndelay)
	jruc	chkb
turnok	move	*a13(plyr_balldir),a14
	move	a14,*a13(plyr_newdir)



chkb	move	*a13(plyr_ownball),a14
	jrle	setseq
	move	a1,a0
	move	*a13(plyr_dribmode),a14
	jrgt	setseq			;Dribbling?
stndwb	movk	STNDWB_SEQ,a0
	move	@inbound,a14
	jrnn	setseq
	move	*a13(plyr_num),a14
	btst	0,a14
	jrnz	setseq
	movk	STNDWB2_SEQ,a0

setseq	cmp	a0,a2

	.if	1		;0 for plyr anim patch temp
	jreq	anicnt

	.if	IMGVIEW
	movi	debug_SEQ1,a0
	.endif

	callr	plyr_setseq


;TEMP!!! anim patch temp
	.else
	movk	STNDDRIB_SEQ,a0
	move	*a13(plyr_seq),a1
	cmp	a0,a1
	jrne	tmp0
	move	*a13(plyr_seqdir),a1
	cmpi	4,a1
	jreq	anicnt
tmp0	movi	040H,a7
	callr	plyr_setseq
	.endif


anicnt	dsj	a10,noani1

	move	*a13(plyr_ani_p),a14,L		;>Set new ani
getdel	
    move	*a14+,a10			;Delay
	jrnn	nocodea				;Not code?

	move	*a14+,a0,L			;*Code
	move	a14,b4
	call	a0				;Can trash scratch, A2-A5
	move	b4,a14
	jruc	getdel

nocodea	
    jrnz	i100
	move	*a13(plyr_seqcode_p),a0,L
	jrge	noendc
	call	a0				;Can trash scratch, A2-A5
noendc	move	*a13(plyr_ani1st_p),a14,L	;Head of list

getdel2
	move	*a14+,a10

;Sequences can start with a command!
	jrnn	i100
				;Not code?
	move	*a14+,a0,L			;*Code
	move	a14,b4
	call	a0				;Can trash scratch, A2-A5
	move	b4,a14
	jruc	getdel2


i100	
    move	*a14+,a0,L			;*Img
	move	*a14+,a1			;Flags (OCTRL)
	move	*a13(plyr_anirevff),a2		;Get reverse flip flag
	xor	a2,a1
	move	a1,a4

	move	*a0(IANI2Z),*a13(plyr_ballzo)

	move	a14,*a13(plyr_ani_p),L
	callr	plyr_ani

	callr	anipt2_getsclxy
	move	a0,*a13(plyr_ballxo),L
	sra	16,a1
	move	a4,a4
	jrnn	ynorma				;!YFree flag?
	movi	-200,a1
ynorma	
    move	a1,*a13(plyr_ballyo)

	move	*a13(plyr_jmpcnt),a14
	jrnz	injmp				;Jumping?

	move	*a13(plyr_aniy),a1
	neg	a1
	move	a1,*a8(OYPOS)			;Set on gnd

;Don't allow long tick counts on the ground
	cmpi	30,a10
	jrlt	injmp
	movk	4,a10
injmp

	move	*a8(OIMG),a2,L			;>Set new head img
	move	*a2(IANI3ID),a1
	sll	5,a1				;*32
	move	*a2(IANI3Z),a14
	neg	a14

	move	*a13(plyr_attrib_p),a0,L
	move	*a0(PAT_HEADT_p),a0,L
	add	a1,a0
	move	*a0,a4,L

	move	*a13(plyr_headobj_p),a3,L
	move	a14,*a3(OMISC)
	move	a4,*a3(OIMG),L			;Set new img
	move	*a4,a14,L
	move	a14,*a3(OSIZE),L
	move	*a4(ISAG),*a3(OSAG),L

	setf	1,0,0
	move	*a8(OCTRL+4),*a3(OCTRL+4)	;Copy HFlip bit
	move	*a2(IFLAGS+FLIPH_IFB),a14	;Chk reverse bit
	jrz	nohflip
	move	*a3(OCTRL+4),a14		;Reverse hflip
	addk	1,a14
	move	a14,*a3(OCTRL+4)
nohflip
	setf	16,1,0
noani1

;-------


	move	*a13(plyr_jmpcnt),a0	;>Jumping
	jrz	noj
	addk	1,a0
	move	a0,*a13(plyr_jmpcnt)

	move	*a13(plyr_hangcnt),a0
	jrle	nohang			;Not hanging?
	subk	1,a0
	move	a0,*a13(plyr_hangcnt)
	jruc	pass			;Skip grav
nohang
	move	*a8(OYVEL),a0,L

;	move	*a13(plyr_ownball),a14
;	jrgt	grav			;Have ball?
;;	btst	BUT1_B,a6		;Mario like jump
;;	jrnz	grav
;;	addi	GRAV/2,a0		;+Grav/2
;grav
	addi	GRAV,a0			;+Gravity
	jrn	    i200
	move	*a8(OYPOS),a1
	move	*a13(plyr_aniy),a14
	add	a14,a1			;Ani pt position
	jrlt	i200			;Above gnd
	neg	a14
	move	a14,*a8(OYPOS)		;Set on gnd

	.if	DEBUG
;	clr	a0
;	move	a0,@slowmotion
	.endif

	movk	1,a10			;Run landing seq
	clr	a0
	move	a0,*a13(plyr_jmpcnt)
i200	move	a0,*a8(OYVEL),L

	move	*a13(plyr_seqflgs),a0
	btst	DUNK_B,a0
	jrnz	znubb			;In dunk?

	move	*a8(OZPOS),a1		;Get SZ
	subi	CZMID,a1
	abs	a1
	cmpi	40,a1
	jrge	znubb
	move	*a8(OXPOS),a0		;Get SX
	move	*a8(OXANI+16),a14
	add	a14,a0
	subi	WRLDMID,a0
	abs	a0
	move	a0,a3
	movi	020000H,a14
	cmpi	HOOPRX-WRLDMID+13,a0
	jrge	undrbb			;Under backboard?

	subk	10,a1
	jrgt	znubb
	cmpi	HOOPRX-WRLDMID-8,a3
	jrlt	znubb			;!Under rim?
;	cmpi	HOOPRX-WRLDMID+13,a3
;	jrgt	znubb			;!Under rim?

	movi	010000H,a14
	move	*a8(OXVAL),a1,L
	cmpi	WRLDMID<<16,a1
	jrlt	rhoop
	neg	a14
rhoop	add	a14,a1
	move	a1,*a8(OXVAL),L

	movi	010000H,a14
undrbb
	move	*a8(OZVAL),a1,L
	cmpi	CZMID<<16,a1
	jrge	dzpos			;In front of?
	neg	a14
dzpos	add	a14,a1
	move	a1,*a8(OZVAL),L

znubb

	move	*a13(plyr_ownball),a1
	jrz	pass			;No ball?
	jrlt	sblk			;Teammate has ball?

;
 	move	*a13(plyr_jmpcnt),a0
 	subk	12,a0
	jrlt	pass			;Too soon?
	move	*a13(plyr_seq),a0
	cmpi	DDUNK_STRT2_SEQ,a0		;already in seq. ?
	jreq	znub3				;br=yes

	move	*a13(plyr_seqflgs),a0
	btst	DUNK_B,a0
	jrz	znub3

	btst	BUT2_B+8,a6			;pressed PASS button?
	jrnz	ddnk				;br=yes

	btst	BUT1_B+8,a6			;pressed SHOOT button?
	jrz	znub3				;br=no
ddnk
;FIX!!!
;this should really say something about 'lob pass' to teammate


;Need to "debounce" player shoot button so humans & drones don't do an
;automatic layup every time you dunk!


;Quick check:  If Human is controlling drone, don't allow drone to layup
;as quickly as a human could.  Wait longer before it falls into layup seq.
 	move	*a13(plyr_num),a0
	move	@PSTATUS2,a14
	btst	a0,a14
	jrnz	norm1
	xori	1,a0
	btst	a0,a14
	jrz	norm1
 	move	*a13(plyr_jmpcnt),a0
 	subi	40,a0
	jrlt	pass			;Too soon?
norm1


	movk	LAY_UP,a0
	move	a0,@shot_type

	move	*a13(plyr_slam_ticks),a14
	subk	10,a14				;close to rim ?
	move	*a13(plyr_jmpcnt),a0
	sub	a0,a14
	jrn	znub3				;br=too late

	move	*a13(plyr_dir),a7
	movi	DDUNK_STRT2_SEQ,a0
	callr	plyr_setseq
	jruc	pass

znub3
	move	*a8(OYPOS),a1
	move	*a13(plyr_aniy),a14
	add	a14,a1			;Ani pt position
	addk	15,a1
	jrlt	chkb1			;High enough?

	move	*a13(plyr_seqflgs),a0
	btst	DUNK_B,a0
	jrnz	slp			;Already started?

;	btst	BUT2_B+8,a6
;	jrnz	dopass			;Air dish off pass?

	btst	SHOOT_B,a0
	jrz	slp

	move	@gmqrtr,a0
	jrnz	shoot2
	
	move	*a13(plyr_seq),a0
	cmpi	QSHOOT_SEQ,a0
	jrz	shoot2
					;Force him to shoot 
	movk	5,a0
	move	*a13(plyr_num),a1
	calla	idiot_box		;Tell him to release ball at peak of jump

	jruc	shoot2			;Too low?

chkb1

	move	*a13(plyr_seq),a0
	subk	REBOUND_SEQ,a0
	jreq	reb
	subk	REBOUNDA_SEQ-REBOUND_SEQ,a0
	jrne	noreb
reb
	btst	BUT1_B+8,a6
	jrz	noreb			;No press?

	move	*a13(plyr_ohpdist),a14
;This is for doing a layup out of a rebound
;He must be near, and be facing hoop
	cmpi	150*DIST_ADDITION,a14
	jrgt	pass			;Too far?

	move	*a13(plyr_ownball),a0
	jrle	pass			;Don't have?

	move	*a13(plyr_ohpdir),a0
	move	*a13(plyr_dir),a1
	sub	a1,a0
	abs	a0
	cmpi	040H,a0
	jrle	rdsml
	subi	080H,a0
	abs	a0
rdsml	subk	32,a0
	jrgt	pass			;Not between ball and hoop?

	movk	2,a0
	move	a0,@ballptsforshot
	movk	FINGER_ROLL,a0
	move	a0,@shot_type
	movk	LAYUPREB_SEQ,a0
	callr	plyr_setseq
	jruc	pass

noreb

	btst	BUT1_B,a6
	jrnz	pass			;Holding shoot button?

	btst	BUT2_B+8,a6
	jrnz	dopass			;Air dish off pass?

	move	*a13(plyr_seqflgs),a0
	btst	DUNK_B,a0
	jrnz	slp			;Already started?

	btst	SHOOT_B,a0
	jrz	slp

shoot2


;	move	*a8(OIMG),a14,L
;	move	*a14(IANI2Y),a14
;	jrz	ok_shoot
;;Player shot seq. has some animation left before we can release ball
;	ANDK	3,a10
;	jruc	pass
;ok_shoot


	callr	plyr_shoot
	movk	1,a10
	jruc	pass




noj	move	@ballpnum,a0
	jrge	sblk			;Somebody has ball?
	move	*a13(plyr_seq),a0
	cmpi	RUNDRIBTURB_SEQ,a0
	jrhi	sblk			;Doing something?
	move	@ballgoaltcnt,a0
	jrgt	sblk			;Going towards rim?
	move	*a13(plyr_balldist),a0
	cmpi	100*DIST_REDUCTION,a0
	jrgt	sblk			;Too far?
	move	@ballprcv_p,a1,L
	jrnz	sblk			;Pass in progress?
	move	*a13(plyr_seqflgs),a0
	btst	NOJUMP_B,a0
	jrnz	sblk			;No jumping?
	move	*a13(plyr_autoctrl),a0
	jrnz	sblk			;Temp computer control?
	callr	plyr_tryrebound
	move	*a13(plyr_seqflgs),a0
	btst	NOJUMP_B,a0
	jrnz	slp			;No jumping?



sblk
;	move	*a13(plyr_seq),a0
;	cmpi	LOB_PASS_SEQ,a0
;	jreq	pass
;	btst	BUT1_B+8,a6		;>Shoot/block (But1)
;	jrz	sblk2
;	btst	BUT2_B+8,a6		;pressing shoot and turbo ?
;	jrz	sblk2
;	move	*a13(plyr_ownball),a0
;	jrle	slp			;I don't have ball...
;	movi	LOB_PASS_SEQ,a0
;	move	*a13(plyr_dir),a7
;	callr	plyr_setseq		;lob ball to the net!!
;	jruc	slp
;sblk2
	btst	BUT1_B,a6		;>Shoot/block (But1)
	jrz	pass
	move	*a13(plyr_ownball),a1
	jrn	drnshoot		;br=teammate has ball

	movk	1,a0
	move	*a13(plyr_shtbutn),a14
	cmpi	2,a14
	jrle	scont
	cmpi	9,a14
	jrge	scont
	move	*a13(plyr_seq),a0
	cmpi	QSHOOT_SEQ,a0
	jrz	dblhit
	cmpi	TIP_SEQ,a0
	jrz	dblhit
	cmpi	TIPJ_SEQ,a0
	jrz	dblhit

	clr	a0
;	move	a0,*a13(plyr_shtbutn)
;	callr	plyr_startjmp
;	jruc	pass

scont	move	a0,*a13(plyr_shtbutn)

alyoop
	move	*a13(plyr_seqflgs),a0
	btst	NOJUMP_B,a0
	jrnz	pass			;No jumping?
	btst	DUNK_B,a0
	jrnz	pass			;Already in a dunk?

	move	*a13(plyr_rcvpass),a0
	jrgt	slp			;Waiting on pass?

	move	*a13(plyr_tmproc_p),a0,L
	move	*a0(plyr_rcvpass),a0
	jrgt	slp			;Teammate waiting on pass?

	callr	plyr_startjmp
	jruc	pass

drnshoot				;>Tell drone to shoot

;Only have drone shoot on down transition!
;This is ship day!  Is this wise?... No...
	btst	BUT1_B+8,a6		;>Shoot/block (But1)
	jrz	pass

;	btst	BUT3_B,a6
;	jrnz	tshoot			;Turbo override?

	move	*a13(plyr_turbon),a14
	jrnz	alyoop			;br=turbo is on!!

;If human just let up on his turbo butn, don't have drone shoot just yet
;We need to debounce shoot button to avoid accidental drone shots
;Especially on full court shots!

;	move	*a13(plyr_turbon),a0
;	cmpi	2,a0			;Ticks sice last turbo button press
;	jrle	pass

	move	@PSTATUS2,a0		;Plyr start bits 0-3
	move	*a13(plyr_num),a1
	XORK	1,a1
	btst	a1,a0
	jrnz	pass			;Teammate is a human?


;Lets ignore button if this is a full court shot and the shot clock and game
;time are not low.
;If low, allow stupid full court shot

	move	*a13(plyr_tmproc_p),a0,L
	move	*a0(plyr_ohpdist),a14
	cmpi	174h*DIST_ADDITION,a14
	jrlt	cont_shot			;Drone is close enough?


	move	@game_time,a1,L
	srl	8,a1			;Remove tenths
	subk	9,a1
	jrlt	cont_shot		;Less than 9 secs?
;Shot timer 10 or >?
	move	@shotimer+16,a1		;Tens
	jrnz	pass
;	move	@shotimer,a1		;Ones
;	subk	7,a1
;	jrge	pass

cont_shot


	move	*a13(plyr_tmproc_p),a0,L
	movk	DRN_SHOOT_M,a1
	move	a1,*a0(plyr_d_cflgs)

	move	*a0(plyr_ohpdist),a14
	cmpi	350*DIST_ADDITION,a14
	jrlt	pass			;Drone is close enough?

	move	@gmqrtr,a14
	jrnz	pass

	move	*a0(plyr_jmpcnt),a14
	jrnz	pass

	move	*a13(plyr_idiotbit),a14
	btst	1,a14
	jrnz	pass
	addk	2,a14
	move	a14,*a13(plyr_idiotbit)

	movk	4,a0
	move	*a13(plyr_num),a1
	calla	idiot_box		;Tell drone to shoot ball




pass					;>Pass/steal (But2)
	move	*a13(plyr_shtbutn),a0
	jrz	dblhit
	inc	a0
	move	a0,*a13(plyr_shtbutn)
dblhit

	move	*a13(plyr_ownball),a2
	jrz	steal			;No ball?

	move	*a13(plyr_rcvpass),a0
	jrgt	slp			;Waiting on pass?

	btst	BUT2_B+8,a6
	jrz	slp
	move	*a13(plyr_seqflgs),a14
	btst	PASS_B,a14
	jrnz	slp			;Passing?

	move	@pass_off,a14
	jrnz	slp			;Lockout passing for now?

	move	a2,a2
	jrlt	passtome
dopass

	callr	plyr_startpass
	jruc	slp

passtome				;>Tell drone to pass
	btst	BUT3_B,a6
	jrnz	steal			;Turbo?

	move	*a13(plyr_tmproc_p),a0,L
	movk	DRN_PASS_M,a1
;	btst	6,a6
;	jrz	regds			;No turbo?
;	ori	08000H,a1
regds	move	a1,*a0(plyr_d_cflgs)
	jruc	slp




steal
	btst	BUT2_B,a6
	jrz	slp			;No button?
	move	*a13(plyr_jmpcnt),a0
	jrnz	slp
	move	*a13(plyr_seq),a0
	move	*a13(plyr_num),a14
	move	@pup_nopush,a1
	btst	a14,a1
	jrnz	nopush
	btst	BUT3_B,a6
	jrnz	push			;Turbo?

nopush
;	cmpi	STEALUP_SEQ,a0
;	jreq	slp
	subi	STEAL_SEQ,a0
	jreq	slp

	move	*a13(plyr_rcvpass),a0
	jrgt	slp			;Getting pass?
	move	*a13(plyr_tmproc_p),a1,L
	move	*a1(plyr_rcvpass),a0
	jrgt	slp			;Getting pass?

;	move	*a13(plyr_keeppal),a0	;Getting up while on fire, on butt
;	jrz	noflames
;	calla	seq_stopfire
;noflames

;FIX!!!  Add STEALUP_SEQ here....

	movi	STEAL_SEQ,a0
;	movi	STEALUP_SEQ,a0
	callr	plyr_setseq
	move	*a13(plyr_balldir),*a13(plyr_newdir)

	jruc	slp

push
	btst	BUT2_B+8,a6
	jrz	slp			;No button?
	move	*a13(plyr_PDATA_p),a2,L
	move	*a2(ply_turbo),a1
	subk	(TURBO_CNT*2)/13,a1	;!!! Min cnt for push
	jrle	slp			;Turbo too low?
	subi	PUSH_SEQ,a0
	jreq	slp

	move	*a13(plyr_num),a0	;If on fire, don't use turbo on push
	move	@plyr_onfire,a14
;;	cmp	a0,a14
;;	jrz	notingame2
	btst	a0,a14
	jrnz	notingame2		;br=on-fire

	move	a1,*a2(ply_turbo)
	sll	5,a1
	.ref	TURBO_52
	addi	TURBO_52,a1
	move	*a2(ply_meter_imgs+32),a0,L
	move	*a1(0),*a0(OSAG),L

;	subk	8,a1
;	move	a1,*a2(ply_turbo)
;	move	*a2(ply_meter_imgs+40h),a0,L
;	move	*a0(OFSET),a1		;Shrink meter
;	addk	8,a1
;	move	a1,*a0(OFSET)

notingame2
;	calla	seq_stopfire
	movi	PUSH_SEQ,a0
	callr	plyr_setseq

slp
	move	*a13(plyr_ownball),a1
	jrle	nob
	callr	plyr_setballxyz
nob

halted
	callr	plyr_headalign
	callr	plyr_setshadow

;	.if	DEBUG
;	callr	plyr_setgndaligndot
;	.endif

	SLOOP	1,main_lp  ;Assumption this need to go to main player loop.

;--------------------
; plyr  bit val (1,2,3 or 4,8,C) to tm  bit val (1 or 2)

	.def	pbit_tbit
	.def	pbit_tval

pbit_tbit
	.byte	0,1,1,1,2,0,0,0
	.byte	2,0,0,0,2,0,0,0

; plyr  bit val (1,2,3 or 4,8,C) to tm  val (0 or 1)

pbit_tval
	.byte	-1, 0, 0, 0, 1,-1,-1,-1
	.byte	 1,-1,-1,-1, 1,-1,-1,-1

;--------------------

;	.ref	W5ST1
;; matchup-screen player init
;;		PID,Dir,TLXoff,Z
;;		OIMG
;pmatch_t
;	.word	P1_PID,3<<4,118,CZMID+106
;	.long	W5ST1
;pm1	.word	P2_PID,3<<4,168,CZMID+64
;	.long	W5ST1
;	.word	P3_PID,3<<4,242,CZMID+64
;	.long	W5ST1
;	.word	P4_PID,3<<4,289,CZMID+106
;	.long	W5ST1
;	.if DRONES_2MORE
;	.word	P5_PID,3<<4,195,CZMID		;last drone on team1
;	.long	W5ST1
;	.word	P6_PID,3<<4,195,CZMID		;last drone on team2
;	.long	W5ST1
;	.endif

; tip-off init
;		PID,Dir,TLXoff,Z
;		OIMG

pdat_t	.word	P1_PID,3<<4,120,CZMID-50
	.long	w4stand1
;	.long	w3run1
pd1	.word	P2_PID,2<<4,180,CZMID-5
	.long	w3stand1
;	.long	w3run1
	.word	P3_PID,7<<4,235,CZMID+5
	.long	w5stand1
;	.long	w3run1
	.word	P4_PID,7<<4,280,CZMID+45
	.long	w5stand1
;	.long	w3run1
	.if DRONES_2MORE
	.word	P5_PID,1<<4,120,CZMID+50		;last drone on team1
	.long	w5stand1
;	.long	w3run1
	.word	P6_PID,5<<4,280,CZMID-50		;last drone on team2
	.long	w5stand1
;	.long	w3run1
	.endif

	.def	ltshoepal_t
ltshoepal_t
;	COLORW	31,31,31, 27,27,27, 22,22,22, 18,18,18
;	COLORW	14,14,14
	.word   07fffh,077bdh,06f7bh
	.word	06739h,05ef7h,05294h
	.word	04a52h,04210h,039ceh
	.word	0318ch,0294ah,02108h
;	.word	018c6h,00c63h,00421h	;Shoes use only 13 colors
	.word	00000h
;dkshoepal_t
;	COLORW	8,8,8, 6,6,6, 5,5,5, 4,4,4
;	COLORW	2,2,2


dirc_t	.byte	0,0,4<<4,0,6<<4,7<<4,5<<4,0,2<<4,1<<4,3<<4,0,0,0,0,0

;;pdta_l	.long	P1DATA,P2DATA,P3DATA,P4DATA,P5DATA,P6DATA


sqsnds	.long	sqk1_snd,sqk2_snd,sqk3_snd,sqk4_snd,sqk5_snd,sqk6_snd
sqsnds2
	.long	scuf1_snd,scuf2_snd,scuf3_snd,scuf4_snd,scuf2_snd,scuf3_snd

kpball_t
;	.word	100,130,160,190,200,220,280,300,450,550,850
;	.word	190,200,220,280,300,450,550,600,650,650,650

	.asg	80/100,reduce
;	.word	100,130,160,190,200,220,280,300,450,450,450

	.word	100*reduce,130*reduce,160*reduce,190*reduce
	.word	200*reduce,220*reduce,280*reduce,300*reduce
	.word	450*reduce,450*reduce,450*reduce

noblflail_t
;	.word	50,65,80,80,80,80,100,130,170,250,250
	.word	85,100,105,110,115,120,150,190,250,250,300

shortfly_t
	.word	50,100,140,160,180,200,250,300,400,550,650
;	.word	140,160,180,200,250,300,400,550,650,650,650

winshortfly_t
	.word	50/2,100/2,100/2,120/2,150/2,150/2,200/2,300/2,450/2,550/2,550/2

flyb_t
;Extra % chance of allowing losing team to keep ball after being pushed
;1 pt down up to 15 & over down
;	.word	250,275,300,325,350,375,400,425,450,475,500
;	.word	500,500,500,500,500,500,500,500

;	.word	25,50,75,100,125,150,175,200,225,250,275
;	.word	275,275,275,275,275,275,275,275,275

	.asg	80/100,reduce2
	.word	25*reduce2,50*reduce2,75*reduce2,100*reduce2,125*reduce2
	.word	150*reduce2,175*reduce2,200*reduce2,225*reduce2,250*reduce2
	.word	275*reduce2,275*reduce2,275*reduce2,275*reduce2,275*reduce2
	.word	275*reduce2,275*reduce2,275*reduce2,275*reduce2,275*reduce2

RED_C	.equ	3	;0	;No red with blu/blk/prp
GRN_C	.equ	1
BLU_C	.equ	3
PUR_C	.equ	3	;4	;No blk/prp
BLK_C	.equ	3
WHT_C	.equ	6
;YEL_C	.equ	7
	.asg	080H,I	;Always keeps home colors
;;;
;;; updated to account to 30 teams
;;;
;;; referenced in BB3 for bench palette build
;;;
	.def	teampal_t
;	 0 ATLANTA
;	 1 BOSTON
;	 2 CHARLOTTE
;	 3 CHICAGO
;	 4 CLEVELAND
;	 5 DALLAS
;	 6 DENVER
;	 7 DETROIT
;	 8 GOLDEN STATE
;	 9 HOUSTON
;	10 INDIANA
;	11 LOS ANGELES (CLIPPERS)
;	12 LOS ANGELES (LAKERS)
;	13 MIAMI
;	14 MILWAUKEE
;	15 MINNESOTA
;	16 NEW JERSEY
;	17 NEW YORK
;	18 ORLANDO
;	19 PHILADELPHIA
;	20 PHOENIX
;	21 PORTLAND
;	22 SACRAMENTO
;	23 SAN ANTONIO
;	24 SEATTLE
;	25 TORONTO
;	26 UTAH
;	27 VANCOUVER
;	28 WASHINGTON

teampal_t
	.byte	RED_C,GRN_C,BLU_C,RED_C,BLK_C
	.byte	BLU_C,BLK_C,BLU_C,BLU_C,RED_C
	.byte	BLK_C,RED_C,PUR_C,BLK_C,PUR_C
	.byte	BLU_C,BLU_C,BLU_C,BLK_C,RED_C
	.byte	PUR_C,BLK_C,BLK_C,BLK_C,GRN_C
	.byte	BLU_C,PUR_C,BLK_C,RED_C,BLK_C

;DJT Start
	.def	hotspot_xz_t,hotspot_xz_tend

hotspot_xz_t
	.word	WRLDMID+017cH,CZMID-082H
	.word	WRLDMID+0148H,CZMID-082H
	.word	WRLDMID+00d8H,CZMID-080H
	.word	WRLDMID+0110H,CZMID-07cH
	.word	WRLDMID+0084H,CZMID-07aH
	.word	WRLDMID+00acH,CZMID-060H
	.word	WRLDMID+0088H,CZMID-040H
	.word	WRLDMID+00d4H,CZMID-040H
	.word	WRLDMID+007cH,CZMID-014H
	.word	WRLDMID+00a4H,CZMID+000H
	.word	WRLDMID+0082H,CZMID+026H
	.word	WRLDMID+00d4H,CZMID+048H
	.word	WRLDMID+0098H,CZMID+056H
	.word	WRLDMID+00b6H,CZMID+07cH
	.word	WRLDMID+0090H,CZMID+090H
	.word	WRLDMID+00dcH,CZMID+098H
	.word	WRLDMID+011cH,CZMID+0aeH
	.word	WRLDMID+00b0H,CZMID+0b8H
	.word	WRLDMID+0148H,CZMID+0baH
	.word	WRLDMID+00f6H,CZMID+0caH
	.word	WRLDMID+017cH,CZMID+0beH
hotspot_xz_tend

NUM_HOTSPOTS	.equ	(hotspot_xz_tend-hotspot_xz_t)/32
	.def	NUM_HOTSPOTS

;DJT End

********************************
* Setup player sequence data
* A0=Sequence 
* A7=Dir 0-127
* A13=*Player process
* 0A10H=New ani cnt
* Trashes scratch

 SUBR	plyr_setseq

	cmpi	TIP_SEQ,a0
	jrnz	bugok
	move	@scores,a14,L
	jrz	bugok			;Game start?
	.if	DEBUG
	LOCKUP
	.endif
	movk	STND_SEQ,a0
	
bugok
	move	a0,*a13(plyr_seq)

	sll	5,a0			;*32
	addi	pseq_t,a0
	move	*a0,a0,L
	move	*a0+,a1			;Get flags
	move	a1,*a13(plyr_seqflgs)


	btst	DRIBBLE_B,a1		;0CaHlc new dribble mode
	jrnz	d

	move	*a13(plyr_dribmode),a14
	jrz	n
	movi	-1,a1
	jruc	setd

d	move	*a13(plyr_dribmode),a14
	jrnz	n
	movk	1,a1

setd	move	a1,*a13(plyr_dribmode)
n

	move	*a0+,a1,L		;Get *code
	move	a1,*a13(plyr_seqcode_p),L
	move	a7,a1			;Dir
	addk	8,a1			;Round off
	sll	32-7,a1
	srl	32-7+4,a1		;Kill frac
	move	a1,*a13(plyr_seqdir)

	clr	a14			;Dir 5-7 have reversed FLIPH
	cmpi	5,a1
	jrlt	nohf1
	movi	M_FLIPH,a14
nohf1
	move	a14,*a13(plyr_anirevff)

	sll	32-3,a1			;Clr bits
	srl	32-3-5,a1		;*32
	add	a1,a0
	move	*a0,a0,L
	move	a0,*a13(plyr_ani1st_p),L
	move	a0,*a13(plyr_ani_p),L

	movk	1,a10

	rets


********************************
* Delete a players processes and objects
* A0=Plyr  (0-3)

; SUBRP	plyr_del
;
;	PUSH	a2,a3
;
;	move	a0,a2
;	move	a0,a3
;	sll	5,a3		;*32
;	addi	pdel_t,a3
;
;	move	*a3+,a0
;	calla	KIL1C		;Kill process
;
;	move	*a3+,a0
;	calla	obj_del1c	;Kill plyr images
;
;	clr	a0
;	sll	5,a2		;*32
;	movi	plyrobj_t,a1
;	add	a2,a1
;	move	a0,*a1,L
;
;	addi	plyrproc_t,a2
;	move	a0,*a2,L
;
;	PULL	a2,a3
;	rets
;
;
;pdel_t	.word	P1_PID,CLSPLYR|TYPPLYR|SUBPL1
;	.word	P2_PID,CLSPLYR|TYPPLYR|SUBPL2
;	.word	P3_PID,CLSPLYR|TYPPLYR|SUBPL3
;	.word	P4_PID,CLSPLYR|TYPPLYR|SUBPL4




********************************
* Update player controls (called by main loop)

 SUBR	joy_read

	move	@GAMSTATE,a0
	subk	INGAME,a0
	jrne	joy_read_x
	move	@HALT,a0
	jrnz	joy_read_x
	move	@plyrproc_t,a0,L	;Get 1st plyr proc
	move	*a0(plyr_autoctrl),a0
	jrnz	joy_read_x			;Temp computer control?

 SUBR	joy_read2		        	;Called by reftip

	move	@PSTATUS2,a0		;Plyr start bits 0-3

	.if	TUNIT

	move	@TWOPLAYERS,a14		;!0=2 plyr kit
	jrz	    a4p

	movi	P2CTRL,a1		;A1=*PxCTRL
;	move	@SWITCH,a2
	move	@_switch_addr,a2,L
	move	*a2,a2

	not	    a2

	srl	    2,a0			;P2
	jrnc	no2p2
	move	*a1,a14
	xor	    a2,a14			;New with old. Changed bits are now on
	and	    a2,a14			;Keep down transitions
	sll	    8,a14
	move	a2,a3
	sll	    32-8,a3
	srl	    32-8,a3
	or	    a3,a14
	move	a14,*a1

no2p2	
    addk	16,a1			;P3
	srl	1,a0
	jrnc	joy_read_x
	zext	a2
	srl	    8,a2
	move	*a1,a14
	xor	    a2,a14			;New with old. Changed bits are now on
	and	    a2,a14			;Keep down transitions
	sll	    8,a14
	or	    a2,a14
	move	a14,*a1
	jruc	joy_read_x

a4p					        ;04H player version
	movi	P1CTRL,a1		;A1=*PxCTRL

;	move	@SWITCH,a2
	move	@_switch_addr,a2,L
	move	*a2,a2

	not	a2

	srl	    1,a0			;P1
	jrnc	joy_read_nop1
	move	*a1,a14
	xor	    a2,a14			;New with old. Changed bits are now on
	and	    a2,a14			;Keep down transitions
	sll	    8,a14
	move	a2,a3
	sll	    32-8,a3
	srl	    32-8,a3
	or	    a3,a14
	move	a14,*a1

joy_read_nop1	
    addk	16,a1			;P2
	srl	    1,a0
	jrnc	joy_read_nop2
	zext	a2
	srl	    8,a2
	move	*a1,a14
	xor	    a2,a14			;New with old. Changed bits are now on
	and	    a2,a14			;Keep down transitions
	sll	    8,a14
	or	    a2,a14
	move	a14,*a1

joy_read_nop2
;	move	@SWITCH2,a2
	move	@_switch2_addr,a2,L
	move	*a2,a2

	not	a2

	addk	16,a1			;P3
	srl	    1,a0
	jrnc	joy_read_nop3
	move	*a1,a14
	xor	    a2,a14			;New with old. Changed bits are now on
	and	    a2,a14			;Keep down transitions
	sll	    8,a14
	move	a2,a3
	sll	    32-8,a3
	srl	    32-8,a3
	or	    a3,a14
	move	a14,*a1

joy_read_nop3	    
    srl	1,a0			;P4
	jrnc	joy_read_x
	addk	16,a1
	zext	a2
	srl	    8,a2
	move	*a1,a14
	xor	    a2,a14			;New with old. Changed bits are now on
	and	    a2,a14			;Keep down transitions
	sll	    8,a14
	or	    a2,a14
	move	a14,*a1

	.else				;>YUNIT

	move	@SWITCH,a2,L
	not	a2

	srl	1,a0			;P1
	jrnc	joy_read_nop1a
	move	*a1,a14
	xor	a2,a14			;New with old. Changed bits are now on
	and	a2,a14			;Keep down transitions
	sll	8,a14
	move	a2,a3
	sll	32-8,a3
	srl	32-8,a3
	or	a3,a14
	move	a14,*a1

joy_read_nop1a	
    addk	16,a1			;P2
	srl	8,a2
	srl	1,a0
	jrnc	joy_read_nop_2a
	move	*a1,a14
	xor	a2,a14			;New with old. Changed bits are now on
	and	a2,a14			;Keep down transitions
	sll	8,a14
	move	a2,a3
	sll	32-8,a3
	srl	32-8,a3
	or	a3,a14
	move	a14,*a1

joy_read_nop2a	
    addk	16,a1			;P3
	srl	1,a0
	jrnc	joy_read_nop3a
	srl	16,a2
	move	a2,a14			;>Move bit 7 to 6 (But 3)
	sll	32-6,a2
	srl	7,a14
	or	a14,a2
	rl	6,a2
	move	*a1,a14
	xor	a2,a14			;New with old. Changed bits are now on
	and	a2,a14			;Keep down transitions
	sll	8,a14
	or	a2,a14
	move	a14,*a1

joy_read_nop3a	
    srl	1,a0			;P4
	jrnc	joy_read_x
	move	@SWITCH+020H,a2
	not	a2
	addk	16,a1
	sll	32-8,a2
	srl	32-8,a2
	move	*a1,a14
	xor	a2,a14			;New with old. Changed bits are now on
	and	a2,a14			;Keep down transitions
	sll	8,a14
	or	a2,a14
	move	a14,*a1


	.endif

joy_read_x ; first
	rets

;	.if 0
;	move	@GAMSTATE,a0
;	subk	INGAME,a0
;	jrne	x
;	move	@HALT,a0
;	jrnz	x
;	move	@plyrproc_t,a0,L	;Get 1st plyr proc
;	move	*a0(plyr_autoctrl),a0
;	jrnz	x			;Temp computer control?
;
; SUBRP	joy_read2			;Called by reftip
;
;	move	@PSTATUS2,a0		;Plyr start bits 0-3
;	movi	P1CTRL,a1		;A1=*PxCTRL
;
;	.if	TUNIT
;
;	move	@SWITCH,a2
;	not	a2
;
;	srl	1,a0			;P1
;	jrnc	nop1
;	move	*a1,a14
;	xor	a2,a14			;New with old. Changed bits are now on
;	and	a2,a14			;Keep down transitions
;	sll	8,a14
;	move	a2,a3
;	sll	32-8,a3
;	srl	32-8,a3
;	or	a3,a14
;	move	a14,*a1
;
;nop1	addk	16,a1			;P2
;	srl	1,a0
;	jrnc	nop2
;	zext	a2
;	srl	8,a2
;	move	*a1,a14
;	xor	a2,a14			;New with old. Changed bits are now on
;	and	a2,a14			;Keep down transitions
;	sll	8,a14
;	or	a2,a14
;	move	a14,*a1
;
;nop2
;	move	@SWITCH2,a2
;	not	a2
;
;	addk	16,a1			;P3
;	srl	1,a0
;	jrnc	nop3
;	move	*a1,a14
;	xor	a2,a14			;New with old. Changed bits are now on
;	and	a2,a14			;Keep down transitions
;	sll	8,a14
;	move	a2,a3
;	sll	32-8,a3
;	srl	32-8,a3
;	or	a3,a14
;	move	a14,*a1
;
;nop3	srl	1,a0			;P4
;	jrnc	x
;	addk	16,a1
;	zext	a2
;	srl	8,a2
;	move	*a1,a14
;	xor	a2,a14			;New with old. Changed bits are now on
;	and	a2,a14			;Keep down transitions
;	sll	8,a14
;	or	a2,a14
;	move	a14,*a1
;
;	.else
;
;	move	@SWITCH,a2,L
;	not	a2
;
;	srl	1,a0			;P1
;	jrnc	nop1
;	move	*a1,a14
;	xor	a2,a14			;New with old. Changed bits are now on
;	and	a2,a14			;Keep down transitions
;	sll	8,a14
;	move	a2,a3
;	sll	32-8,a3
;	srl	32-8,a3
;	or	a3,a14
;	move	a14,*a1
;
;nop1	addk	16,a1			;P2
;	srl	8,a2
;	srl	1,a0
;	jrnc	nop2
;	move	*a1,a14
;	xor	a2,a14			;New with old. Changed bits are now on
;	and	a2,a14			;Keep down transitions
;	sll	8,a14
;	move	a2,a3
;	sll	32-8,a3
;	srl	32-8,a3
;	or	a3,a14
;	move	a14,*a1
;
;nop2	addk	16,a1			;P3
;	srl	1,a0
;	jrnc	nop3
;	srl	16,a2
;	move	a2,a14			;>Move bit 7 to 6 (But 3)
;	sll	32-6,a2
;	srl	7,a14
;	or	a14,a2
;	rl	6,a2
;	move	*a1,a14
;	xor	a2,a14			;New with old. Changed bits are now on
;	and	a2,a14			;Keep down transitions
;	sll	8,a14
;	or	a2,a14
;	move	a14,*a1
;
;nop3	srl	1,a0
;	jrnc	x
;	move	@SWITCH+020H,a2
;	not	a2
;	addk	16,a1
;	sll	32-8,a2
;	srl	32-8,a2
;	move	*a1,a14
;	xor	a2,a14			;New with old. Changed bits are now on
;	and	a2,a14			;Keep down transitions
;	sll	8,a14
;	or	a2,a14
;	move	a14,*a1
;
;
;	.endif
;
;x
;	rets
;
;	.endif

********************************
* Check for collision with opponent players
* A8=*Obj
* A13=*Player process
* Trashes scratch

	.asg	1,BABY_DETECT

 SUBRP	plyr_chkpcollide

	PUSH	a2,a3,a4,a5,a6,a7,a9,a10,a11

	move	*a8(OXPOS),a4
	move	*a8(OXANI+16),a5
	add	a5,a4			;Img center X
	move	a4,a5			;Copy for X box rgt
	move	*a8(OZPOS),a6		;A6=my Z

	move	*a8(OSIZEX),a2		;Get SIZEX & bump up if small img
	move	*a8(OIMG),a0,L
	move	*a0(IFLAGS),a14		;Large img? Yes if !-
	jrnn	pcc_1
	move	a2,a14			;Small img
	srl	2,a14
	add	a14,a2			;=125%
pcc_1
;	move	*a0(ICBZ),a11		;A11=Z radius
;	jrnz	pcc_2
;	movk	13,a11			;stupid K!!!A11=Z radius
	movk	13*2,a11		;stupid K!!!A11=Z radius (for both)
;pcc_2
	.if BABY_DETECT
	move	@pup_baby,a14		;Plyr babies? No if 0
	jrz	pcc_3
	srl	1,a2			;Yes. Half of X & Z ranges
	srl	1,a11
pcc_3
	.endif
	srl	1+1,a2			;Half for lft/rgt, more to tighten up
	sub	a2,a4			;A4=my box lft X
	add	a2,a5			;A5=my box rgt X

	movi	plyrobj_t,a7		;Set ptr to other team
	move	*a13(plyr_num),a0
	subk	2,a0
	jrge	pcc_4
	addi	64,a7
pcc_4
	movk	2,b1			;Lp cnt

;--------------------
; top of test loop

test_lp	; Top of test loop
    move	*a7+,a9,L

	move	*a9(OZPOS),a2		;Chk Z
	sub	    a6,a2
	abs	    a2			;A2=ABS(dZ)
;	move	*a9(OIMG),a0,L
;	move	*a0(ICBZ),a3		;Get Z radius
;	jrnz	pcc_l1
;	movk	13,a3			;stupid K!!!A11=Z radius
;pcc_l1
;	.if BABY_DETECT
;	move	@pup_baby,a14		;Plyr babies? No if 0
;	jrz	pcc_l2
;	srl	1,a3			;Yes. Half of Z range
;pcc_l2
;	.endif
;	add	    a11,a3
	move	a11,a3			;!!!Replaces previous comments
	cmp	    a3,a2			;Z in range? No if >=
	jrge	next

	move	*a9(OXPOS),a1		;Chk X
	move	*a9(OXANI+16),a2
	add	    a2,a1			;Img center X
	move	*a9(OSIZEX),a2		;Get SIZEX & bump up if small img
	move	*a9(OIMG),a0,L
	move	*a0(IFLAGS),a14		;Large img? Yes if !-
	jrnn	pcc_l3
	move	a2,a14			;Small img
	srl	    2,a14
	add	    a14,a2			;=125%
pcc_l3
	.if BABY_DETECT
	move	@pup_baby,a14		;Plyr babies? No if 0
	jrz	    pcc_l4
	srl	    1,a2			;Yes. Half of X range
pcc_l4
	.endif
	srl	    1+1,a2			;Half for lft/rgt, more to tighten up
	add	    a2,a1			;A1=his box rgt
	sub	    a4,a1			;His rgt > my lft? No if <=
	jrle	next
	move	a1,a10			;A10=his rgt,my lft dX
	add	    a4,a1
	sub	    a2,a1
	sub	    a2,a1			;A1=his box lft
	sub	    a5,a1			;His lft < my rgt? No if >=
	jrge	next

	abs	    a1			;Make A10=ABS(nearer dX)
	cmp	    a1,a10
	jrle	pcc_l5
	move	a1,a10
pcc_l5
	move	*a8(OYPOS),a0		;Chk Y
	move	*a9(OYPOS),a1
	addi	75,a1			;stupid K!!! Y difference
	cmp	    a1,a0
	jrgt	next			;Opponent much higher?

;---------- Detected

	move	*a8(OXVEL),a14,L	;>Outer box collision
	abs	    a14
	srl	    15,a14
	jrnz	otrbnc			;Moving in X? Yes if !0
	move	*a8(OZVEL),a2,L
	abs	    a2
	srl	    15,a2
	jrz	    chkib			;Not moving in Z? Yes if 0
otrbnc
	PUSH	a6,a7
	clr	    a0
	clr	    a1
	move	*a8(OXVEL),a6,L
	move	*a8(OZVEL),a7,L
	callr	seekdir_xyxy128		;Customize?
	PULL	a6,a7

	move	*a13(plyr_num),a2
	sll	    2,a2			;*4
	move	*a9(OPLINK),a1,L
	move	*a1(plyr_num),a1
	add	    a1,a2
	sll	    4,a2			;*16
	addi	c_t,a2
	move	*a2,a2			;Get my dir variable offset
	add	    a13,a2
	move	*a2,a2			;Get dir

	sub	    a0,a2
	move	a2,a14
	abs	    a14
	cmpi	040H,a14
	jrle	dsmlb
	neg	    a2
dsmlb	
    move	a2,a2
	jrge	angpos			;Positive angle?
	addi	028H+028H,a0
angpos	
    subi	028H,a0

	addk	4,a0
	sll	    32-7,a0
	srl	    32-7+3,a0		;Leave 4 bits
	sll	    4,a0
	addi	vel_t,a0

	move	*a0,a1
	move	*a0(16*4),a0
	sll	    1,a0
	sll	    1,a1
	move	*a8(OXVAL),a14,L
	add	    a0,a14
	move	a14,*a8(OXVAL),L
	move	*a8(OZVAL),a14,L
	add	    a1,a14
	move	a14,*a8(OZVAL),L

chkib
	movk	6,a2			;stupid K!!!Inner box delta
	.if     BABY_DETECT
	move	@pup_baby,a14		;Plyr babies? No if 0
	jrz	    pcc_ib1
	srl	    1,a2			;Yes. Half of delta
pcc_ib1
	.endif
	sub	    a2,a10			;X touch only slight?
	jrle	next

	move	*a9(OZPOS),a1
	sub	    a6,a1
	abs	    a1			;Z distance
	sub	    a2,a3
	cmp	    a3,a1			;Z touch only slight? Yes if >=
	jrge	next

	move	*a8(OXVEL),a14,L	;>Inner box collision
	move	*a9(OXVEL),a2,L
	move	a2,a3
	xor	    a14,a2
	move	a2,a2
	jrn	    xvdif			;XV different dir?
	move	a14,a0
	abs	    a3
	abs	    a0
	cmp	    a3,a0
	jrlt	skipxv			;My vel smaller?
	xor	    a14,a2			;Fix A2
	sub	    a2,a14
xvdif
	move	*a8(OXVAL),a1,L
	sub	    a14,a1
	move	a1,*a8(OXVAL),L
skipxv
	move	*a8(OZVEL),a14,L
	move	*a9(OZVEL),a2,L
	move	a2,a3
	xor	    a14,a2
	move	a2,a2
	jrn	    zvdif			;ZV different dir?
	move	a14,a0
	abs	    a3
	abs	    a0
	cmp	    a3,a0
	jrlt	next			;My vel smaller?
	xor	    a14,a2			;Fix A2
	sub	    a2,a14
zvdif
	move	*a8(OZVAL),a1,L
	sub	    a14,a1
	move	a1,*a8(OZVAL),L


	move	*a13(plyr_ownball),a0
	jrgt	next			;I have ball?

	move	*a13(plyr_stagcnt),a10	;0AddH some stagger
	move	*a9(OPLINK),a14,L

	move	*a14(plyr_seqflgs),a0
	btst	DUNK_B,a0
	jrz	    nodunk			;!Dunking?

;This dunker may not have the ball!  Do I own it?
	move	*a14(plyr_num),a2
	move	@ballpnum,a3
	cmp	    a2,a3
	jrnz	nodunk

	btst	LAYUP_B,a0
	jrnz	nodunk			;Layup=don't disrupt ball

	addk	1,a10
	move	*a13(plyr_num),a0
	move	*a14(plyr_num),a2
	srl	    1,a0
	srl	    1,a2
	cmp	    a0,a2
	jreq	nodunk			;Same team?

	move	*a13(plyr_jmpcnt),a0
	jrz	    nopop
	move	*a8(OYPOS),a0
	move	*a9(OYPOS),a1
	addk	9,a1			;15

	cmp	a1,a0
	jrgt	nopop			;Dunker is higher?


	move	@slamming,a0		;Ball already successfully into hoop
	jrnz	nopop

	move	@HCOUNT,a0
	sll	32-4,a0
	jrnz	noflsh

	calla	flash_reward

noflsh
;Shawn, this % should also key off from ptsdown.  The % should never get
;higher, but maybe get a bit lower for the good team?

	move	*a13(plyr_attrib_p),a14,L
	move	*a14(PAT_DEFSKILL),a0
	sll	    4,a0
	addi	tryblk_t,a0
	move	*a0,a0

;	movk	22,a0			;38,25,21,19


	move	*a13(plyr_num),a14

;	move	@plyr_onfire,a3
;	btst	a14,a3
;	jrz	    nofire			;br=not on-fire
;;This guy on fire
;	movi	75,a0
;nofire

	move	@PSTATUS2,a3
	btst	a14,a3
	jrnz	contb
	movk	18,a0			;Drone is less
contb

	calla	RNDPER
	jrls	nopop

;	movk	01fH,a0
;	callr	rnd
;	jrnz	nopop


	move	a13,a3
	calla	def_play_reward		;Good defensive play reward snds, etc

;If player is still going up, give him ball, otherwise, maybe disrupt dunk

	move	*a13(plyr_seq),a0
	cmpi	BLOCKREJ_SEQ,a0
	jreq	disrupt
	cmpi	FASTBLOCKREJ_SEQ,a0
	jreq	disrupt

	movi	200,a0
	calla	RNDPER
	jrhi	disrupt

	move	*a8(OYVEL),a0,L
	jrn	gvbl

disrupt
;If coming down, disrupt ball

;	movi	200,a0
;	calla	RNDPER
;	jrhi	gvbl

;Probably want to give swatter the ball if this is a rebound!
;Check goaltcnt?
	
	.ref	deflected_speech
	calla	deflected_speech

	move	*a13(plyr_dir),a0
	calla	sinecos_get

	move	@ballobj_p,a2,L

	sll	    4,a0
	sll	    4,a1
	move	a0,*a2(OZVEL),L
	move	a1,*a2(OXVEL),L
	movi	-GRAV*21,a1		;Towards roof
	move	a1,*a2(OYVEL),L

	movi	-1,a0
	move	a0,@ballpnum
	move	a0,@ballpnumlast

	calla	ball_convfmprel

	move	*a9(OPLINK),a14,L

	clr	    a0
	move	a0,*a14(plyr_ownball)
	move	a0,@ballbbhitcnt

	movk	15,a0
	move	a0,*a13(plyr_shtdly)
	move	a0,*a14(plyr_shtdly)

    jruc	nopop

gvbl
	.ref	in_air_steal_speech
	calla	in_air_steal_speech

	move	*a13(plyr_num),a0	;Give defender the ball
	move	a0,@ballpnum
	clr	a0
	move	a0,*a13(plyr_dribmode)
	move	a0,@ballbbhitcnt

;	movi	steal_snd,a0
;	calla	snd_play1

nopop
;	move	@plyrcharge,a0
;	addk	1,a0
;	move	a0,@plyrcharge

nodunk	move	*a14(plyr_jmpcnt),a3
	jrz	    ongnd
	addk	1,a10			;Collided with a jumper
ongnd
	move	*a13(plyr_seqflgs),a2
	btst	EASYSTAG_B,a2
	jrz	    nesy			;!An easy stagger?
	move	*a13(plyr_num),a0
	move	*a14(plyr_num),a2
	srl	    1,a0
	srl	    1,a2
	cmp	    a0,a2
	jreq	setstg			;Same team?
	addk	1,a10
nesy
setstg	move	a10,*a13(plyr_stagcnt)

next	dsj	b1,test_lp


testlp_x	
    PULL	a2,a3,a4,a5,a6,a7,a9,a10,a11
	rets

tryblk_t
	.word	1,2,3,10,15,18,22,23,24,25,25

c_t	.word	0,plyr_tmdir,plyr_o1dir,plyr_o2dir
	.word	plyr_tmdir,0,plyr_o1dir,plyr_o2dir
	.word	plyr_o1dir,plyr_o2dir,0,plyr_tmdir
	.word	plyr_o1dir,plyr_o2dir,plyr_tmdir,0

vel_t
	.word	-16384,-15137,-11585,-6270
	.word	0,6270,11585,15137,16384,15137,11585,6270
	.word	0,-6269,-11585,-15137,-16384,-15137,-11585,-6270



********************************
* Change the players image
* A0=*New image
* A1=New OCTRL (low 8 bits)
* A8=*Obj
* A13=*Plyr process
* Trashes scratch, A2,A3

 SUBRP	plyr_ani

	cmpi	ROM,a0
	jrlo	anierr

	move	a0,a2
	move	a1,a3
	callr	anipt_getsclxy		;get old XY ani's

	move	a2,*a8(OIMG),L
	movb	a3,*a8(OCTRL)
	move	*a2(ISIZE),*a8(OSIZE),L
	move	*a2(ISAG),*a8(OSAG),L

	move	*a13(plyr_attrib_p),a3,L
	move	*a3,a3,L		;Get *scale_t
	move	@pup_baby,a14		;Plyr babies? No if 0
	jrz	pa_1
	movi	scalebaby_t,a3		;Yes. Set baby *scale_t
pa_1
	move	*a2(IFLAGS),a14		;Large img? Yes if !-
	jrnn	contc
	addi	scale_t_size,a3		;No. Set small img *scale_t
contc
	move	a3,*a8(ODATA_p),L	;Save *scale_t

	move	a0,a2			;save old XY ani's
	move	a1,a3
	callr	anipt_getsclxy		;get new XY ani's

	sub	a0,a2			;subtract new from old
	sub	a1,a3

	move	a0,*a8(OXANI),L		;save new X ani
	sra	16,a1			;Y ani int only
	move	a1,*a13(plyr_aniy)	;save new Y ani

	move	a8,a0			;set XVAL base addr
	addi	OXVAL,a0
	move	*a0,a14,L		;mod XVAL with diff of old X ani to
	add	a2,a14			; new X ani
	move	a14,*a0+,L
	move	*a0,a14,L		;mod YVAL with diff of old Y ani to
	add	a3,a14			; new Y ani
	move	a14,*a0,L

anilp_x	rets

anierr 
	.if	DEBUG
	LOCKUP
	eint
	.else
	CALLERR	2,2
	.endif
	jruc	anilp_x



********************************
* Start player jumping (block, shoot, dunk)
* A1=Shot distance
* A8=*Plyr obj
* A13=*Plyr process
* Trashes scratch, A2-A5

 SUBRP	plyr_startjmp

	PUSH	a6,a7,a9

;DJT Start
	clr	a14
	move	a14,*a13(plyr_hotspotf)	;Clr hotspot jump flag
	move	a14,*a13(plyr_hotspotp)	;Clr hotspot shot %
;DJT End

	move	*a13(plyr_ownball),a5
	jrz	blk			;We don't have ball?

	move	*a13(plyr_ohoopx),a6
	movi	CZMID,a7
	callr	seekdirdist_obxz128

	move	*a13(plyr_newdir),a9	;Get old
	move	a0,*a13(plyr_newdir)	;Turn toward basket

	move	a5,a5
	jrn	tag1			;trick shot shit
;	jrlt	blkd			;Teammate has ball?

;DJT Start
	move	*a8(OXPOS),a0		;Chk hotspot X
	move	*a8(OXANI+16),a14
	add	a14,a0
	move	*a13(plyr_hotspotx),a14
	sub	a14,a0
	abs	a0
	subk	HOTSPOTX_RNG,a0
	jrnn	hsnoshow

	move	*a8(OZPOS),a0		;Chk hotspot Z
	move	*a13(plyr_hotspotz),a14
	sub	a14,a0
	abs	a0
	subk	HOTSPOTZ_RNG,a0
	jrnn	hsnoshow

;Shooter is on his hotspot!
;Do ball smoke puff
	movk	1,a14
	move	a14,*a13(plyr_hotspotf)		;Set hotspot jump flag

hsnoshow
;DJT End
	clr	a14
	move	a14,@reduce_3ptr

	cmpi	1b0h,a1			;400+15%;!!!Desperation shot?
	jrge	desp			; br=yes

	cmpi	136h,a1			;270+15%;!!!Long 3ptr?
	jrge	i3ptr			; br=yes

	cmpi	0c0h,a1			;200+15%;!!!Hook allowed?
	jrge	tag1

;Attempt a hook from the top of scrn down toward hoop
;Must be near top of scrn, near baseline, and running in same dir
;for at least several ticks.
	move	*a8(OZPOS),a0
	movi	CZMID,a14
	sub	a0,a14
;Don't allow this hook from 3pt range
	cmpi	110,a14
	jrgt	tag1			;Near 3 pt range?
	cmpi	70,a14
	jrgt	yes0
;Yes, I am near top of scrn


;Attempt a hook from the bottom of scrn up toward hoop
;Must be near bottom of scrn, near baseline, and running in same dir
;for at least several ticks.
;	move	*a8(OZPOS),a0
	subi	CZMID,a0
	cmpi	70,a0
	jrlt	tryhk2
;Don't allow this hook from 3pt range
	cmpi	98h,a0
	jrgt	tag1			;Near 3 pt range?
;Yes, I am near bottom of scrn

yes0
	move	*a13(plyr_seqdir),a14
	cmpi	2,a14
	jrz	tryhk1
	cmpi	6,a14
	jrnz	tryhk2	

tryhk1
;Player is running horizontally
;Is he near near baseline?
	movi	WRLDMID,a0

	move	*a13(plyr_num),a14
	srl	1,a14
	jrnz	reg2			;Team1?

	move	*a8(OXPOS),a14
	sub	a0,a14
;	abs	a14
	cmpi	110h,a14		;160
	jrlt	tryhk2
	jruc	yes
reg2
	move	*a8(OXPOS),a14
	sub	a14,a0
;	abs	a0
	cmpi	140h,a0		;160
	jrlt	tryhk2
yes
;Yes, near baseline
	move	*a13(plyr_dirtime),a14
	subk	5,a14
	jrlt	tryhk2
;Yes, I've been running in this dir for awhile!

	move	a9,*a13(plyr_newdir)	;Turn toward basket

	jruc	hs			;Hook shot


tryhk2

;Attempt a running in 2 dir hook from near the top of scrn up toward hoop
;Must be past CRTMID, far away from baseline, and running in same 2 dir
;for at least several ticks.
	move	*a8(OZPOS),a0
	cmpi	CZMID,a0
	jrgt	tryhk3
;Yes, I am above CRTMID


	move	*a13(plyr_seqdir),a14
	cmpi	1,a14
	jrz	tryhk2a
	cmpi	7,a14
	jrnz	tryhk3

	move	*a13(plyr_num),a14
	srl	1,a14
	jrnz	tryhk2a		;Team1?
;Yes team 1
	movk	10h,a9			;Fix wrong way hookshot!

tryhk2a
;Player is running up at a diagonal
;Is he near near baseline?
	move	*a13(plyr_ohpdist),a14
	cmpi	60h,a14			;out farther...fade away
	jrhs	tryhk3
	movi	WRLDMID,a0

	move	*a13(plyr_num),a14
	srl	1,a14
	jrnz	rega			;Team1?

	move	*a8(OXPOS),a14
	sub	a0,a14
	cmpi	140h,a14		;160
	jrgt	tryhk3
	jruc	yesa
rega
	move	*a8(OXPOS),a14
	sub	a14,a0
	cmpi	140h,a0		;160
	jrgt	tryhk3
yesa
;Yes, far enough away from baseline
	move	*a13(plyr_dirtime),a14
	subk	5,a14
	jrlt	tryhk3
;Yes, I've been running in this dir for awhile!

	move	a9,*a13(plyr_newdir)	;Turn toward basket

	jruc	hs			;Hook shot


tryhk3

;Attempt a 1 or 5 dir hook (Running vertically)
	move	*a13(plyr_seqdir),a14
	jrz	ahook
	subk	4,a14
	jrne	tag1
ahook
	move	*a13(plyr_ohpdir),a14
	addk	8,a14			;Round off
	sll	32-7,a14
	srl	32-7+4,a14		;Kill frac
	jrz	tag1
	cmpi	4,a14
	jrz	tag1



	move	*a13(plyr_num),a2
	srl	1,a2
	jrz	tg1			;Team1?
	cmpi	5,a14
	jrlt	tag1			;Team 2 behind hoop
	jruc	tgx
tg1	cmpi	4,a14
	jrge	tag1
tgx



	move	*a13(plyr_ohpdist),a14
	cmpi	40h,a14			;48h
	jrlt	tag1			;Too close for hook?
	move	*a8(OZPOS),a14
	cmpi	0448H,a14
	jrlt	tag1
	cmpi	04a8H,a14
	jrgt	tag1
;Okay to do hook!	

	move	a9,*a13(plyr_newdir)	;Turn toward basket
	jruc	hs			;Hook shot

tag1

	move	*a13(plyr_newdir),a0
	move	a0,a3
	move	a1,a4			;A1=Distance to hoop for shot
					;>Skip dunks from behind the hoop
	addk	8,a0			;Round off
	sll	32-7,a0
	srl	32-3,a0			;Kill frac
	move	*a13(plyr_num),a14
	srl	1,a14
	jrnz	lhoopa			;Team2?
	subk	5,a0
	jrlt	trydunk
tag1a
	move	*a13(plyr_ownball),a5
	jrp	sj			;br=teammate doesn't have ball
tag1b	move	a9,*a13(plyr_newdir)	;Turn toward basket
	jruc	plyr_startjmp_x


;If behind hoop, I will try to do a hook shot...

lhoopa
   	move	a0,a0
	jrz	trydunk
	subk	4,a0
	jrlt	tag1a			;br=no dunk 
;	jrlt	sj


trydunk				;>Try a dunk
	move	*a13(plyr_ownball),a5
	jrnn	td2			;br=teammate doesn't have ball
	cmpi	65,a4			;too close for alleyoop ?
	jrle	tag1b			;br=yes...do nothing
	jruc	td2a	

td2
	cmpi	42,a4			;ADJ'd for new COURT SIZE
;	cmpi	53,a4			;ADJ'd for new COURT SIZE
;	cmpi	60,a4
	jrle	velok			;Close to hoop, Allow dunk!! w/o turbo

td2a
	move	*a13(plyr_dir),a14
	sub	a3,a14
	abs	a14
	cmpi	040H,a14
	jrle	nodov
	subi	080H,a14
	abs	a14
nodov
	subk	24,a14
	jrgt	sj			;!Facing basket?

	move	*a13(plyr_PDATA_p),a14,L
	move	*a14(ply_turbo),a14
	subk	3,a14			;!!! Min cnt for dunk
	jrle	sj			;Turbo too low?

;Shawn, stop dunker if he just made a real quick move.  Should we do this?
;	move	*a13(plyr_dirtime),a14
;	subk	4,a14
;	jrgt	dnk_ok
;	nop
;	jruc	sj
;
;dnk_ok

	cmpi	165,a4			;Max dunk range (ADJ'd for new COURT)
;	cmpi	170,a4			;Max dunk range
	jrge	sj			;Too far for dunk?
	move	*a8(OZPOS),a14		;Chk Z range
	cmpi	CZMAX-34,a14
	jrhs	sj
	cmpi	CZMIN+34,a14
	jrls	sj
	move	*a8(OXVEL),a14,L	;0CHhk velocity
	abs	a14
	srl	16,a14
	jrnz	velok
	move	*a8(OZVEL),a14,L
	abs	a14
	srl	16,a14
	jrz	sj
velok
	move	*a13(plyr_ownball),a5
	jrn	aly1			;alleyoop

;Perhaps allow big guys to dunk through anybody!
	move	*a13(plyr_attrib_p),a0,L
	move	*a0(PAT_POWER),a0
	sll	4,a0
	addi	dnkthru_t,a0
	move	*a0,a0
	calla	RNDPER
	jrhi	dunk			;Yes, jump over anybody!

;	movk	7,a0			;12%
;	callr	rnd
;	jrz	dunk			;Ignore opponents?

aly1
;Get opponents defense of dunks info
	movi	64,a7
	move	*a13(plyr_num),a14
	cmpi	2,a14
	jrlt	tm1zz
	clr	a7
tm1zz
	movi	plyrproc_t,a14,L
	add	a7,a14
	move	*a14,a14,L




	move	*a14(plyr_num),a7
	move	@plyr_onfire,a0
;;	cmp	a0,a7
;;	jrnz	nof1
	btst	a7,a0
	jrz	nof1			;br=not on-fire
;This defender is on fire!  Make his defense of dunkers the best!
	movk	11,a0
	jruc	gdd
nof1
	move	*a14(plyr_attrib_p),a14,L
	move	*a14(PAT_DEFSKILL),a0
gdd
;	jruc	temp
	sll	4,a0
	movi	dist_t,a14
	add	a0,a14
	move	*a14,a2			;Distance check
	movi	width_t,a14
	add	a0,a14
	move	*a14,a0			;Get width of check			;Distance check

	move	*a13(plyr_ownball),a14
	jrnn	norma				;br=not an alleyoop
	move	*a13(plyr_num),a7
	move	@PSTATUS2,a14
	btst	a7,a14				;drone ?
	jrnz	nrm				;br=no
	move	*a13(plyr_dirtime),a14
	subk	5,a14
	jrle	o1dok
	addk	15,a2				;drone has to be more open
nrm
	move	a2,a14
	srl	    1,a14
	add	    a14,a2
norma
	move	*a13(plyr_o1dist),a14
	cmp	    a14,a4
	jrlt	o1dok			;I'm closer?

;	cmpi	50,a14
	cmp	a2,a14

	jrgt	o1dok			;He's too far?
	move	*a13(plyr_o1dir),a2
	sub	a3,a2
	abs	a2
	cmpi	040H,a2
	jrle	o1dsml
	subi	080H,a2
	abs	a2
o1dsml

;	subk	32,a2
	sub	a0,a2

	jrlt	trylyup		;In front of me?
o1dok

	movi	64,a7
	move	*a13(plyr_num),a14
	cmpi	2,a14
	jrlt	tm1ax
	clr	a7
tm1ax
	movi	plyrproc_t+32,a14,L
	add	a7,a14
	move	*a14,a14,L

	move	*a14(plyr_num),a7
	move	@plyr_onfire,a0
;;	cmp	a0,a7
;;	jrnz	nof2
	btst	a7,a0
	jrz	nof2			;br=not on-fire
;This defender is on fire!  Make his defense of dunkers the best!
	movk	11,a0
	jruc	gdd2
nof2

	move	*a14(plyr_attrib_p),a14,L
	move	*a14(PAT_DEFSKILL),a0
gdd2
	sll	4,a0
	movi	dist_t,a14
	add	a0,a14
	move	*a14,a2			;Distance check
	movi	width_t,a14
	add	a0,a14
	move	*a14,a0			;Get width of check			;Distance check

	move	*a13(plyr_ownball),a14
	jrnn	norm2				;br=not an alleyoop
	move	*a13(plyr_num),a7
	move	@PSTATUS2,a14
	btst	a7,a14				;drone ?
	jrnz	nrm2				;br=no
	move	*a13(plyr_dirtime),a14
	subk	5,a14
	jrle	trylyup
	addk	15,a2				;drone has to be more open
nrm2	
	move	a2,a14
	srl	1,a14
	add	a14,a2

norm2

	move	*a13(plyr_o2dist),a14
	cmp	a14,a4
	jrlt	o2dok			;I'm closer?
;	cmpi	50,a14
	cmp	a2,a14
	jrgt	o2dok			;He's too far?
	move	*a13(plyr_o2dir),a2
	sub	a3,a2
	abs	a2
	cmpi	040H,a2
	jrle	o2dsml
	subi	080H,a2
	abs	a2
o2dsml
;	subk	32,a2
	sub	a0,a2
	jrlt	trylyup		;In front of me?
o2dok

dunk	move	a3,*a13(plyr_dir)
	movi	-1,a14
	move	a14,*a13(plyr_newdir)	;Cancel turn

	addk	8,a3			;Round off
	srl	4,a3			;Kill frac
	sll	5,a3			;*32


	move	*a13(plyr_ownball),a5
	jrp	noalya				;br=teammate doesn't have ball !!

	move	*a13(plyr_tmproc_p),a14,L
	move	*a14(plyr_seqflgs),a0
	btst	DUNK_B,a0			;is teammate in dunk ?
	jrnz	tmdnk				;br=yes
	move	*a14(plyr_ohpdist),a14		;get teammates dist. from hoop
	cmpi	375,a14				;passer not in view of basket

;Passer can be at about half court!  His teammates cursor will flash white
;to alert him of an offscrn alley oop jump!
;	cmpi	01EBH,a14			;passer not in view of basket
	jrhs	plyr_startjmp_x				;br=teammate too far away!!



;Disallow alley oop jump if not good enough dunker!
;	move	*a13(plyr_attrib_p),a0,L
;	move	*a0(PAT_DUNKSKILL),a0
;	cmpi	4,a0
;	jrlt	x_red

;Disallow alley oop jump if not enough turbo - then reduce turbo correct
;amount if it is ok
	move	@PSTATUS2,a0		;Plyr start bits 0-3
	move	*a13(plyr_num),a1
	btst	a1,a0
	jrz	I_drone

	move	*a13(plyr_PDATA_p),a2,L	;Shrink turbo meter for this plyr
	move	*a2(ply_turbo),a1
	subk	TURBO_CNT/7,a1		;Min cnt for alley oop

;Flash him red if we are about to disallow alley oop!

	jrle	x_red			;Turbo too low?
	move	a1,*a2(ply_turbo)

	jruc	cont_aly

I_drone
;I am a drone, check my teammate, if human, then make sure
;drone does only 1 jump up attempt per inbound...
	xori	1,a1
	btst	a1,a0
	jrz	cont_aly		;Br=2 drones on same team - allow it

;Has this drone already tried this jump 1 time?

	.ref	balltmshotcnt
	move	@balltmshotcnt,a0	;Maybe. Chk shot cnt
	subk	TMFIRE_MINCNT,a0
	jrnn	cont_aly		; br=a team is on-fire

	move	@drone_attempt,a0
	jrnz	plyr_startjmp_x
	movk	1,a0
	move	a0,@drone_attempt

;Only allow drone teammates of a human to have scored 3 alley oops per period!
	move	*a13(plyr_alley_cnt),a0
	cmpi	3,a0
	jrge	plyr_startjmp_x


cont_aly
;	move	*a13(plyr_inflsh),a0
;	jrnz	skip1

	CREATE	flashpid,flash_me
	move	a13,*a0(PDATA+32),L
;skip1
	move	*a13(plyr_attrib_p),a14,L
	move	*a14(PAT_DUNKSKILL),a14
;	subk	4,a14			;if less than 4 dunk rating do layup alley
	subk	3,a14			;if less than 3 dunk rating do layup alley
	jrgt	nrmaly

	movi	ALLEYOOP10_SEQ,a0		;dir 1
	move	*a13(plyr_seqdir),a14
	jrz	qucklay2			;br=direction 1
	movi	ALLEYOOP14_SEQ,a0		;dir 5
	cmpi	4,a14
	jreq	qucklay2			;br=direction 5
	movi	ALLEYOOP11_SEQ,a0		;dir 2
	cmpi	1,a14
	jreq	qucklay2
	cmpi	7,a14
	jreq	qucklay2
	movi	ALLEYOOP13_SEQ,a0		;dir 4
	cmpi	3,a14				;dir 4 or 8 ?
	jreq	qucklay2			;br=yes
	cmpi	5,a14				;dir 4 or 8 ?
	jreq	qucklay2			;br=yes
	movi	ALLEYOOP12_SEQ,a0		;dir 3
	jruc	qucklay2
nrmaly
	movi	ALLEYOOP8_SEQ,a0
	move	*a13(plyr_seqdir),a14
	jrz	qucklay2			;br=direction 1
	movi	ALLEYOOP9_SEQ,a0
	cmpi	4,a14
	jreq	qucklay2			;br=direction 5
	movi	ALLEYOOP7_SEQ,a0		;br=yes
	cmpi	1,a14
	jreq	qucklay2
	cmpi	7,a14
	jreq	qucklay2
	movi	ALLEYOOP5_SEQ,a0		;br=yes
	cmpi	3,a14				;dir 4 or 8 ?
	jreq	qucklay2			;br=yes
	cmpi	5,a14				;dir 4 or 8 ?
	jreq	qucklay2			;br=yes
	callr	get_rndm_alleyoop_seq		;ret. a0 = alleyoop seq.
	jruc	qucklay2			;br=not in direction 1
tmdnk

;Make this double dunker flash white upon take off...

;At the very least, we should do this for the 1st period...

;	move	*a13(plyr_inflsh),a0
;	jrnz	skip2

	CREATE	flashpid,flash_me
	move	a13,*a0(PDATA+32),L
;skip2

	movi	DDUNK_RECV_SEQ,a0
	jruc	qucklay

 SUBRP	flash_me

	SLEEPK	3
	move	*a13(PDATA+32),a0,L	;Player proc ptr

	move	*a0(plyr_inflsh),a14
	jrnz	flash_me

	SLEEPK	4

	move	*a13(PDATA+32),a0,L	;Player proc ptr
	move	*a0(plyr_jmpcnt),a0
	jaz	SUCIDE
	movk	1,a14
	move	a14,*a0(plyr_inflsh)

;flash player white to alert him
	move	*a8(OPAL),a0
	move	a0,*a13(PDATA)

	.ref	white_pal
	movi	white_pal,a0
	calla	pal_getf
	move	a0,*a13(PDATA+16)

	move	*a8(OPLINK),a0,L
	move	*a0(plyr_headobj_p),a9,L
	move	*a9(OPAL),a11

	movk	3,a10
again
;If on, flash plyr off scrn arrow
	move	*a13(PDATA+32),a0,L	;Player proc ptr
	move	*a0(plyr_lost_ptr),a14,L
	move	*a14(PA8),a1,L		;a8=0 if no side arw on or arw obj ptr
	jrz	no_arw

	movi	00101H,a2
	move	a2,*a1(OCONST)
	setf	4,0,0
	movk	M_CONNON,a0		;Replace non-zero data with constant
	move	a0,*a1(OCTRL)		;Write 4 low bits
	setf	16,1,0
no_arw

	move	*a13(PDATA+16),a0
	move	a0,*a8(OPAL)
	move	a0,*a9(OPAL)

	SLEEPK	3

;If on, restore normal arrow const status
	move	*a13(PDATA+32),a0,L	;Player proc ptr
	move	*a0(plyr_lost_ptr),a14,L
	move	*a14(PA8),a1,L		;a8=0 if no side arw on or arw obj ptr
	jrz	no_arw2

	setf	4,0,0
	movk	M_WRNONZ,a0
	move	a0,*a1(OCTRL)		;Write 4 low bits
	setf	16,1,0

no_arw2

;Restore normal player pal
	move	*a13(PDATA),a0
	move	a0,*a8(OPAL)
	move	a11,*a9(OPAL)

	SLEEPK	3

	dsj	a10,again

	clr	a14
	move	*a13(PDATA+32),a0,L	;Player proc ptr
	move	a14,*a0(plyr_inflsh)

	DIE

 SUBRP	flash_me_red

	move	*a13(PDATA+32),a0,L	;Player proc ptr
	move	*a0(plyr_jmpcnt),a14
	janz	SUCIDE
	movk	2,a14
	move	a14,*a0(plyr_inflsh)

;flash player red to alert him
	move	*a8(OPAL),a0
	move	a0,*a13(PDATA)

	.ref	red_pal
	movi	red_pal,a0
	calla	pal_getf
	move	a0,*a13(PDATA+16)

	move	*a8(OPLINK),a0,L
	move	*a0(plyr_headobj_p),a9,L
	move	*a9(OPAL),a11

	movk	2,a10
again1
	move	*a13(PDATA+16),a0
	move	a0,*a8(OPAL)
	move	a0,*a9(OPAL)

	SLEEPK	3

;Restore normal player pal
	move	*a13(PDATA),a0
	move	a0,*a8(OPAL)
	move	a11,*a9(OPAL)

	SLEEPK	3

	dsj	a10,again1

	clr	a14
	move	*a13(PDATA+32),a0,L	;Player proc ptr
	move	a14,*a0(plyr_inflsh)

	DIE

noalya
	move	*a13(plyr_tbutn),a14
	cmpi	4,a14			;just pressed turbo ?
	jrgt	dodnk			;br=no, do a dunk

	move	*a13(plyr_ohpdist),a14	
;	cmpi	75,a14			;too close for QUICK LAYUP ?
	cmpi	95,a14			;too close for QUICK LAYUP ?
	jrlt	dodnk			;br=yes, do dunk

	movk	2,a0
	move	a0,@ballptsforshot

	movk	LAY_UP,a0
	move	a0,@shot_type

	movi	QUICK_LAYUP_SEQ,a0
	jruc	qucklay
dodnk

	.ref	getdunkseq
	calla	getdunkseq
	move	a0,a0
	jrnz	sj


	clr	a0
	move	a0,@shot_distance

	movk	DUNK_SHORT,a0
	cmpi	80,a4
	jrle	short

	movk	DUNK_MED,a0
	cmpi	120,a4
	jrle	med

	movk	DUNK_LONG,a0
short
med
	move	a0,@shot_type

	.if DEBUG
	movi	DUNKA_SEQ,a0
	movi	DUNKA2_SEQ,a0
	movi	DUNKA3_SEQ,a0
	movi	DUNKB_SEQ,a0
	movi	DUNKB2_SEQ,a0
	movi	DUNKB3_SEQ,a0
	movi	DUNKC_SEQ,a0
	movi	DUNKD_SEQ,a0
	movi	DUNKD2_SEQ,a0
	movi	DUNKE_SEQ,a0
	movi	DUNKE2_SEQ,a0
	movi	DUNKF_SEQ,a0
	movi	DUNKG_SEQ,a0
	movi	DUNKG2_SEQ,a0
	movi	DUNKJ_SEQ,a0
	movi	DUNKJ2_SEQ,a0
	movi	DUNKK_SEQ,a0
	movi	DUNKK2_SEQ,a0
	movi	DUNKL_SEQ,a0
	movi	DUNKL2_SEQ,a0
	movi	DUNKL3_SEQ,a0
	movi	DUNKN_SEQ,a0
	movi	DUNKN2_SEQ,a0
	movi	DUNKN3_SEQ,a0
	movi	DUNKO_SEQ,a0
	movi	DUNKO2_SEQ,a0
	movi	DUNKP_SEQ,a0
	movi	DUNKP2_SEQ,a0
	movi	DUNKP3_SEQ,a0
	movi	DUNKQ_SEQ,a0
	movi	DUNKQ2_SEQ,a0
	movi	DUNKQ3_SEQ,a0
	movi	DUNKR_SEQ,a0
	movi	DUNKR2_SEQ,a0
	movi	DUNKS_SEQ,a0
	movi	DUNKS2_SEQ,a0
	movi	DUNKT_SEQ,a0
	movi	DUNKT2_SEQ,a0
	movi	DUNKT3_SEQ,a0
	movi	DUNKT4_SEQ,a0
	movi	DUNKT5_SEQ,a0
	movi	DUNKU_SEQ,a0
	movi	DUNKU2_SEQ,a0
	movi	DUNKU3_SEQ,a0
	movi	DUNKV_SEQ,a0
	movi	DUNKV2_SEQ,a0
	movi	DUNKV3_SEQ,a0
	movi	DUNKV4_SEQ,a0
	movi	DUNKW_SEQ,a0
	movi	DUNKW2_SEQ,a0
	movi	DUNKW3_SEQ,a0
	movi	DUNKX_SEQ,a0
	movi	DUNKX2_SEQ,a0
	movi	DUNKX3_SEQ,a0
	movi	DUNKY_SEQ,a0
	movi	DUNKY2_SEQ,a0
	movi	DUNKZ_SEQ,a0
	movi	DUNKZ2_SEQ,a0
	movi	DUNKZ3_SEQ,a0
	movi	DUNKLAY_SEQ,a0
	movi	DUNKLAY2_SEQ,a0
	movi	DUNKLAY3_SEQ,a0
	movi	DUNKLAY3A_SEQ,a0
	movi	DUNKLAY3B_SEQ,a0
	movi	DUNKLAY3C_SEQ,a0
	movi	DUNKLAY4_SEQ,a0
	movi	DUNKLAY5_SEQ,a0
	movi	DUNKLAY6_SEQ,a0
	movi	DUNKLAY7_SEQ,a0
	movi	DUNKLAY7A_SEQ,a0
	movi	DUNKLAY8_SEQ,a0
	movi	DUNKT4_SEQ,a0
	movi	DUNKU4_SEQ,a0
	movi	DUNKU5_SEQ,a0
	movi	DUNKU6_SEQ,a0
	movi	DUNKU7_SEQ,a0
	movi	DUNKU8_SEQ,a0

	movi	1,a2
;	movi	-1,a2

	jrn	tstdnk
	.endif

	move	*a3,a2,L
	move	*a2+,a0			;Entries-1
	callr	rndrng0
	sll	4,a0			;*16
	add	a2,a0
	move	*a0,a0
	jrz	sj			;Null entry?
tstdnk


	.if	DEBUG
;Shawn, I'm stuffing the dunk into ram so I can pause the game when someone
;has a problem with a dunk and I can jot down the dunk  and fix it.
	.bss	debug_dunk_num,16
	.ref	slowmotion

	move	a0,@debug_dunk_num
	clr	a1
	move	a1,@slowmotion
	.endif

	move	a0,a2
	CREATE0	start_animate
;	cmpi	DUNKX_SEQ,a2
;	jreq	smk
;	cmpi	DUNKX2_SEQ,a2
;	jreq	smk
;	cmpi	DUNKX3_SEQ,a2
;	jrne	nosmk
;smk	CREATE0	plyr_smoketrail
;	move	a13,*a0(PA10),L
nosmk	move	a2,a0

qucklay
	movk	2,a14
	move	a14,@ballptsforshot
qucklay2
	move	*a13(plyr_dir),a7
	callr	plyr_setseq		;Dunk!

	move	*a13(plyr_num),a14
	srl	1,a14
	jrz	    plyr_startjmp_x			;Team1?
	movi	M_FLIPH,a14
	move	a14,*a13(plyr_anirevff)
	jruc	plyr_startjmp_x


;strtsnd	SLEEP	40
;	movi	dnk_snd,a0
;	calla	snd_play1
;	SLEEP	180
;	movi	push1_snd,a0
;	calla	snd_play1
;	DIE
;
;push1_snd	.word	0fd85H,15,08160H,0	;Push ugh
;dnk_snd		.word	0fda9H,120,08167H,0

dnkthru_t
	.word	0,0,0,0,0,0,0,100,150,250,350


dist_t	.word	40*DIST_REDUCTION
	.WORD	43*DIST_REDUCTION
	.WORD	46*DIST_REDUCTION
	.WORD	49*DIST_REDUCTION
	.WORD	50*DIST_REDUCTION
	.WORD	52*DIST_REDUCTION
	.WORD	54*DIST_REDUCTION
	.WORD	56*DIST_REDUCTION
	.WORD	68*DIST_REDUCTION
	.WORD	70*DIST_REDUCTION
	.WORD	72*DIST_REDUCTION
	.WORD	95*DIST_REDUCTION
width_t
	.word	27,29,31,33,36,37,38,39,40,43,45,70

trylyup
	move	*a13(plyr_ownball),a14
	jrn	sj_red			;alleyoop
	move	@HCOUNT,a14
	btst	0,a14
	jrnz	sj
	move	*a13(plyr_ohpdist),a14
	cmpi	138*DIST_ADDITION,a14
	jrgt	sj
	cmpi	35*DIST_ADDITION,a14
	jrlt	sj

;temp
	move	a3,*a13(plyr_dir)
	movi	-1,a14
	move	a14,*a13(plyr_newdir)	;Cancel turn
	movk	2,a0
	move	a0,@ballptsforshot

	movk	FINGER_ROLL,a0
	move	a0,@shot_type

	movi	LAYUP_SEQ,a0
	jruc	sseq

hs
	movk	2,a4
	move	a4,@ballptsforshot

	movk	HOOK_SHOT,a0
	move	a0,@shot_type

	movk	HOOK_SEQ,a0
	move	*a13(plyr_turbon),a4
	jrnz	hs1
	movk	HOOK2_SEQ,a0		;Not a high arc


hs1	move	*a13(plyr_dir),a7
	callr	plyr_setseq

	move	*a13(plyr_seqdir),a14
	subk	2,a14
	jrz	plyr_startjmp_x

	move	*a13(plyr_num),a14
	srl	1,a14
	jrz	plyr_startjmp_x			;Team1?
	movi	M_FLIPH,a14
	move	a14,*a13(plyr_anirevff)
	jruc	plyr_startjmp_x



sj					;>Start a jump shot seq
	move	*a13(plyr_ownball),a5
	jrnn	sj2
	move	a9,*a13(plyr_newdir)	;Turn toward basket
	jruc	plyr_startjmp_x

sj_red
	move	a9,*a13(plyr_newdir)	;Turn toward basket
	jruc	x_red




sj2
	.asg	CZMIN+18,PT3_TOPZ

	movk	2,a4			;Assume 2ptr

	move	*a8(OZPOS),a0
	subi	PT3_TOPZ,a0
	jrlt	i3ptra
	cmpi	PT3_CNT*4,a0,W
	jrge	i3ptra

	.if 0			;DEBUG code for 3pt line positioning
	BSSX	pt3_tval,16
	srl	2,a0
	move	a0,a1
	sll	4,a0
	addi	pt3_t,a0
	move	*a0,a0
	move	a0,@pt3_tval
	dec	a0
	move	*a13(plyr_num),a14
	subk	2,a14
	jrlt	3pt1
	neg	a0
3pt1	addi	WRLDMID,a0
	move	*a8(OXANI+16),a14
	sub	a14,a0
	move	a0,*a8(OXPOS)
	sll	2,a1
	addi	PT3_TOPZ,a1
	move	a1,*a8(OZPOS)
	clr	a0
	move	a0,*a13(plyr_nojoy)
	movk	STNDDRIB_SEQ,a0
	jruc	sseq
	.endif			;DEBUG end

	srl	2,a0			;In 3pt arc Z range
	sll	4,a0
	addi	pt3_t,a0
	move	*a0,a0
	move	*a8(OXANI+16),a14
	move	*a8(OXPOS),a2
	add	a14,a2
	subi	WRLDMID,a2
	abs	a2
	sub	a2,a0			;Inside 3pt line?
	jrle	z2ptra			; br=yes

;	LOCKUP			;03Hptr from just outside the arc
	cmpi	25,a0			;22+15%;!!!
	jrlt	s3ptrx
i3ptr
;	LOCKUP			;03Hptr from further out but NOT a desperation
	movk	1,a4
	move	a4,@reduce_3ptr
i3ptra
;	LOCKUP			;03Hptr from top or bottom sideline

s3ptrx
	movk	3,a4			;Is 3ptr

	movk	_3_POINTS,a0
	move	*a13(plyr_ohpdist),a14
;	cmpi	310*DIST_ADDITION,a0	;!!!Chk distance from hoop (158 h)
	cmpi	290*DIST_ADDITION,a14
	jrle	contxy

	movk	LONG_RANGE,a0
	jruc	contxy
z2ptra
	movk	_2_POINTS,a0

;	move	a4,@ballptsforshot
;	move	*a13(plyr_tbutn),a14
;	cmpi	12,a14
;	jrgt	contxy
;	movk	LAYUP_SEQ,a0
;	jruc	sseq

contxy
	move	a0,@shot_type
	move	a4,@ballptsforshot

	movk	UNDR_HOOP_SHT_SEQ,a0	;for team 2
	move	*a13(plyr_num),a14
	srl	1,a14
	jrnz	tem2				;br=team1
	movk	UNDR_HOOP_SHT_SEQ2,a0
tem2
	.ref	chck_plyr_under_hoop
	calla	chck_plyr_under_hoop
	jrc	sseq

	movk	SHOOT_SEQ,a0
	move	*a13(plyr_shtbutn),a14
	jrnz	sseq

	movk	QSHOOT_SEQ,a0
	movk	1,a14
	move	a14,*a13(plyr_shtbutn)
	jruc	sseq

;--------------------

desp
	movi	DESPERATION,a0
	move	a0,@shot_type

	movk	3,a14
	move	a14,@ballptsforshot

;This is a heave grenade toss
;only do it if under 5 seconds in quarter
	movk	SHOOTDESP2_SEQ,a0	;Heave
	move	@PCNT,a14
	btst	0,a14
 	jrz	abc
	movk	SHOOTDESP_SEQ,a0	;Heave
abc
	move	@game_time,a14,L
	cmpi	0500H,a14
	jrlt	heave_a			;Do it

;FIX!!  We need another desp shot
;	move	@PCNT,a0
;	ANDK	1,a0
;	sll	1,a0
;	addk	SHOOTDESP_SEQ,a0

	movi	SHOOTDESP3_SEQ,a0

heave_a
	move	*a13(plyr_newdir),a14
	move	a14,*a13(plyr_dir)
	movi	-1,a14
	move	a14,*a13(plyr_newdir)
	jruc	sseq

blk
;Player has hit shoot/block button try to block shot or other...

;Am I about to get a pass?
	move	*a13(plyr_rcvpass),a0
	jrgt	plyr_startjmp_x			;Waiting on pass?

;FIX!!!
;Realize that no jumping can occur offscrn...  Perhaps this is OK
;Maybe allow block attempt if ball is in air (shot)...
	move	*a13(plyr_offtime),a14
	jrnz	plyr_startjmp_x			;br=offscreen, dont jump

;Does anyone own ball
	move	@ballpnum,a14
	jrn	inair			;br=no owner

	sll	5,a14			;*32
	addi	plyrproc_t,a14
	move	*a14,a14,L
	move	*a14(plyr_seqflgs),a0
	btst	SHOOT_B,a0
;	jrz	faceb			;!Shooting?
	jrnz	inair

;Slow down drift fr this blocker!

	move	*a8(OXVEL),a0,L
	sra	1,a0
	move	a0,*a8(OXVEL),L
	move	*a8(OYVEL),a0,L
	sra	1,a0
	move	a0,*a8(OYVEL),L
	move	*a8(OZVEL),a0,L
	sra	1,a0
	move	a0,*a8(OZVEL),L

	move	@ballobj_p,a5,L
	move	*a5(OXPOS),a6
	addk	6,a6
	move	*a5(OZPOS),a7
	PUSH	A0
	callr	seekdirdist_obxz128
	move	a0,*a13(plyr_newdir)	;Turn toward ball
	PULL	A0
	btst	DUNK_B,a0
	jrz	blkd
	movk	7,a0
	calla	rndrng0
	sll	4,a0
	addi	blktype_t,a0
	move	*a0,a0

;What seq for trying to block a dunk?
;
;	movi	FASTBLOCKREJ_SEQ,a0
;	movi	BLOCK_SEQ,a0
;	movi	BLOCKREJ_SEQ,a0
;	movi	REBOUND_SEQ,A0

	jruc	sseq

blktype_t
	.word	BLOCK_SEQ,BLOCK_SEQ,BLOCK_SEQ,BLOCK_SEQ
	.word	REBOUND_SEQ,BLOCKREJ_SEQ
	.word	REBOUND_SEQ,FASTBLOCKREJ_SEQ

inair

;if teammate shot ball, dont swat at the ball, just do a rebound seq.
	move	@ballshotinair,a1
	jrn	nstm			;br=ball hit something !!
	move	*a13(plyr_num),a14
	srl	1,a14
	srl	1,a1
	cmp	a14,a1
	jreq	dorb			;br=plyrs, not on same team !!
nstm
	move	@ballobj_p,a5,L

	move	*a5(OYPOS),a1
;	cmpi	-20,a1
	cmpi	-40,a1
	jrge	faceb			;Ball close to gnd?

	move	*a5(OXVAL),a6,L
	move	*a5(OXANI),a14,L
	add	a14,a6
	move	*a5(OZVAL),a7,L

	move	@ballpnum,a14
	jrge	chkdist		;Other team has ball?

;PUTBACK logic
;	move	*a13(plyr_num),a1
;	move	@ballpnumlast,a14	;Plyr on the same team as plyr who
;	srl	1,a1			; missed the basket?
;	srl	1,a14
;	cmp	a1,a14
;	jrnz	noffreb		;br=no
;
;	move	*a13(plyr_ohpdist),a14
;	cmpi	50,a14
;	jrhs	dorb			;br=not close enough for put-back dunk
;	movi	PUTBACK_SEQ,a0
;	jruc	sseq
;noffreb
	movk	20,a0
	move	*a5(OXVEL),a1,L
	mpys	a0,a1
	add	a1,a6
	move	*a5(OZVEL),a1,L
	mpys	a0,a1
	add	a1,a7

chkdist
;TEMP!!!
;	movi	FASTBLOCKREJ_SEQ,a0
;	movi	BLOCK_SEQ,a0
;	movk	BLOCKREJ_SEQ,a0
;	movk	REBOUND_SEQ,a0
;
;	jruc	sseq
;
	sra	16,a6
	sra	16,a7
	callr	seekdirdist_obxz128
	move	a0,*a13(plyr_newdir)	;Turn where ball is headed
	cmpi	120,a1
	jrge	blkd			;Too far to jump?

;	movk	1,a0			;50%
	movi	650,a0
	move	@ballpnum,a1
	jrge	dornd

	move	@ballgoaltcnt,a14
	jrle	dorb			;Do rebound?



;	movk	1,a0			;50%
	movi	650,a0
;Do more rejections!
dornd	calla	RNDPER
;	jrnz	dorej
	jrhi	dorej

;Weak shot blockers will do swat, not grab!
	move	*a13(plyr_attrib_p),a14,L
	move	*a14(PAT_DEFSKILL),a0
	cmpi	5,a0
	jrlt	dorej

dorb	movk	REBOUND_SEQ,a0
	jruc	sseq
dorej
	movk	BLOCKREJ_SEQ,a0
	jruc	sseq


faceb	move	@ballobj_p,a5,L
	move	*a5(OXPOS),a6
	addk	6,a6
	move	*a5(OZPOS),a7
	callr	seekdirdist_obxz128
	move	a0,*a13(plyr_newdir)	;Turn toward ball
;If near ball, and it's near ground, go ahead and try pickup 
	move	*a13(plyr_balldist),a0
	cmpi	024H,a0
	jrgt	blkd
;Pickup
	movi	PICKUP_SEQ,a0		;No. Pick-up ball
 	jruc	sseq

blkd	movk	BLOCK_SEQ,a0


sseq	move	*a13(plyr_dir),a7
	callr	plyr_setseq


plyr_shoot_x	
    PULL	a6,a7,a9
	rets


x_red
;Missed alley oop attempt
	move	*a13(plyr_inflsh),a0
	jrnz	plyr_startjmp_x	

	move	@PSTATUS2,a0		;Plyr start bits 0-3
	move	*a13(plyr_num),a1
	btst	a1,a0
	jrz	    plyr_startjmp_x	


	CREATE	flashpid,flash_me_red
	move	a13,*a0(PDATA+32),L

plyr_startjmp_x	
	PULL	a6,a7,a9
	rets

pt3_t
	.word	336,276,248,235,222,213,204,196
	.word	188,182,176,163,158,155,152,149
	.word	146,143,141,140,139,138,137,137
	.word	136,136,136,135,135,135,135,135
	.word	136,137,137,138,138,139,140,141
	.word	141,142,144,145,147,148,150,151
	.word	153,155,158,161,164,168,171,174
	.word	177,180,183,186,189,193,197,201
	.word	205,210,215,220,226,231,238,245
	.word	254,262,272,286,316
PT3_CNT	.equ	($-pt3_t)/16

	.if CRTALGN
	.word	-1
	.endif



********************************
 SUBRP	get_rndm_alleyoop_seq

	PUSH	a1
 	movk	4,a0
	calla	rndrng0
	sll	    4,a0
	addi	alleyoop_seq_tbl,a0
	move	*a0,a0
	PULL	a1
 	rets

alleyoop_seq_tbl
	.word	ALLEYOOP1_SEQ
	.word	ALLEYOOP2_SEQ
	.word	ALLEYOOP3_SEQ
	.word	ALLEYOOP4_SEQ
	.word	ALLEYOOP6_SEQ

********************************
* Player takes a shot (also called by seq)
* A8=*Plyr obj
* A13=*Plyr process
* Trashes scratch, A2-A5

 SUBR	plyr_shoot

	PUSH	a6,a7,a9,a10,a11

	.ref	bkbrd_proc_flg
	clr	a14
	move	a14,@bkbrd_proc_flg	;just in case speech proc was killed

	move	*a13(plyr_num),a0	;Exit if plyr doesn't have
	move	@ballpnum,a1	 	; the ball
	cmp	a0,a1
	jrne	plyr_shoot_x

	clr	a1
	move	*a13(plyr_seq),a14
	cmpi	ALLEYOOP1_SEQ,a14	;Take care to update here when alley
	jrlo	nally			; seq's are changed or added!!!
	cmpi	ALLEYOOP14_SEQ,a14	;This stuff is elsewhere too!!!
	jrhi	nally
	movk	1,a1
nally
	BSSX	was_alley_shot,16
	move	a1,@was_alley_shot

;	move	@GAMSTATE,a0
;	cmpi	INAMODE,a0
;	jrnz	nofake
;	.ref	do_ball_spark
;	CREATE0	do_ball_spark
;nofake

;DJT Start
	move	@plyr_onfire,a14	;Do on-fire shot snd?
	btst	a0,a14
	jrnz	fire			; br=on-fire
	move	*a13(plyr_hotspotp),a14	;Do sound for hotspot shot?
	jrz	cold			; br=no
	move	a0,a14			;Chk hotspot shot cnt
	sll	4,a14
	.ref	hotspot_count
	addi	hotspot_count,a14
	move	*a14,a14
	subk	HOTSPOT_MINCNT,a14
	jrlt	cold			; br=hotspot not active yet
fire
	SOUND1	fball_snd
;DJT End
cold
	move	@ballobj_p,a0,L

	move	*a13(plyr_ballyo),a1
	cmpi	-200,a1			;Ball Y free?
	jrne	notfree		; br=no
	move	@ballfree,a14		;Yes. Was it already free?
	jrnz	contv			; br=yes

	.if DEBUG
	LOCKUP				;Should not occur!
	.endif

	movk	1,a14
	move	a14,@ballfree		;!0=ball free
	move	*a0(OYPOS),a1
	move	*a0(OIMG),a14,L
	move	*a14(IANIOFFY),a14
	add	a14,a1			;A1=ball ctr Y
	movi	-0a00H,a14		;Push it towards gnd
	mpys	a14,a1
	addi	016000H,a1
	move	a1,*a0(OYVEL),L
	jruc	contv

notfree
	clr	a1
	move	a1,*a0(OYVEL),L		;Clr vels
	move	a1,*a0(OXVEL),L
	move	a1,*a0(OZVEL),L
	move	a1,@ballfree		;0=ball not free

contv
	move	*a13(plyr_ohoopx),a6
	movi	CZMID,a7
	callr	seekdirdist_obxz128
	move	a0,a10			;A10=hoop dir
	move	a1,a11			;A11=hoop distance

	move	*a13(plyr_attrib_p),a7,L	;Get plyr shot % attribute
	move	*a7(PAT_SHOTSKILL),a9

	move	@ballptsforshot,a0
	cmpi	3,a0
	jrnz	no3


;Fades, lean-ins are also reduced via reduce_3ptr flag

;Reduce 3-ptrs based on shoot attribute
;FIX!!  This should also do an adjustment based on who it is and how good
;they are at 3 ptrs!  Hill doesn't even shoot 'em!  Rodman should be a 0!
;Store another flag for guys who don't even shoot them...
	.ref	SHT5
	cmpi	SHT5,a9
	jrgt	oui
	subi	200,a9			;!!! ;Stat 0-4 reduce 3-ptrs
oui
	move	@reduce_3ptr,a0
	jrz	no3
	subi	150,a9			;!!!150?;Reduce 3-ptr


no3
;FIX!!!
;Make sure these are good numbers....
	cmpi	112,a11			;!!! ;Close-in?
	jrgt	notshort
	addi	250,a9			;!!! ;Improve for close-in
notshort
	cmpi	304,a11			;!!! ;Far shot?
	jrlt	notlong
	subi	990,a9			;!!! ;Reduce for far shot

notlong
	move	*a13(plyr_num),a4	;>Process opponents dir/dist
	srl	2,a4
	subb	a4,a4
	addk	1,a4
	sll	1+5,a4
	addi	plyrobj_t,a4

	movk	2,a5
chkopp
	move	*a4+,a0,L
	move	*a0(OYPOS),a3
	callr	seekdirdist_obob128

	cmpi	50,a1	;40		;!!! ;Opponent tight-in, any angle?
	jrgt	s1far			; br=no
	subi	240,a9			;!!!
s1far
	cmpi	85,a1	;75		;!!! ;Opponent close-in?
	jrgt	nxtopp			; br=no
	sub	a10,a0			;Yes. Process my hoop angle with his
	abs	a0			; angle on me
	cmpi	040H,a0
	jrle	p1dsml
	subi	080H,a0
	abs	a0
p1dsml
	subk	20,a0			;!!! ;Between me & hoop?
	jrge	nxtopp			; br=no
	sll	2,a1			;!!! = 0   to 300
;Make shot% reduce greatly if someone is in his face...
	subi	390,a1			;!!! =-390 to -90	;350

	move	*a8(OYPOS),a2
	sub	a3,a2			;Shooter above opponent?
	jrle	s1above			; br=yes
	addk	8,a2
	mpys	a2,a1
	sra	3,a1
s1above
	add	a1,a9			;Decrease accuracy
nxtopp
	dsj	a5,chkopp

	move	a11,a14			;Decrease shot % per hoop distance
	sll	1,a14			;!!!
	sub	a14,a9

	cmpi	50,a9			;!!! ;Ensure valid minimun shot %
	jrge	minok
	movi	50,a9			;!!!
minok

	move	*a13(plyr_num),a0	;Get plyr brick cnt
	sll	4,a0
	addi	brick_count,a0
	move	*a0,a1
	cmpi	3,a1			;!!! ;If too many in a row, make this
	jrlt	nobrick		; shot go in
;DJT Start
 .if DEBUG
	LOCKUP
 .endif ;DEBUG
;DJT End

;Too far to pump up this brick thrower?
	cmpi	304,a11			;!!! ;Far shot?
	jrgt	nobrick

	movi	990,a9			;!!! ;Set best shot %
nobrick

	move	*a13(plyr_ptsdown),a1	;0AdHjust shot % per score diff
	move	a1,a2			;A2=plyr_ptsdown
;	movk	20,a0			;!!! ;% factor
;DJT Start
	movk	15,a0	;12 ;14 ;15		;!!! ;% factor
;DJT End
	mpys	a0,a1
	add	a1,a9

	cmpi	50,a9
	jrge	minok1
	movi	50,a9
minok1

	move	a2,a2			;Is plyr losing?
	jrgt	nomis			; br=yes
	movi	55,a0			;!!! ;Randomly knock down his %
	calla	RNDPER
	jrls	nomis
	movi	350,a9			;!!!
nomis
	move	@game_time,a1,L
	cmpi	0400H,a1			;!!! ;Last seconds of qrtr?
	jrgt	nohelp			; br=no

*If end of qrtr/game, affect shots like this:
*
* 1. If 4th or overtime qrtr has 5 seconds or less remaining and
*
*	a. If score is already tied or I am ahead, do nothing.
*	b. This shot (2 or 3) would tie the score, then make it go in 75% of
*	   the time.  (Regardless of shot distance)
*	c. This shot (2 or 3) would win the game, then make it go in at
*	   least 30% of the time (Close in would be higher, but even bombs
*	   go in 30%)
*	d. If this shot would pull me to within 1/2 points, then make it go
*	   in 90% of the time for max excitement without putting him ahead.
*
* 2. If 1/2/3rd qrtr has 5 seconds or less remaining and
*
*	a. If score is already tied or I am ahead, do nothing.
*	b. This shot (2 or 3) would tie the score, then make it go in 40% of
*	   the time at least.  (Regardless of shot distance)
*	c. If this shot would pull me to within or ahead by 1/2 points, then
*	   make it go in 50% of the time for max excitement)
*	d. If I am losing by a larger margin than 4, then make it go in at
*	   least 60%.  (Regardless of shot distance)

	move	@gmqrtr,a3

	move	a2,a0			;Game tied?
	jrnz	notie			; br=no

	subk	3,a3			;In 4th qrtr or OT?
	jrlt	nohelp			; br=no
	movi	50,a9			;!!! ;Last second shot of a tie game
	jruc	nohelp			; should almost never go in
notie
	jrgt	tryhelp		;Is plyr losing? br=yes

	addk	5,a0			;!!! ;Winning by 5 or more?
	jrgt	nohelp			; br=no
	subk	3,a3			;In 4th qrtr or OT?
	jrlt	nohelp			; br=no
	cmpi	0200H,a1			;How close to qrtr being over?
	jrgt	endgbig		;Last few seconds
	jruc	willtie		;At the buzzer
tryhelp
	move	@ballptsforshot,a14
	subk	3,a3			;In 4th qrtr or OT?
	jrge	endgame		; br=yes

	subk	5,a0			;!!! ;Losing by more than 5?
	jrgt	losebig		; br=yes

	cmp	a2,a14			;Will this shot tie the game?
	jreq	willtie		; br=yes

	movi	100,a3			;!!! ;Min % down 1-5, no tie shot
	jruc	chkper
willtie
	movi	120,a3			;!!! ;Min % down 1-5, is tie shot
	jruc	chkper
losebig
	movi	120,a3			;!!! ;Min % down 05H
	jruc	chkper

endgame
	subk	4,a0			;!!! ;Losing by 4 or more?
	jrge	endgbig		; br=yes

	cmp	a2,a14			;Will this shot tie the game?
	jreq	endgtie		; br=yes

	move	*a13(plyr_num),a0
	move	@PSTATUS2,a1
	btst	a0,a1			;Is plyr a drone?
	jrnz	endgnod		; br=no
	movk	1,a14
	xor	a14,a0
	btst	a0,a1			;Is team mate a drone too?
	jrnz	endgnod		; br=no

	movi	100,a3			;!!! ;Min % drones down <4, no tie shot
	jruc	chkper
endgnod
	movi	380,a3			;!!! ;Min % down <4, no tie shot
	jruc	chkper
endgtie
	movi	800,a3			;!!! ;Min % for down <4, is tie shot
	jruc	chkper
endgbig
	movi	300,a3			;!!! ;Min % for down 03H

chkper
	cmp	a3,a9			;Set min % if > current %
	jrge	nohelp
	move	a3,a9

;--------------------

nohelp
;	movi	950,a9

	move	@ballobj_p,a7,L		;Is ball on fire?
	move	*a7(OPLINK),a0,L
	move	*a0(ball_onfire),a14
	jrz	nofire			; br=no

	addi	750,a9			;!!! ;On-fire % increase
	cmpi	328,a11
	jrlt	nofire
	movi	100,a9			;!!! ;On-fire & close-in % increase
nofire
;DJT Start
	move	*a13(plyr_hotspotp),a14	;Add any hotspot shot% bump
	add	a14,a9
;DJT End

	calla	ball_convfmprel

;--------------------

	move	*a13(plyr_seq),a0	;0AdHjust % per plyr seq
	cmpi	DDUNK_STRT2_SEQ,a0
	jrnz	ntddnk2
	movi	500,a9			;!!!
	jruc	fixperc
ntddnk2
	cmpi	DUNKLAY5_SEQ,a0
	jrnz	ck2
	addi	760,a9			;!!!
	jruc	fixperc
ck2
	cmpi	DUNKLAY4_SEQ,a0
	jrnz	ck3
	addi	760,a9			;!!!
	jruc	fixperc
ck3
	cmpi	DUNKLAY3_SEQ,a0
	jrnz	ck4
	addi	760,a9			;!!!
	jruc	fixperc
ck4
	cmpi	DUNKLAY2_SEQ,a0
	jrnz	ck6
	addi	760,a9			;!!!
	jruc	fixperc
ck6
	cmpi	DUNKLAY3A_SEQ,a0
	jrnz	ck6a
	addi	760,a9			;!!!
	jruc	fixperc
ck6a
	cmpi	DUNKLAY6_SEQ,a0
	jrnz	ck7
	addi	760,a9			;!!!
fixperc
;	movi	750,a0			;!!! ;Should layups be blockable?


;	movi	800,a0			;!!! ;Should layups be blockable?
;	calla	RNDPER
;	jrhi	fixde	
;FIX!!  Maybe
;Should layups be unblockable - time will tell
;Allow layups to be blocked...
;Remove this for now...	4/2/96
;	movi	TSEC*2-20,a0		;!!! ;Don't allow blocked layups
;	callr	plyr_setshtdly
	jruc	fixde

ck7
	cmpi	LAYUPREB_SEQ,a0
	jreq	ly			;Layup?
	cmpi	DUNKLAY_SEQ,a0
	jreq	ly			;Layup?
	cmpi	LAYUP_SEQ,a0		;Put back layup
	jreq	ly
	move	*a13(plyr_seqflgs),a14	;Chk funky new layups
	btst	LAYUP_B,a14
	jrz	noly
ly
;DJT Start
	movi	800,a9			;!!! ;Base shot % for layup
;	movi	850,a9			;!!! ;Base shot % for layup
;DJT End
;	movi	990,a9			;!!! ;Base shot % for layup

	move	*a13(plyr_ptsdown),a1
;DJT Start
	subk	2,a1
;DJT End
	jrge	noairb			;Losing by 2 or more? No airball

	move	*a13(plyr_ptsdown),a1	;Is plyr losing?
	jrgt	noms			; br=yes

	movi	100,a0			;!!! ;Pull down % sometimes
	calla	RNDPER
	jrls	noms
	movi	650,a9			;!!!
noms
;;	movi	700,a0			;!!! ;No blocked layups sometimes
;	movi	800,a0			;!!! ;No blocked layups sometimes
;	calla	RNDPER
;	jrhi	fixde
;;FIX!!
;;Should layups be unblockable - time will tell
;;Remove this for now...	4/2/96
;	movi	TSEC*2-20,a0		;!!! ;Don't allow blocked layups
;	callr	plyr_setshtdly
	jruc	fixde

noly
	cmpi	HOOK_SEQ,a0
	jreq	hk
	cmpi	HOOK2_SEQ,a0
	jrne	nohk
hk
;DJT Start
	movi	600,a9			;!!! ;Base shot % for hook
;	movi	700,a9			;!!! ;Base shot % for hook
;DJT End

	movi	120,a0			;!!! ;Pull down % sometimes
	calla	RNDPER
	jrls	fixde
	movi	450,a9			;!!!
;	jruc	fixde

nohk
fixde

;--------------------

	move	a10,a3			;A3=hoop dir (0-7F)
	move	a11,a1			;A1=hoop dist
	sll	32-6,a3			;Throw out dir msb for range of (0-3F)
	srl	32-6,a3
	subk	020H,a3			;Make dir be just angle offset from
	abs	a3			; dirs (0base) 2 or 6 (0-1F)

	move	*a13(plyr_ohpdist),a14	;distance from hoop
	move	a14,@shot_distance
	movk	1,a14
	move	a14,@shot_percentage	;start at 100%


;This flag disallows rejected rebounds for about 2 seconds after rim hit.
;Zero it upon new shot.
	clr	a0
	.ref	must_rebound
	move	a0,@must_rebound


	.if DEBUG
;(FIX!!!)
	movk	1,a14
	move	a14,@pup_showshotper
	.endif
	move	@pup_showshotper,a14
	jrz	nosp

	PUSH	a1,a2,a7,a8,a9,a10

	move	@crplate_ptr,a2,L
	move	*a2(ODATA_p),a7,L
	jrz	makesp

	callr	make_ssp_ptrs

	move	*a7(PA10),a8,L
	move	*a8(OCTRL),a1
	move	*a10,a0,L
	calla	obj_aniq_cnoff

	move	*a7(PA8),a8,L
	move	*a8(OCTRL),a1
	move	*a9,a0,L
	calla	obj_aniq_cnoff

	movi	TSEC*2,a0
	move	a0,*a7(PTIME)
	jruc	madesp
makesp
	CREATE	06000H,plyr_showshotpercent
	move	a0,*a2(ODATA_p),L
madesp
	PULL	a1,a2,a7,a8,a9,a10
nosp

;--------------------

	movk	1,a10			;A10=normal shot arc

	PUSH	a1
	movk	16,a0			;!!! All shots chance of flat arc
	calla	RNDPER
	jrls	noflat0
	clr	a10			;A10=flat shot arc
noflat0
	move	*a13(plyr_seqflgs),a14
	btst	LAYUP_B,a14		;Doing a lay-up?
	jrz	noflat			; br=no
	movi	100,a0			;!!! Lay-up chance of flat arc
	calla	RNDPER
	jrls	noflat
	clr	a10			;A10=flat shot arc
noflat
	PULL	a1

;	jruc	miss			;DEBUG
;	jruc	good			;DEBUG

;--------------------
; See if we should do a bank shot

	subk	018H,a3			;!!! Would bank angle be too steep?
	jrge	athoop			; br=yes, don't bank

	move	@plyr_onfire,a0		;Is someone on-fire?
	jrnz	athoop			; br=yes, don't bank

;;	move	*a13(plyr_num),a14
;;	move	@plyr_onfire,a0
;;	btst	a14,a0			;Is the shooter on-fire?
;;	jrz	cont			; br=no
;;	move	@PSTATUS2,a0
;;	btst	a14,a0			;Is the shooter a human?
;;	jrnz	athoop			; br=yes, don't bank
;;cont
	cmpi	100,a1			;!!! Too far for short bank?
	jrgt	longshot		; br=yes

;;	movk	2,a0			;33% chance
;;	move	*a13(plyr_seqflgs),a14
;;	btst	LAYUP_B,a14
;;	jrnz	fmfront

	move	*a13(plyr_seq),a14
;FIX!!!  Determine which seq(s) should always close bank
	cmpi	DUNKLAY5_SEQ,a14	;In a seq that wants a short bank?
	jrz	offbb			; br=yes

	movk	4,a0			;!!! 20% chance
	addk	8,a3			;More in front of board?
	jrlt	fmfront		; br=yes
	movk	3,a0			;!!! 25% chance for steeper angles
fmfront
	callr	rndrng0
	move	a0,a0			;Beat the odds?
	jrnz	athoop			; br=no, don't bank

offbb					;0CHlose bank shot
	movk	15,a10			;!!! 1 in 16 chance of flat arc

	movi	-10,a4			;!!! =X offset
	movi	-8,a5			;!!! =Y offset
	movk	2,a6			;!!!

	movi	999,a0
	callr	rndrng0
	and	a0,a10			;A10=flat shot arc
	cmp	a0,a9			;Beat shot % odds?
	jrgt	cbgood			; br=yes
cbbad
	movk	3,a0			;Randomize X offset for some misses
	callr	rndrng0
	addk	1,a0
	sll	1,a0
	sub	a0,a4
	movk	1,a0			;Randomize Z offset for some misses
	callr	rndrng0
	sll	4,a0
	subk	8,a0
	move	a0,a2
	jruc	cbdxdy

cbgood
	move	*a7(OZPOS),a3
	subi	CZMID,a3		;=ball Z delta from hoop
	sll	8,a3

	move	*a7(OXPOS),a14
	move	*a7(OIMG),a1,L
	move	*a1(IANIOFFX),a1
	add	a1,a14			;=ball ctr X
	move	*a13(plyr_ohoopx),a1
	sub	a14,a1			;=ball X delta from hoop
	abs	a1
	jrz	cbnodiv		; br=delta X=0 (should never be)?
	divs	a1,a3
cbnodiv
	mpys	a6,a3
	sra	8,a3
	move	a3,a2			;=Z offset
cbdxdy
	move	a4,a0			;=X offset
	move	a5,a1			;=Y offset
	jruc	calcshot

longshot				;>Long bank shot
	addk	8,a3			;!!! Would bank angle be too steep?
	jrge	athoop			; br=yes, don't bank

	movk	3,a0			;!!! 75% chance
	callr	rnd			;Beat the odds?
	jrnz	athoop			; br=no, don't bank

	movi	-12,a4			;!!! =X offset
	movi	-10,a5			;!!! =Y offset
	movk	2,a6			;!!!

	movi	999,a0
	callr	rndrng0
	cmp	a0,a9			;Beat shot % odds?
	jrgt	cbgood			; br=yes
	jruc	cbbad			;Make shot miss

;--------------------

athoop
	cmpi	55,a9			;25
	jrge	notlng
	cmpi	0148H,a11
	jrlt	notlng

	movi	120,a0			;250
	calla	RNDPER
	jrls	noairb
	jruc	airok
notlng
	movk	01fH,a0			;3%
	cmpi	55,a11
	jrge	chkairb		;Not a close shot?
	movi	07fH,a0			;1.5%
chkairb
	callr	rnd
	jrnz	noairb			;No air ball?

	move	*a13(plyr_ptsdown),a0
	subk	2,a0
	jrge	noairb			;Losing by 2 or more? No airball

	move	@plyr_onfire,a14	;Is someone on-fire?
	jrnz	noairb			; br=yes, don't do airball

;	move	*a13(plyr_num),a0
;	btst	a0,a14			;Is the shooter on-fire?
;	jrnz	noairb			; br=yes, don't do airball

	move	*a13(plyr_o1dist),a14	;Totally open shot?
	cmpi	50*DIST_REDUCTION,a14
	jrlt	airok
	move	*a13(plyr_o2dist),a14
	cmpi	50*DIST_REDUCTION,a14
	jrgt	noairb
airok

	movi	-1,a0
	move	a0,@plyrairballoff

	move	a7,a2
	CREATE0	plyr_airballsnd
	movi	-1,a0
	move	a0,@shot_percentage	;miss
	move	a2,a7

	movk	20,a2			;0AHir ball ;18
	movk	1,a0
	callr	rnd
	jrnz	airf
	neg	a2			;-Z
airf
	clr	a0			;=X offset
	clr	a1			;=Y offset

;	movi	-40,a0
;	movi	-30,a1			;Y
	jruc	calcshot

;--------------------

    .even
rnd

	move	@RAND,a1,L
	rl	a1,a1
	move	@HCOUNT,a14
	rl	a14,a1
	add	sp,a1
	move	a1,@RAND,L

	and	a1,a0
	rets


noairb
	movi	999,a0			;>Shoot at hoop
	callr	rndrng0
	addi	50,a9			;Adj for better %
	cmp	a0,a9			;Beat shot % odds?
	jrgt	good			; br=yes, make shot score

miss
	clr	a0
	move	a0,@shot_percentage	;miss

	movk	01fH,a0			;Miss
	callr	rnd
	sll	4,a0
	addi	misszx_t,a0
	move	*a0,a5
	move	*a0(8*16),a3

	movk	1,a0			;50%
	callr	rnd
	jrnz	miss2

	movk	2,a0			;More towards rim edge
	callr	rndrng0
	addk	6,a0			;7 ;Vel multiplier range
	jruc	miss3
miss2
	movk	3,a0			;Regular miss (they go in a fair amount)
	callr	rnd
	addk	4,a0			;6 ;Vel multiplier range
miss3
	mpys	a0,a3
	mpys	a0,a5
	move	a3,a0
	move	a5,a2
	sra	12,a0			;=X offset
	sra	12,a2			;=Z offset

	jruc	cyo

good
	movk	4,a0			;>Make shot score
	callr	rndrng0
	subk	2,a0
	move	a0,a2			;=Z offset

	movk	4,a0
	callr	rndrng0
	subk	2,a0			;=X offset
cyo
	movi	-3,a1			;=Y offset

;--------------------
;  a0=shot X offset
;  a1=shot Y offset
;  a2=shot Z offset
;  a7=ball *obj
; a10=!0 for normal shot arc, 0 for flat shot arc
;
;Dan, 5% shots go in about 50% of time, we need to make this more like 25%!
;I think...  Maybe we should play a little longer....

calcshot
	move	*a13(plyr_ohoopx),a3
	cmpi	WRLDMID,a3
	jrlt	lhoop
	neg	a0
lhoop
	add	a0,a3			;Add X offset
	move	*a7(OXPOS),a14
	move	*a7(OIMG),a5,L
	move	*a5(IANIOFFX),a5
	add	a5,a14			;=ball ctr X
	sub	a14,a3			;X delta

	movi	CZMID,a5
	add	a2,a5
	move	*a7(OZPOS),a14
	sub	a14,a5			;Z delta

	move	a1,a2

	move	a3,a4			;0CaHlc distance (long+short/2.667)
	move	a5,a14
	abs	a4
	abs	a14
	cmp	a14,a4
	jrhs	xbig1
	SWAP	a14,a4
xbig1
   	sra	1,a14			;/2
	add	a14,a4
	sra	2,a14			;/8
	sub	a14,a4

	cmpi	170,a4
	jrls	distok
	move	a4,a14			;>Reduce excess
	movi	170,a4
	sub	a4,a14
	sra	3,a14			;/8
	add	a14,a4
distok
	move	a4,a1
	movi	110,a14			;120
	mpys	a14,a1
	move	a1,a4
	sra	8,a4			;/256

	movi	50,a14			;!!! Min tick for normal shot arc
	move	a10,a10			;Normal or flat shot arc?
	jrnz	chkmin			; br=normal
	movi	35,a14			;!!! Min tick for flat shot arc
	move	a4,a1			;Reduce tick cnt 25% to flatten shot
	sra	2,a1
	sub	a1,a4
chkmin
	cmp	a14,a4
	jrge	divok
	move	a14,a4

divok
	move	*a13(plyr_seq),a1
;DJT Start
	move	*a13(plyr_seqflgs),a14
	btst	LAYUP_B,a14
	jrz	hkck

;	jruc	hkck
;	addk	2,a4			;8

	move	@HCOUNT,a14
	btst	0,a14
	jrz	hko
	subk	10,a4
	jruc	hko

hkck
;DJT End
	cmpi	HOOK_SEQ,a1
	jrnz	hky
	addk	15,a4			;Make hook shot go a bit higher
	jruc	hko
hky
	cmpi	HOOK2_SEQ,a1
	jrnz	hko
	subk	10,a4
hko
	addk	2,a4
	movk	10,a0
	calla	RNDPER
	jrls	regshot
;Try a rainbow!
	move	@shot_distance,a0

;This is OK...
;Check to make sure a rainbow can happen from corners
	cmpi	0104H,a0
	jrgt	regshot
	addk	20,a4

	SOUND1	rainbow_sp

regshot
	sll	16,a3
	sll	16,a5
	divs	a4,a3
	divs	a4,a5

;	move	*a8(OXVEL),a1,L
;	sra	3,a1
;	add	a1,a3

	move	@plyrairballoff,a0
	jrnn	nobrick1
	clr	a0
	move	a0,@plyrairballoff

	clr	a0
	move	a0,@ballgoaltcnt

	move	a3,a0
	sra	2,a0
	sub	a0,a3
;	move	*a13(plyr_num),a14
;	cmpi	2,a14
;	jrge	nobrick1
;	add	a0,a3
;	add	a0,a3
nobrick1
	move	a3,*a7(OXVEL),L

;	move	*a8(OZVEL),a1,L
;	sra	3,a1			;/8
;	add	a1,a5
	move	a5,*a7(OZVEL),L

	movi	-GRAVB/2,a1
	mpys	a4,a1
	move	*a7(OYVAL),a3,L		;Adjust for hgt difference
	addi	HOOPY-8,a2
	sll	16,a2
	sub	a2,a3			;- if above
	divs	a4,a3
	sub	a3,a1

	move	a1,*a7(OYVEL),L

	addk	2,a4
;	subk	1,a4			;Allows goaltend of airballs

	move	a4,@ballgoaltcnt

	move	*a13(plyr_num),a1	;A1=Plyr 
	move	a1,@ballpnumshot
	move	a1,@ballpnumlast
	move	a1,@ballsclastp
	move	a1,@ballshotinair	;Shooter  if shot in air, else -1

	clr	a0
	move	a0,@ballprcv_p,L
	move	a0,@ballscorezhit
	move	a0,@ballrimhitcnt
	move	a0,@ballbbhitcnt
	move	a0,@plyrcharge
	move	a0,*a13(plyr_ownball)
	not	a0			;=-1
	move	a0,@ballpnum		;No owner

;FIX!!! Need yo look into this...
;Don't allow ball collisions for x ticks....
;This is for all shots!
;	movi	50,a0			;40
	movi	45,a0			;40
	move	a0,*a13(plyr_shtdly)
					;>Inc try shot stat
;If a player shoots a three and his teammate is in an ALLEY-OOP seq.
; then dont let'em catch it (unless teammate is a drone)

	move	@ballptsforshot,a0
	subk	2,a0
	jrle	ignre
	move	*a13(plyr_tmproc_p),a0,L
	move	*a0(plyr_num),a14
	move	@PSTATUS2,a9
	btst	a14,a9
	jrnz	ignre			;br=a human teammate
	move	*a0(plyr_seq),a14
	cmpi	ALLEYOOP1_SEQ,a14
	jrlo	ignre
	cmpi	ALLEYOOP14_SEQ,a14
	jrhi	ignre
	movi	2*TSEC,a14			;roughly 2 seconds.
	move	a14,*a0(plyr_shtdly)
ignre
	move	*a13(plyr_seqflgs),a0
	btst	LAYUP_B,a0
	jrnz	plyr_startjmp_x2            ;!!AM!! need to debug this, probably wrong, too many x's..

	movi	PS_2PTS_TRY,a0
	move	@ballptsforshot,a14
	subk	2,a14
	jreq	i_2ptrb
	movk	PS_3PTS_TRY,a0
i_2ptrb
   	calla	inc_player_stat
;DJT Start
;;Shouldn't need to do this here
;;	move	*a13(plyr_num),a14
;;	movk	1,a1
;;	sll	a14,a1
;;	move	@pup_showhotspots,a0
;;	andn	a1,a0
;;	move	a0,@pup_showhotspots
;DJT End

plyr_startjmp_x2
	move	*a13(plyr_num),a0	;Plyr  shooting
	calla	shoots_speech

	PULL	a6,a7,a9,a10,a11
	rets


misszx_t
	.word	-4096,-4017,-3784,-3406,-2896,-2275,-1567,-799
	.word	0,799,1567,2275,2896,3406,3784,4017
	.word	4096,4017,3784,3406,2896,2275,1567,799
	.word	0,-799,-1567,-2275,-2896,-3406,-3784,-4017
	.word	-4096,-4017,-3784,-3406,-2896,-2275,-1567,-799

	



	.end