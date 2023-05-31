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

	.file	"plyrmore.asm"
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

;!!AM!! we need these from plyr.asm
    .ref      plyr_main,plyr_main_initdone,joy_read2,plyr_setseq,plyr_shoot,plyr_ani

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

;!!AM!! these are in plyr1.asm now.
   	.def 	seekdirdist_obob128,seekdir_xyxy128,seekdirdist_obxz128
   	.def 	plyr_headalign,plyr_startpass,plyr_airballsnd,plyr_referee
   	.def 	plyr_setballxyz,plyr_showshotpercent,plyr_setshadow,plyr_tryrebound
   	.def 	anipt_getsclxy,anipt2_getsclxy,make_ssp_ptrs,rndrng0


;uninitialized ram definitions
	.BSS	reduce_3ptr,16
	.BSS	kp_scores	,32
	.BSS	kp_team1	,16
	.BSS	kp_team2	,16

	.BSS	pleasewt	,16
	.BSS	PSTATUS		,16	;Player in game bits (0-3)
					;/Must be in order!
	.BSS	P1CTRL		,16	;P1 joy/but bits (0-3=UDLR, 4-6=B1-B3)
	.BSS	P2CTRL		,16	;P2 (^ 8-14 are on for a on transition
	.BSS	P3CTRL		,16	;P3 of 0-6)
	.BSS	P4CTRL		,16	;P4
	.if DRONES_2MORE
	.BSS	P5CTRL		,16	;P5
	.BSS	P6CTRL		,16	;P6
	.endif

	.BSS	P1DATA		,PDSIZE	;Player 1 data
	.BSS	P2DATA		,PDSIZE	;P2
	.BSS	P3DATA		,PDSIZE	;P3
	.BSS	P4DATA		,PDSIZE	;P4
	.if DRONES_2MORE
	.BSS	P5DATA		,PDSIZE	;D5	;always a drone
	.BSS	P6DATA		,PDSIZE	;D6	;always a drone
	.endif

	.bss	pld		,PLDSZ*NUMPLYRS	;Plyr secondary data
	.BSS	plyrobj_t	,32*NUMPLYRS	;*player obj
	.BSS	plyrproc_t	,32*NUMPLYRS	;*player process

	.BSS	plyrcharge	,16	;!0=Dunker rammed an opponent
	.BSS	plyrpasstype	,16	;!0=Turbo pass
	.BSS	plyrairballoff	,16	;!0=No airball sound

	.bss	plyrinautorbnd	,16	;!0=A plyr is in auto rebound
;	.bss	drnzzcnt	,16	;Drone zigzag mode cntdn
;	.bss	drnzzmode	,16	;Drone zigzag mode (0-?)

	.BSS	plyrpals_t 	,256*16*NUMPLYRS ;Assembled palette for each plyr
	.BSS	assist_delay	,16
	.BSS	assist_plyr	,16
	.BSS	kp_qscrs	,(2*16)*7   ;Keep scores during game play
	.BSS	kp_qscrs2	,(2*16)*7   ;Keep scores for attract mode
;
;Ram for secret power-ups (if add any, also add to 'clear_secret_powerup_ram')
;
	.BSS	pup_lockcombo	,16	;Flag for locking power-up combos

	.BSS	pup_bighead	,16	;Bit 0-3 on = plyr 0-3 has big head
	.BSS	pup_hugehead	,16	;Bit 0-3 on = plyr 0-3 has huge head
	.BSS	pup_showshotper	,16
	.BSS	pup_notag	,16	;Bit 0-3 on = dont show plyr 0-3 arrow
	.BSS	pup_nodrift	,16	;Bit 0-3 on = no drift for block jumps
	.BSS	pup_noassistance,16	;1=turn help off
	.BSS	pup_aba		,16	;0=regular ball, !0=ABA ball
	.BSS	pup_court	,16	;0=indoor, !0=outdoor
	.BSS	pup_showhotspots,16	;Bit 0-3 on = show plyr 0-3 hotspots

	.BSS	pup_tournament	,16	;*4

	.BSS	pup_baby	,16	;Flag for baby size mode
	.BSS	pup_nomusic	,16	;Flag for no game-time music
	.BSS	pup_goaltend	,16	;Bit 0-3 on = plyr 0-3 has powerup g.t.
	.BSS	pup_maxblock	,16	;Bit 0-3 on = plyr 0-3 has stl power
	.BSS	pup_maxsteal	,16	;Bit 0-3 on = plyr 0-3 has stl power
	.BSS	pup_maxpower	,16	;Powerup power - can't be pushed down
	.BSS	pup_maxspeed	,16	;Bit 0-3 on = plyr 0-3 max runing speed
	.BSS	pup_hypspeed	,16	;Bit 0-3 on = plyr 0-3 max runing speed
	.BSS	pup_trbstealth	,16	;Bit 0-3 on = plyr 0-3 shoes dont change color
	.BSS	pup_trbinfinite	,16	;Bit 0-3 on = plyr 0-3 always has turbo
	.BSS	pup_nopush	,16	;Bit 0-3 on = plyr 0-3 can't push
	.BSS	pup_fastpass	,16	;Bit 0-3 on = plyr 0-3 has fast passing

	.BSS	pup_strongmen	,16	;Grnd champ flag 0,1 or 2 for team 

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

********************************
* Make shot percentage digit ptrs
* A9=Percent (0-1000)
* 0A10H=*tens digit *img
* 0A9H=*ones digit *img
* Destroys A8

 SUBR	make_ssp_ptrs

	movk	10,a10
	divu	a10,a9

	cmpi	99,a9
	jrls	maxok
	movi	99,a9
maxok
	clr	a8
	divu	a10,a8
	sll	5,a8
	sll	5,a9
	movi	f_t,a10
	add	a10,a9
	add	a8,a10

	rets

f_t
	.long	font60,font61,font62,font63,font64
	.long	font65,font66,font67,font68,font69


********************************
* Show shot percentage (process)
* A9=Percent (0-1000)

 SUBRP	plyr_showshotpercent

;;	PUSHP	a11			;Save hoop-2-plyr dist

	.if DEBUG
	cmpi	5700,a9
	jrlo	pss
;	LOCKUP
pss
	.endif

	callr	make_ssp_ptrs

	move	*a10,a2,L
	movi	[SCOREBRD_X+26,0],a0
	movi	[SCOREBRD_Y+13,0],a1
	movi	SCOREBRD_Z,a3
	movi	DMAWNZ|M_NOCOLL|M_SCRNREL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
	move	a8,a10

	move	*a9,a2,L
	movi	[SCOREBRD_X+32,0],a0
	movi	[SCOREBRD_Y+13,0],a1
	calla	BEGINOBJ2

	movi	SHOTPER,a9,L		;Change credit plate
	move	@crplate_ptr,a11,L
	move	*a9(ISAG),*a11(OSAG),L

	SLEEP	TSEC*2

	move	*a11(OIMG),a9,L		;Restore previous credit plate
	move	*a9(ISAG),*a11(OSAG),L
	clr	a9
	move	a9,*a11(ODATA_p),L

;;	PULLP	a11			;Retrieve hoop-2-plyr dist

	move	a10,a0
	calla	DELOBJ
	jauc	DELOBJDIE



********************************
* Make sound for airball (process)

 SUBRP	plyr_airballsnd

	SLEEP	80

	move	@plyrairballoff,a0
	jrnz	plyr_airballsnd_x
	.ref	crwd_arbl_sp
	SOUND1	crwd_arbl_sp

	movk	4,a0
	calla	rndrng0
	sll	5,a0
	addi	airbl_sp_tbl,a0
	move	*a0,a0,L
	calla	snd_play1
plyr_airballsnd_x	DIE

airbl_sp_tbl
	.long	airball_sp
	.long	sht_stunk_sp
	.long	misd_mile_sp
	.long	way_shrt_sp
	.long	misd_evry_sp


********************************
* Start player pass to teammate
* A8=*Plyr obj
* A13=*Plyr process
* Trashes scratch, A2-A5

 SUBRP	plyr_startpass

	PUSH	a6,a7

	move	*a13(plyr_tmproc_p),a4,L

	move	*a4(plyr_seqflgs),a14
	btst	DUNK_B,a14
	jrz	psp1a				;br=not dunk,in air = no pass

	move	*a13(plyr_seqflgs),a14
	btst	DUNK_B,a14
	jrnz	plyr_startpass_x				;br=both in dunk = no pass

	jruc	contd
psp1a
	move	*a4(plyr_jmpcnt),a0
	jrnz	plyr_startpass_x
contd
	move	*a13(plyr_seqdir),a14
	move	a14,*a13(plyr_old_seqdir)

	move	*a13(plyr_num),a1
	inc	a1
	move	a1,@assist_plyr
	movi	3*60+30,a0
	move	a0,@assist_delay

	move	a10,a2
	move	a4,a10
	calla	arw_on1plyr		;Guy who picks up ball gets arw
	move	a2,a10
	move	a4,@ballprcv_p,L

	move	*a4(PA8),a2,L		;Get teammates obj
	move	*a2(OXPOS),a6
	move	*a2(OXANI+16),a14
	add	a14,a6
	move	*a2(OZPOS),a7

	move	*a4(plyr_seqflgs),a14
	btst	DUNK_B,a14
	jrz	psp2				;br=teammate not in a dunk

; DONT worry about this, cause plyr_pass isn't called for nine ticks after
;   the pass button was pushed...thus startdunk will have been called
;   and velocities set!!
;
;	move	*a4(plyr_jmpcnt),a14
;	jrz	x
	move	*a4(plyr_slam_ticks),a2
	move	*a4(plyr_jmpcnt),a14
	sub	a14,a2
	jrle	plyr_startpass_x				;br=to late for pass
;	subk	20,a2				;at least 20 ticks b4 slam ?
	subk	26,a2				;at least 25 ticks b4 slam ?
	jrle	plyr_startpass_x				;br=no
	
	callr	seekdirdist_obxz128
	move	a0,*a13(plyr_newdir)		;Turn toward alley-ooper

	clr	a2
	move	*a13(plyr_ptsdown),a14
	addk	3,a14
	jrge	losing
	movi	100,a0				;Make alleys doink sometimes
	calla	RNDPER				; if plyr is ahead
	jrls	losing
	movi	500,a2
losing
	move	a2,@shot_distance
	movi	ALLEYOOP_PAS_SEQ,a0
	move	*a13(plyr_jmpcnt),a14
	jrz	reg3
	movi	PASSDO_SEQ,a0
	move	*a13(plyr_tmdist),a14
	cmpi	110*DIST_REDUCTION,a14
	jrgt	reg3
	movi	PASSDO2_SEQ,a0

reg3

;	move	*a13(plyr_dir),a7
	move	*a13(plyr_newdir),a7	;Turn toward alley-ooper
	callr	plyr_setseq
;	jruc	end
	movi	-1,a3
	jruc	bhin

psp2
	move	@inbound,a0
	jrnn	notnl4			;Inbounding the ball?

;DEBUG - Check no look pass code/art
;	jruc	nlcont


;How often do we try a no look pass?
	movi	200,a0
	calla	RNDPER
	jrls	notnl4			;BR=nope

	move	*a13(plyr_jmpcnt),a14
	jrnz	notnl4			;In air?

	move	*a13(plyr_tmdist),a14
	cmpi	90*DIST_REDUCTION,a14
	jrlt	notnl4			;Too short?
	subi	320*DIST_REDUCTION,a14
	jrgt	notnl4			;Too far?

nlcont

;Check to see if teammate is in an ok position to receive a no look
;pass based on what direction passer is facing and teammate is located.

;Directions are 0-7
;
;
;	0
;     7	  1
;   6	    2
;     5	  3
;	4	
;
;

	callr	seekdirdist_obxz128
	move	a1,a2

;	move	*a13(plyr_dir),a14
;	sub	a0,a14
;	abs	a14
;	cmpi	020H,a14
;	jrhs	notbh

	move	a0,a14
	addi	040H,a14
	sll	32-7,a14
	srl	32-7,a14

	addk	8,a0			;Round off
	sll	32-7,a0
	srl	32-7+4,a0		;Kill frac

	move	*a13(plyr_seqdir),a1
;	move	a1,*a13(plyr_old_seqdir)

;
; a0 = teammates dir
; a1 = passers seq. dir
;
;Facing up scrn
	cmpi	0,a1
	jrnz	nldir2

;Allow 2 angle
	cmpi	2,a0
	jrz	nldo1

;Allow 6 angle if I X flip passer

	cmpi	6,a0
	jrnz	notnl4

;X flip after seq starts
	movi	PASSNL_SEQ,a0
	move	a0,a3
	callr	plyr_setseq

	movi	M_FLIPH,a3
	move	a3,*a13(plyr_anirevff)
	clr	a3
	dec	a3
	jruc	bhconta
nldo1
	movi	PASSNL_SEQ,a0
	move	a14,*a4(plyr_newdir)
	move	*a13(plyr_dir),a7
	jruc	bhpas


nldir2					;2 direction possibility
;Facing up & right on scrn
	cmpi	1,a1
	jrnz	nldir2a

;Allow 2,3 angle
	cmpi	2,a0
	jrz	nldo2
	cmpi	3,a0
	jrnz	nldir2a

nldo2
	movi	PASSNL_SEQ,a0
	move	a14,*a4(plyr_newdir)
	move	*a13(plyr_dir),a7
	jruc	bhpas


nldir2a
;Facing up & left on scrn
	cmpi	7,a1
	jrnz	nldir3

;Allow 5,6 angle
	cmpi	5,a0
	jrz	nldo2
	cmpi	6,a0
	jrz	nldo2

nldir3
;Facing right on scrn
	cmpi	2,a1
	jrnz	nldir3a

;Allow 4 angle
	cmpi	4,a0
;	jrz	nldo3
;	cmpi	3,a0
	jrnz	nldir3a

nldo3
	movi	PASSNL_SEQ,a0
	move	a14,*a4(plyr_newdir)
	move	*a13(plyr_dir),a7
	jruc	bhpas


nldir3a
;Facing left on scrn
	cmpi	6,a1
	jrnz	nldir4

;Allow 4 angle
	cmpi	4,a0
	jrz	nldo3
;	cmpi	6,a0
;	jrz	nldo3


nldir4
;Facing down & right on scrn
	cmpi	3,a1
	jrnz	nldir4a

;Allow 5 angle
	cmpi	5,a0
;	jrz	nldo2
;	cmpi	3,a0
	jrnz	nldir4a

nldo4
	movi	PASSNL_SEQ,a0
	move	a14,*a4(plyr_newdir)
	move	*a13(plyr_dir),a7
	jruc	bhpas


nldir4a
;Facing down & left on scrn
	cmpi	5,a1
	jrnz	nldir5

;Allow 3 angle
	cmpi	3,a0
	jrz	nldo4
;	cmpi	6,a0
;	jrz	nldo2

nldir5
;Facing down on scrn
	cmpi	4,a1
	jrnz	notnl4

;Allow 6 angle
	cmpi	6,a0
;	jrz	nldo5
;	cmpi	3,a0
	jrnz	nldir5a

nldo5
	movi	PASSNL_SEQ,a0
	move	a14,*a4(plyr_newdir)
	move	*a13(plyr_dir),a7
	jruc	bhpas


nldir5a
;Allow 2 angle if I X flip passer

	cmpi	2,a0
	jrnz	notnl4

;X flip after seq starts
	movi	PASSNL_SEQ,a0
	move	a0,a3
	callr	plyr_setseq

	movi	M_FLIPH,a3
	move	a3,*a13(plyr_anirevff)
	clr	a3
	dec	a3
	jruc	bhconta


notnl4

;DEBUG - Check behind the back pass code/art
;	jruc	bhcont


 	movi	350,a0
	calla	RNDPER
	jrls	notbh

	move	*a13(plyr_jmpcnt),a14
	jrnz	notbh			;In air?

	move	*a13(plyr_tmdist),a14
	cmpi	90*DIST_REDUCTION,a14
	jrlt	notbh			;Too short?
	subi	360*DIST_REDUCTION,a14
	jrgt	notbh			;Too far?

;Only decent passers can do behind the back passes
	move	*a13(plyr_attrib_p),a14,L
	move	*a14(PAT_PASS),a14
	cmpi	5,a14
	jrlt	notbh

	move	*a13(plyr_o1dist),a1
 	cmpi	078H*DIST_REDUCTION,a1
	jrlt	notbh
	move	*a13(plyr_o2dist),a1
	cmpi	078H*DIST_REDUCTION,a1
	jrlt	notbh
 
;Want to stop ball from being inbounded using the BHPASS

	move	@inbound,a0
	jrn	bhcont			;Inbounding the ball?

;I'm ahead, maybe still do cocky inbound

	move	*a13(plyr_ptsdown),a1
	jrgt	notbh			;If losing, don't bhpass
	addk	6,a1
	jrge	notbh			;If ahead by 7 or more, allow attempt
bhcont
 
;Check to see if teammate is in an ok position to receive a behind the back
;pass based on what direction passer is facing and teammate is located.

;Directions are 0-7
;
;
;	0
;     7	  1
;   6	    2
;     5	  3
;	4	
;
;
;Rules for T1HINDR10-6 art:
;
;If passer is facing 0 and teammate is in 1,2 then do it,
;or if passer is facing 0, but art is flipped, and teammate is in 7,8 then
;do it.
;


	callr	seekdirdist_obxz128
	move	a1,a2

;	move	*a13(plyr_dir),a14
;	sub	a0,a14
;	abs	a14
;	cmpi	020H,a14
;	jrhs	notbh

	move	a0,a14
	addi	040H,a14
	sll	32-7,a14
	srl	32-7,a14

	addk	8,a0			;Round off
	sll	32-7,a0
	srl	32-7+4,a0		;Kill frac

	move	*a13(plyr_seqdir),a1
;	move	a1,*a13(plyr_old_seqdir)

;
; a0 = teammates dir
; a1 = passers seq. dir
;
;Facing up scrn
	cmpi	0,a1
	jrnz	dir2

;Allow 1,2 angle
	cmpi	1,a0
	jrz	do1
	cmpi	2,a0
	jrz	do1

;Allow 6,7 angle if I X flip passer

	cmpi	6,a0
	jrz	do1a
	cmpi	7,a0
	jrnz	notbh

do1a
;X flip after seq starts
	movi	PASSBH_SEQ,a0
	move	a0,a3
	callr	plyr_setseq

	movi	M_FLIPH,a3
	move	a3,*a13(plyr_anirevff)
	clr	a3
	dec	a3
	jruc	bhconta
do1
	movi	PASSBH_SEQ,a0
	move	a14,*a4(plyr_newdir)
	move	*a13(plyr_dir),a7
	jruc	bhpas


dir2					;2 direction possibility
;
; a0 = teammates dir
; a1 = passers seq. dir
;
;Facing up & right on scrn
	cmpi	1,a1
	jrnz	dir2a

;Allow 1,2 angle
	cmpi	1,a0
	jrz	do2
	cmpi	2,a0
	jrnz	dir2a
do2
	movi	PASSBH_SEQ,a0
	move	a14,*a4(plyr_newdir)
	move	*a13(plyr_dir),a7
	jruc	bhpas

dir2a
;
; a0 = teammates dir
; a1 = passers seq. dir
;
;Facing up & left on scrn
	cmpi	7,a1
	jrnz	dir3

;Allow 6,7 angle
	cmpi	6,a0
	jrz	do2
	cmpi	7,a0
	jrz	do2


dir3
;Facing up & right on scrn
	cmpi	1,a1
	jrnz	dir3a

;Allow 0,7 angle also
	cmpi	0,a0
	jrz	do3
	cmpi	7,a0
	jrnz	dir3a
do3
;Do PASSBH2 because we already have a 2 BHPASS!
	movi	PASSBH2_SEQ,a0
	move	a14,*a4(plyr_newdir)
	move	*a13(plyr_dir),a7
	jruc	bhpas

dir3a
;Facing up & left on scrn
	cmpi	7,a1
	jrnz	dir4

;Allow 0,1 angle also
	cmpi	0,a0
	jrz	do3
	cmpi	1,a0
	jrz	do3

dir4
;Do 3 horizontal facing behind the back passes
;Facing right on scrn
	cmpi	2,a1
	jrnz	dir4a

;Allow 2,3 angle
	cmpi	2,a0
	jrz	do4
	cmpi	3,a0
	jrnz	dir4a
do4
	movi	PASSBH_SEQ,a0
	move	a14,*a4(plyr_newdir)
	move	*a13(plyr_dir),a7
	jruc	bhpas
dir4a
;Facing left on scrn
	cmpi	6,a1
	jrnz	dir5

;Allow 5,6 angle
	cmpi	5,a0
	jrz	do4
	cmpi	6,a0
	jrz	do4

dir5
;Do 3 horizontal facing behind the back passes
;Facing right on scrn
	cmpi	2,a1
	jrnz	dir5a

;Allow 0,1 angle
	cmpi	0,a0
	jrz	do5
	cmpi	1,a0
	jrnz	dir5a
do5
	movi	PASSBH2_SEQ,a0
	move	a14,*a4(plyr_newdir)
	move	*a13(plyr_dir),a7
	jruc	bhpas
dir5a
;Facing left on scrn
	cmpi	6,a1
	jrnz	dir6

;Allow 0,7 angle
	cmpi	0,a0
	jrz	do5
	cmpi	7,a0
	jrz	do5

dir6
;Do 4 facing behind the back passes
;Facing down & right on scrn
	cmpi	3,a1
	jrnz	dir6a

;Allow 3,4,5 angle
	cmpi	3,a0
	jrz	do6
	cmpi	4,a0
	jrz	do6
	cmpi	5,a0
	jrnz	dir6a
do6
	movi	PASSBH_SEQ,a0
	move	a14,*a4(plyr_newdir)
	move	*a13(plyr_dir),a7
	jruc	bhpas
dir6a
;Facing down & left on scrn
	cmpi	5,a1
	jrnz	dir7

;Allow 3,4,5 angle
	cmpi	3,a0
	jrz	do6
	cmpi	4,a0
	jrz	do6
	cmpi	5,a0
	jrz	do5
dir7
;Facing down & right on scrn
	cmpi	3,a1
	jrnz	dir7a

;Allow 2,3 angle
	cmpi	2,a0
	jrz	do7
	cmpi	3,a0
	jrnz	dir7a
do7
	movi	PASSBH2_SEQ,a0
	move	a14,*a4(plyr_newdir)
	move	*a13(plyr_dir),a7
	jruc	bhpas
dir7a
;Facing down & left on scrn
	cmpi	5,a1
	jrnz	dir8

;Allow 5,6 angle
	cmpi	5,a0
	jrz	do7
	cmpi	6,a0
	jrz	do7

dir8
notbh
	callr	seekdirdist_obxz128	;>Turn toward teammate
	move	a0,*a13(plyr_dir)

	move	a0,*a13(plyr_newdir)

	move	a0,a7
	move	a0,a3

	addi	040H,a0
	sll	32-7,a0
	srl	32-7,a0
	move	a0,*a4(plyr_newdir)
	move	a1,a2

	movi	PASSDO_SEQ,a0

	move	*a13(plyr_jmpcnt),a14
	jrz	contpass

;Fix dunks attempted stat

	move	*a13(plyr_seqflgs),a14
	btst	DUNK_B,a14
	jrz	nodnk

	PUSH	a0

	movk	PS_DUNKS_TRY,a0		;0DecH dunk stats
	move	*a13(plyr_num),a1
	.ref	dec_player_stat
	calla	dec_player_stat
	movi	PS_2PTS_TRY,a0
	move	*a13(plyr_num),a1
	calla	dec_player_stat

	PULL	a0

nodnk

	move	*a13(plyr_tmdist),a14
	cmpi	110*DIST_REDUCTION,a14
	jrgt	ss
	movi	PASSDO2_SEQ,a0
	jrnz	ss			;Air dish off pass?
contpass

	movi	PASSS_SEQ,a0
	cmpi	170*DIST_ADDITION,a2			;50
	jrle	ss

;If a good passer...

	movi	PASSC_SEQ,a3

	move	*a13(plyr_attrib_p),a14,L
	move	*a14(PAT_PASS),a5
	cmpi	6,a5
	jrlt	normp
	movi	FASTPASSC_SEQ,a3
normp
	movk	7,a0
	callr	rnd
	jrnz	normchest		;12% regular chest?
	movi	PASSNEWOH_SEQ,a3
	cmpi	6,a5
	jrlt	normchest
	movi	FASTPASSNEWOH_SEQ,a3
normchest
	move	a3,a0

ss
bhpas
	.if	DEBUG
;Test different types of passing
	jruc	skipem
	movi	PASSS_SEQ,a0	     ;Short pass
	movi	PASSC_SEQ,a0	     ;Long chest pass
	movi	FASTPASSC_SEQ,a0     ;Fast long chest pass
	movi	PASSDO_SEQ,a0	     ;Dish off
	movi	PASSDO2_SEQ,a0	     ;Dish off no big arm extend
	movi	PASSNL_SEQ,a0	     ;No look pass
;	movi	PASSNL2_SEQ,a0	     ;
;	movi	PASSNL3_SEQ,a0	     ;
	movi	PASSC_SEQ,a0	     ;Long chest pass
	movi	FASTPASSNEWOH_SEQ,a0 ;Fast new overhead pass
	movi	PASSBH_SEQ,a0	     ;Behind back pass
	movi	PASSNEWOH_SEQ,a0     ;New overhead pass

	movi	PASSC_SEQ,a0	     ;Long chest pass
skipem
	.endif

	move	a0,a3

	move	*a13(plyr_tmdist),a14
	cmpi	170,a14
	jrgt	bhconta
;If close pass, rotate now instead of calculating where I should be
;if this is a leading pass...

	callr	plyr_setseq

bhconta
;	subk	PASSOH_SEQ,a3
;	jreq	nolead

	cmpi	PASSNL_SEQ,a3
	jrnz	noleadnl
	jrz	lead_nl
;	cmpi	PASSNL2_SEQ,a3
;	jrnz	noleadnl

lead_nl
;Try a leading pass even on a no look pass
	move	*a4(plyr_dirtime),a1
	jrz	nolead_nl
	subk	10,a1			;10
	jrlt	nolead_nl

noleadnl

;	cmpi	35,a2
;	jrlt	nolead			;Too close?

	move	*a4(plyr_dirtime),a1
	jrz	nolead_notm

;Shawn, I increased this because we were getting to many missed leading
;passes.  Because the receiver would bump into a defender and get thrown
;off course. 

	subk	8,a1			;8
	jrgt	leadingpass

	move	*a4(plyr_o1dist),a0

	cmpi	25*DIST_ADDITION,a0
;	cmpi	35,a0
	jrlt	nolead_ocls		;Opponent too close?
	move	*a4(plyr_o2dist),a0
	cmpi	25*DIST_ADDITION,a0
;	cmpi	35,a0
	jrge	leadingpass


;Additional checks are required here to determine if this will cause the
;leading pass to fly off scrn and cause the receiver to become stuck
;against the glass wall.

;	move	*a13(plyr_tmdist),a2
	cmpi	30*DIST_ADDITION,a2		;30
	jrlt	nolead_tm		;Too close?
	move	*a4(plyr_dirtime),a1
	subk	4,a1
	jrgt	leadingpass

nolead_notm
;	LOCKUP				;Not running long enough
	move	@PCNT,a0

	ANDK	1,a0
;	ANDK	3,a0
;TEMP!!!
;	jrnz	nolead_a
	jruc	nolead_a
	jruc	leadingpass

nolead_nl
;	LOCKUP				;A no look pass
	jruc	nolead_a

nolead_ocls
;	LOCKUP				;Opponent too close
	jruc	nolead_a

nolead_tm
;	LOCKUP				;Teammate too close


nolead_a
	movk	1,a0
	move	a0,*a4(plyr_nojoy)

	jruc	end


leadingpass
	move	*a4(plyr_jmpcnt),a1
	jrnz	nolead			;He's jumping?


;Disallow leading behind the back pass if using 4 or 2 behind back pass art
;and teammate is running toward passer
;At the moment, receiver must be running horizontally away from me!  (2 or 6)

;FIX!!!  Make new rules here for not allowing leading behind the back passes

;	cmpi	PASSBH2_SEQ,a3
;	jrz	tst
;	cmpi	PASSBH_SEQ,a3
;	jrne	notst
;
;tst
;;	move	@PCNT,a14
;;	ANDK	3,a14
;;	jrnz	notst
;
;;	move	*a13(plyr_seqdir),a1
;;	move	*a4(plyr_seqdir),a0
;;	cmpi	5,a1
;;	jrge	ck1
;;	cmpi	2,a0
;;	jrz	bhin
;;	jruc	nolead
;;ck1	cmpi	6,a0
;;	jrne	nolead
;;	jruc	bhin
;notst		

;Will be a leading pass, rotate passer so that pass will go to where
;receiver will be when he receives the pass


	move	*a13(plyr_tmproc_p),a4,L
	move	*a4(PA8),a2,L		;Get teammates obj
	move	*a2(OXPOS),a6
	move	*a2(OXANI+16),a14
	add	a14,a6
	move	*a2(OZPOS),a7

;All passes are not 32 ticks however!
	move	*a2(OXVEL),a0,L		;Where will teammate be in 32 ticks?
	sra	16-5,a0

;Subtract a few ticks
	move	*a2(OXVEL),a14,L
	sra	15,a14
	add	a14,a0


	add	a0,a6
	move	*a2(OZVEL),a0,L
	sra	16-5,a0


	move	*a2(OZVEL),a14,L
	sra	15,a14
	add	a14,a0


	add	a0,a7

	callr	seekdirdist_obxz128	;>Turn toward where teammate will be
	move	a0,*a13(plyr_dir)
	move	a0,*a13(plyr_newdir)


bhin
	move	*a4(PA11),a0,L		;>Keep teammate moving in same dir
	move	*a0,a0
	sll	32-4,a0
	srl	32-4,a0
	ori	08000H,a0
	move	a0,*a4(plyr_nojoy)	;Neg
	move	a0,*a4(plyr_newdir)

end

;Check teammates position along all boundaries
;and make sure he is set inside of buffer

;If teammate is running horizontally along the top or bottom of court,
;push him slightly toward center of screen and allow leading pass...
	move	*a4(PA8),a1,L		;>Keep teammate moving in same dir
	move	*a1(OZPOS),a0
	cmpi	CZMIN+8,a0
	jrgt	upok
	movi	CZMIN+10,a0
	move	a0,*a1(OZPOS)
	jruc	ck_ok

upok	cmpi	CZMAX-6,a0		;stupid K!!! ;Is Z ok? Yes if <
	jrlt	dnok
	movi	CZMAX-8,a0		;stupid K!!! ;Is Z ok? Yes if <
	move	a0,*a1(OZPOS)
	jruc	ck_ok

dnok
;Don't do a leading pass if teammate is running vertically against either 
;court edge!
;	move	*a1(OXPOS),a0
;	move	*a1(OXANI+16),a14
;	add	a14,a0
;	cmpi	PLYRMINX,a0		;Is X ok? Yes if >
;	jrgt	lok
;	movi	PLYRMINX+2,a0		;Is X ok? Yes if >
;	move	a0,*a1(OXPOS)
;	jruc	ck_ok
;
;lok	cmpi	PLYRMAXX,a0		;Is X ok? Yes if <
;	jrlt	ck_ok
;	movi	PLYRMAXX-2,a0		;Is X ok? Yes if <
;	move	a0,*a1(OXPOS)

ck_ok

;Player dir changes if a leading pass should happen...
;If alley oop, don't do this setseq
	move	a3,a3			;Alley oop type pass?
	jrn	no

	move	*a13(plyr_tmdist),a14
	cmpi	170,a14
	jrle	no

;I must have already done the setseq!  
;Watch this for bugs...
	move	*a13(plyr_dir),a7
	move	a3,a0
	callr	plyr_setseq

no

	movk	30,a0
	move	a0,*a4(plyr_rcvpass)

	move	*a4(plyr_seqflgs),a0
	btst	SAMEDIR_B,a0
	jrz	    plyr_startpass_x
	movi	-1,a0
	move	a0,*a4(plyr_newdir)	;Kill dir change


plyr_startpass_x	PULL	a6,a7
	rets


********************************
* Player lobs the ball from a dunk (called from seq)
* A8=*Plyr obj
* A13=*Plyr process
* Trashes scratch, A2-A5

 SUBR	plyr_lob_ball

	PUSH	a6,a9,a10,a11,a12

	move	*a13(plyr_tmproc_p),a6,L
	move	*a6(plyr_seq),a14
	cmpi	DDUNK_RECV_SEQ,a14
	jrne	shtbl				;br=player not in correct seq.
;
; Get teammates distance from hoop, and time remaining before get to hoop
;
	move	*a6(plyr_slam_ticks),a4
	move	*a6(plyr_jmpcnt),a14
	sub	a14,a4				;ticks before reach rim
	jrn	shtbl				;br=player cant recv. pass

;this is a fudge factor...catch ball 10 ticks before slam ball
	movk	10,a0
	calla	rndrng0
	addk	10,a0
	sub	a0,a4
;	subk	10,a4
	jrn	shtbl				;br=not enough time...

	calla	ball_convfmprel
	move	@ballobj_p,a0,L

	move	*a6(PA8),a8,L			;Get * teammates obj
	move	*a8(OXVAL),a3,L
	move	*a8(OXANI),a14,L
	add	a14,a3
	move	*a8(OXVEL),a1,L

	move	*a8(OZVAL),a5,L
	move	*a8(OZVEL),a14,L

	move	*a8(OYVAL),a10,L
	move	*a8(OYVEL),a9,L

	move	a4,b0				;0CaHlc where ball should go

poslp	add	a1,a3				;Walk through movements
	add	a14,a5	
	add	a9,a10	
	addi	GRAVB,a9

	subk	1,b0				;1 step
	jrgt	poslp
outb
	move	*a0(OZVAL),a1,L
	sub	a1,a5				;Z delta

	move	*a0(OXVAL),a1,L
;	move	*a0(OXANI+16),a14		;ALWAYS A ZERO
;	add	a14,a1
	sub	a1,a3				;X delta

	divs	a4,a3
	divs	a4,a5

	move	a3,*a0(OXVEL),L
	move	a5,*a0(OZVEL),L

	move	a10,a3			;- if ball above dest
	move	*a0(OYVAL),a10,L	;Adjust for hgt difference
	sub	a10,a3			;- if ball above dest
	move	a4,a5

	movi	-GRAVB/2,a1
	mpys	a4,a1
	divs	a4,a3
	add	a3,a1
	move	a1,*a0(OYVEL),L

	move	*a13(PA8),a8,L

	clr	a14
	move	a14,@plyrpasstype	;0=Normal, !0=Turbo

	move	*a13(plyr_num),a1
	inc	a1
	move	a1,@assist_plyr
	movi	3*60+30,a0
	move	a0,@assist_delay

	subk	3,a5
;	subk	2,a5
	move	a5,*a6(plyr_shtdly)

	move	a6,@ballprcv_p,L

	move	*a13(plyr_num),a0
	move	a0,@ballpnumshot
	move	a0,@ballpnumlast
	move	a0,@ballsclastp
	movi	-1,a0
	move	a0,@ballpnum		;No owner
	move	a0,@ballshotinair	;Shooter  if shot in air, else -1
	clr	a0
	move	a0,@ballscorezhit
	move	a0,@ballbbhitcnt
	move	a0,@ballpasstime
	move	a0,*a13(plyr_ownball)

;Don't reattach to my lobbed pass
	movk	30,a0
	move	a0,*a13(plyr_shtdly)

	movk	2,a14			;Make alley-oops always 2 ptrs
	move	a14,@ballptsforshot
	movk	DUNK_LONG,a14
	move	a14,@shot_type

	move	@plyr_onfire,a14
	move	*a13(plyr_num),a5
	btst	a5,a14
	jrnz	npasa			;br=plyr not on fire

	.ref	lob_ball_speech
	calla	lob_ball_speech
	jruc	plyr_lob_ball_x
npasa
	movi	fpass_snd,a0,L
	calla	snd_play1


plyr_lob_ball_x	PULL	a6,a9,a10,a11,a12
	rets

shtbl
	callr	plyr_shoot

	movi	swith_hnd_sp,a0,L
	move	@HCOUNT,a14
	btst	0,a14
	jrnz	shtbl2
;FIX!!
	movi	spn_shtup_sp,a0,L
;	movi	a_fngr_rl_sp,a0,L
shtbl2
	calla	snd_play1

	PULL	a6,a9,a10,a11,a12
	rets


********************************
* Player passes to teammate (called from seq)
* A8=*Plyr obj
* A13=*Plyr process
* Trashes scratch, A2-A5

 SUBR	plyr_pass

	PUSH	a6,a9,a10,a11,a12

	move	@ballpnum,a0
	move	*a13(plyr_num),a1
	cmp	a0,a1
	jrne	plyr_pass_x			;I don't have ball?

	calla	ball_convfmprel

	move	@ballobj_p,a0,L

	move	*a13(plyr_tmproc_p),a6,L
	move	*a6(PA8),a2,L		;Get * teammates obj

	move	*a2(OXPOS),a3
	move	*a2(OXANI+16),a14
	add	a14,a3
	move	*a2(OZPOS),a5

	move	*a0(OXPOS),a1
	move	*a0(OXANI+16),a14
	add	a14,a1
	sub	a1,a3			;X delta
	move	*a0(OZPOS),a1
	sub	a1,a5			;Y delta

	move	a3,a4			;0CaHlc distance (long+short/2.667)
	move	a5,a14
	abs	a4
	abs	a14
	cmp	a14,a4
	jrhs	xbig
	SWAP	a14,a4
xbig	sra	1,a14			;/2
	add	a14,a4
	sra	2,a14			;/8
	sub	a14,a4

	PUSH	a0

	move	@inbound,a0
	jrnn	no_speech

	cmpi	100,a4			;too close to call
	jrlt	no_speech

	move	*a13(plyr_num),a1
	calla	pass_to_speech

no_speech
	PULL	a0

	move	*a13(plyr_attrib_p),a14,L
	move	*a14(PAT_PASS),a2
	sll	4,a2
	movi	longpas_t,a1
	add	a2,a1
	move	*a1,a1	

;	movi	95,a1			;0CaHlc time

	cmpi	300,a4
	jrgt	ct_a

	movi	shortpas_t,a1
	add	a2,a1
	move	*a1,a1	

;	movi	115,a1


ct_a
   	move	*a13(plyr_turbon),a14
	jrz	noturb2			;No turbo?
	addi	turbopas_t,a2
	move	*a2,a2
	sub	a2,a1

;	subi	32,a1			;Quicker

noturb2
	move	a14,@plyrpasstype	;0=Normal, !0=Turbo

	mpys	a4,a1
	sra	10,a1			;/1024
	move	a1,a4
	subk	16,a1
	jrge	nshrt			;!Short?
	movk	16,a4			;Min
nshrt

	move	*a6(PA8),a2,L		;Get * teammates obj

	move	*a2(OYVAL),a10,L
	move	*a6(plyr_seq),a14
	cmpi	ALLEYOOP1_SEQ,a14	;M1SPDU1-20 frames
	jrlo	noalyb
	cmpi	ALLEYOOP14_SEQ,a14
	jrhi	noalyb
	movk	2,a14			;Make alley-oops always 2 ptrs
	move	a14,@ballptsforshot
	movk	DUNK_LONG,a14
	move	a14,@shot_type
;this was added so that there is no out-of-bounds check on alley oops
	move	a4,b0			;0CaHlc where ball should go
	move	*a2(OXVAL),a3,L
	move	*a2(OXANI),a14,L
	add	a14,a3
	move	*a2(OZVAL),a5,L
	move	*a2(OXVEL),a1,L
	move	*a2(OZVEL),a14,L
	move	*a2(OYVEL),a9,L

vellp	add	a1,a3			;Walk through movements
	add	a14,a5	
	add	a9,a10	
	addi	GRAVB,a9
	subk	1,b0			;1 step
	jrgt	vellp
	jruc	outb
noalyb
;For moving during inbound!
;	move	@inbound_lead,a14
;	jrnz	ledpas


	move	*a6(plyr_nojoy),a14
	jrnn	nolead
ledpas
	move	a4,b0			;0CaHlc where ball should go
	move	*a2(OXVAL),a3,L
	move	*a2(OXANI),a14,L
	add	a14,a3
	move	*a2(OZVAL),a5,L

	move	*a2(OXVEL),a1,L
	move	*a2(OZVEL),a14,L

;Added yvel into calc
	move	*a2(OYVEL),a9,L

bndlp	add	a1,a3			;Walk through movements
	add	a14,a5	
	add	a9,a10	
	addi	GRAVB,a9
	cmpi	(PLYRMINX)<<16,a3
	jrle	outb2
	cmpi	(PLYRMAXX)<<16,a3
	jrge	outb2
	cmpi	(CZMIN+8)<<16,a5
	jrle	outb3
	cmpi	(GZMAX-6)<<16,a5
	jrge	outb3

	subk	1,b0			;1 step
	jrgt	bndlp

	jruc	outb4

outb3
	add	a1,a3
	add	a14,a5
	add	a9,a10
	addi	GRAVB,a9

	add	a1,a3
	add	a14,a5
	add	a9,a10
	addi	GRAVB,a9
outb2
	add	a1,a3
	add	a14,a5
	add	a9,a10
	addi	GRAVB,a9

	add	a1,a3
	add	a14,a5
	add	a9,a10
	addi	GRAVB,a9
outb4
	sra	16,a3
	sra	16,a5

	move	*a6(plyr_jmpcnt),a14
	jrnz	chkoop			;In jump?
	move	*a2(OYVAL),a10,L	;Not an alley-oop. Restore YVAL
	jruc	nooff

chkoop
	clr	a1
	clr	a11
	clr	a12

	move	*a6(plyr_seq),a14
	cmpi	ALLEYOOP1_SEQ,a14	;M1SPDU1-20 frames
	jrne	nxtd1
	movi	-9,a1			;y pos additive
	movk	22,a11
	movi	-33,a12
	jruc	drevs
nxtd1
	cmpi	ALLEYOOP2_SEQ,a14	;W3FLDU1-13 frames
	jrne	nxtd2
	movi	-48,a1			;y pos additive
	movi	-18,a11
	movk	3,a12
	jruc	drevs
nxtd2
	cmpi	ALLEYOOP3_SEQ,a14	;W3CRZDU2-20 frames
	jrne	nxtd3
	movi	-1,a1			;y pos additive
	movi	-5,a11
	movk	5,a12
	jruc	drevs
nxtd3
	cmpi	ALLEYOOP4_SEQ,a14	;S3BKDU1-16
	jrne	nxtd4
	movi	-37,a1			;y pos additive
	movk	5,a11
	movi	-5,a12
	jruc	drevs
nxtd4
	cmpi	ALLEYOOP5_SEQ,a14	;M3SPRDU1-11 frames
	jrne	nxtd5
	movi	-50,a1			;y pos additive
	movk	10,a11
	movi	-20,a12
	jruc	drevs
nxtd5
	cmpi	ALLEYOOP6_SEQ,a14	;W3SPNDU1-21 frames
	jrne	nxtd6
	movi	-35,a1			;y pos additive
	movk	5,a11
	movi	-10,a12
	jruc	drevs
nxtd6
	cmpi	ALLEYOOP7_SEQ,a14	;W3SPNDU1-21 frames
	jrne	nxtd7
	movi	-50,a1			;y pos additive
	movi	-14,a11			;norm. X additive
	movk	5,a12			;flip X additive
	jruc	drevs
nxtd7
	cmpi	ALLEYOOP8_SEQ,a14	;only angle 1
	jrne	nxtd8
	movi	-60,a1			;y pos additive
	movk	30,a11
	movi	-30,a12
	jruc	drevs

nxtd8
	cmpi	ALLEYOOP9_SEQ,a14	;only angle 5 
	jrne	nxtd9
	movi	-33,a1			;y pos additive
	movk	25,a11			;x pos additive
	movi	-25,a12
	jruc	drevs
nxtd9
	cmpi	ALLEYOOP10_SEQ,a14	;only angle 1, <5 dnk rating
	jrne	nxtd10
	movi	-47,a1			;y pos additive
	movk	25,a11			;x pos additive
	movi	-25,a12
nxtd10
	cmpi	ALLEYOOP11_SEQ,a14	;only angle 2, <5 dnk rating
	jrne	nxtd11
	movi	-23,a1			;y pos additive
	movk	2,a11			;x pos additive
	movi	-2,a12
nxtd11
	cmpi	ALLEYOOP12_SEQ,a14	;only angle 3, <5 dnk rating
	jrne	nxtd12
	movi	-17,a1			;y pos additive
	movi	-15,a11			;x pos additive
	movi	15,a12
nxtd12
	cmpi	ALLEYOOP13_SEQ,a14	;only angle 4, <5 dnk rating
	jrne	nxtd13
	movi	-26,a1			;y pos additive
	movk	5,a11			;x pos additive
	movi	-5,a12
nxtd13
	cmpi	ALLEYOOP14_SEQ,a14	;only angle 5, <5 dnk rating
	jrne	drevs
	movi	-34,a1			;y pos additive
	movk	1,a11			;x pos additive
	movi	-1,a12
drevs
	sll	16,a1
	add	a1,a10
	move	*a6(plyr_anirevff),a1
	jrnz	nooff
	move	a12,a11

nooff
	move	*a0(OXPOS),a1
	move	*a0(OXANI+16),a14
	add	a14,a1
	sub	a1,a3			;X delta
	move	*a0(OZPOS),a1
	sub	a1,a5			;Y delta

	move	*a6(plyr_jmpcnt),a14
	jrz	nolead			;In jump?
	add	a11,a3

nolead
	sll	16,a3
	sll	16,a5
	divs	a4,a3
	divs	a4,a5

	move	a3,*a0(OXVEL),L
	move	a5,*a0(OZVEL),L

	move	*a0(OYVAL),a3,L		;get balls Y
;;	move	*a2(OYVAL),a14,L
;	move	a10,a14			;teammates Y val
	sub	a10,a3			;a3=delta Y

;	move	*a6(plyr_jmpcnt),a14
;	jrnz	fine			;In jump?
;	move	a10,a14
;fine
	sra	2,a10
	add	a10,a3

	move	a4,a5
	move	*a6(plyr_nojoy),a2
	jrn	nopoh			;Leading pass?

	subk	4,a5			;leading pass, get there a faster...
nopoh
	movi	-GRAVB/2,a1
	move	*a13(plyr_jmpcnt),a2
	jrnz	level			;In jump?

	move	*a6(plyr_jmpcnt),a2
	jrnz	level			;In jump? No bounce pass


;Don't allow bnc pass in close!
	move	*a13(plyr_tmdist),a14
	cmpi	130*DIST_REDUCTION,a14
	jrlt	level



	move	@PCNT,a14
	andi	0fh,a14
	jrnz	level

;Try a bounce pass
;Desperation pass?  If so, don't allow bounce pass
	move	*a8(OIMG),a14,L
	.ref	T4DESPA5
	cmpi	T4DESPA5,a14
	jrz	level

	move	*a13(plyr_seq),a14	;0CHhk for overhead pass
	cmpi	PASSNEWOH_SEQ,a14
	jrz	level
	cmpi	PASSNL_SEQ,a14
	jrz	level
	move	*a13(plyr_seqdir),a14
	cmpi	0,a14
	jrz	level
	cmpi	1,a14
	jrz	level
	cmpi	7,a14
	jrz	level

	move	*a0(OYVAL),a3,L		;Adjust for hgt difference
	movi	-GRAVB/2,a1
	srl	1,a4
level
	mpys	a4,a1
	divs	a4,a3
	sub	a3,a1
	move	a1,*a0(OYVEL),L

	move	*a13(plyr_num),a0
	move	a0,@ballpnumshot
	move	a0,@ballpnumlast
	move	a0,@ballsclastp

	movi	-1,a0
	move	a0,@ballpnum		;No owner
;	move	a0,@ballshotinair	;Shooter  if shot in air, else -1
	clr	a0
	move	a0,@ballscorezhit
;	move	a0,@ballbbhitcnt
	move	a0,@ballpasstime
	move	a0,*a13(plyr_ownball)
	move	a0,*a6(plyr_shtdly)	;Tell teammate he can catch ball!!
	movk	30,a0
	move	a0,*a13(plyr_shtdly)

	addk	5,a5
;	addk	32,a5
	move	a5,*a6(plyr_rcvpass)	;Tell teammate when to expect pass


	movi	pass_snd,a0,L
	move	*a6(plyr_seqflgs),a14		;is teammate in dunk ?
	btst	DUNK_B,a14
	jrz	rpas
	movi	aly_pass_snd,a0,L		;passing to alley-opper
rpas	move	@plyr_onfire,a14
	move	*a13(plyr_num),a5
	btst	a5,a14
	jrz	npas			;br=plyr not on fire
	movi	fpass_snd,a0,L
npas	calla	snd_play1



plyr_pass_x	PULL	a6,a9,a10,a11,a12
	rets


longpas_t
	.word	103,101,99,97,95,93
	.word	91,89,87,85,83
shortpas_t
	.word	127,124,121,118,115,112
	.word	109,106,103,100,97
turbopas_t
	.word	28,29,30,31,32,33
	.word	35,38,41,44,44


********************************
* Try a rebound if possible
* A8=*Plyr obj
* A13=*Plyr process
* Trashes scratch, A2-A5

RTIME	.equ	25

 SUBRP	plyr_tryrebound

	PUSH	a6,a7

	move	@plyrinautorbnd,a1
	jrnz	plyr_tryrebound_x			;Someone else doing?

	move	@game_time,a14,L
	cmpi	0500H,a14
	jrge	heave_b			;Do it
	
	move	*a13(plyr_num),a0
	move	@ballpnumshot,a1
	cmp	    a0,a1
	jrz	    plyr_tryrebound_x
	XORI	1,a1
	cmp	    a1,a0
	jrz	    plyr_tryrebound_x			;Br=teammate shot

heave_b
					;0CHhk my start
	move	*a8(OZPOS),a1		;Get SZ
	subi	CZMID,a1
	abs	a1
	cmpi	40,a1
	jrgt	posok
	move	*a8(OXPOS),a0		;Get SX
	move	*a8(OXANI+16),a14
	add	a14,a0
	subi	WRLDMID,a0
	abs	a0
	cmpi	HOOPRX-WRLDMID+13,a0
	jrge	plyr_tryrebound_x			;Under backboard?

	subk	12,a1
	jrgt	posok
	cmpi	HOOPRX-WRLDMID-8,a3
	jrge	plyr_tryrebound_x			;Under rim?


posok
	move	@ballobj_p,a5,L


	movk	RTIME,a0		;0FHind new Y pos in x ticks
	move	*a5(OYVAL),a4,L
	move	*a5(OYVEL),a2,L
	movi	GRAVB,a1
newblp
	add	a2,a4
	add	a1,a2
	dsj	a0,newblp

	sra	16,a4

	cmpi	-140,a4
	jrlt	plyr_tryrebound_x			;Too hi?

	addk	30,a4
	move	*a8(OYPOS),a0
	cmp	a0,a4
	jrge	plyr_tryrebound_x			;Ball lower than plyr?



	move	*a5(OXVAL),a6,L		;0FHind new XZ pos in x ticks
	move	*a5(OXANI),a14,L
	add	a14,a6
	move	*a5(OZVAL),a7,L

	move	a6,a0			;0CHhk ball pos
	move	a7,a1
	sra	16,a0
	sra	16,a1

	subi	CZMID,a1
	abs	a1
	subk	12,a1
	jrgt	bposok
	subi	WRLDMID,a0
	abs	a0
	cmpi	HOOPRX-WRLDMID-10,a3
	jrge	plyr_tryrebound_x			;Under rim or backboard?
bposok

	movk	RTIME,a0
	move	*a5(OXVEL),a1,L
	mpys	a0,a1
	add	a1,a6
	move	*a5(OZVEL),a1,L
	mpys	a0,a1
	add	a1,a7

	sra	16,a6
	sra	16,a7

	move	a6,a0			;0CHhk my destination
	move	a7,a1

	subi	CZMID,a1
	abs	a1
	cmpi	40,a1
	jrgt	eposok
	subi	WRLDMID,a0
	abs	a0
	cmpi	HOOPRX-WRLDMID+13,a0
	jrge	plyr_tryrebound_x			;Under backboard?
	subk	14,a1
	jrgt	eposok
	cmpi	HOOPRX-WRLDMID-10,a3
	jrge	plyr_tryrebound_x			;Under rim?
eposok

	move	*a13(plyr_num),a14
	sll	5,a14
	addi	player_data,a14,L
	move	*a14,a14,L
	move	*a14(PR_PRIVILEGES),a14
	jrle	eposok2       			;br=not a created player
	btst	5,a0				;SUPER AUTO-REBOUND privilege?
	jrz	eposok2			;br=no

	callr	seekdirdist_obxz128
	cmpi	70,a1				;close enough to jump?
	jrlt	eposok3			;br=yes
	jruc	plyr_tryrebound_x
eposok2
	callr	seekdirdist_obxz128
	cmpi	60,a1
	jrge	plyr_tryrebound_x			;Too far to jump?

eposok3
	move	a0,*a13(plyr_newdir)	;Turn where ball is headed

	movk	REBOUNDA_SEQ,a0
	move	a0,@plyrinautorbnd

	move	*a13(plyr_dir),a7
	callr	plyr_setseq


plyr_tryrebound_x	PULL	a6,a7
	rets


********************************
* Clear auto rebound flag - Called when SEQ_REBOUNDA lands

 SUBR	clr_autorbnd

	clr	a0
	move	a0,@plyrinautorbnd
	rets


********************************
* Set the ball xyz position from player
* A8=*Plyr obj
* A13=*Plyr process
* Trashes scratch

 SUBRP	plyr_setballxyz
;LOOK!!!
	move	@ballobj_p,a0,L

	move	*a8(OZPOS),a1		;>Set Z
	move	*a13(plyr_ballzo),a14
	add	a14,a1
	move	a1,*a0(OZPOS)

	move	*a8(OXVAL),a1,L		;>Set X
	move	a1,b0
	move	*a13(plyr_ballxo),a14,L
	add	a14,a1
	move	*a0(OIMG),a14,L
	move	*a14(IANIOFFX),a14
	sll	16,a14
	sub	a14,a1
	move	a1,*a0(OXVAL),L

	move	*a8(OXANI),a14,L	;Make 3D ball X+ani = plyr X+ani
	sub	a14,a1
	move	b0,a14
	sub	a1,a14
	move	a14,*a0(OXANI),L

	move	*a13(plyr_ballyo),a1
	cmpi	-200,a1
	jreq	bfree			;Ball Y free?

	move	*a0(OIMG),a14,L		;>Set Y
	move	*a14(IANIOFFY),a14
	sub	a14,a1
	move	*a8(OYPOS),a14
	add	a14,a1
	move	a1,*a0(OYPOS)
	clr	a1
	move	a1,*a0(OYVEL),L		;Stop grav from accumulating
	move	a1,*a0(OXVEL),L
	move	a1,*a0(OZVEL),L
	move	a1,@ballfree		;!Free

	rets

bfree
	move	@ballfree,a14
	jrnz	plyr_setballxyz_x			;Already free?
	movk	1,a14
	move	a14,@ballfree		;Free
	move	*a0(OYPOS),a1
	move	*a0(OIMG),a14,L
	move	*a14(IANIOFFY),a14
	add	a14,a1
	movi	-0a00H,a14		;Push it towards gnd
	mpys	a14,a1
	addi	016000H,a1
	move	a1,*a0(OYVEL),L
plyr_setballxyz_x	rets


********************************
* Get a scaled objects anipt XY
* A8=*Obj
* 0A0H=Scaled Ani X (16:16)
* 0A1H=Scaled Ani Y
* Trashes scratch

 SUBR	anipt_getsclxy

	move	a2,b0

	move	*a8(ODATA_p),a0,L
	move	*a8(OIMG),a2,L

	move	*a8(OZPOS),a14
	subi	GZBASE,a14
	jrge	zok1
	clr	a14
zok1	srl	4,a14			;/16
	sll	6,a14			;*64
	add	a14,a0
	addk	32,a0

	move	*a0+,a14
	sll	4,a14			;*16
	move	*a2(IANIOFFX),a1
	mpys	a14,a1

	move	*a0,a14
	sll	4,a14			;*16
	move	a1,a0
	move	*a2(IANIOFFY),a1
	mpys	a14,a1

	move	*a8(OCTRL),a14
	btst	B_FLIPH,a14
	jrz	    anipt_getsclxy_x			;No flip?

	move	*a2,a2			;ISIZEX
	subk	1,a2
	sll	16,a2			;*64K
	neg	a0
	add	a2,a0			;+size

anipt_getsclxy_x	move	b0,a2
	rets


********************************
* Get a scaled objects 2nd anipt XY
* A8=*Obj
* 0A0H=Scaled Ani2 X (16:16)
* 0A1H=Scaled Ani2 Y
* Trashes scratch

 SUBR	anipt2_getsclxy

	move	a2,b0

	move	*a8(ODATA_p),a0,L
	move	*a8(OIMG),a2,L

	move	*a8(OZPOS),a14
	subi	GZBASE,a14
	jrge	zok2
	clr	    a14
zok2	
    srl	    4,a14			;/16
	sll	    6,a14			;*64
	add	    a14,a0
	addk	32,a0

	move	*a0+,a14
	sll	    4,a14			;*16
	move	*a2(IANI2X),a1
	mpys	a14,a1

	move	*a0,a14
	sll	    4,a14			;*16
	move	a1,a0
	move	*a2(IANI2Y),a1
	cmpi	-200,a1			;stupid K!!! alert!!!
	jrne	ynorm
	sll	    16,a1
	jruc	cflip
ynorm	
    mpys	a14,a1

cflip	
    move	*a8(OCTRL),a14
	btst	B_FLIPH,a14
	jrz	    anipt2_getsclxy_x			;No flip?

	move	*a2,a2			;ISIZEX
	subk	1,a2
	sll	    16,a2			;*64K
	neg	    a0
	add	    a2,a0			;+size

anipt2_getsclxy_x	
    move	b0,a2
	rets


********************************
* Get a scaled objects 3rd anipt XY
* A8=*Obj
* 0A0H=Scaled Ani3 X (16:16)
* 0A1H=Scaled Ani3 Y
* Trashes scratch

 SUBR	anipt3_getsclxy

	move	a2,b0

	move	*a8(ODATA_p),a0,L
	move	*a8(OIMG),a2,L

	move	*a8(OZPOS),a14
	subi	GZBASE,a14
	jrge	zok3
	clr	a14
zok3	srl	4,a14			;/16
	sll	6,a14			;*64
	addk	32,a0
	add	a14,a0

	move	*a0+,a14
	sll	4,a14			;*16
	move	*a2(IANI3X),a1
	mpys	a14,a1

	move	*a0,a14
	sll	4,a14			;*16
	move	a1,a0
	move	*a2(IANI3Y),a1
	mpys	a14,a1

	move	*a8(OCTRL),a14
	btst	B_FLIPH,a14
	jrz	    anipt3_getsclxy_x			;No flip?

	move	*a2,a2			;ISIZEX
	subk	1,a2
	sll	16,a2			;*64K
	neg	a0
	add	a2,a0			;+size

anipt3_getsclxy_x	
    move	b0,a2
	rets


********************************
* Align shadow obj with player obj and set ani
* A8=*Obj
* A13=*Plyr process
* Trashes scratch, A2-A4

 SUBRP	plyr_setshadow

	move	*a13(plyr_shadobj_p),a4,L

	move	*a8(OZPOS),a0
	move	a0,a1
	subi	50,a1			;Adjust
	move	a1,*a4(OZPOS)

	subi	CZMIN,a0		;-Base
	jrge	zok4
	clr	a0
zok4	srl	5,a0			;/32
	move	*a8(OYPOS),a1
	move	*a13(plyr_aniy),a14
	add	a14,a1			;Ani pt position
	sra	4,a1			;/16 (Neg)
	add	a1,a0

	addk	(ani_t-sani_t)/32,a0
	jrnn	pss_0
	clr	a0
pss_0
	movk	(bani_t-sani_t)/32-1,a14
	cmp	a0,a14
	jrge	pss_1
	move	a14,a0
pss_1
	move	@pup_baby,a14		;Plyr babies? No if 0
	jrz	pss_2
	addk	(bani_t-sani_t)/32,a0
pss_2
	sll	5,a0			;*32
	addi	sani_t,a0

	move	*a0,a2,L
	move	a2,*a4(OIMG),L		;Set new img
	move	*a2,a14,L
	move	a14,*a4(OSIZE),L
	move	*a2(ISAG),*a4(OSAG),L

	callr	anipt_getsclxy

	move	*a2(IANIOFFX),a3
	sll	16,a3
	move	a3,*a4(OXANI),L

	move	*a8(OXVAL),a14,L
	add	a0,a14			;Ani X
	sub	a3,a14
	move	a14,*a4(OXVAL),L

	move	*a2(IANIOFFY),a3
	neg	a3
	move	a3,*a4(OYPOS)

	rets


sani_t
	.long	shadow15,shadow15,shadow15,shadow15
	.long	shadow15,shadow15,shadow15,shadow15
	.long	shadow15,shadow14,shadow13,shadow12
ani_t	.long	shadow11,shadow10,shadow9,shadow8
	.long	shadow7,shadow6,shadow5,shadow4
	.long	shadow3,shadow2,shadow1,shadow1
	.long	shadow1,shadow1,shadow1

bani_t
	.long	ballshad7,ballshad7,ballshad7,ballshad7
	.long	ballshad7,ballshad7,ballshad7,ballshad7
	.long	ballshad7,ballshad5,ballshad4,ballshad2
	.long	shadow18,shadow18,shadow17,shadow17
	.long	shadow16,shadow16,shadow15,shadow15
	.long	shadow14,shadow14,shadow13,shadow13
	.long	shadow12,shadow12,shadow11


********************************
* Align head obj with player obj
* A8=*Obj
* A13=*Plyr process
* Trashes scratch, A2-A6

 SUBR	plyr_headalign

	move	*a13(plyr_headobj_p),a6,L ;0A6H=*Head obj

 SUBR	plyr_headalign2

	move	*a8(OIMG),a0,L		;>Set Z
	move	*a8(OZPOS),a14
	move	*a0(IANI3Z),a1
	add	a1,a14
	move	a14,*a6(OZPOS)
	sub	a1,a14
	neg	a1
	move	a1,*a6(OMISC)		;Z offset

					;0CaHlc head scale anixy (A3,A5)
	subi	GZBASE,a14		;-Base
	jrge	zok5
	clr	a14
zok5	srl	4,a14			;/16
	sll	6,a14			;*64
	move	*a6(ODATA_p),a0,L
	addk	32,a0
	add	a14,a0

	move	*a0+,a14
	sll	4,a14			;*16
	move	*a6(OIMG),a2,L

	move	*a2(IANIOFFX),a3
	mpys	a14,a3

	move	*a0,a14
	sll	4,a14			;*16

	move	*a2(IANIOFFY),a5
	mpys	a14,a5

	move	*a6(OCTRL),a14
	btst	B_FLIPH,a14
	jrz	nohf2			;No flip?

	move	*a2,a2			;ISIZEX
	subk	1,a2
	sll	16,a2			;*64K
	neg	a3
	add	a2,a3			;+size
nohf2

	callr	anipt3_getsclxy

	move	*a8(OYVAL),a14,L
	add	a1,a14			;Ani3 Y
	sub	a5,a14
	move	a14,*a6(OYVAL),L

	move	*a8(OXVAL),a14,L
	move	a14,a1
	add	a0,a14			;Ani3 X
	sub	a3,a14
	move	a14,*a6(OXVAL),L

	move	*a8(OXANI),a0,L		;Make head X+ani = plyr X+ani
	add	a0,a1
	sub	a14,a1
	move	a1,*a6(OXANI),L

	rets

;********************************
;* Align arw obj with player obj
;* A8=*Obj
;* a6=Arw Obj
;* Trashes scratch, A2-A6
;
; SUBR	plyr_arwalign
;
;
;	move	*a8(OIMG),a0,L		;>Set Z
;	move	*a8(OZPOS),a14
;	move	*a0(IANI3Z),a1
;	add	a1,a14
;	move	a14,*a6(OZPOS)
;	sub	a1,a14
;	neg	a1
;	move	a1,*a6(OMISC)		;Z offset
;
;					;0CaHlc head scale anixy (A3,A5)
;	subi	GZBASE,a14		;-Base
;	jrge	zok6
;	clr	a14
;zok6	srl	4,a14			;/16
;	sll	6,a14			;*64
;	move	*a6(ODATA_p),a0,L
;	addk	32,a0
;	add	a14,a0
;
;	move	*a0+,a14
;	sll	4,a14			;*16
;	move	*a6(OIMG),a2,L
;
;	move	*a2(IANIOFFX),a3
;	mpys	a14,a3
;
;	move	*a0,a14
;	sll	4,a14			;*16
;
;	move	*a2(IANIOFFY),a5
;	mpys	a14,a5
;
;;	move	*a6(OCTRL),a14
;;	btst	B_FLIPH,a14
;;	jrz	nohf			;No flip?
;;
;;	move	*a2,a2			;ISIZEX
;;	subk	1,a2
;;	sll	16,a2			;*64K
;;	neg	a3
;;	add	a2,a3			;+size
;;nohf
;
;	callr	anipt3_getsclxy
;
;	move	*a8(OYVAL),a14,L
;	add	a1,a14			;Ani3 Y
;	sub	a5,a14
;	move	a14,*a6(OYVAL),L
;
;	move	*a8(OXVAL),a14,L
;	move	a14,a1
;	add	a0,a14			;Ani3 X
;	sub	a3,a14
;	move	a14,*a6(OXVAL),L
;
;
;	move	*a8(OXANI),a0,L		;Make head X+ani = plyr X+ani
;	add	a0,a1
;	sub	a14,a1
;	move	a1,*a6(OXANI),L
;
;
;	rets
;




********************************
* Referee tosses up ball (process)

 SUBRP	plyr_referee


	.asg	12,REFCTR_OX		;Ref Xoff so toss to be centered

;Show player 0 pal to verify pal build
;	.ref	show_plyr_pal
;	CREATE0	show_plyr_pal

	clr	a0
	move	a0,@ditch_meter

	.if	DEBUG
	move	@QUICK_TIP,a0
	jrnz	skipq3
	.endif

	clr	a9
	movk	1,a11
	CREATE	METER_PID,jumpball_meter
	movk	1,a9
	movk	2,a11
	CREATE	METER_PID,jumpball_meter
	.ref	jumpball_meter
	.if	DEBUG
skipq3
	.endif

	movk	1,a0
	callr	plyr_setac

	movi	[WRLDMID+REFCTR_OX,0],a0
	clr	a1
	movi	shadow7,a2
	movi	CZMID-30-1,a3
	movi	DMAWNZ|M_3D|M_SHAD|M_NOCOLL,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7
	calla	BEGINOBJ2
;	movi	50,a0
;	move	a0,*a8(OMISC)		;Z offset
	move	a8,a11			;A11=ref shadow *obj

	movi	[WRLDMID+REFCTR_OX,0],a0
	clr	a1
	movi	REFWHS1,a2
	movi	CZMID-30,a3
	movi	DMAWNZ|M_3D|M_NOCOLL,a4
	calla	BEGINOBJ2

	movi	att_t,a0,L
	move	a0,*a13(plyr_attrib_p),L
	move	*a0,a0,L
	move	a0,*a8(ODATA_p),L

	SLEEPK	5

	movk	1,a0
	move	a0,*a13(plyr_ownball)		;!0=Ref has ball

;	clr	a0
	movk	25,a0
	move	a0,*a13(plyr_ballzo)

	movi	ani_l,a9
	.if	DEBUG
	move	@QUICK_TIP,a14
	jrz	skipq2
	movi	ani_l_quick_tip,a9
skipq2
	.endif
	movk	1,a10
ani_lp
	dsj	a10,noani2

getwt	move	*a9+,a10
	jrz	refdone
	jrnn	nocode
	
	move	*a9+,a0,L			;Call function
	call	a0
	jruc	getwt
nocode
	move	*a9+,a0,L
	movk	M_WRNONZ,a1
	callr	plyr_ani

	callr	anipt2_getsclxy
	move	a0,*a13(plyr_ballxo),L
	sra	16,a1
	move	a1,*a13(plyr_ballyo)

	move	*a13(plyr_aniy),a1
	neg	a1
	move	a1,*a8(OYPOS)			;Set on gnd

noani2
	move	*a13(plyr_ownball),a0
	jrz	noball				;Tossed up?

	callr	plyr_setballxyz
noball
	callr	joy_read2			;Scan buttons since ac is on

	clr	a0
	move	a0,@P1CTRL
	move	a0,@P4CTRL

	movi	P1CTRL,a1			;>Kill unwanted bits
	movk	4,b0
jlp	move	*a1,a0
	andi	BUT1_M<<8+BUT1_M,a0
	move	a0,*a1+
	dsj	b0,jlp

	SLEEPK	1
	move	@HALT,a0
	jrnz	noball
	jruc	ani_lp

refdone
	SLEEPK	5
	calla	SCRTST
	jrz	refdone			;Still on screen?
	move	a11,a0
	calla	DELOBJ
	jauc	DELOBJDIE


att_t	.long	scale66_t,REF_P

	.if	DEBUG
ani_l_quick_tip
; Quick jump ball for debugging
	WL	-1,tossball
	WL	-1,step_back
	WL	-1,ac_off
	W0
	.endif

ani_l

	WL	TSEC,REFWHS1
	WL	4,REFWHS2
	WL	4,REFWHS3
	WL	4,REFWHS4
	WL	4,REFWHS5
	WL	4,REFWHS6
	WL	4,REFWHS7
	WL	4,REFWHS8
	WL	-1,do_whstle
	WL	15,REFWHS9
	WL	4,REFWHS8
	WL	4,REFWHS7
	WL	4,REFWHS6
	WL	4,REFWHS5
	WL	4,REFWHS4
	WL	4,REFWHS3
	WL	4,REFWHS2
	WL	4,REFWHS1

	WL	3,REFTOS1
	WL	3,REFTOS2
	WL	3,REFTOS3
	WL	3,REFTOS4
	WL	3,REFTOS5
	WL	3,REFTOS6
	WL	3,REFTOS7
	WL	3,REFTOS8
	WL	3,REFTOS9
	WL	3,REFTOS10
	WL	3,REFTOS11
	WL	3,REFTOS12
	WL	3,REFTOS13

	WL	-1,tossball	;109 TICKS


	WL	3,REFTOS14
	WL	4,REFTOS15
	WL	-1,start_jumps
	WL	3,REFTOS16
	WL	3,REFTOS17
	WL	3,REFTOS18
	WL	3,REFTOS19
	WL	-1,step_back


	WL	3,REFRUN1
	WL	3,REFRUN2
	WL	3,REFRUN3
	WL	3,REFRUN4
	WL	3,REFRUN5
	WL	3,REFRUN6
	WL	3,REFRUN7
	WL	3,REFRUN8
	WL	3,REFRUN9
	WL	3,REFRUN10
	WL	3,REFRUN11
	WL	3,REFRUN1
	WL	3,REFRUN2
	WL	3,REFRUN3
	WL	3,REFRUN4
	WL	3,REFRUN5
	WL	3,REFRUN6
	WL	3,REFRUN7
	WL	3,REFRUN8
	WL	3,REFRUN9
	WL	3,REFRUN10
	WL	3,REFRUN11
	WL	-1,ac_off	;85 AFTER TOSS
	WL	-1,tip_off_spch
	WL	3,REFRUN1
	WL	3,REFRUN1
	WL	3,REFRUN2
	WL	3,REFRUN3
	WL	3,REFRUN4
	WL	3,REFRUN5
	WL	3,REFRUN6
	WL	3,REFRUN7
	WL	3,REFRUN8
	WL	3,REFRUN9
	WL	3,REFRUN10
	WL	3,REFRUN11
	WL	3,REFRUN1
	WL	3,REFRUN2
	WL	3,REFRUN3
	WL	3,REFRUN4
	WL	3,REFRUN5
	WL	2,REFRUN6
	WL	-1,stop_back
	WL	4,REFSTN1
	WL	4,REFSTN2
	WL	4,REFSTN4
;REFROT1
	W0

tip_off_spch
	.ref	tip_off_speech
	CREATE0	tip_off_speech
	rets

do_whstle
	movi	whitsle_snd,a0
	jauc	snd_play1


tossball
	move	@ballobj_p,a1,L
	movi	0fffa4800H,a0
	clr	a2

	.if	DEBUG
; Quick jump ball for debugging
	move	@QUICK_TIP,a14
	jrz	normqa
	movi	-GRAVB,a0
	movk	3,a2
normqa
	.endif

	move	a0,*a1(OYVEL),L
	clr	a0
	move	a0,@clock_active		;Turn on clock

	move	a2,*a13(plyr_ownball)		;Let go
	rets


step_back
	movi	-11800h,a0			;-14000h
	move	a0,*a8(OZVEL),L
	move	a0,*a11(OZVEL),L

	rets

start_jumps

	move	a11,a2

	move	@plyrproc_t+32,a11,L
	CREATE	TIPID,plyr_tip

	move	@plyrproc_t+32*2,a11,L
	CREATE	TIPID,plyr_tip

  
	move	a2,a11

	rets

ac_off
	clr	a0
	jruc	plyr_setac


stop_back
	clr	a0
	move	a0,*a8(OZVEL),L
	move	a0,*a11(OZVEL),L
	rets


********************************
* Jump at ball for tip (Process)
* A11=*Plyr process

	.bss	t1bcnt	,16	;Team1 (p1)  button hits
	.bss	t2bcnt	,16	;Team2 (p2) ^

 SUBRP	plyr_tip

	move	*a11(PA8),a8,L

	PUSH	a13
	move	a11,a13

	movi	TIPJ_SEQ,a0
	move	*a13(plyr_dir),a7
	callr	plyr_setseq
	move	a10,*a13(PA10),L

	PULL	a13



	.if	DEBUG
; Quick jump ball for debugging
	move	@QUICK_TIP,a14
	jrz	normq
	SLEEPK	6
	clr	a0
	jruc	conte
normq
	.endif

	SLEEPK	15
	movi	-GRAVB*30-4000h,a0
conte
	move	a0,*a8(OYVEL),L


	movi	8800h,a0
	move	*a8(OCTRL),a14
	btst	B_FLIPH,a14
	jrz	    normnf			;No flip?
	neg	    a0
normnf
	move	a0,*a8(OXVEL),L


	movk	1,a0			;Start jump
	move	a0,*a11(plyr_jmpcnt)

	movi	t1bcnt,a9		;0CHount button1 down presses
	move	*a11(plyr_num),a1
	btst	1,a1
	jrz	    t1c
	addk	16,a9
t1c	
    clr	a0
	move	@PSTATUS2,a14
	btst	a1,a14
	jrnz	human2			;Human opponent?
	movk	3,a0			;Drones  presses
human2
   	move	a0,*a9

	.if	DEBUG
;Quick jump ball for debugging
	move	@QUICK_TIP,a14
	jrnz	skipq4
	.endif
	SLEEPK	25
skipq4

	move	@plyrobj_t+32,a0,L
;	move	*a0(OXVEL),a14,L
;	sra	2,a14
;	neg	a14
	movi	-2800h,a14
	move	a14,*a0(OXVEL),L



	move	@plyrobj_t+64,a0,L
;	move	*a0(OXVEL),a14,L
;	sra	2,a14
;	neg	a14

	movi	2800h,a14
	move	a14,*a0(OXVEL),L

;	movk	1,a10			;temp!!!
;	movk	25,a10
;lp
;	move	*a11(PA11),a0,L
;	move	*a0,a0
;	btst	BUT1_B+8,a0
;	jrz	    noprs			;No down transition?
;	move	*a9,a0			;+1 cnt
;	addk	1,a0
;	move	a0,*a9
;noprs
;	SLEEPK	1
;	dsj	a10,lp

	move	*a11(plyr_num),a5

	move	@plyrproc_t+32,a0,L
	move	*a0(plyr_meter_time),a0
	move	@plyrproc_t+64,a1,L
	move	*a1(plyr_meter_time),a1
;	move	a0,a14
;	add	a1,a14
;	jrnz	gotone
;	inc	a0
;gotone

;	movi	t1bcnt,a2
;	move	*a2+,a0
;	move	*a2+,a1

	btst	1,a5
	jrnz	tm1xx
	SWAP	a0,a1
tm1xx
	.if	DEBUG
	move	@QUICK_TIP,a14
	jrnz	contq
	.endif
	cmp	a1,a0
	jrlt	plyr_tip_x			;Less presses than opponent?
	jrne	contq
	.ref	meter_maxxed
	move	@meter_maxxed,a0
	jrnz	shitpile
	move	@HCOUNT,a0
	andi	1,a0
	addk	1,a0
	move	a0,@meter_maxxed
shitpile
	cmp	a0,a5
	jrne	plyr_tip_x
contq
	movi	0fffea000H,a0
	movi	0ffff1000H,a1
  	movi	-9,a3
	btst	1,a5
	jrz	tm1a

	neg	a0
	neg	a1
	neg	a3
tm1a
	move	@ballobj_p,a2,L

	move	*a2(OXPOS),a4
	add	a3,a4
	move	a4,*a2(OXPOS)
	move	a0,*a2(OXVEL),L
	move	a1,*a2(OZVEL),L

	movi	-GRAVB*10,a0
	move	a0,*a2(OYVEL),L

	movi	TIPID,a0
	calla	KIL1C
	
	movk	1,a0
	.ref	ditch_meter
	move	a0,@ditch_meter

plyr_tip_x

;call ball slap sound
	SOUND1	swat_snd

	DIE


********************************
* End of quarter (JSRP by score)

 SUBR	plyr_endofqrtr

	movi	1000,a0
	move	a0,@cntrs_delay		;Delay credit timers

;DJT Start
	.ref	firstbskt,t1ispro,t2ispro
	move	@gmqrtr,a0		;Next quarter
	addk	1,a0
	subk	7,a0
	jrn	qcap
	clr	a0
qcap
	addk	7,a0
;DJT End
	move	a0,@gmqrtr
	subk	1,a0
	jrne	not1st

	movi	AUD_1STQUARTR,a0	;01Hst guarter
	calla	AUD1

	JSRP	plyr_endqfinishshot

	clr	a0
	move	a0,@kp_qscrs,L
	move	a0,@kp_qscrs+32,L
	move	a0,@kp_qscrs+64,L
	move	a0,@kp_qscrs+96,L
	move	a0,@kp_qscrs+128,L	;overtime 1
	move	a0,@kp_qscrs+160,L	;overtime 2
	move	a0,@kp_qscrs+192,L	;overtime 3
	move	@scores,a0
	move	a0,@kp_qscrs
	move	@scores+16,a0
	move	a0,@kp_qscrs+16

	.ref	tuneq1_snd
	.ref	tuneq1ed_snd
	.ref	crwdbed_kill
	move	@pup_nomusic,a14
	jrz	play1
	SOUND1	tuneq1_snd
play1
	SOUND1	tuneq1ed_snd
	SOUND1	crwdbed_kill

	JSRP	hint_page
	jruc	tob

delay_spch
	SLEEP	90
	.ref	at_hlftme_sp
	SOUND1	at_hlftme_sp
	DIE

not1st
	subk	1,a0
	jrne	nothalf

	movi	AUD_HALFTIME,a0		;02Hnd quarter
	calla	AUD1

	JSRP	plyr_endqfinishshot

	move	@scores,a0
	move	@kp_qscrs,a14
	sub	a14,a0
	move	a0,@kp_qscrs+32
	move	@scores+16,a0
	move	@kp_qscrs+16,a14
	sub	a14,a0
	move	a0,@kp_qscrs+48

	CREATE0	delay_spch
;	.ref	at_hlftme_sp
;	SOUND1	at_hlftme_sp

	.ref	tuneq2_snd
	.ref	tuneq2ed_snd
	move	@pup_nomusic,a14
	jrz	play2
	SOUND1	tuneq2_snd
play2
	SOUND1	tuneq2ed_snd
	SOUND1	crwdbed_kill
	JSRP	halftime_showclips

; SUBR	plyr_eoq_lockcont		;Continuation point after clip lockup

	clr	a0
	JSRP	stats_page2

	movi	t1dunkcnt,a2		;>Setup most dunking team for board shatter
	move	*a2,a1
	cmpi	3,a1
	jrlt	nobrk			;!Enough dunks?
	subk	2,a1
	neg	a1
	move	a1,*a2			;New cnt
nobrk
	movi	t1dunkcnt+16,a2		;>Setup most dunking team for board shatter
	move	*a2,a1
	cmpi	3,a1
	jrlt	nobrk2			;!Enough dunks?
	subk	2,a1
	neg	a1
	move	a1,*a2			;New cnt
nobrk2

;LOOK!!! What's THIS?!?
;Restart players here?

	move	@plyrproc_t,a8,L
	move	*a8(plyr_headobj_p),a0,L
	calla	DELOBJ
	move	*a8(plyr_shadobj_p),a0,L
	calla	DELOBJ
	move	a8,a0
	calla	KILL

	move	@plyrproc_t+32,a8,L
	move	*a8(plyr_headobj_p),a0,L
	calla	DELOBJ
	move	*a8(plyr_shadobj_p),a0,L
	calla	DELOBJ
	move	a8,a0
	calla	KILL

	move	@plyrproc_t+64,a8,L
	move	*a8(plyr_headobj_p),a0,L
	calla	DELOBJ
	move	*a8(plyr_shadobj_p),a0,L
	calla	DELOBJ
	move	a8,a0
	calla	KILL

	move	@plyrproc_t+96,a8,L
	move	*a8(plyr_headobj_p),a0,L
	calla	DELOBJ
	move	*a8(plyr_shadobj_p),a0,L
	calla	DELOBJ
	move	a8,a0
	calla	KILL


	.if DRONES_2MORE
	move	@plyrproc_t+128,a8,L
	move	*a8(plyr_headobj_p),a0,L
	calla	DELOBJ
	move	*a8(plyr_shadobj_p),a0,L
	calla	DELOBJ
	move	a8,a0
	calla	KILL
	move	@plyrproc_t+160,a8,L
	move	*a8(plyr_headobj_p),a0,L
	calla	DELOBJ
	move	*a8(plyr_shadobj_p),a0,L
	calla	DELOBJ
	move	a8,a0
	calla	KILL
	.endif


	move	@plyrobj_t,a0,L
	calla	DELOBJ
	move	@plyrobj_t+32,a0,L
	calla	DELOBJ
	move	@plyrobj_t+64,a0,L
	calla	DELOBJ
	move	@plyrobj_t+96,a0,L
	calla	DELOBJ


	.if DRONES_2MORE
	move	@plyrobj_t+128,a0,L
	calla	DELOBJ
	move	@plyrobj_t+160,a0,L
	calla	DELOBJ
	.endif


	movi	P1_PID,a0
	calla	KIL1C
	movi	P2_PID,a0
	calla	KIL1C
	movi	P3_PID,a0
	calla	KIL1C
	movi	P4_PID,a0
	calla	KIL1C


	.if DRONES_2MORE
	movi	P5_PID,a0
	calla	KIL1C
	movi	P6_PID,a0
	calla	KIL1C
	.endif


	movi	P1_PID,a0
	calla	obj_del1c
	movi	P2_PID,a0
	calla	obj_del1c
	movi	P3_PID,a0
	calla	obj_del1c
	movi	P4_PID,a0
	calla	obj_del1c


	.if DRONES_2MORE
	movi	P5_PID,a0
	calla	obj_del1c
	movi	P6_PID,a0
	calla	obj_del1c
	.endif

	CREATE0	doplyrs

	calla	pal_clean

	clr	a0
	move	a0,@plyr_main_initdone
	move	a0,@DISPLAYON

 
;LOOK!!!
	movi	ARWPID,a0
	calla	KIL1C
	movi	arwid,a0
	calla	obj_del1c
	movi	ARWPID,a0
	calla	obj_del1c

	CREATE0	delay_arws

; 	movk	1,a0
;	move	a0,@HALT

;	movi	01e0c3100H,a0
;	move	a0,@WORLDTLX,L
;	clr	a0
;	move	a0,@WORLDTLY,L
;	move	@ballobj_p,a0,L
;	movi	01e7d6cafH,a1
;	move	a1,*a0(OXVAL),L
;	movi	0ffc265dfH,a1
;	move	a1,*a0(OYVAL),L
;	movi	00476c52dH,a1
;	move	a1,*a0(OZVAL),L
;	movi	02500H,a1
;	move	a1,*a0(OZVEL),L
;	clr	a1
;	move	a1,*a0(OXVEL),L
;	move	a1,*a0(OYVEL),L

; 	clr	a0
;	move	a0,@HALT
plyrwt
	SLEEPK	1
	move	@plyr_main_initdone,a0	;Wait for plyrs to init
	jrz	plyrwt

	SLEEPK	1

	PUSH	a8,a13

	move	@plyrproc_t,a13,L
	move	@plyrobj_t,a8,L
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
	jrz	nohflip1
	move	*a3(OCTRL+4),a14		;Reverse hflip
	addk	1,a14
	move	a14,*a3(OCTRL+4)
nohflip1
	setf	16,1,0

	move	@plyrproc_t+32,a13,L
	move	@plyrobj_t+32,a8,L
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
	jrz	nohflip2
	move	*a3(OCTRL+4),a14		;Reverse hflip
	addk	1,a14
	move	a14,*a3(OCTRL+4)
nohflip2
	setf	16,1,0

	PULL	a8,a13

	movk	1,a0
	move	a0,@DISPLAYON
; 	movk	1,a0
;	move	a0,@HALT
	jruc	tob

;--------------------

delay_arws
	SLEEPK	10			;Give players a chance to start

 	.ref	start_arws
	calla	start_arws

;	SLEEP	1*60
	SLEEPK	8

 	clr	a0
	move	a0,@HALT

	DIE

;--------------------

doplyrs
;	move	@pup_bighead,a0
;	zext	a0
;	cmpi	0eaeaH,a0
;	jrnz	no_3d
;	movk	0fH,a2
;	move	a2,@pup_maxsteal
;	jruc	adjoff
;no_3d
;	clr	a2
;	movk	ADJHEADSZ,a0		;Get head size
;	calla	GET_ADJ			;1-2
;	subk	1,a0
;	jrle	adjoff			;No big heads?
;	movk	0fH,a2
;adjoff
;	move	a2,@pup_bighead

	movi	plyrproc_t+32*NUMPLYRS,a2
	movi	plyrobj_t+32*(NUMPLYRS-1),a9
	movk	NUMPLYRS-1,a8
strtp2
	CREATE0	plyr_main
	move	a0,-*a2,L		;Save *proc
	subk	32,a9
	dsj	a8,strtp2

	move	a13,-*a2,L
	jruc	plyr_main		;0
	
;--------------------

nothalf
	subk	1,a0
	jrne	not3rd

	movi	AUD_3RDQUARTR,a0	;03Hrd quarter
	calla	AUD1

	JSRP	plyr_endqfinishshot

	move	@scores,a0
	move	@kp_qscrs,a14
	move	@kp_qscrs+32,a1
	add	a1,a14
	sub	a14,a0
	move	a0,@kp_qscrs+64
	move	@scores+16,a0
	move	@kp_qscrs+16,a14
	move	@kp_qscrs+48,a1
	add	a1,a14
	sub	a14,a0
	move	a0,@kp_qscrs+80

	.ref	tuneq3_snd
	.ref	tuneq3ed_snd
	move	@pup_nomusic,a14
	jrz	play3
	SOUND1	tuneq3_snd
play3
	SOUND1	tuneq3ed_snd
	SOUND1	crwdbed_kill

	JSRP	hint_page
	jruc	tob


not3rd

;2/9/93
;	clr	a0
;	move	a0,@gmqrtr
;	jruc	mark

	subk	1,a0
	jrne	not4th

	movi	AUD_4THQUARTR,a0	;04Hth quarter
	calla	AUD1

	JSRP	plyr_endqfinishshot

	move	@scores,a0
	move	@kp_qscrs,a14
	move	@kp_qscrs+32,a1
	move	@kp_qscrs+64,a2
	add	a1,a14
	add	a2,a14
	sub	a14,a0
	move	a0,@kp_qscrs+96
	move	@scores+16,a0
	move	@kp_qscrs+16,a14
	move	@kp_qscrs+48,a1
	move	@kp_qscrs+80,a2
	add	a1,a14
	add	a2,a14
	sub	a14,a0
	move	a0,@kp_qscrs+112

	.ref	tuneq4_snd
	move	@pup_nomusic,a14
	jrz	play4
	SOUND1	tuneq4_snd
play4
 	move	@scores,a0
	move	@scores+16,a1
	cmp	a0,a1
	jreq	tie

endofg	callr	endgame_audits		;0EHnd of game

	.ref	tune_wingame
	SOUND1	tune_wingame
	SOUND1	crwdbed_kill

	SLEEP	TSEC*2

	.ref	victory_speech
	calla	victory_speech

	SLEEP	TSEC*2+30

;	JSRP	result_screen

;The TRIVIA GAME is called within 'stats_page'
	movk	1,a0
	JSRP	stats_page

	clr	a0
	move	a0,@IRQSKYE

	calla	display_blank
	calla	save_player_records
	.ref	update_team_stats_records
	calla	update_team_stats_records
	.ref	update_world_records
	calla	update_world_records
	calla	display_unblank

	JSRP	rank_screen

	JSRP	grand_champs_screen	;if a champ is found then
;	move	a10,a10			;print the hiscore screen next
;	jrz	no_champ

;	JSRP	show_hiscore

;no_champ

	clr	a0

	move	a0,@qtr_purchased,L	;clr 4x16
	move	a0,@qtr_purchased+20h,L

	move	@team1,a0
	move	a0,@kp_team1
	move	@team2,a0
	move	a0,@kp_team2
	move	@scores,a0,L
	move	a0,@kp_scores,L

	move	@kp_qscrs,a0,L
	move	a0,@kp_qscrs2,L
	move	@kp_qscrs+32,a0,L
	move	a0,@kp_qscrs2+32,L
	move	@kp_qscrs+64,a0,L
	move	a0,@kp_qscrs2+64,L
	move	@kp_qscrs+96,a0,L
	move	a0,@kp_qscrs2+96,L
	move	@kp_qscrs+128,a0,L
	move	a0,@kp_qscrs2+128,L
	move	@kp_qscrs+160,a0,L
	move	a0,@kp_qscrs2+160,L
	move	@kp_qscrs+192,a0,L
	move	a0,@kp_qscrs2+192,L

	JSRP	winner_stays_on

;	move	@PSTATUS2,a0
;	jrz	x
;	jruc	game_start2
;x
	jauc	game_over


not4th
	JSRP	plyr_endqfinishshot	;>Overtime

	move	@gmqrtr,a0
	subk	5,a0			;which overtime ?
	jrne	notot1			;br=not 1st

	move	@scores,a0
	move	@kp_qscrs,a14
	move	@kp_qscrs+32,a1
	move	@kp_qscrs+64,a2
	add	a1,a14
	add	a2,a14
	move	@kp_qscrs+96,a1
	add	a1,a14
	sub	a14,a0
	move	a0,@kp_qscrs+128
	move	@scores+16,a0
	move	@kp_qscrs+16,a14
	move	@kp_qscrs+48,a1
	move	@kp_qscrs+80,a2
	add	a1,a14
	add	a2,a14
	move	@kp_qscrs+112,a1
	add	a1,a14
	sub	a14,a0
	move	a0,@kp_qscrs+144
	jruc	otdne
notot1
	subk	1,a0
	jrne	notot2

	move	@scores,a0
	move	@kp_qscrs,a14
	move	@kp_qscrs+32,a1
	move	@kp_qscrs+64,a2
	add	a1,a14
	add	a2,a14
	move	@kp_qscrs+96,a1
	add	a1,a14
	move	@kp_qscrs+128,a1
	add	a1,a14
	sub	a14,a0
	move	a0,@kp_qscrs+160
	move	@scores+16,a0
	move	@kp_qscrs+16,a14
	move	@kp_qscrs+48,a1
	move	@kp_qscrs+80,a2
	add	a1,a14
	add	a2,a14
	move	@kp_qscrs+112,a1
	add	a1,a14
	move	@kp_qscrs+144,a1
	add	a1,a14
	sub	a14,a0
	move	a0,@kp_qscrs+176
	jruc	otdne
notot2
	subk	1,a0
	jrne	otdne

	move	@scores,a0
	move	@kp_qscrs,a14
	move	@kp_qscrs+32,a1
	move	@kp_qscrs+64,a2
	add	a1,a14
	add	a2,a14
	move	@kp_qscrs+96,a1
	add	a1,a14
	move	@kp_qscrs+128,a1
	add	a1,a14
	move	@kp_qscrs+160,a1
	add	a1,a14
	sub	a14,a0
	move	a0,@kp_qscrs+192
	move	@scores+16,a0
	move	@kp_qscrs+16,a14
	move	@kp_qscrs+48,a1
	move	@kp_qscrs+80,a2
	add	a1,a14
	add	a2,a14
	move	@kp_qscrs+112,a1
	add	a1,a14
	move	@kp_qscrs+144,a1
	add	a1,a14
	move	@kp_qscrs+176,a1
	add	a1,a14
	sub	a14,a0
	move	a0,@kp_qscrs+208

otdne
	.ref	tuneot_snd
	move	@pup_nomusic,a14
	jrz	play5
	SOUND1	tuneot_snd
play5
 	move	@scores,a0
	move	@scores+16,a1
	cmp	a0,a1
	jrne	endofg


;Display Double or Triple OT message, keep going...

tie					;>Tie
	movi	AUD_OVERTIME,a0
	calla	AUD1

	.ref	tuneoted_snd
	SOUND1	tuneoted_snd
	SOUND1	crwdbed_kill

	movk	1,a0
	move	a0,@HALT

;DJT Start
;	movi	6*TSEC+10-70+60-20,a11
;	CREATE0	scr1
;DJT End
	CREATE0	show_ot_msg

	SLEEP	120

	SOUND1	overtime_sp

	SLEEP	110

	movk	12,a1			;Free time into OT for
	movi	P1DATA,a2

	move	@game_purchased,a0
	movk	4,b0
	clr	a3

tlp	btst	a3,a0
	jrz	nx			;No full game?
	move	a1,*a2(ply_time)	;Give xtra time
nx	addi	PDSIZE,a2
	addk	1,a3
	dsj	b0,tlp

	move	b0,@game_purchased

	move	@team1,a0
	move	a0,@kp_team1
	move	@team2,a0
	move	a0,@kp_team2
	move	@scores,a0,L
	move	a0,@kp_scores,L

	JSRP	hint_page

;	jruc	tob
;
;	move	@ballpnum,a11
;	jrnn	ok1
;	move	@ballpnumshot,a11
;ok1
;	srl	1,a11
;	subk	1,a11
;	CREATE0	plyr_takeoutball3
;	jruc	tob2


tob
;DJT Start
	move	@plyr_onfire,a0
	jrnz	nodrnfr
	move	@t1ispro,a0
	jrnz	chk2			; br=tm1 not champ level
	move	@PSTATUS2,a14
	andi	0CH,a14
	jrz	drnfr
chk2
	move	@t2ispro,a0
	jrnz	nodrnfr		; br=tm2 not champ level
	move	@PSTATUS2,a14
	andi	3,a14
	jrnz	nodrnfr
drnfr
	subk	1,a0
	move	a0,@firstbskt
;;not	.ref	do_smkn
;;here	CREATE0	do_smkn
nodrnfr
;DJT End

	CREATE0	test
	

	.ref	random_ads
	calla	random_ads

	calla	pal_clean
	movi	nofade_t,a10
	CREATE0	fade_up_half

	CREATE0	fix_floor

;Take this out to stop ball being inbounded after score
;FIX!!! where'd this buggy hunk-o-junk come from?

;	move	@gmqrtr,a11
;	sll	32-1,a11
;	move	@gmqrtr,a0
;	cmpi	2,a0
;	jrnz	not2
;	CREATE0	plyr_takeoutball	;takepid(?)
;	jruc	tob2
;not2	CREATE0	plyr_takeoutball2
;tob2

;What's up with this mod?
	move	@gmqrtr,a11
	sll	32-1,a11
	CREATE0	plyr_takeoutball2

	clr	a0
	move	a0,@cntrs_delay		;Delay credit timers
;LOOK!!!
	move	@gmqrtr,a14
	cmpi	2,a14
	jrz	skp
	move	a0,@HALT
skp	clr	a0
;movi	2<<10+4<<5+9,a0
	move	a0,@IRQSKYE

	move	@gmqrtr,a14
	cmpi	2,a14
	jrnz	skpz
	CREATE0	delay_numbs
	RETP



test
;Del old side arrows for all players & in plyr_lost A8
	movi	plyrproc_t,a9
	movk	4,a10
arrow_lp
	move	*a9+,a0,L
	move	*a0(plyr_lost_ptr),a2,L
	move	*a2(PA8),a0,L
	jrz	nxt
	clr	a14
	move	*a2(PA9),a1,L
	move	a14,*a1(OSCALE)
	movk	10,a14
	move	a14,*a2(PTIME)
	calla	DELOBJ
	clr	a0
	move	a0,*a2(PA8),L
nxt	dsj	a10,arrow_lp

	DIE

skpz
;Make sure 's are on at start of qrtr
	movi	P1DATA,a10		;Turn on 's at start of qrtr
	calla	stick_number
	movi	P2DATA,a10
	calla	stick_number
	movi	P3DATA,a10
	calla	stick_number
	movi	P4DATA,a10
	calla	stick_number

	RETP

delay_numbs
;Make sure 's are on at start of qrtr
	SLEEPK	20			;Turn on 's at start of 2nd half
	movi	P1DATA,a10
	calla	stick_number
	movi	P2DATA,a10
	calla	stick_number
	movi	P3DATA,a10
	calla	stick_number
	movi	P4DATA,a10
	calla	stick_number
	DIE

fix_floor
	SLEEPK	12
	.ref	fix_floorclr
	calla	fix_floorclr
	DIE

********************************

 SUBRP	endgame_audits




	movi	AUD_COMPLETED,a0	;04Hth quarter
	calla	AUD1

	move	@scores,a0
	move	@scores+10h,a1
	cmp	    a1,a0
	jrhi	t1_wins

t2_wins
	movi	AUD_LOS_SCORE,a0
	move	@scores,a1
	calla	AUD

	movi	AUD_WIN_SCORE,a0
	move	@scores+10h,a1
	calla	AUD

	jruc	contf

t1_wins
	movi	AUD_WIN_SCORE,a0
	move	@scores,a1
	calla	AUD

	movi	AUD_LOS_SCORE,a0
	move	@scores+10h,a1
	calla	AUD
contf

	move	@PSTATUS2,a0
	andi	011b,a0
	jrnz	team1_human
;team1_cpu
	move	@scores,a4		;CPU SCORE
	move	@scores+10h,a5		;HUMAN SCORE

	movi	AUD_CPUGAMES,a0		;a cpu team
	calla	AUD1
	movi	AUD_CPUSCORES,a0
	move	a4,a1			;cpu score
	calla	AUD
	callr	do_cpu_stats
	jruc	cont2

team1_human
	movi	AUD_HUMGAMES,a0		;a human team
	calla	AUD1
	movi	AUD_HUMSCORES,a0
	move	@scores,a1		;human score
	calla	AUD


cont2
	move	@PSTATUS2,a0
	andi	01100b,a0
	jrnz	team2_human
;team2_cpu
	move	@scores+10h,a4		;CPU SCORE
	move	@scores,a5		;HUMAN SCORE


	movi	AUD_CPUGAMES,a0		;a cpu team
	calla	AUD1
	movi	AUD_CPUSCORES,a0
	move	a4,a1			;cpu score
	calla	AUD
	callr	do_cpu_stats
	rets

team2_human
	movi	AUD_HUMGAMES,a0		;a human team
	calla	AUD1
	movi	AUD_HUMSCORES,a0
	move	@scores+10h,a1		;human score
	calla	AUD


;Now total all human vs. human games, and audit left side winners

	move	@PSTATUS2,a0
	andi	011b,a0
	jrz	novs
	move	@PSTATUS2,a0
	andi	01100b,a0
	jrz	novs
;Was a human vs. human game.
	movi	AUD_HUMANVSHUMAN,a0
	calla	AUD1
	move	@scores,a0
	move	@scores+10h,a1
	cmp	a1,a0
	jrlo	tm2_wins
	movi	AUD_WINSONLEFT,a0
	calla	AUD1
tm2_wins
novs
	rets


********************************
* Update CPU stats
* A4=Cpu score
* A5=Human score

do_cpu_stats

	cmp	a4,a5
	jrhi	cpu_loses

;cpu_wins
	movi	AUD_CPUWINS,a0		;CPU victories + 1
	calla	AUD1

	movi	AUD_CPUWINMARG,a0
	calla	GET_AUD			;RET in A1

	sub	a5,a4
	cmp	a1,a4
	jrls	not_higher
	move	a4,a1
	movi	AUD_CPUWINMARG,a0	;new win margin
	calla	STORE_AUDIT
	rets

cpu_loses
	movi	AUD_CPULOSMARG,a0
	calla	GET_AUD			;RET in A1

	sub	a4,a5			;HUMAN - CPU SCORE
	cmp	a1,a5
	jrls	not_higher
	move	a5,a1
	movi	AUD_CPULOSMARG,a0	;new loss margin
	calla	STORE_AUDIT
not_higher
	rets



********************************
* Let shot finish at end of quarter (JSRP)

 SUBRP	plyr_endqfinishshot

	movi	TSEC*5/2,a10
shot_lp
	move	@ballpnum,a0
	jrnn	stop			;Somebody has ball?
	move	@ballobj_p,a2,L
	move	*a2(OYPOS),a0
	cmpi	-15,a0
	jrgt	stop			;Ball near gnd?

	SLEEPK	2

gbcnt	dsj	a10,shot_lp

stop
	move	@ballpnum,a0
	jrn	no_owner
	sll	5,a0			;*32
	addi	plyrproc_t,a0
	move	*a0,a0,L
	move	*a0(plyr_seqflgs),a1
	btst	DUNK_B,a1
	jrz	no_owner
	move	*a0(plyr_jmpcnt),a1
	cmpi	15,a1
	jrlt	no_owner

;	jrnz	was_bad
;	btst	SHOOT_B,a1
;	jrz	no_owner
;was_bad
	CREATE0	dobad
no_owner

	movk	1,a0
	callr	plyr_setac

	clr	a0
	move	a0,@P1CTRL,L		;Clr p1 & p2 &
	move	a0,@P3CTRL,L		; p3 & p4
	.if DRONES_2MORE
	move	a0,@P5CTRL,L		; & p5 & p6
	.endif

	movi	clockid,a0
	calla	KIL1C 			;Kill existing shot clock proc
	movi	CLSDEAD|clockid,a0
	calla	obj_del1c		;Delete any 24 second shot clock imgs
	clr	a0
	move	a0,@sc_proc,L
	move	a0,@game_time,L

	movk	1,a0
	move	a0,@HALT

	move	@tvpanelon,a0,L
	jrz	turnon_a

	movi	CLSDEAD|tvid,a0
	clr	a1
	calla	EXISTOBJ
	jrz	turnon_a

	move	@tvpanelon,a0,L
	movi	6*TSEC,a1
	move	a1,*a0(PTIME)
turnon_a

;DJT Start
	movi	3*TSEC+10+30,a11
	move	@gmqrtr,a0
	subk	4,a0
	jrn	no_ot
	movi	6*TSEC+10-70+60-20,a11
no_ot
	CREATE0	scr1
;	CREATE0	score_showtvpanel2
;DJT End

	move	@gmqrtr,a0		;Ran out of time
	subk	4,a0
	jrlt	fade
	move	@scores,a0
	move	@scores+16,a1
	cmp	a0,a1
	jreq	fade

	SLEEP	90

;	move	@tvpanelon,a0,L
;	jrz	turnon
;	movi	6*TSEC,a1
;	move	a1,*a0(PTIME)
;turnon

;Turn on winning team message

;	SOUND1	tune_gmovr

	.ref	winning_msg
	CREATE0	winning_msg
	jruc	fade

fade
	SLEEPK	1
;Must wait for flash me routine to finish
	movi	flashpid,a0
	clr	a1
	not	a1
	calla	EXISTP
	jrnz	fade

	calla	pal_clean

	movi	nofade_t,a10
	CREATE0	fade_down_half

plyr_endqfinishshot_x	
    RETP

dobad	SLEEP	100
	SOUND1	baddec_sp
	DIE

nofade_t			;Pals not to fade
	.long	scorep,NEWPLATPP
	.long   SGMD8RED,SGMD8WHT
	.long	textp,cred_p
	.long	ledw,ledr
	.long	NEWPLATPP,NBALOG_P
	.long	TURBO_B_P,TURBO_G_P,TURBO_Y_P,TURBO_R_P
	.long	BST18Y_P,BST18W_P,BST18R_P
	.long	BAST_W_P,BAST_Y_P
	.long	BRUSH_W_P,BRUSH_Y_P,BRUSH_R_P
	.long	HANGF_R_P,HANGF_W_P
	.long	LED_P,TIMPLT_P
	.long	HINT_B_P,HINT_B_P,HINT_B_P,HINT_B_P
	.long	BRSH_R_P
	.long	BALLBAK_P
	.long	FFRAM_B_P
	.long	LOG_ATLP
	.long	LOG_BOSP
	.long	LOG_CHAP
	.long	LOG_CHIP
	.long	LOG_CLEP
	.long	LOG_DALP
	.long	LOG_DENP
	.long	LOG_DETP
	.long	LOG_DETNP
	.long	LOG_GOLP
	.long	LOG_HOUP
	.long	LOG_INDP
	.long	LOG_LACP
	.long	LOG_LALP
	.long	LOG_MIAP
	.long	LOG_MILP
	.long	LOG_MINP
	.long	LOG_MINNP
	.long	LOG_NEJP
	.long	LOG_NEYP
	.long	LOG_ORLP
	.long	LOG_PHIP
	.long	LOG_PHXP
	.long	LOG_PORP
	.long	LOG_SACP
	.long	LOG_SANP
	.long	LOG_SEAP
	.long	LOG_TORP
	.long	LOG_UTAP
	.long	LOG_UTANP
	.long	LOG_VANP
	.long	LOG_WASP
	.long	0




********************************
* Player goaltended (Process)
* A11=*Plyr obj

 SUBR	plyr_goaltending

	move	*a11(OPLINK),a11,L
	move	*a11(plyr_num),a0

	srl	1,a0
	move	a0,a11
	XORK	1,a0
	sll	4,a0			;0 or 16

	addi	scores,a0		;+Base
	move	@ballptsforshot,a1
	move	a1,a3
	calla	score_add

	calla	plyr_setptsdown


	movk	PS_2PTS_MADE,a0		;>Inc try shot stat
	subk	2,a3
	jreq	plyr_goaltending_2ptrc
	movk	PS_3PTS_MADE,a0
plyr_goaltending_2ptrc
	move	@ballpnumshot,a1
	calla	inc_player_stat

	calla	prt_top_scores		;Update scores at scrn top

	movi	TSEC*2,a0
	callr	plyr_setshtdly

	CREATE0	goaltend_text

	SOUND1	whitsle_snd

	move	@tvpanelon,a0,L
	jrz	turnon
	movi	4*TSEC+10-70,a1
	move	a1,*a0(PTIME)
	jruc	alrdyon
turnon
	CREATE0	score_showtvpanel
alrdyon

	movi	P1DATA,a10
	calla	stick_number
	movi	P2DATA,a10
	calla	stick_number
	movi	P3DATA,a10
	calla	stick_number
	movi	P4DATA,a10
	calla	stick_number

	SLEEP	30

	clr	a0
	move	a0,@ballptsforshot

	jruc	plyr_takeoutball3

********************************
* Show goaltending message (JSRP)

 SUBRP	goaltend_text

;	move	@ballobj_p,a2,L		;clear out ball vels
;	clr	a0
;	move	a0,*a2(OXVEL),L
;	move	a0,*a2(OYVEL),L
;	move	a0,*a2(OZVEL),L
;
;	movk	4,a3
;	movi	plyrobj_t,a2,L		;clear out player vels
;velini_lp
;	move	*a2+,a1,L
;	move	a0,*a1(OXVEL),L
;	move	a0,*a1(OYVEL),L
;	move	a0,*a1(OZVEL),L
;	dsj	a3,velini_lp
;
;	SLEEPK	1
;
;	movk	1,a0
;	move	a0,@HALT

	movk	3,a10
	CREATE0	doalert_snd

	move	@game_time,a0,L
	jaz	SUCIDE

	movi	ln0_setup,a2
	calla	setup_message
	move	*a2,a0,L
	move	a0,@mess_justify,L	;justification method
	move	@mess_cursx,a0
	move	a0,@mess_cursx2
	movi	CLSDEAD|123,a0
	move	a0,@mess_objid

	movi	str_goaltend,a4
	calla	print_string2b

	movi	84,a0
	move	a0,@mess_cursx2
	movi	127,a0
	move	a0,@mess_cursy

	addk	8,a4
	calla	print_string2b

	CREATE0	flash_bigtxt
	move	a0,a9

	SLEEP	1*TSEC

	.ref	goal_tend_sp
	SOUND1	goal_tend_sp

	SLEEP	1*TSEC

	move	a9,a0
	calla	KILL

	movi	CLSDEAD|123,a0
	calla	obj_del1c		;delete text

;	clr	a0
;	move	a0,@HALT

	DIE


ln0_setup
	PRINT_STR	hangfnt38_ascii,9,0,131,77,HANGF_R_P,kern_chars

str_goaltend
	.string	"G",1,-1,"O",1,-5,"A",1,3,"L",0
	.string	"T",1,-6,"E",1,-6,"N",1,-6,"D",1,-2,"I",1,-5,"N",1,-3,"G",0
	.even


********************************
* Control players for taking the ball out (Process)
* A11=Team who gets ball (0=1, !0=2)

	STRUCTPD
	WORD	ptob_pball	;Plyr  (0-3) who gets ball
	WORD	ptob_pball2	;P who gets ball passed to him


 SUBR	plyr_takeoutball

;	move	@ballpnumshot,@ballpnum	;DEBUG
;	move	@ballpnumshot,a2
;	sll	5,a2			;*32
;	addi	plyrproc_t,a2
;	move	*a2,a1,L
;	clr	a0
;	move	a0,*a1(plyr_dribmode)	;Reset dribble
;	movi	-1,a0
;	move	a0,@inbound
;	DIE


	movi	TOB_PID,a0		;Kill any other plyr_takeoutball
	move	a0,*a13(PROCID)
	calla	KIL1C

	movi	-1,a0
	move	a0,@ballsclastp
	move	a0,@ballshotinair	;Shooter  if shot in air, else -1

	movi	TSEC+20,a0
	callr	plyr_setshtdly
	clr	a0
	move	a0,@P1CTRL,L		;Clr p1 & p2 &
	move	a0,@P3CTRL,L		; p3 & p4
	.if DRONES_2MORE
	move	a0,@P5CTRL,L		; & p5 & p6
	.endif

	SLEEPK	1

	movi	-1,a0
	move	a0,@ballpnum
	move	a0,@ballpnumlast

	movk	1,a0
	callr	plyr_setac

	clr	a0			;Clr staggers
	movi	plyr_stagcnt,a1
	callr	plyr_setprocword

	movi	plyrproc_t,a0		;Assume team 1 is inbounding
	clr	a2
	move	@PSTATUS2,a3
	movk	2,a9
	move	a11,a11
	jrz	t11
	addk	32,a0			;Team 2 is inbounding
	addk	32,a0
	movk	1,a2
	srl	2,a3
	clr	a9
t11
	move	*a0+,a8,L		;A8=*Proc of plyr who gets ball
	move	*a0+,a7,L
	move	a2,@inbound		;Inbounding team (0-1)
	add	a2,a2			;Make 0 or 1 a 0 or 2

	andi	3,a3			;Only look @ selected team bits
	jrz	two_same		;Closest inbounds if both drones
	cmpi	010b,a3
	jreq	plyr_takeoutball_1st			;If human/drone, drone always
	jrlo	plyr_takeoutball_2nd			; inbounds

two_same
	move	*a8(plyr_balldist),a0	;Both drone or human. Plyr closest
	move	*a7(plyr_balldist),a1	; to ball inbounds
	cmp	a1,a0
	jrle	plyr_takeoutball_1st			;1st in team if <=
plyr_takeoutball_2nd
	move	a7,a8			;2nd in team
	addk	1,a2
plyr_takeoutball_1st
	move	a2,*a13(ptob_pball)	;=inbounding plyr 
	XORK	1,a2
	move	a2,*a13(ptob_pball2)	;=inbound teammate plyr 


	movi	TSEC*3,a10		;Max wait for ball to be gotten
gblp1
	movi	-1,a0
	move	a0,@ballpnum
	move	a0,@ballpnumlast

	SLEEPK	1


	.if	DEBUG
	move	@plyrproc_t,a0,L
	move	*a0(plyr_nojoy),a0
	jrnz	lock2
	move	@plyrproc_t+32,a0,L
	move	*a0(plyr_nojoy),a0
	jrnz	lock2
	move	@plyrproc_t+64,a0,L
	move	*a0(plyr_nojoy),a0
	jrnz	lock2
	move	@plyrproc_t+96,a0,L
	move	*a0(plyr_nojoy),a0
	jrz	    debug_ok
lock2
	.if	DEBUG
	LOCKUP
	.endif
debug_ok
	.endif



	callr	plyrtob_moveo3		;Move other plyrs to their spots

	move	@ballobj_p,a3,L		;Figure ball coor for inbounder to
	move	*a3(OXPOS),a0		; chase
	addk	6,a0			;stupid K!!!
	move	*a3(OZPOS),a1
	move	*a13(ptob_pball),a2
	callr	plyrtob_seekxy		;Move inbounder to the ball
	jrz	atball
	dsj	a10,gblp1		;Don't wait longer then A10
	jruc	atball2
atball
	move	*a8(plyr_jmpcnt),a0	;Wait for inbounder to land if still
	jrnz	gblp1			; in a jump but has the ball
atball2
	clr	a0
	move	a0,*a8(plyr_shtdly)


	movi	TSEC*1,a10		;Max wait for ball to be picked up
gblp2
	movi	-1,a0			;Make sure noone has it
	move	a0,@ballpnum
	move	a0,@ballpnumlast
	SLEEPK	1
	move	@ballpnum,a0		;Does anyone have it now?
	jrn	gbcnt2
	move	*a13(ptob_pball),a2
	cmp	a0,a2			;Is it the inbounding plyr? Yes if =
	jreq	gotball
gbcnt2
	callr	plyrtob_moveo3		;Move other plyrs to their spots

	move	@ballobj_p,a3,L		;Figure ball coor for inbounder to
	move	*a3(OXPOS),a0		; chase
	addk	6,a0			;stupid K!!!
	move	*a3(OZPOS),a1
	move	*a13(ptob_pball),a2
	callr	plyrtob_seekxy		;Move inbounder to the ball
	dsj	a10,gblp2		;Don't wait longer then A10
gotball
	move	*a13(ptob_pball),a0	;Grab the ball
	move	a0,@ballpnum
	clr	a0
	move	a0,*a8(plyr_dribmode)


	movi	TSEC*3,a10		;Max wait for inbounder to get OOB
outlp1
	SLEEPK	1

	callr	plyrtob_moveo3		;Move other plyrs to their spots

	movi	-IBX_OOB,a0		;Set X per team inbounding
	move	a11,a11
	jrz	    outl1			;Team2 on def
	neg	a0
outl1	    
    addi	WRLDMID,a0
	movi	IBZ_OOB,a1
	move	*a13(ptob_pball),a2
	move	a2,@ballpnum
	callr	plyrtob_seekxy		;Move inbounder to OOB spot
	jrz	    outofb			;He's there if 0
	dsj	    a10,outlp1		;Don't wait longer then A10
outofb
	movi	-1,a0
	move	a0,*a8(plyr_dribmode)
	calla	call_scores


	movi	TSEC*3,a10		;Max wait for other 3 to get in place
wtlp1
	SLEEPK	1

	callr	plyrtob_moveo3		;Move other plyrs to their spots
	jrz	inposa			;They're there if 0
	dsj	a10,wtlp1		;Don't wait longer then A10
;	.if	DEBUG
;	LOCKUP
;	.endif
inposa
;
;
;FIX!!! Allow movement during inbounds
;
;	clr	a14
;	movi	plyrproc_t,a0,L		;Assume team 1 is inbounding
;	move	*a0+,a1,L
;	move	a14,*a1(plyr_autoctrl)
;	move	*a0+,a1,L
;	move	a14,*a1(plyr_autoctrl)
;	move	*a0+,a1,L
;	move	a14,*a1(plyr_autoctrl)
;	move	*a0,a1,L
;	move	a14,*a1(plyr_autoctrl)
;	movk	1,a14
;	move	a0,*a13(plyr_autoctrl)
;
;
;
;
	SLEEPK	30			;Pause before inbounding

	move	*a13(ptob_pball),a0	;Set inbounder as ball owner
	move	a0,@ballpnum

	movk	20,a0			;Don't call pass on inbound
	move	a0,@last_name_time


plyrtob_dopass
	move	*a13(ptob_pball),a10	;>Pass with turbo
	sll	4,a10
	addi	P1CTRL,a10
	movi	(BUT2_M|BUT3_M)<<8|BUT2_M|BUT3_M,a0
	move	a0,*a10

	movi	TSEC*2,a2		;Max wait for pass to start
waitp
	PUSHP	a2
	SLEEPK	1
	PULLP	a2
	move	*a8(plyr_seqflgs),a0
	btst	PASS_B,a0
	jrnz	passing
	dsj	a2,waitp		;Don't wait longer then A2
passing
	clr	a0			;Clr inbounder PxCRTL

	move	a0,@drone_attempt	;Alley oop jump up attempts

	move	a0,*a10
	not	a0			;Inbounding off
	move	a0,@inbound

;Take out for moving during inbound!

	SLEEPK	30
	jruc	runinlp
;
;;Start here for moving during inbound!
;
;	SLEEPK	1
;
;	movk	1,a0
;	move	a0,@inbound_lead
;
;	SLEEPK	1
;
;	move	*a13(ptob_pball),a0
;	XORK	1,a0
;	sll	5,a0
;	addi	plyrproc_t,a0,L
;	move	*a0+,a1,L
;	clr	a14
;	move	a14,*a1(plyr_autoctrl)
;	move	a14,*a1(plyr_nojoy)
;
;	move	*a13(ptob_pball),a0
;	btst	1,a0
;	jrz	tm1
;;Team 2 is inbounding
;
;	movi	plyrproc_t,a0,L
;	move	*a0+,a1,L
;	move	a14,*a1(plyr_autoctrl)
;	move	a14,*a1(plyr_nojoy)
;	move	*a0,a1,L
;	move	a14,*a1(plyr_autoctrl)
;	move	a14,*a1(plyr_nojoy)
;	jruc	ext
;
;tm1
;;Team 1 is inbounding
;
;	movi	plyrproc_t+64,a0,L
;	move	*a0+,a1,L
;	move	a14,*a1(plyr_autoctrl)
;	move	a14,*a1(plyr_nojoy)
;	move	*a0,a1,L
;	move	a14,*a1(plyr_autoctrl)
;	move	a14,*a1(plyr_nojoy)
;
;ext
;	PUSHP	a9
;	movk	30,a9
;lpit	SLEEPK	1
;	callr	joy_read2
;
;	move	*a13(ptob_pball),a0
;	sll	4,a0
;	addi	P1CTRL,a0
;	clr	a14
;	move	a14,*a0
;
;	dsjs	a9,lpit
;	PULLP	a9
;
;
;	clr	a0
;	move	a0,@inbound_lead



runinlp
	SLEEPK	1			;Wait till inbounder is back on court
	movi	-IBX_CRT,a0		;Set X per team inbounding
	move	a11,a11
	jrz	    outl2a			;Team2 on def
	neg	a0
outl2a	
    addi	WRLDMID,a0
	movi	IBZ_CRT,a1
	move	*a13(ptob_pball),a2
	callr	plyrtob_seekxy		;Move inbounder to court spot
	jrz	    contg			;Wait till he gets there

;For moving during inbound!
	
;	PUSHP	a9,a10,a11
;	move	a13,a11
;	move	a0,a9
;	move	@tmp_fix,a10,L
;	CREATE0	fuck
;	PULLP	a9,a10,a11

	jruc	runinlp		;Wait till he gets there
contg
	move	a11,a0
	calla	shot_clock		;New 24

	clr	a0
	move	a0,@plyrinautorbnd	;In case seq didn't clr
	move	a0,@ballflash
	move	a0,@pass_off
	move	a0,@steals_off
	move	a0,@slamming


	move	*a13(ptob_pball),a0
	sll	5,a0
	addi	plyrproc_t,a0
	move	*a0,a0,L
	clr	a14
	move	a14,*a0(plyr_nojoy)

	clr	a0
	callr	plyr_setac

	clr	a0			;Clr staggers
	movi	plyr_stagcnt,a1
	callr	plyr_setprocword

	clr	a0
	movi	plyr_d_cflgs,a1
	callr	plyr_setprocword

	.ref	drone_setuptob
	calla	drone_setuptob



;This patch allows clock to be displayed at start of qrtrs and to not get
;an overlapped time when someone scores..
	move	@game_time,a14,L
	cmpi	02040906H,a14
	jrlt	goclock
	SLEEP	45
goclock
	clr	a0
	move	a0,@clock_active	;Start game clock again
	DIE




;For moving during inbound!
;fuck
;	move	*a11(ptob_pball),a0
;	sll	5,a0
;	addi	plyrproc_t,a0
;	move	*a0,a0,L
;	move	a9,*a10
;	ori	8000h,a9
;	move	a9,*a0(plyr_nojoy)
;	DIE


******************************************************************************
* Control players for taking the ball out (Process)
* Teleport players to their positions
* A11=Team who gets ball (0=1, !0=2)

	.asg	60h,FACE_LEFT
	.asg	20h,FACE_RIGHT

 SUBR	plyr_takeoutball2

	movi	TOB_PID,a0		;Kill any other plyr_takeoutball
	move	a0,*a13(PROCID)
	calla	KIL1C

	movi	-1,a0
	move	a0,@ballsclastp
	move	a0,@ballshotinair	;Shooter  if shot in air, else -1

	movk	1,a0
	callr	plyr_setac

	clr	a0
	move	a0,@P1CTRL,L		;Clr p1 & p2 &
	move	a0,@P3CTRL,L		; p3 & p4
	.if DRONES_2MORE
	move	a0,@P5CTRL,L		; & p5 & p6
	.endif

	move	a0,@WORLDTLY,L			;Set for plyr 1 with the ball
	movi	[WRLDMID-200-MAX_VIEW1+15,0],a1
	movk	1,a2				;Plyr 2 receives
	movi	t1_setup_table,a10
	move	a11,a11
	jrz	setiba
	movk	1,a0				;Set for plyr 4 with the ball
	movi	[WRLDMID-200+MAX_VIEW1-15,0],a1
	movk	2,a2				;Plyr 3 receives
	movi	t2_setup_table,a10
setiba
	move	a0,@inbound		;Inbounding team
	move	a1,@WORLDTLX,L
	subi	[WRLDMID-200,0],a1
	move	a1,@gndx,L
	movi	-1,a0
	move	a0,@ballpnumlast

	move	a2,*a13(ptob_pball2)	;=1|2
	XORK	1,a2
	move	a2,*a13(ptob_pball)	;=0|3
	move	a2,@ballpnum

	PUSH	a13
	sll	5,a2
	movi	plyrobj_t,a8
	add	a2,a8
	move	*a8,a8,L		;*Plyr obj
	addi	plyrproc_t,a2
	move	*a2,a13,L		;*Plyr process
	callr	plyr_setballxyz
	PULL	a13

	move	@pup_court,a0
	jrz	nootd
	.ref	otdscroller_wake,otdscroll_p	;fix no city on otd at half
	move	@otdscroll_p,a0,L
	movi	otdscroller_wake,a14
	move	a14,*a0(PWAKE),L
nootd
	movk	NUMPLYRS,a14			;>Teleport them
init_loop
	PUSH	a14
	move	*a10+,a0		;=Plyr  (0-3)
	move	*a10+,a4		;=ZPOS
	sll	16,a4			;Make it ZVAL
	move	*a10+,a5		;=XPOS
	sll	16,a5			;Make it XVAL
	move	*a10+,a7		;Direction facing
	callr	plyr_init
	PULL	a14
	dsj	a14,init_loop

;	move	@gmqrtr,a14
;	subk	2,a14
;	jrnz	qkfix
;	clr	a14
;	move	a14,@HALT
;	SLEEPK	1
;	movk	1,a14
;	move	a14,@HALT
;qkfix
	SLEEP	60

	movk	20,a0
	move	a0,@last_name_time	;Don't call pass on inbound

	jruc	plyrtob_dopass


;normal setup (left)
t1_setup_table
	.word	0,IBZ_OOB,	WRLDMID-IBX_OOB,	20h	;ply,z,x,face
	.word	1,IBZ_INB,	WRLDMID-IBX_INB,	60h	;ply,z,x,face
	.word	2,IBZ_DEF1,	WRLDMID-IBX_DEF,	60h	;ply,z,x,face
	.word	3,IBZ_DEF2,	WRLDMID-IBX_DEF,	60h	;ply,z,x,face
	.if DRONES_2MORE
	.word	4,IBZ_DEF1,	WRLDMID-IBX_DEF,	60h	;ply,z,x,face
	.word	5,IBZ_DEF2,	WRLDMID-IBX_DEF,	60h	;ply,z,x,face
	.endif

;normal setup	(right)
t2_setup_table
	.word	3,IBZ_OOB,	WRLDMID+IBX_OOB,	60h	;ply,z,x,face
	.word	2,IBZ_INB,	WRLDMID+IBX_INB,	20h	;ply,z,x,face
	.word	0,IBZ_DEF1,	WRLDMID+IBX_DEF,	20h	;ply,z,x,face
	.word	1,IBZ_DEF2,	WRLDMID+IBX_DEF,	20h	;ply,z,x,face
	.if DRONES_2MORE
	.word	4,IBZ_DEF1,	WRLDMID+IBX_DEF,	20h	;ply,z,x,face
	.word	5,IBZ_DEF2,	WRLDMID+IBX_DEF,	20h	;ply,z,x,face
	.endif


******************************************************************************
* Control players for taking the ball out (Process)
* Created by goaltending
* A11=Team who gets ball (0=1, !0=2)

 SUBR	plyr_takeoutball3

	movi	TOB_PID,a0		;Kill any other plyr_takeoutball
	move	a0,*a13(PROCID)
	calla	KIL1C

	movi	-1,a0
	move	a0,@ballsclastp
	move	a0,@ballshotinair	;Shooter  if shot in air, else -1

	movk	25,a0
	callr	plyr_setshtdly

	SLEEPK	1

	movi	-1,a0
	move	a0,@ballpnum
	move	a0,@ballpnumlast

	move	a11,a0
	jrz	setib
	movk	1,a0
setib
	move	a0,@inbound		;Inbounding team

	movk	1,a0
	callr	plyr_setac

	clr	a0			;Clr staggers
	movi	plyr_stagcnt,a1
	callr	plyr_setprocword

	movk	2,a9			;A9=1st p of team on defense
	movi	plyrproc_t,a0
	move	a11,a2
	jrz	t12
	clr	a9
	addk	32,a0
	addk	32,a0
	movk	2,a2
t12
	move	*a0+,a8,L		;A8=*Proc of plyr who gets ball
	move	*a0+,a7,L
	move	*a8(plyr_hpdist),a0
	move	*a7(plyr_hpdist),a1
	cmp	a1,a0
	jrle	plyr_takeoutball3_1st			;Closer?
	move	a7,a8
	addk	1,a2			;2nd in team
plyr_takeoutball3_1st
	move	a2,*a13(ptob_pball)
	move	a2,@ballpnum
	XORK	1,a2
	move	a2,*a13(ptob_pball2)
	movi	-1,a0
	move	a0,@ballpnumlast

outlp2
	SLEEPK	1

	move	*a13(ptob_pball),a0	;Ensure goaltender has ball
	move	a0,@ballpnum
	clr	a0
	move	a0,*a8(plyr_dribmode)

	callr	plyrtob_moveo3		;Move other plyrs to their spots

	movi	-IBX_OOB,a0		;Set X per team inbounding
	move	a11,a11
	jrz	    outl2			;Team2 on def
	neg	    a0
outl2	    
    addi	WRLDMID,a0
	movi	IBZ_OOB,a1
	move	*a13(ptob_pball),a2
	callr	plyrtob_seekxy		;Move inbounder to OOB spot
	jrnz	outlp2			;He's not there yet if !0


	movi	TSEC*3,a10		;Max wait for other 3 to get in place
wtlp2
	SLEEPK	1

	callr	plyrtob_moveo3		;Move other plyrs to their spots
	jrz	inpos			;They're there if 0
	dsj	a10,wtlp2		;Don't wait longer then A10
inpos
	SLEEP	60			;Pause before inbounding

	jruc	plyrtob_dopass


******************************************************************************
* Clear out plyr variables
*	a0 = player number in (0-3)
*	a4 = player Z VAL
*	a5 = player X VAL
*	a7 = player direction	(00h - 7fh)

 SUBR	plyr_init

	PUSH	a8,a10,a13

	sll	5,a0			;x 32 bits
	movi	plyrproc_t,a13
	add	a0,a13
	move	*a13,a13,L		;*plyr process

	addi	plyrobj_t,a0
	move	*a0,a8,L		;*plyr object

	move	a4,*a8(OZVAL),L
	callr	anipt_getsclxy		;a0 = anix, a1 = aniy
	move	a0,*a8(OXANI),L
	neg	a1
	move	a1,*a8(OYVAL),L
	sub	a0,a5
	move	a5,*a8(OXVAL),L

	movk	STND_SEQ,a0
	callr	plyr_setseq

	clr	a0

	move	a0,*a8(OXVEL),L
	move	a0,*a8(OYVEL),L
	move	a0,*a8(OZVEL),L

	move	a0,*a13(plyr_jmpcnt)
	move	a0,*a13(plyr_dribmode)
	move	a0,*a13(plyr_offscrn)
	move	a0,*a13(plyr_d_cflgs)
	move	a0,*a13(plyr_hangcnt)
	move	a0,*a13(plyr_nojoy)
	move	a0,*a13(plyr_shtdly)
;	move	a0,*a13(plyr_passbtime)
	move	a0,*a13(plyr_slam_ticks)
	move	a0,*a13(plyr_rcvpass)
	move	a0,*a13(plyr_ownball)
	move	a0,*a13(plyr_stagcnt)

	movi	-1,a0
	move	a0,*a13(plyr_newdir)

	movk	1,a0
	move	a0,*a13(PA10),L		;reset sequence wake count

	PULL	a8,a10,a13
	rets


********************************
* Set new autoctrl value
* A0=autoctrl 
* Trashes scratch

 SUBRP	plyr_setac

	movi	plyrproc_t,a14
	movk	NUMPLYRS,b0
aclp0
	move	*a14+,a1,L
	move	a0,*a1(plyr_autoctrl)
	dsj	b0,aclp0

	rets


********************************
* Set new shtdly value
* A0=shtdly 
* Trashes scratch

 SUBR	plyr_setshtdly

	movi	plyrproc_t,a14
	movk	NUMPLYRS,b0
aclp1
	move	*a14+,a1,L
	move	a0,*a1(plyr_shtdly)
	dsj	b0,aclp1

	rets


********************************
* Set word in plyr's proc
* A0=
* A1=Proc offset
* Trashes scratch

 SUBRP	plyr_setprocword

	move	a2,b1
	movi	plyrproc_t,a14
	movk	NUMPLYRS,b0
aclp2
	move	*a14+,a2,L
	add	a1,a2
	move	a0,*a2
	dsj	b0,aclp2

	move	b1,a2

	rets


********************************
* Move the other 3 guys who aren't getting the ball
* A9=1st pnum of team on defense (0/2)
* A11=Team who gets ball (0=1, !0=2)
* 0A0H=0 if all players in position (Pass CC)
* Trashes scratch, A1-A4

 SUBRP	plyrtob_moveo3

	movi	-IBX_DEF,a0		;Set X's per team inbounding
	movi	-IBX_INB,a4
	move	a11,a11
	jrz	t2			;Team1 gets?
	neg	a0
	neg	a4
t2	addi	WRLDMID,a0
	addi	WRLDMID,a4

	move	a0,a3			;>Send defenders to their spots
	movi	IBZ_DEF1,a1
	move	a9,a2
	callr	plyrtob_seekxy
	PUSH	a0

	move	a3,a0
	movi	IBZ_DEF2,a1
	addk	1,a2
	callr	plyrtob_seekxy
	PUSH	a0

	move	a4,a0			;>Send teammate to spot
	movi	IBZ_INB,a1
	move	*a13(ptob_pball2),a2
	callr	plyrtob_seekxy
	PULL	a1
	or	a1,a0
	PULL	a1
	or	a1,a0

	rets


********************************
* Push stick to move plyr towards an XZ location
* A0=X to seek
* A1=Z
* A2=Player  (0-3)
* 0A0H=Joy bits set or 0 (Pass CC)
* Trashes scratch

 SUBRP	plyrtob_seekxy

	PUSH	a2,a8,a11

	move	a0,b0

	sll	4,a2			;*16
	move	a2,a11
	addi	P1CTRL,a11
	sll	1,a2
	addi	plyrobj_t,a2
	move	*a2,a8,L


	move	*a8(OXPOS),a2
	move	*a8(OXANI+16),a14
	add	a14,a2

;	.if	DEBUG
;	cmpi	WRLDMID-IBX_OOB-15,a2
;	jrle	bugout
;	cmpi	WRLDMID+IBX_OOB+15,a2
;	jrlt	nobug
;bugout
;	LOCKUP
;nobug
;	.endif

	sub	a0,a2

	clr	a0

	move	a2,a14
	abs	a2
	subk	10,a2
	jrle	onx
	move	a14,a14
	jrlt	nolft
	subk	4,a0			;Left

nolft	addk	8,a0			;Rgt
onx
	move	*a8(OZPOS),a2

;	.if	DEBUG
;	cmpi	CZMIN-17,a2
;	jrle	bugout1
;	cmpi	CZMAX+17,a2
;	jrlt	nobug1
;bugout1
;	LOCKUP
;nobug1
;	.endif

	sub	a1,a2
	move	a2,a14
	abs	a2
	subk	10,a2
	jrle	onz
	move	a14,a14
	jrlt	noup2
	subk	1,a0			;Up

noup2	
    addk	2,a0			;Dn
onz

	move	a0,*a11
;For moving during inbound!
;	.bss	tmp_fix,16
;	move	a11,@tmp_fix,L
	move	a0,a0
	jrnz	plyrtob_seekxy_x

	move	b0,a14
	move	*a8(OXANI+16),a2
	sub	a2,a14
	move	a14,*a8(OXPOS)

	move	a1,*a8(OZPOS)

	move	*a8(OXVEL),a1,L
	sra	1,a1
	move	a1,*a8(OXVEL),L
	move	*a8(OZVEL),a1,L
	sra	1,a1
	move	a1,*a8(OZVEL),L

plyrtob_seekxy_x	
    PULL	a2,a8,a11
	move	a0,a0
	rets


********************************
* Get dir for object to face an XZ
* A6=Dest X
* A7=Dest Z
* A8=*Source obj
* 0A0H=0-127
* Trashes A0-A2,A14

 SUBRP	seekdir_obxz128

	move	*a8(OXPOS),a0		;Get SX
	move	*a8(OXANI+16),a14
	add	a14,a0
	move	*a8(OZPOS),a1		;Get SZ

********************************
* Get dir for src XY to face an XY
* A0=Src X
* A1=Src Y
* A6=Dest X
* A7=Dest Y
* 0A0H=0-127
* Trashes A0-A2,A14

 SUBR	seekdir_xyxy128

	clr	a2			;Octant 0-1
	sub	a6,a0			;A0=SrcX-DestX
	jrgt	seekdir_xyxy128_o45_67
	abs	a0
	sub	a7,a1			;A1=SrcY-DestY
	jrnn	gotoct1
	movk	2,a2			;Oct 2-3
	abs	a1
	jruc	d_sw1
seekdir_xyxy128_o45_67
	movk	4,a2			;Oct 4-5
	sub	a7,a1			;A1=SrcY-DestX
	abs	a1
	jrnn	o_up1
	movk	6,a2			;Oct 6-7
d_sw1
	SWAP	a0,a1			;Swap XY delts for oct 23 & 67
o_up1
	sll	4,a2			;Oct*16

gotoct1
	clr	a14
	cmp	a1,a0			;0CHmp slope
	jrhs	seekdir_xyxy128_300

	srl	4,a1			;Bigger/16
	jrnz	seekdir_xyxy128_250
	jruc	seekdir_xyxy128_x
lp1
	addk	1,a2			;Next 1/16 oct
	add	    a1,a14			;+1/16
seekdir_xyxy128_250
	cmp	    a0,a14
	jrlo	lp1
	jruc	seekdir_xyxy128_x

seekdir_xyxy128_300
	addk	31,a2			;End of next octant

	srl	4,a0			;Bigger/16
	jrnz	seekdir_xyxy128_350
	jruc	seekdir_xyxy128_x
lp2a
	subk	1,a2			;Next 1/16 oct
	add	a0,a14			;+1/16
seekdir_xyxy128_350
	cmp	a1,a14
	jrlo	lp2a

seekdir_xyxy128_x
	movi	07fH,a0
	and	a2,a0
	rets


********************************
* Get dir and distance from object to object
* A0=*Dest obj
* A8=*Source obj
* 0A0H=0-127
* 0A1H=Distance
* Trashes scratch, A2,A6,A7

 SUBRP	seekdirdist_obob128

	move	*a0(OXPOS),a6		;Get SX
	move	*a0(OXANI+16),a14
	add	a14,a6
	move	*a0(OZPOS),a7		;Get SZ

********************************
* Get dir and distance from object to XZ
* A6=Dest X
* A7=Dest Z
* A8=*Source obj
* 0A0H=0-127
* 0A1H=Distance
* Trashes scratch, A2

 SUBR	seekdirdist_obxz128

	move	*a8(OXPOS),a0		;Get SX
	move	*a8(OXANI+16),a14
	add	a14,a0
	move	*a8(OZPOS),a1		;Get SZ

	clr	a2			;Octant 0-1
	sub	a6,a0			;A0=SrcX-DestX
	jrgt	seekdirdist_obxz128_o45_67
	abs	a0
	sub	a7,a1			;A1=SrcY-DestY
	jrnn	gotoct2
	movk	2,a2			;Oct 2-3
	abs	a1
	jruc	d_sw2
seekdirdist_obxz128_o45_67
	movk	4,a2			;Oct 4-5
	sub	a7,a1			;A1=SrcY-DestX
	abs	a1
	jrnn	o_up2
	movk	6,a2			;Oct 6-7
d_sw2
	SWAP	a0,a1			;Swap XY delts for oct 23 & 67
o_up2
	sll	4,a2			;Oct*16

gotoct2
	clr	a14
	cmp	a1,a0			;0CHmp slope
	jrhs	seekdirdist_obxz128_300

	move	a0,b0			;Save distance
	move	a1,b1

	srl	4,a1			;Bigger/16
	jrnz	seekdirdist_obxz128_250
	jruc	seekdirdist_obxz128_x
lp1a
	addk	1,a2			;Next 1/16 oct
	add	a1,a14			;+1/16
seekdirdist_obxz128_250
	cmp	a0,a14
	jrlo	lp1a
	jruc	seekdirdist_obxz128_x

seekdirdist_obxz128_300
	move	a0,b1			;Save distance
	move	a1,b0

	addk	31,a2			;End of next octant

	srl	4,a0			;Bigger/16
	jrnz	seekdirdist_obxz128_350
	jruc	seekdirdist_obxz128_x
lp2b
	subk	1,a2			;Next 1/16 oct
	add	a0,a14			;+1/16
seekdirdist_obxz128_350
	cmp	a1,a14
	jrlo	lp2b

seekdirdist_obxz128_x					;0CaHlc distance (long+short/2.667)
	srl	1,b0			;Shorter/2
	add	b0,b1
	srl	2,b0			;Shorter/8
	sub	b0,b1
	move	b1,a1

	movi	07fH,a0
	and	a2,a0
	rets


********************************
* Get random  with mask
* A0=Mask
* 0A0H=Rnd  (Pass CC)
* Trashes scratch

 SUBRP	rnd

	move	@RAND,a1,L
	rl	a1,a1
	move	@HCOUNT,a14
	rl	a14,a1
	add	sp,a1
	move	a1,@RAND,L

	and	a1,a0
	rets


********************************
* Quickly produce a random  in range 0-X
* A0=X
* 0A0H=Random  (0 to A0) (No CC)
* Trashes scratch

 SUBR	rndrng0

	move	@RAND,a1,L
	rl	a1,a1
	move	@HCOUNT,a14
	rl	a14,a1
	add	sp,a1
	move	a1,@RAND,L

	addk	1,a0
	mpyu	a1,a0		;Condition codes not valid!

	rets

;---------------------------------------

	.if CRTALGN

********************************
* Create ground alignment dots for debugging (Process)

 SUBR	gnd_aligndots

	.ref	hoopl_t,hoopr_t

	movi	alignimg_t,a2
	movi	0800cH|M_NOCOLL|M_3D|M_NOSCALE,a4
	movi	CLSDEAD,a5
	clr	a6
	clr	a7


	.if 0		;1=SHOW 3PT DOTS, 0=DON'T
	movi	pt3_t,a11
	movi	PT3_TOPZ,a3
	jruc	3pstrt
3plp
	neg	a0
	addi	200,a0
	sll	16,a0
	clr	a1			;Y lft
	calla	BEGINOBJ
	movi	0101H,a0
	move	a0,*a8(OCONST)
	move	*a11+,a0		;X rgt
	addi	200,a0
	sll	16,a0
	clr	a1			;Y rgt
	calla	BEGINOBJ
	movi	0101H,a0
	move	a0,*a8(OCONST)
	addk	4,a3			;Z inc
3pstrt	move	*a11,a0			;X lft
	jrnn	3plp
	.endif


	.if 0		;1=SHOW HOOP DOTS, 0=DON'T
	movi	hoopl_t,a11		;>Setup left hoop dots
	jruc	hlstrt
hllp
	sll	16,a0
	move	*a11+,a1		;Y
	sll	16,a1
	move	*a11+,a3		;Z
	move	*a11+,a14
	jrn	hlstrt		;Keep in to not show score pts!
	addi	300,a3
	calla	BEGINOBJ2
	movi	0101H,a0
	move	a0,*a8(OCONST)
	movi	-300,a0
	move	a0,*a8(OMISC)		;Z offset
hlstrt	move	*a11+,a0		;X
	jrnz	hllp			;!End?

	movi	hoopr_t,a11		;>Setup rgt hoop dots
	jruc	hrstrt
hrlp
	sll	16,a0
	move	*a11+,a1		;Y
	sll	16,a1
	move	*a11+,a3		;Z
	move	*a11+,a14
	jrn	hrstrt		;Keep in to not show score pts!
	addi	300,a3
	calla	BEGINOBJ2
	movi	0101H,a0
	move	a0,*a8(OCONST)
	movi	-300,a0
	move	a0,*a8(OMISC)		;Z offset
hrstrt	move	*a11+,a0		;X
	jrnz	hrlp			;!End?
	.endif


	.if 0		;1=SHOW BACKBOARD DOTS, 0=DON'T
	.asg	((BBRD_ZWID/2)*3/32),FC8	;Fudge cnt X offset

	movi	(-BBRD_X+200-FC8) << 16,a0
	movi	(BBRD_Y) << 16,a1
	movi	BBRD_Z+BBRD_ZWID/2,a3
	calla	BEGINOBJ
	movi	0101H,a0
	move	a0,*a8(OCONST)

	movi	(-BBRD_X+200+FC8) << 16,a0
	movi	(BBRD_Y) << 16,a1
	movi	BBRD_Z-BBRD_ZWID/2,a3
	calla	BEGINOBJ
	movi	0101H,a0
	move	a0,*a8(OCONST)

	movi	(-BBRD_X+200-FC8) << 16,a0
	movi	(BBRD_Y-BBRD_YWID) << 16,a1
	movi	BBRD_Z+BBRD_ZWID/2,a3
	calla	BEGINOBJ
	movi	0101H,a0
	move	a0,*a8(OCONST)

	movi	(-BBRD_X+200+FC8) << 16,a0
	movi	(BBRD_Y-BBRD_YWID) << 16,a1
	movi	BBRD_Z-BBRD_ZWID/2,a3
	calla	BEGINOBJ
	movi	0101H,a0
	move	a0,*a8(OCONST)

	movi	(BBRD_X+200+FC8) << 16,a0
	movi	(BBRD_Y) << 16,a1
	movi	BBRD_Z+BBRD_ZWID/2,a3
	calla	BEGINOBJ
	movi	0101H,a0
	move	a0,*a8(OCONST)

	movi	(BBRD_X+200-FC8) << 16,a0
	movi	(BBRD_Y) << 16,a1
	movi	BBRD_Z-BBRD_ZWID/2,a3
	calla	BEGINOBJ
	movi	0101H,a0
	move	a0,*a8(OCONST)

	movi	(BBRD_X+200+FC8) << 16,a0
	movi	(BBRD_Y-BBRD_YWID) << 16,a1
	movi	BBRD_Z+BBRD_ZWID/2,a3
	calla	BEGINOBJ
	movi	0101H,a0
	move	a0,*a8(OCONST)

	movi	(BBRD_X+200-FC8) << 16,a0
	movi	(BBRD_Y-BBRD_YWID) << 16,a1
	movi	BBRD_Z-BBRD_ZWID/2,a3
	calla	BEGINOBJ
	movi	0101H,a0
	move	a0,*a8(OCONST)
	.endif


	.if 0		;1=SHOW COURT DOTS, 0=DON'T
	movi	init_t,a11		;>Setup gnd dot images
	jruc	5
dots_lp
	addi	200,a0
	sll	16,a0
	clr	a1			;Y
	move	*a11+,a3		;Z
	calla	BEGINOBJ
	movi	0101H,a0
	move	a0,*a8(OCONST)
5	move	*a11+,a0		;X
	cmpi	4000,a0
	jrne	dots_lp			;!End?
	.endif


;--------------------
; Cycle dot color

	move	*a8(OPAL),a9
	sll	8,a9
	addk	1,a9			;Color 1
	clr	a10
plp
	move	a10,a0
	addi	color_t,a0
	move	a9,a1
	movk	1,a2			;Colors
	calla	pal_set
	SLEEPK	10
	addk	16,a10
	sll	32-6,a10		;0-3 color 
	srl	32-6,a10
	jruc	plp


x0	.equ	LFTCRT_X-WRLDMID	;-350
x1	.equ	RGTCRT_X-WRLDMID	;350

z0	.equ	GZMIN
z0a	.equ	GZMIN+(CZMIN-GZMIN)/4
z0b	.equ	GZMIN+(CZMIN-GZMIN)/2
z0c	.equ	GZMIN+(CZMIN-GZMIN)*3/4
z1	.equ	CZMIN			;1000
z1a	.equ	CZMIN+(CZMAX-CZMIN)/16
z1b	.equ	CZMIN+(CZMAX-CZMIN)/8
z1c	.equ	CZMIN+(CZMAX-CZMIN)*3/16
z2	.equ	CZMIN+(CZMAX-CZMIN)/4	;1095		
z2a	.equ	CZMIN+(CZMAX-CZMIN)*5/16
z2b	.equ	CZMIN+(CZMAX-CZMIN)*3/8
z2c	.equ	CZMIN+(CZMAX-CZMIN)*7/16
z3	.equ	CZMIN+(CZMAX-CZMIN)/2	;1190
z3a	.equ	CZMIN+(CZMAX-CZMIN)*9/16
z3b	.equ	CZMIN+(CZMAX-CZMIN)*5/8
z3c	.equ	CZMIN+(CZMAX-CZMIN)*11/16
z4	.equ	CZMIN+(CZMAX-CZMIN)*3/4	;1284
z4a	.equ	CZMIN+(CZMAX-CZMIN)*13/16
z4b	.equ	CZMIN+(CZMAX-CZMIN)*7/8
z4c	.equ	CZMIN+(CZMAX-CZMIN)*15/16
z5	.equ	CZMAX

init_t
	.word	4000	;TEMP!!!
	.word	x0,z0,  0,z0,  x1,z0
	.word	x0,z0a, 0,z0a, x1,z0a
	.word	x0,z0b, 0,z0b, x1,z0b
	.word	x0,z0c, 0,z0c, x1,z0c
	.word	x0,z1,  0,z1,  x1,z1
	.word	x0,z1a, 0,z1a, x1,z1a
	.word	x0,z1b, 0,z1b, x1,z1b
	.word	x0,z1c, 0,z1c, x1,z1c
	.word	x0,z2,  0,z2,  x1,z2
	.word	x0,z2a, 0,z2a, x1,z2a
	.word	x0,z2b, 0,z2b, x1,z2b
	.word	x0,z2c, 0,z2c, x1,z2c
	.word	x0,z3,  0,z3,  x1,z3
	.word	x0,z3a, 0,z3a, x1,z3a
	.word	x0,z3b, 0,z3b, x1,z3b
	.word	x0,z3c, 0,z3c, x1,z3c
	.word	x0,z4,  0,z4,  x1,z4
	.word	x0,z4a, 0,z4a, x1,z4a
	.word	x0,z4b, 0,z4b, x1,z4b
	.word	x0,z4c, 0,z4c, x1,z4c
	.word	x0,z5,  0,z5,  x1,z5
	.word	4000

color_t
	COLORW	0,0,0, 0,16,0, 0,31,0, 0,16,0

alignimg_t
	.word	1,1,0,0
	.long	0
	.word	01000H
	.long	test_p

test_p	.word	1, 0

	.endif

	.end