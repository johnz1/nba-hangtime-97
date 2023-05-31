;I'm not putting initials in plyrseq files! 
**************************************************************
*
* Owner:	TURMELL
*
* Software:		Shawn Liptak, Mark Turmell
* Initiated:		10/8/92
*
* Modified:		Shawn Liptak, 10/8/92	-Split from BB.asm
*
* COPYRIGHT (C) 1992 WILLIAMS ELECTRONICS GAMES, INC.
*
*.Last mod - 12/18/92 1:40
**************************************************************
	.file	"plyrseq.asm"
	.title	"basketball plyr sequence code"
	.width	132
	.option	b,d,l,t
	.mnolist


	.include	"mproc.equ"
	.include	"disp.equ"
	.include	"sys.equ"
	.include	"imgtbl.glo"
	.include	"imgtbl2.glo"
	.include	"game.equ"
	.include	"macros.hdr"
	.asg		1,SEQT
	.include	"plyr.equ"
	.include	"plyrseq.glo"
	.include	"plyrseq3.glo"
	.include	"behind.tbl"
	.include	"plyrdsp.tbl"
	.include	"plyrjsht.tbl"
	.include	"dunks.glo"
	.include	"world.equ"

;sounds external

	.ref	swipe_snd

;symbols externally defined

	.ref	plyr_pass,plyr_shoot
	.ref	seq_newdir
	.ref	seq_slamball
	.ref	seq_strtdunk
	.ref	seq_jump
	.ref	seq_jump2
	.ref	seq_resetseq
	.ref	seq_stand
	.ref	seq_stealstand
	.ref	seq_block,seq_push,seq_rebounda
	.ref	seq_run
	.ref	seq_snd
	.ref	clr_autorbnd

    .ref    PSTATUS2

	.ref	rndrng0
	.ref	seq_handle_fade_away,seq_handle_fadeaside
	.ref	fades_sp,fadeaway_sp,leans_bck_sp
	.ref	leans_sp,leans_in_sp,pull_jmpr_sp
	.ref	bslne_lnr_sp
	.ref	seq_goto_line
;symbols defined in this file

;	.def	w3run1
;	.def	w3desp1
;	.def	w1blok3,w2blok3,w4blok3,w5blok3
;	.def	w1blok2,w2blok2,w4blok2,w5blok2
;	.def	w5dst1

	.ref	w1jupa
	.ref	w2jupa
	.ref	w3jupa
	.ref	w4jupa
	.ref	w5jupa

;uninitialized ram definitions

;!!AM!! these are used in plyrseqa.asm so def here.
 	.def	  passc_t
 	.def	  fastpassnewoh_t
 	.def	  passdo2_t
 	.def	  undr_hoop_sht_tbl2
 	.def	  steal_t
 	.def	  shootdesp2_t
 	.def	  shootdesp3_t
 	.def	  fastpassc_t
 	.def	  passs_t
 	.def	  shootdesp_t
 	.def	  qshoot_t
 	.def	  undr_hoop_sht_tbl
 	.def	  passnewoh_t
 	.def	  passbh_t
 	.def	  passbh2_t
 	.def	  passdo_t
 	.def	  shoot_t

;!!AM!! these are in plyrseqa.asm and used here so we ref.
	.ref  	  stnd2_t
	.ref  	    fadeaside_seq1a
	.ref  	    fadein_seq2
	.ref  	    fadein_seq3
	.ref  	    fadein_seq4
	.ref  	    fadeaside_seq5a
	.ref  	    blockrej_t
	.ref  	    fadeaway_seq2
	.ref  	    fadeaway_seq3
	.ref  	    fadeaway_seq4
	.ref  	    stnddrib2_t
	.ref  	    rebounda_t
	.ref  	      RNDPER
	.ref  	      rebound_t
	.ref  	      nospear_t
	.ref  	      fastblockrej_t
	.ref  	      block_t
	.ref  	      stnddribdef_t
	.ref  	      fadeaside_seq1
	.ref  	      fadeaside_seq5
	.ref  	      stnddrib_t

;equates for this file

M_YF	.equ	08000H	;Y free (OFLAGS)

	.bss	keep_xvel,32
	.bss	keep_zvel,32
	
    .asg	M_WRNONZ,F
	.asg	M_WRNONZ|M_FLIPH,FF

#*
undr_hoop_sht_tbl	;(team 2)
;	.word	NOJUMP_M|NOJOY_M
	.word	NOJUMP_M|SHOOT_M|NOJOY_M
	.long	seq_stand
	.long	#uhsht_1,#uhsht_2,#uhsht_3,#uhsht_4,#uhsht_5,#uhsht_6,#uhsht_7,#uhsht_8
#uhsht_2
#uhsht_8
	WLW	2,w2js1,F
#uhsht_1a
	WLW	3,W1UNDR1,F
	WLW	3,W1UNDR2,F
	WL	-1,seq_jump
	WLL	-1,seq_snd,bslne_lnr_sp
	WL	-1,set_vels
	WLW	3,W1UNDR3,F
	WLW	3,W1UNDR4,F
	WLW	25,W1UNDR5,F
	WL	-1,plyr_shoot
	WLW	1,W1UNDR5,F
	WLW	3,W1UNDR6,F
	WLW	77,W1UNDR7,F
	WLW	3,W1UNDR8,F
	WLW	3,W1UNDR9,F
	WLW	-1,seq_newdir,0*16
	W0
#uhsht_1
	WLW	2,w1js1,F
	WLL	-1,seq_goto_line,#uhsht_1a
	W0

#uhsht_4
	WLW	2,w4js1,F
#uhsht_6
	WLW	3,W5UNDR1,F
	WLW	3,W5UNDR2,F
	WLW	3,W5UNDR3,F
	WL	-1,seq_jump
	WLL	-1,seq_snd,bslne_lnr_sp
	WL	-1,set_vels2
	WLW	3,W5UNDR4,F
	WLW	3,W5UNDR5,F
	WLW	26,W5UNDR6,F
	WL	-1,plyr_shoot
	WLW	2,W5UNDR7,F
	WLW	3,W5UNDR8,F
	WLW	77,W5UNDR9,F
	WLW	3,W5UNDR10,F
	WLW	3,W5UNDR11,F
	WLW	-1,seq_newdir,4*16
	W0
#uhsht_3
#uhsht_7
	WLW	2,w3js1,F

	WLW	3,W1UNDR1,F
	WLW	3,W1UNDR2,F
	WL	-1,seq_jump
	WLL	-1,seq_snd,bslne_lnr_sp
	WL	-1,set_vels3
	WLW	3,W1UNDR3,F
	WLW	3,W1UNDR4,F
	WLW	25,W1UNDR5,F
	WL	-1,plyr_shoot
	WLW	1,W1UNDR5,F
	WLW	3,W1UNDR6,F
	WLW	77,W1UNDR7,F
	WLW	3,W1UNDR8,F
	WLW	3,W1UNDR9,F
	WLW	-1,seq_newdir,0*16
	W0

#uhsht_5
	WLW	3,W5UNDR1,F
	WLW	3,W5UNDR2,F
	WLW	3,W5UNDR3,F
	WL	-1,seq_jump
	WLL	-1,seq_snd,bslne_lnr_sp
	WL	-1,set_vels2
	WLW	3,W5UNDR4,F
	WLW	3,W5UNDR5,F
	WLW	26,W5UNDR6,F
	WL	-1,plyr_shoot
	WLW	2,W5UNDR7,F
	WLW	3,W5UNDR8,F
	WLW	77,W5UNDR9,F
	WLW	3,W5UNDR10,F
	WLW	3,W5UNDR11,F
	WLW	-1,seq_newdir,4*16
	W0



#*
undr_hoop_sht_tbl2	;(team 1)
;	.word	NOJUMP_M|NOJOY_M
	.word	NOJUMP_M|SHOOT_M|NOJOY_M
	.long	seq_stand
	.long	#uhshta_1,#uhshta_2,#uhshta_3,#uhshta_4,#uhshta_5,#uhshta_6,#uhshta_7,#uhshta_8

#uhshta_1
	WLW	2,w1js1,FF
	WLL	-1,seq_goto_line,#uhshta_1a
#uhshta_2
	WLW	2,w2js1,FF
	WLL	-1,seq_goto_line,#uhshta_1a
#uhshta_8
	WLW	2,w2js1,F
	WLL	-1,seq_goto_line,#uhshta_8a
#uhshta_1a
	WLW	2,W1UNDR1,FF
	WLW	2,W1UNDR2,FF
	WL	-1,seq_jump
	WLL	-1,seq_snd,bslne_lnr_sp
	WL	-1,set_vels
	WLW	3,W1UNDR3,FF
	WLW	3,W1UNDR4,FF
	WLW	25,W1UNDR5,FF
	WL	-1,plyr_shoot
	WLW	1,W1UNDR5,FF
	WLW	3,W1UNDR6,FF
	WLW	77,W1UNDR7,FF
	WLW	3,W1UNDR8,FF
	WLW	3,W1UNDR9,FF
	WLW	-1,seq_newdir,0*16
	W0

#uhshta_3
#uhshta_7
	WLW	2,w3js1,F
#uhshta_8a
	WLW	2,W1UNDR1,F
	WLW	2,W1UNDR2,F
	WL	-1,seq_jump
	WLL	-1,seq_snd,bslne_lnr_sp
	WL	-1,set_vels3
	WLW	3,W1UNDR3,F
	WLW	3,W1UNDR4,F
	WLW	25,W1UNDR5,F
	WL	-1,plyr_shoot
	WLW	1,W1UNDR5,F
	WLW	3,W1UNDR6,F
	WLW	77,W1UNDR7,F
	WLW	3,W1UNDR8,F
	WLW	3,W1UNDR9,F
	WLW	-1,seq_newdir,0*16
	W0

#uhshta_5
	WLW	2,W5UNDR1,FF
	WLW	2,W5UNDR2,FF
	WLW	2,W5UNDR3,FF
	WL	-1,seq_jump
	WLL	-1,seq_snd,bslne_lnr_sp
	WL	-1,set_vels2
	WLW	3,W5UNDR4,FF
	WLW	3,W5UNDR5,FF
	WLW	26,W5UNDR6,FF
	WL	-1,plyr_shoot
	WLW	2,W5UNDR7,FF
	WLW	3,W5UNDR8,FF
	WLW	77,W5UNDR9,FF
	WLW	3,W5UNDR10,FF
	WLW	3,W5UNDR11,FF
	WLW	-1,seq_newdir,4*16
	W0

#uhshta_4
	WLW	2,w4js1,F
#uhshta_6
	WLW	2,W5UNDR1,F
	WLW	2,W5UNDR2,F
	WLW	2,W5UNDR3,F
	WL	-1,seq_jump
	WLL	-1,seq_snd,bslne_lnr_sp
	WL	-1,set_vels2
	WLW	3,W5UNDR4,F
	WLW	3,W5UNDR5,F
	WLW	26,W5UNDR6,F
	WL	-1,plyr_shoot
	WLW	2,W5UNDR7,F
	WLW	3,W5UNDR8,F
	WLW	77,W5UNDR9,F
	WLW	3,W5UNDR10,F
	WLW	3,W5UNDR11,F
	WLW	-1,seq_newdir,4*16
	W0



set_vels
	movi	00f000h,a14
	move	*a13(plyr_num),a0
	srl	1,a0
	jrnz	sxv_1			;br=team 2
	movi	-00f000h,a14
sxv_1	move	a14,*a8(OXVEL),L

	movi	013000h,a14
	move	a14,*a8(OZVEL),L
	rets


set_vels2
	movi	00f000h,a14
	move	*a13(plyr_num),a0
	srl	1,a0
	jrnz	sxv2_1			;br=team 2
	movi	-00f000h,a14
sxv2_1	move	a14,*a8(OXVEL),L

	movi	-00f000h,a14
	move	a14,*a8(OZVEL),L
	rets


set_vels3
	movi	006000h,a14
	move	*a13(plyr_num),a0
	srl	1,a0
	jrnz	sxv3_1			;br=team 2
	movi	-006000h,a14
sxv3_1	move	a14,*a8(OXVEL),L

	movi	025000h,a14
	move	a14,*a8(OZVEL),L
	rets


#*
shoot_t
	.word	NOJUMP_M|SHOOT_M|NOJOY_M
	.long	seq_stand
	.long	#shoot_t1,#shoot_t2,#shoot_t3,#shoot_t4,#shoot_t5,#shoot_t4,#shoot_t3,#shoot_t2

	.asg	3,N
#shoot_t1
	WLW	N,w1js1,F
	WLLL	-1,seq_handle_fadeaside,fadeaside_seq1,fadeaside_seq1a
	WLW	N,w1js2,F
	WLW	1,w1js3,F
	WL	-1,seq_jump
	WLW	2,w1js3,F
	WLW	77,w1js4,F
	WLW	3,w1js5,F
	WLW	3,w1js6,F
	WLW	77,w1js7,F
	WLW	4,w1js8,F
	WLW	4,w1js9,F
	WLW	4,w1js10,F
	W0
#shoot_t2
	WLW	N,w2js1,F
	WLW	N,w2js2,F
	WLLL	-1,seq_handle_fade_away,fadeaway_seq2,fadein_seq2
	WLW	1,w2js3,F
	WL	-1,seq_jump
	WLW	2,w2js3,F
	WLW	77,w2js4,F
	WLW	3,w2js5,F
	WLW	3,w2js6,F
	WLW	77,w2js7,F
	WLW	4,w2js8,F
	WLW	4,w2js9,F
	WLW	4,w2js10,F
	W0
#shoot_t3
	WLW	N,w3js1,F
	WLW	N,w3js2,F
	WLLL	-1,seq_handle_fade_away,fadeaway_seq3,fadein_seq3
	WLW	1,w3js3,F
	WL	-1,seq_jump
	WLW	2,w3js3,F
	WLW	77,w3js4,F
	WLW	3,w3js5,F
	WLW	3,w3js6,F
	WLW	3,w3js7,F
	WLW	77,w3js8,F
	WLW	4,w3js9,F
	WLW	4,w3js10,F
	W0
#shoot_t4
	WLW	N,w4js1,F
	WLW	N,w4js2,F
	WLLL	-1,seq_handle_fade_away,fadeaway_seq4,fadein_seq4
	WLW	1,w4js3,F
	WL	-1,seq_jump
	WLW	2,w4js3,F
	WLW	77,w4js4,F
	WLW	3,w4js5,F
	WLW	3,w4js6,F
	WLW	77,w4js7,F
	WLW	4,w4js8,F
	WLW	4,w4js9,F
	WLW	4,w4js10,F
	W0
#shoot_t5
	WLW	N,w5js1,F
	WLLL	-1,seq_handle_fadeaside,fadeaside_seq5,fadeaside_seq5a
	WLW	N,w5js2,F
	WLW	1,w5js3,F
	WL	-1,seq_jump
	WLW	2,w5js3,F
	WLW	77,w5js4,F
	WLW	3,w5js5,F
	WLW	3,w5js6,F
	WLW	3,w5js7,F
	WLW	77,w5js8,F
	WLW	4,w5js9,F
	WLW	4,w5js10,F
	W0

#*
qshoot_t
	.word	NOJUMP_M|SHOOT_M|NOJOY_M
	.long	seq_stand
	.long	#qshoot_t1,#qshoot_t2,#qshoot_t3,#qshoot_t4,#qshoot_t5,#qshoot_t4,#qshoot_t3,#qshoot_t2

	.asg	3,N
#qshoot_t1
	WLW	N,w1js1,F
	WLW	N,w1js2,F
	WLW	N,w1js3,F
	WL	-1,seq_jump2
	WLW	77,w1js4,F
	WLW	N,w1js5,F
	WLW	N,w1js6,F
	WLW	77,w1js7,F
	WLW	4,w1js8,F
	WLW	3,w1js9,F
	WLW	3,w1js10,F
	W0
#qshoot_t2
	WLW	N,w2js1,F
	WLW	N,w2js2,F
	WLW	N,w2js3,F
	WL	-1,seq_jump2
	WLW	77,w2js4,F
	WLW	3,w2js5,F
	WLW	3,w2js6,F
	WLW	77,w2js7,F
	WLW	3,w2js8,F
	WLW	3,w2js9,F
	WLW	3,w2js10,F
	W0
#qshoot_t3
	WLW	N,w3js1,F
	WLW	N,w3js2,F
	WLW	N,w3js3,F
	WL	-1,seq_jump2
	WLW	77,w3js4,F
	WLW	3,w3js5,F
	WLW	3,w3js6,F
	WLW	3,w3js7,F
	WLW	77,w3js8,F
	WLW	3,w3js9,F
	WLW	3,w3js10,F
	W0
#qshoot_t4
	WLW	N,w4js1,F
	WLW	N,w4js2,F
	WLW	N,w4js3,F
	WL	-1,seq_jump2
	WLW	77,w4js4,F
	WLW	3,w4js5,F
	WLW	3,w4js6,F
	WLW	77,w4js7,F
	WLW	3,w4js8,F
	WLW	3,w4js9,F
	WLW	3,w4js10,F
	W0
#qshoot_t5
	WLW	N,w5js1,F
	WLW	N,w5js2,F
	WLW	N,w5js3,F
	WL	-1,seq_jump2
	WLW	77,w5js4,F
	WLW	3,w5js5,F
	WLW	3,w5js6,F
	WLW	3,w5js7,F
	WLW	77,w5js8,F
	WLW	3,w5js9,F
	WLW	3,w5js10,F
	W0

#*
;Hold and shoot desperations
shootdesp_t
	.word	NOJUMP_M|SHOOT_M|NOJOY_M
	.long	seq_stand
	.long	#shootdesp_t1,#shootdesp_t2,#shootdesp_t3,#shootdesp_t4,#shootdesp_t5,#shootdesp_t4,#shootdesp_t3,#shootdesp_t2

#shootdesp_t1
#shootdesp_t2
#shootdesp_t3
#shootdesp_t4
#shootdesp_t5
;Use this as a pass also!
	WLW	3,T4DESPA1,F
	WLL	-1,seq_snd,swipe_snd
	WLW	3,T4DESPA2,F
	WL	-1,seq_jump
	WL	-1,#lower_jumpa
	WLW	3,T4DESPA3,F
	WLW	3,T4DESPA4,F
	WLW	1,T4DESPA5,F
	WL	-1,plyr_shoot
	WLW	2,T4DESPA5,F
	WLW	50,T4DESPA6,F
	WLW	3,T4DESPA7,F
	WLW	3,T4DESPA8,F
;Never see these frames
;	WLW	4,T4DESPA9,F
;	WLW	4,T4DESPA10,F
	W0

#lower_jumpa
	move	*a8(OYVEL),a0,L
	sra	1,a0
	move	a0,*a8(OYVEL),L

	jruc	lower_jumpa


#*
shootdesp3_t
	.word	NOJUMP_M|SHOOT_M|NOJOY_M
	.long	seq_stand
	.long	#shootdesp3_t1,#shootdesp3_t2,#shootdesp3_t3,#shootdesp3_t4,#shootdesp3_t5,#shootdesp3_t4,#shootdesp3_t3,#shootdesp3_t2
#shootdesp3_t1
#shootdesp3_t2
#shootdesp3_t3
#shootdesp3_t4
#shootdesp3_t5
	WLW	4,T3DESPB1,F
	WLW	4,T3DESPB2,F
	WL	-1,seq_jump
	WL	-1,lower_jump
	WLW	50,T3DESPB3,F
	WLW	3,T3DESPB4,F
	WLW	3,T3DESPB5,F
	WLW	50,T3DESPB6,F
	WLW	3,T3DESPB7,F
	WLW	3,T3DESPB8,F
;Never see these frames
;	WLW	4,T3DESPB9,F
;	WLW	4,T3DESPB10,F
	W0


lower_jump
;	move	*a8(OYVEL),a0,L
;	sra	1,a0
;	move	a0,*a8(OYVEL),L

;Give seq a little x drift
	movi	010000H,a2		;For this desperation shot, we
	move	*a13(plyr_num),a0	;need some x velocity
	subk	2,a0
	jrlt	ok
	movi	-010000H,a2
#ok	move	a2,*a8(OXVEL),L
	rets
	

#*
;Grenade launch - last second shot
shootdesp2_t
	.word	NOJUMP_M|SHOOT_M|NOJOY_M
	.long	seq_stand
	.long	#sd2_t3,#sd2_t3,#sd2_t3,#sd2_t3,#sd2_t3,#sd2_t3,#sd2_t3,#sd2_t3
#sd2_t3
	WLW	2,T3DESPA1,F
	WLL	-1,seq_snd,swipe_snd
	WLW	2,T3DESPA2,F
	WLW	2,T3DESPA3,F
	WLW	2,T3DESPA4,F
	WL	-1,seq_jump
	WLW	2,T3DESPA5,F
	WLW	2,T3DESPA6,F
	WL	-1,plyr_shoot
	WLW	66,T3DESPA7,F
;Never see these frames
;	WLW	4,T3DESPA8,F
;	WLW	4,T3DESPA9,F
;	WLW	4,T3DESPA10,F
	W0

#*
;shootdesp3_t
;	.word	NOJUMP_M|SHOOT_M|NOJOY_M
;	.long	seq_stand
;	.long	#3,#3,#3,#3,#3,#3,#3,#3
;#3
;	WLW	4,T2DESP1,F
;	WLW	4,T2DESP2,F
;	WL	-1,seq_jump
;	WLW	12h,T2DESP3,F
;	WLW	62h,T2DESP4,F
;	WLW	28,T2DESP5,F
;	WLW	4,T2DESP6,F
;	W0


#*	;(chest pass)
passc_t		
	.word	PASS_M|NOJOY_M
	.long	seq_stand
	.long	#passc1_l,#passc2_l,#passc3_l,#passc4_l
	.long	#passc5_l,#passc4_l,#passc3_l,#passc2_l
	.asg	3,N
#passc1_l
	WLW	N,w1cp1,F
	WLW	N,w1cp2,F
	WLW	N,w1cp3,F
	WLW	N,w1cp4,F
	WL	-1,plyr_pass
	WLW	N,w1cp5,F
	WLW	N,w1cp6,F
	WLW	N,w1cp5,F
	WLW	N,w1cp4,F
	WLW	N,w1cp3,F
	WLW	N,w1cp2,F
	WLW	N,w1cp1,F
	W0
#passc2_l
	WLW	N,w2cp1,F
	WLW	N,w2cp2,F
	WLW	N,w2cp3,F
	WLW	N,w2cp4,F
	WL	-1,plyr_pass
	WLW	N,w2cp5,F
	WLW	N,w2cp6,F
	WLW	N,w2cp5,F
	WLW	N,w2cp4,F
	WLW	N,w2cp3,F
	WLW	N,w2cp2,F
	WLW	N,w2cp1,F
	W0
#passc3_l
	WLW	N,w3cp1,F
	WLW	N,w3cp2,F
	WLW	N,w3cp3,F
	WLW	N,w3cp4,F
	WL	-1,plyr_pass
	WLW	N,w3cp5,F
	WLW	N,w3cp6,F
	WLW	N,w3cp5,F
	WLW	N,w3cp4,F
	WLW	N,w3cp3,F
	WLW	N,w3cp2,F
	WLW	N,w3cp1,F
	W0
#passc4_l
	WLW	N,w4cp1,F
	WLW	N,w4cp2,F
	WLW	N,w4cp3,F
	WLW	N,w4cp4,F
	WL	-1,plyr_pass
	WLW	N,w4cp5,F
	WLW	N,w4cp6,F
	WLW	N,w4cp5,F
	WLW	N,w4cp4,F
	WLW	N,w4cp3,F
	WLW	N,w4cp2,F
	WLW	N,w4cp1,F
	W0
#passc5_l
	WLW	N,w5cp1,F
	WLW	N,w5cp2,F
	WLW	N,w5cp3,F
	WLW	N,w5cp4,F
	WL	-1,plyr_pass
	WLW	N,w5cp5,F
	WLW	N,w5cp6,F
	WLW	N,w5cp5,F
	WLW	N,w5cp4,F
	WLW	N,w5cp3,F
	WLW	N,w5cp2,F
	WLW	N,w5cp1,F
	W0

#*	;(fast, chest pass)
fastpassc_t
	.word	PASS_M|NOJOY_M
	.long	seq_stand
	.long	#ps1a_l,#ps2a_l,#ps3a_l,#ps4a_l
	.long	#ps5a_l,#ps4a_l,#ps3a_l,#ps2a_l
	.asg	2,N
#ps1a_l
	WLW	N,w1cp1,F
	WLW	N,w1cp2,F
	WLW	N,w1cp3,F
	WLW	N,w1cp4,F
	WL	-1,plyr_pass
	WLW	N,w1cp5,F
	WLW	N,w1cp6,F
	WLW	N,w1cp5,F
	WLW	N,w1cp4,F
	WLW	N,w1cp3,F
	WLW	N,w1cp2,F
	WLW	N,w1cp1,F
	W0
#ps2a_l
	WLW	N,w2cp1,F
	WLW	N,w2cp2,F
	WLW	N,w2cp3,F
	WLW	N,w2cp4,F
	WL	-1,plyr_pass
	WLW	N,w2cp5,F
	WLW	N,w2cp6,F
	WLW	N,w2cp5,F
	WLW	N,w2cp4,F
	WLW	N,w2cp3,F
	WLW	N,w2cp2,F
	WLW	N,w2cp1,F
	W0
#ps3a_l
	WLW	N,w3cp1,F
	WLW	N,w3cp2,F
	WLW	N,w3cp3,F
	WLW	N,w3cp4,F
	WL	-1,plyr_pass
	WLW	N,w3cp5,F
	WLW	N,w3cp6,F
	WLW	N,w3cp5,F
	WLW	N,w3cp4,F
	WLW	N,w3cp3,F
	WLW	N,w3cp2,F
	WLW	N,w3cp1,F
	W0
#ps4a_l
	WLW	N,w4cp1,F
	WLW	N,w4cp2,F
	WLW	N,w4cp3,F
	WLW	N,w4cp4,F
	WL	-1,plyr_pass
	WLW	N,w4cp5,F
	WLW	N,w4cp6,F
	WLW	N,w4cp5,F
	WLW	N,w4cp4,F
	WLW	N,w4cp3,F
	WLW	N,w4cp2,F
	WLW	N,w4cp1,F
	W0
#ps5a_l
	WLW	N,w5cp1,F
	WLW	N,w5cp2,F
	WLW	N,w5cp3,F
	WLW	N,w5cp4,F
	WL	-1,plyr_pass
	WLW	N,w5cp5,F
	WLW	N,w5cp6,F
	WLW	N,w5cp5,F
	WLW	N,w5cp4,F
	WLW	N,w5cp3,F
	WLW	N,w5cp2,F
	WLW	N,w5cp1,F
	W0


#*	;(dish out, of dunk, or rebound!)
passdo_t
	.word	PASS_M|NOJUMP_M|NOJOY_M
	.long	seq_stand
	.long	#pd1_l,#pd2_l,#pd3_l,#pd4_l
	.long	#pd5_l,#pd4_l,#pd3_l,#pd2_l

#pd1_l
	WL	-1,dble_yvel
	WLW	1,w1jupa,F
	WL	-1,plyr_pass
	WLW	4,w1jupa,F
	WLW	77,w1js4,F
	WLW	4,w1js2,F
	WLW	3,w1js1,F
	W0
#pd2_l
	WL	-1,dble_yvel
	WLW	1,w2jupa,F
	WL	-1,plyr_pass
	WLW	4,w2jupa,F
	WLW	77,w2js4,F
	WLW	3,w2js3,F
	WLW	3,w2js2,F
	WLW	2,w2js1,F
	W0
#pd3_l
	WL	-1,dble_yvel
	WLW	1,w3jupa,F
	WL	-1,plyr_pass
	WLW	4,w3jupa,F
	WLW	77,w3js5,F
	WLW	3,w3js4,F
	WLW	3,w3js3,F
	WLW	3,w3js2,F
	WLW	2,w3js1,F
	W0
#pd4_l
	WL	-1,dble_yvel
	WLW	1,w4jupa,F
	WL	-1,plyr_pass
	WLW	4,w4jupa,F
	WLW	77,w4js5,F
	WLW	3,w4js4,F
	WLW	3,w4js3,F
	WLW	3,w4js2,F
	WLW	2,w4js1,F
	W0
#pd5_l
	WL	-1,dble_yvel
	WLW	1,w5jupa,F
	WL	-1,plyr_pass
	WLW	4,w5jupa,F
	WLW	77,w5js4,F
	WLW	3,w5js3,F
	WLW	3,w5js2,F
	WLW	2,w5js1,F
	W0

passdo2_t
	.word	PASS_M|NOJUMP_M|NOJOY_M
	.long	seq_stand
	.long	#pd21_l,#pd22_l,#pd23_l,#pd24_l
	.long	#pd25_l,#pd24_l,#pd23_l,#pd22_l

#pd21_l
	WL	-1,dble_yvel
	WLW	1,w1js4,F
	WL	-1,plyr_pass
	WLW	77,w1js4,F
	WLW	4,w1js2,F
	WLW	3,w1js1,F
	W0
#pd22_l
	WL	-1,dble_yvel
	WLW	1,w2js4,F
	WL	-1,plyr_pass
	WLW	77,w2js4,F
	WLW	3,w2js3,F
	WLW	3,w2js2,F
	WLW	2,w2js1,F
	W0
#pd23_l
	WL	-1,dble_yvel
	WLW	1,w3js5,F
	WL	-1,plyr_pass
	WLW	77,w3js5,F
	WLW	3,w3js4,F
	WLW	3,w3js3,F
	WLW	3,w3js2,F
	WLW	2,w3js1,F
	W0
#pd24_l
	WL	-1,dble_yvel
	WLW	1,w4js5,F
	WL	-1,plyr_pass
	WLW	77,w4js5,F
	WLW	3,w4js4,F
	WLW	3,w4js3,F
	WLW	3,w4js2,F
	WLW	2,w4js1,F
	W0
#pd25_l
	WL	-1,dble_yvel
	WLW	1,w5js4,F
	WL	-1,plyr_pass
	WLW	77,w5js4,F
	WLW	3,w5js3,F
	WLW	3,w5js2,F
	WLW	2,w5js1,F
	W0


dble_yvel
	move	*a8(OYVEL),a14,L
	jrz	ex
	addi	30000h,a14
	move	a14,*a8(OYVEL),L
	rets
#ex
;	LOCKUP
;	nop
	rets


#*     ;(short, chest pass)
passs_t
	.word	PASS_M|NOJOY_M
	.long	seq_stand
	.long	#passs1,#passs2,#passs3,#passs4,#passs5,#passs4,#passs3,#passs2
	.asg	2,N
#passs1
	WLW	N,w1cp1,F
	WLW	N,w1cp2,F
	WLW	N,w1cp3,F
	WLW	N,w1cp4,F
	WL	-1,plyr_pass
;	WLW	N,w1cp5,F
	WLW	N,w1cp4,F
	WLW	N,w1cp3,F
	WLW	N,w1cp2,F
	WLW	N,w1cp1,F
	W0
#passs2
	WLW	N,w2cp1,F
	WLW	N,w2cp2,F
	WLW	N,w2cp3,F
	WLW	N,w2cp4,F
	WL	-1,plyr_pass
;	WLW	N,w2cp5,F
	WLW	N,w2cp4,F
	WLW	N,w2cp3,F
	WLW	N,w2cp2,F
	WLW	N,w2cp1,F
	W0
#passs3
	WLW	N,w3cp1,F
	WLW	N,w3cp2,F
	WLW	N,w3cp3,F
	WLW	N,w3cp4,F
	WL	-1,plyr_pass
;	WLW	N,w3cp5,F
	WLW	N,w3cp4,F
	WLW	N,w3cp3,F
	WLW	N,w3cp2,F
	WLW	N,w3cp1,F
	W0
#passs4
	WLW	N,w4cp1,F
	WLW	N,w4cp2,F
	WLW	N,w4cp3,F
	WLW	N,w4cp4,F
	WL	-1,plyr_pass
;	WLW	N,w4cp5,F
	WLW	N,w4cp4,F
	WLW	N,w4cp3,F
	WLW	N,w4cp2,F
	WLW	N,w4cp1,F
	W0
#passs5
	WLW	N,w5cp1,F
	WLW	N,w5cp2,F
	WLW	N,w5cp3,F
	WLW	N,w5cp4,F
	WL	-1,plyr_pass
;	WLW	N,w5cp5,F
	WLW	N,w5cp4,F
	WLW	N,w5cp3,F
	WLW	N,w5cp2,F
	WLW	N,w5cp1,F
	W0


#*	;(overhead pass)
passnewoh_t
	.word	PASS_M|NOJOY_M
	.long	seq_stand
	.long	#pn1a_l,#pn2a_l,#pn3a_l,#pn4a_l
	.long	#pn5a_l,#pn4a_l,#pn3a_l,#pn2a_l

	.asg	3,N
#pn1a_l
	WLW	N,w1ohp1,F
	WLW	N,w1ohp2,F
	WLW	N,w1ohp3,F
	WLW	N,w1ohp4,F
	WLW	N,w1ohp5,F
	WLW	N,w1ohp6,F
	WLW	N-2,w1ohp7,F
	WL	-1,plyr_pass
	WLW	N-1,w1ohp7,F
	WLW	N,w1ohp8,F
	WLW	N,w1ohp9,F
	WLW	N,w1ohp10,F
	WLW	N,w1ohp11,F
	W0
#pn2a_l
	WLW	N,w2ohp1,F
	WLW	N,w2ohp2,F
	WLW	N,w2ohp3,F
	WLW	N,w2ohp4,F
	WLW	N,w2ohp5,F
	WLW	N-1,w2ohp6,F
	WL	-1,plyr_pass
	WLW	N-1,w2ohp7,F
	WLW	N,w2ohp8,F
	WLW	N,w2ohp9,F
	WLW	N,w2ohp10,F
	WLW	N,w2ohp11,F
	W0
#pn3a_l
;If passer is facing #4 or #5 and we are doing a #3 pass, sometimes use
;desperation art as a pass!
	WL	-1,choose_desp

	WLW	N,w3ohp1,F
	WLW	N,w3ohp2,F
	WLW	N,w3ohp3,F
	WLW	N,w3ohp4,F
	WLW	N,w3ohp5,F
	WLW	N-1,w3ohp6,F
	WL	-1,plyr_pass
	WLW	1,w3ohp6,F
	WLW	N,w3ohp7,F
	WLW	N,w3ohp8,F
	WLW	N,w3ohp9,F
	WLW	N,w3ohp10,F
	WLW	N,w3ohp11,F
	W0

choose_desp
	move	*a13(plyr_tmdist),a14
	cmpi	180,a14
	jrlt	not
	movi	600,a0
	calla	RNDPER
	jrls	#not
;Need to look at dir I was facing - not where pass code tells me to face.
	move	*a13(plyr_old_seqdir),a0
	cmpi	3,a0
	jrz	yes
	cmpi	4,a0
	jrz	yes
	cmpi	5,a0
	jrnz	not

#yes
	movi	#desp_pass,b4
#not
	rets
	.def	T4DESPA5

#desp_pass
	WLW	3,T4DESPA1,F
	WLW	3,T4DESPA2,F
	WLW	3,T4DESPA3,F
	WLW	3,T4DESPA4,F
	WLW	1,T4DESPA5,F
	WL	-1,plyr_pass
	WLW	2,T4DESPA5,F
	WLW	50,T4DESPA6,F
	WLW	3,T4DESPA7,F
	WLW	3,T4DESPA8,F
;Never see these frames
;	WLW	4,T4DESPA9,F
;	WLW	4,T4DESPA10,F
	WLW	-1,seq_newdir,2*16
	W0




#pn4a_l
	WLW	N,w4ohp1,F
	WLW	N,w4ohp2,F
	WLW	N,w4ohp3,F
	WLW	N,w4ohp4,F
	WLW	N,w4ohp5,F
	WLW	N,w4ohp6,F
	WLW	N-1,w4ohp7,F
	WL	-1,plyr_pass
	WLW	1,w4ohp7,F
	WLW	N,w4ohp8,F
	WLW	N,w4ohp9,F
	WLW	N,w4ohp10,F
	WLW	N,w4ohp11,F
	W0
#pn5a_l
	WLW	N,w5ohp1,F
	WLW	N,w5ohp2,F
	WLW	N,w5ohp3,F
	WLW	N,w5ohp4,F
	WLW	N,w5ohp5,F
	WLW	N,w5ohp6,F
	WLW	N-2,w5ohp7,F
	WL	-1,plyr_pass
	WLW	N-1,w5ohp7,F
	WLW	N,w5ohp8,F
	WLW	N,w5ohp9,F
	WLW	N,w5ohp10,F
	WLW	N,w5ohp11,F
	W0


#*	;(fast, overhead pass)
fastpassnewoh_t
	.word	PASS_M|NOJOY_M
	.long	seq_stand
	.long	#fpn_1_l,#fpn_2_l,#fpn_3_l,#fpn_4_l
	.long	#fpn_5_l,#fpn_4_l,#fpn_3_l,#fpn_2_l

	.asg	2,N
#fpn_1_l
	WLW	N,w1ohp1,F
	WLW	N,w1ohp2,F
	WLW	N,w1ohp3,F
	WLW	N,w1ohp4,F
	WLW	N,w1ohp5,F
	WLW	N,w1ohp6,F
	WLW	1,w1ohp7,F
	WL	-1,plyr_pass
	WLW	1,w1ohp7,F
	WLW	N,w1ohp8,F
	WLW	N,w1ohp9,F
	WLW	N,w1ohp10,F
	WLW	N,w1ohp11,F
	W0
#fpn_2_l
	WLW	N,w2ohp1,F
	WLW	N,w2ohp2,F
	WLW	N,w2ohp3,F
	WLW	N,w2ohp4,F
	WLW	N,w2ohp5,F
	WLW	1,w2ohp6,F
	WL	-1,plyr_pass
	WLW	1,w2ohp6,F
	WLW	N,w2ohp7,F
	WLW	N,w2ohp8,F
	WLW	N,w2ohp9,F
	WLW	N,w2ohp10,F
	WLW	N,w2ohp11,F
	W0
#fpn_3_l
	WL	-1,choose_desp

	WLW	N,w3ohp1,F
	WLW	N,w3ohp2,F
	WLW	N,w3ohp3,F
	WLW	N,w3ohp4,F
	WLW	N,w3ohp5,F
	WLW	1,w3ohp6,F
	WL	-1,plyr_pass
	WLW	1,w3ohp6,F
	WLW	N,w3ohp7,F
	WLW	N,w3ohp8,F
	WLW	N,w3ohp9,F
	WLW	N,w3ohp10,F
	WLW	N,w3ohp11,F
	W0
#fpn_4_l
	WLW	N,w4ohp1,F
	WLW	N,w4ohp2,F
	WLW	N,w4ohp3,F
	WLW	N,w4ohp4,F
	WLW	N,w4ohp5,F
	WLW	N,w4ohp6,F
	WLW	1,w4ohp7,F
	WL	-1,plyr_pass
	WLW	1,w4ohp7,F
	WLW	N,w4ohp8,F
	WLW	N,w4ohp9,F
	WLW	N,w4ohp10,F
	WLW	N,w4ohp11,F
	W0
#fpn_5_l
	WLW	N,w5ohp1,F
	WLW	N,w5ohp2,F
	WLW	N,w5ohp3,F
	WLW	N,w5ohp4,F
	WLW	N,w5ohp5,F
	WLW	N,w5ohp6,F
	WLW	1,w5ohp7,F
	WL	-1,plyr_pass
	WLW	1,w5ohp7,F
	WLW	N,w5ohp8,F
	WLW	N,w5ohp9,F
	WLW	N,w5ohp10,F
	WLW	N,w5ohp11,F
	W0



#*
passbh_t
	.word	PASS_M|NOJOY_M
	.long	seq_stand
	.long	#passbh1,#passbh1,#passbh1,#passbh1,#passbh1,#passbh1,#passbh1,#passbh1

	.asg	3,N
#passbh1
	WL	-1,#choosea
#passbh1a
	WLW	N,T1HINDR10,F
	WLW	N,T1HINDR9,F
	WLW	N-1,T1HINDR8,F
	WLW	N-1,T1HINDR7,F
	WL	-1,plyr_pass
	WLW	N+1,T1HINDR6,F
	WLW	N,T1HINDR7,F
	WLW	N,T1HINDR8,F
	WLW	N,T1HINDR9,F
	WLW	N,T1HINDR10,F
	WLW	-1,seq_newdir,0*16
	W0

#choosea
;Need to look at dir I was facing - not where pass code tells me to face.
	move	*a13(plyr_old_seqdir),a0
	sll	5,a0
	addi	#tblchoose,a0
	move	*a0,a0,L
	move	a0,b4
	rets

#tblchoose
   	.long	#passbh1a,#passbh2,#passbh3,#passbh4,#passbh5,#passbh6,#passbh7,#passbh8


#passbh2
#passbh8
	WLW	N,T2HINDR10,F
	WLW	N,T2HINDR9,F
	WLW	N-1,T2HINDR8,F
	WLW	N-1,T2HINDR7,F
	WL	-1,plyr_pass
	WLW	N+1,T2HINDR6,F
	WLW	N,T2HINDR7,F
	WLW	N,T2HINDR8,F
	WLW	N,T2HINDR9,F
	WLW	N,T2HINDR10,F
	WLW	-1,seq_newdir,1*16
	W0

#passbh3
#passbh7
	WLW	N,T3HINDR10,F
	WLW	N,T3HINDR9,F
	WLW	N-1,T3HINDR8,F
	WLW	N-1,T3HINDR7,F
	WL	-1,plyr_pass
	WLW	N+1,T3HINDR6,F
	WLW	N,T3HINDR7,F
	WLW	N,T3HINDR8,F
	WLW	N,T3HINDR9,F
	WLW	N,T3HINDR10,F
	WLW	-1,seq_newdir,2*16
	W0
#passbh4
#passbh5
#passbh6
	WLW	N,T4HINDR10,F
	WLW	N,T4HINDR9,F
	WLW	N-1,T4HINDR8,F
	WLW	N-1,T4HINDR7,F
	WL	-1,plyr_pass
	WLW	N+1,T4HINDR6,F
	WLW	N,T4HINDR7,F
	WLW	N,T4HINDR8,F
	WLW	N,T4HINDR9,F
	WLW	N,T4HINDR10,F
	WLW	-1,seq_newdir,3*16
	W0

#*
passbh2_t
	.word	PASS_M|NOJOY_M
	.long	seq_stand
	.long	#passbh2_1,#passbh2_1,#passbh2_1,#passbh2_1,#passbh2_1,#passbh2_1,#passbh2_1,#passbh2_1

	.asg	3,N
#chooseb
;Need to look at dir I was facing - not where pass code tells me to face.
	move	*a13(plyr_old_seqdir),a0
	sll	5,a0
	addi	#tblpassbh2,a0
	move	*a0,a0,L
	move	a0,b4
	rets

#tblpassbh2	.long	#passbh2_1a,#passbh2_2,#passbh2_3,#passbh2_4,#passbh2_5,#passbh2_6,#passbh2_7,#passbh2_8

#passbh2_1
	WL	-1,#chooseb
#passbh2_1a
;Should never get here...

#passbh2_8
#passbh2_2
	WLW	N,T2HINDL10,F
	WLW	N,T2HINDL9,F
	WLW	N-1,T2HINDL8,F
	WLW	N-1,T2HINDL7,F
	WL	-1,plyr_pass
	WLW	N+1,T2HINDL6,F
	WLW	N,T2HINDL7,F
	WLW	N,T2HINDL8,F
	WLW	N,T2HINDL9,F
	WLW	N,T2HINDL10,F
	WLW	-1,seq_newdir,1*16
	W0

#passbh2_3
#passbh2_7
	WLW	N,T3HINDL10,F
	WLW	N,T3HINDL9,F
	WLW	N-1,T3HINDL8,F
	WLW	N-1,T3HINDL7,F
	WL	-1,plyr_pass
	WLW	N+1,T3HINDL6,F
	WLW	N,T3HINDL7,F
	WLW	N,T3HINDL8,F
	WLW	N,T3HINDL9,F
	WLW	N,T3HINDL10,F
	WLW	-1,seq_newdir,2*16
	W0
#passbh2_4
	WLW	N,T4HINDL10,F
	WLW	N,T4HINDL9,F
	WLW	N-1,T4HINDL8,F
	WLW	N-1,T4HINDL7,F
	WL	-1,plyr_pass
	WLW	N+1,T4HINDL6,F
	WLW	N,T4HINDL7,F
	WLW	N,T4HINDL8,F
	WLW	N,T4HINDL9,F
	WLW	N,T4HINDL10,F
	WLW	-1,seq_newdir,3*16
	W0
#passbh2_5
#passbh2_6
;Is this seq used?
	WLW	N,T4HINDR10,F
	WLW	N,T4HINDR9,F
	WLW	N-1,T4HINDR8,F
	WLW	N-1,T4HINDR7,F
	WL	-1,plyr_pass
	WLW	N+1,T4HINDR6,F
	WLW	N,T4HINDR7,F
	WLW	N,T4HINDR8,F
	WLW	N,T4HINDR9,F
	WLW	N,T4HINDR10,F
	WLW	-1,seq_newdir,3*16
	W0


#*
steal_t
	.word	NOMV_M|NOSTEAL_M|NOJUMP_M|NOJOY_M
	.long	seq_stealstand
	.long	#steal_1,#steal_2,#steal_3,#steal_4,#steal_5,#steal_4,#steal_3,#steal_2
#steal_1
	WLW	1,T1SWPE5,F
	WLL	-1,seq_snd,swipe_snd
	WLW	1,T1SWPE6,F
	WLW	1,T1SWPE7,F
	WLW	1,T1SWPE8,F
	WLW	1,T1SWPE9,F
	WLW	1,T1SWPE10,F
	WLW	1,T1SWPE11,F
	WLW	1,T1SWPE12,F
	WL	-1,seq_stealstand
	WLW	1,T1SWPE11,F
	WLW	1,T1SWPE10,F
	WLL	-1,seq_snd,swipe_snd
	WLW	1,T1SWPE9,F
	WLW	1,T1SWPE8,F
	WLW	1,T1SWPE7,F
	WLW	1,T1SWPE6,F
	WLW	1,T1SWPE5,F
	WL	-1,seq_stealstand
	WLW	1,T1SWPE4,F
	WLW	1,T1SWPE3,F
	WLW	1,T1SWPE2,F
	WLW	1,T1SWPE1,F
	WLW	1,T1SWPE2,F
	WLW	1,T1SWPE3,F
	WLW	1,T1SWPE4,F
	W0
#steal_2
	WLW	1,T2SWPE3,F
	WLL	-1,seq_snd,swipe_snd
	WLW	1,T2SWPE4,F
	WLW	1,T2SWPE5,F
	WLW	1,T2SWPE6,F
	WLW	1,T2SWPE7,F
	WLW	1,T2SWPE8,F
	WLW	1,T2SWPE9,F
	WLW	1,T2SWPE10,F
	WL	-1,seq_stealstand
	WLW	1,T2SWPE11,F
	WLW	1,T2SWPE12,F
	WLL	-1,seq_snd,swipe_snd
	WLW	1,T2SWPE11,F
	WLW	1,T2SWPE10,F
	WLW	1,T2SWPE9,F
	WLW	1,T2SWPE8,F
	WLW	1,T2SWPE7,F
	WL	-1,seq_stealstand
	WLW	1,T2SWPE6,F
	WLW	1,T2SWPE5,F
	WLW	1,T2SWPE4,F
	WLW	1,T2SWPE3,F
	WLW	1,T2SWPE2,F
	WLW	1,T2SWPE1,F
	WLW	1,T2SWPE2,F
	W0
#steal_3
	WLW	1,T3SWPE5,F
	WLL	-1,seq_snd,swipe_snd
	WLW	1,T3SWPE6,F
	WLW	1,T3SWPE7,F
	WLW	1,T3SWPE8,F
	WLW	1,T3SWPE9,F
	WLW	1,T3SWPE10,F
	WLW	1,T3SWPE11,F
	WLW	1,T3SWPE12,F
	WL	-1,seq_stealstand
	WLW	1,T3SWPE11,F
	WLW	1,T3SWPE10,F
	WLL	-1,seq_snd,swipe_snd
	WLW	1,T3SWPE9,F
	WLW	1,T3SWPE8,F
	WLW	1,T3SWPE7,F
	WLW	1,T3SWPE6,F
	WLW	1,T3SWPE5,F
	WL	-1,seq_stealstand
	WLW	1,T3SWPE4,F
	WLW	1,T3SWPE3,F
	WLW	1,T3SWPE2,F
	WLW	1,T3SWPE1,F
	WLW	1,T3SWPE2,F
	WLW	1,T3SWPE3,F
	WLW	1,T3SWPE4,F
	W0
#steal_4
	WLW	1,T4SWPE6,F
	WLL	-1,seq_snd,swipe_snd
	WLW	1,T4SWPE7,F
	WLW	1,T4SWPE8,F
	WLW	1,T4SWPE9,F
	WLW	1,T4SWPE10,F
	WLW	1,T4SWPE11,F
	WLW	1,T4SWPE12,F
	WLW	1,T4SWPE11,F
	WL	-1,seq_stealstand
	WLW	1,T4SWPE10,F
	WLW	1,T4SWPE9,F
	WLL	-1,seq_snd,swipe_snd
	WLW	1,T4SWPE8,F
	WLW	1,T4SWPE7,F
	WLW	1,T4SWPE6,F
	WLW	1,T4SWPE5,F
	WLW	1,T4SWPE4,F
	WL	-1,seq_stealstand
	WLW	1,T4SWPE3,F
	WLW	1,T4SWPE2,F
	WLW	1,T4SWPE1,F
	WLW	1,T4SWPE2,F
	WLW	1,T4SWPE3,F
	WLW	1,T4SWPE4,F
	WLW	1,T4SWPE5,F
	W0
#steal_5
	WLW	1,T5SWPE5,F
	WLL	-1,seq_snd,swipe_snd
	WLW	1,T5SWPE6,F
	WLW	1,T5SWPE7,F
	WLW	1,T5SWPE8,F
	WLW	1,T5SWPE9,F
	WLW	1,T5SWPE10,F
	WLW	1,T5SWPE11,F
	WLW	1,T5SWPE12,F
	WL	-1,seq_stealstand
	WLW	1,T5SWPE11,F
	WLW	1,T5SWPE10,F
	WLL	-1,seq_snd,swipe_snd
	WLW	1,T5SWPE9,F
	WLW	1,T5SWPE8,F
	WLW	1,T5SWPE7,F
	WLW	1,T5SWPE6,F
	WLW	1,T5SWPE5,F
	WL	-1,seq_stealstand
	WLW	1,T5SWPE4,F
	WLW	1,T5SWPE3,F
	WLW	1,T5SWPE2,F
	WLW	1,T5SWPE1,F
	WLW	1,T5SWPE2,F
	WLW	1,T5SWPE3,F
	WLW	1,T5SWPE4,F
	W0

#*
push_t
	.word	NOMV_M|NOJUMP_M|NOJOY_M
	.long	seq_stand
	.long	#push_1,#push_2,#push_3,#push_4,#push_5,#push_4,#push_3,#push_2
#push_1
	WLW	2,w1push1,F
	WLW	2,w1push2,F
	WLW	4,w1push3,F
	WL	-1,seq_push
	WLW	2,w1push4,F
	WLW	2,w1push5,F
	WLW	2,w1push6,F
	WLW	2,w1push7,F
	WLW	2,w1push8,F
	WLW	2,w1push9,F
	WLW	2,w1push10,F
	WLW	2,w1push11,F
	W0
#push_2
	WLW	2,w2push1,F
	WLW	2,w2push2,F
	WLW	4,w2push3,F
	WL	-1,seq_push
	WLW	2,w2push4,F
	WLW	2,w2push5,F
	WLW	2,w2push6,F
	WLW	2,w2push7,F
	WLW	2,w2push8,F
	WLW	2,w2push9,F
	WLW	2,w2push10,F
	WLW	2,w2push11,F
	W0
#push_3
	WLW	2,w3push1,F
	WLW	2,w3push2,F
	WLW	4,w3push3,F
	WL	-1,seq_push
	WLW	2,w3push4,F
	WLW	2,w3push5,F
	WLW	2,w3push6,F
	WLW	2,w3push7,F
	WLW	2,w3push8,F
	WLW	2,w3push9,F
	WLW	2,w3push10,F
	WLW	2,w3push11,F
	W0
#push_4
	WLW	2,w4push1,F
	WLW	2,w4push2,F
	WLW	4,w4push3,F
	WL	-1,seq_push
	WLW	2,w4push4,F
	WLW	2,w4push5,F
	WLW	2,w4push6,F
	WLW	2,w4push7,F
	WLW	2,w4push8,F
	WLW	2,w4push9,F
	WLW	2,w4push10,F
	WLW	2,w4push11,F
	W0
#push_5
	WLW	2,w5push1,F
	WLW	2,w5push2,F
	WLW	4,w5push3,F
	WL	-1,seq_push
	WLW	2,w5push4,F
	WLW	2,w5push5,F
	WLW	2,w5push6,F
	WLW	2,w5push7,F
	WLW	2,w5push8,F
	WLW	2,w5push9,F
	WLW	2,w5push10,F
	WLW	2,w5push11,F
	W0

	.end