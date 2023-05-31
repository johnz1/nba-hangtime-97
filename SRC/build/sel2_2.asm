****************************************************************
*
* Owner:	JOHNSON
*
* Software:	Jeff Johnson/Jamie Rivett
* Initiated:	?
*
* Modified:	?
*
* COPYRIGHT (C) 1992 WILLIAMS ELECTRONICS GAMES, INC.
*
*.Last mod - 1/15/93 15:29
****************************************************************
	.file	"select2.asm"
	.title	"name & team selection"
	.width	132
	.option	b,d,l,t
	.mnolist

	.include	"mproc.equ"
	.include	"disp.equ"
	.include	"sys.equ"
	.include	"gsp.equ"
	.include	"game.equ"
	.include	"audit.equ"
	.include	"macros.hdr"
	.include	"world.equ"

	.include	"logos.tbl"
	.include	"names2.tbl"		;New names from pnames2.img
	.include	"names2.glo"		;New names from pnames2.img

	.include	"mugshot.glo"
	.include	"imgtbl.glo"
	.include	"imgtblp.glo"
	.include	"imgtbl2.glo"
	.include	"imgtbl7.glo"
	.include	"bgndtbl.glo"
	.include	"imgtblm.glo"
	.include	"bgndtbl7.glo"
	.include	"plyrnub.tbl"

	.include	"bbvda.tbl"


** defines in this file

	.def	city_names_str_tbl
	.def	CUST6,CUST7,CUST8,CUST9,CUST10
	.def	T_HAWKS,GAINED_TXT

;	.def	attrib_off
;	.def	attrib_on
;	.def	update_attribs
;	.def	team_sqaud_cnts

;DJT plyr_names_img_tbl removed to ATTRACT


************************************************************************
** external refs
	.ref	kp_qscrs2,PCNT
	.ref	HALT

	.ref	OUR_MUG,TOB_MUG,JAS_MUG,QUI_MUG,BOO_MUG,MARTY_MUG,CARL_MUG
;DJT Start
	.ref	HEI_MUG,MAT_MUG
;DJT End


	.def	team_sqaud_cnts
	.def	city_names_str_tbl
	.def	logos
	.def	city_table_start
	.def	city_table_end
	.def	our_names			;table addr.
	.def	our_heads			;table addrs.
	.def	player_attribs			;table addr.
	.def	name_sort


;	.ref	kp_ram
;	.ref	snd_play1
;	.ref	tm2set,tm1set
 ;
;	.ref	credit1_obj
;	.ref	credit2_obj
;	.ref	credit3_obj
;	.ref	name1_obj
;	.ref	name2_obj
;	.ref	name3_obj
;	.ref	name4_obj

;	.ref	attrib1_obj
;	.ref	attrib2_obj
;	.ref	attrib3_obj
;	.ref	attrib4_obj
;	.ref	CRED_P
;	.ref	teamset1_obj
;	.ref	teamset2_obj
 ;	.ref	create_credits
;	.ref	TWOPLAYERS			;0 = NO, 1 = YES 2 players
;	.ref	concat_string
;	.ref	copy_rom_string,concat_rom_string
;	.ref	message_ascii,mess_space_width,mess_spacing
;	.ref	mess_cursy,mess_objid
;	.ref	mess_line_spacing
;	.ref	CYCLE_TABLE,COLTAB2
;	.ref	pal_getf
;	.ref	get_initials_string
;	.ref	dropout_stats
;	.ref	conttimers
;	.ref	PSTATUS2
;	.ref	GET_ADJ
;	.ref	game_purchased
;	.ref	GAMSTATE
;	.ref	monitor_fullgame
;	.ref	message_buffer
;	.ref	pleasewt
;	.ref	game_over
;	.ref	credits
;	.ref	KILBGND,KILALL
;	.ref	print_string_C2
;	.ref	cntrs_delay
;	.ref	can_enter_inits
;	.ref	winningteam
;	.ref	newptr,newplyrs
;	.ref	CR_CONTP
;	.ref	team_control
;	.ref	plyrsdropped
;	.ref	P1DATA
;	.ref	pal_clean
;	.ref	qtr_purchased
;	.ref	credit_messages
;	.ref	monitor_buyins
;	.ref	COLRTEMP
;	.ref	gmqrtr
;	.ref	_4plyrsingame,_2plyr_competitive

;	.ref	do_scrn_transition
;	.ref	un_wipe_horizontal,wipe_horizontal
;	.ref	wipe_stack_vertical
;	.ref	NO_CREATE_DEL_OBJS,CREATE_NO_DEL_OBJS

;	.ref	fade_up,fade_down
;	.ref	calc_num_defeated
;	.ref	RNDRNG0,BAKMODS
;	.ref	team2,team1
;	.ref	switches_cur
;	.ref	inmatchup
;	.ref	player1_data
;	.ref	dec_to_asc
;	.ref	cntdown_snd
;	.ref	pal_set
;	.ref	player2_data
;	.ref	create_logos
;	.ref	call_matchup
;	.ref	pal_find
;	.ref	special_heads
;	.ref	player3_data
;	.ref	create_player_heads
;	.ref	update_player_heads
;	.ref	create_names
;	.ref	dpageflip
;	.ref	IRQSKYE
;	.ref	PSTATUS
;	.ref	player4_data
;	.ref	switches_down
;	.ref	print_string_C
;	.ref	BGND_UD1
;	.ref	obj_on
;	.ref	force_selection
;	.ref	obj_off
;	.ref	scores
;	.ref	WIPEOUT
;	.ref	mess_cursx
;	.ref	update_logos
;	.ref	setup_message
;	.ref	copy_string
;DJT Start
;	.if	ANIM_VS
;	.ref	animate_vs_logo
;	.endif	;ANIM_VS
;DJT End
;	.ref	get_name_string
	.ref	bast8_ascii
;	.ref	plyr_get_combination
;	.ref	set_plyrs_powerup_ram
;	.ref	bast18_ascii,brush20_ascii
	.ref	brush20_ascii
	.ref	bast10_ascii
;	.ref	bounce_snd,tunegc_snd
;	.ref	SOUNDSUP
;	.ref	OVRTME,OVERW_P
;	.ref	hide_ball_under_logo
;	.ref	bast8t_ascii
;	.ref	get_teams_pop,teams_pop
;	.ref	kp_p1_crtplr,kp_p2_crtplr,kp_p3_crtplr,kp_p4_crtplr
;	.ref	kp_p1_name1,kp_p1_name2,kp_p1_name3,kp_p1_name4
;	.ref	kp_p1_name5,kp_p1_name6,kp_p1_hdnbr
;	.ref	kp_p2_name1,kp_p2_name2,kp_p2_name3,kp_p2_name4
;	.ref	kp_p2_name5,kp_p2_name6,kp_p2_hdnbr
;	.ref	kp_p3_name1,kp_p3_name2,kp_p3_name3,kp_p3_name4
;	.ref	kp_p3_name5,kp_p3_name6,kp_p3_hdnbr
;	.ref	kp_p4_name1,kp_p4_name2,kp_p4_name3,kp_p4_name4
;	.ref	kp_p4_name5,kp_p4_name6,kp_p4_hdnbr
;	.ref	kp_team1,kp_scores,kp_team2
;	.ref	mess_cursx2,kern_chars
;	.ref	print_string2b,hangfnt38_ascii
;	.ref	brush50_ascii,mess_justify
;	.ref	message_palette
;DJT Start

;	.ref	t1ispro
;	.ref	t2ispro

;DJT Not .refs
;DJT End
************************************************************************


	.text
_ATL	.equ	0
_BOS	.equ	1
_CHA	.equ	2
_CHI	.equ	3
_CLE	.equ	4
_DAL	.equ	5
_DEN	.equ	6
_DET	.equ	7
_GOL	.equ	8
_HOU	.equ	9
_IND	.equ	10
_LAC	.equ	11
_LAL	.equ	12
_MI	.equ	13
_MIL	.equ	14
_MIN	.equ	15
_NJ	.equ	16
_NY	.equ	17
_ORL	.equ	18
_PHI	.equ	19
_PHX	.equ	20
_POR	.equ	21
_SAC	.equ	22
_SAN	.equ	23
_SEA	.equ	24
_TOR	.equ	25
_UTA	.equ	26
_VAN	.equ	27
_WAS	.equ	28

;;;;;;;;;;TABLES;;;;;;;;;;;;;
;;;;;;;;;;TABLES;;;;;;;;;;;;;

;DJT plyr_names_img_tbl removed to ATTRACT
matchup_mod
	.long	BKGDBMOD
	.word	0,0		;x,y
	.long	VSSCRBMOD
	.word	0,10		;x,y
	.long	0

bsd_stat_str_setup
;DJT Start
	PRINT_STR	bast8_ascii,5,0,200,197,BAST_Y_P,0
;DJT End

bsd_stat_str
	.string	"BASED ON STATS:",0
	.even

favored_by_str
	.string	" FAVORED BY ",0
	.even


tnght_mat_str_setup
	PRINT_STR	brush20_ascii,13,0,200,7,BRSHGYOP,0

tonght_matchup_str
	.string	"TONIGHT'S MATCHUP",0
	.even


tm1_cty_str_setup
	PRINT_STR	bast10_ascii,8,0,80,44,BAST_W_P,0

tm1_nme_str_setup
;	PRINT_STR	bast18_ascii,8,0,80,59,BSTGWW_P,0
	PRINT_STR	brush20_ascii,8,0,80,59,BRSHGWKP,0

tm2_cty_str_setup
	PRINT_STR	bast10_ascii,8,0,310,44,BAST_W_P,0

tm2_nme_str_setup
;	PRINT_STR	bast18_ascii,8,0,310,59,BSTGWW_P,0
	PRINT_STR	brush20_ascii,8,0,310,59,BRSHGWKP,0


city_names_str_tbl
	.long	atl_str,atl2_str
	.long	bos_str,bos2_str
	.long	cha_str,cha2_str
	.long	chi_str,chi2_str
	.long	cle_str,cle2_str
	.long	dal_str,dal2_str
	.long	den_str,den2_str
	.long	det_str,det2_str
	.long	gol_str,gol2_str
	.long	hou_str,hou2_str
	.long	ind_str,ind2_str
	.long	cli_str,cli2_str
	.long	lak_str,lak2_str
	.long	mia_str,mia2_str
	.long	mil_str,mil2_str
	.long	min_str,min2_str
	.long	new_str,new2_str
	.long	ney_str,ney2_str
	.long	orl_str,orl2_str
	.long	phi_str,phi2_str
	.long	pho_str,pho2_str
	.long	por_str,por2_str
	.long	sac_str,sac2_str
	.long	san_str,san2_str
	.long	sea_str,sea2_str
	.long	tor_str,tor2_str
	.long	uta_str,uta2_str
	.long	van_str,van2_str
	.long	was_str,was2_str
			   

atl_str
	.string	"ATLANTA",0
atl2_str
	.string	"HAWKS",0
bos_str
	.string	"BOSTON",0
bos2_str
	.string	"CELTICS",0
cha_str
	.string	"CHARLOTTE",0
cha2_str
	.string	"HORNETS",0
chi_str
	.string	"CHICAGO",0
chi2_str
	.string	"BULLS",0
cle_str
	.string	"CLEVELAND",0
cle2_str
	.string	"CAVALIERS",0
dal_str
	.string	"DALLAS",0
dal2_str
	.string	"MAVERICKS",0
den_str
	.string	"DENVER",0
den2_str
	.string	"NUGGETS",0
det_str
	.string	"DETROIT",0
det2_str
	.string	"PISTONS",0
gol_str
	.string	"GOLDEN STATE",0
gol2_str
	.string	"WARRIORS",0
hou_str
	.string	"HOUSTON",0
hou2_str
	.string	"ROCKETS",0
ind_str
	.string	"INDIANA",0
ind2_str
	.string	"PACERS",0
cli_str
	.string	"LOS ANGELES",0
cli2_str
	.string	"CLIPPERS",0
lak_str
	.string	"LOS ANGELES",0
lak2_str
	.string	"LAKERS",0
mia_str
	.string	"MIAMI",0
mia2_str
	.string	"HEAT",0
mil_str
	.string	"MILWAUKEE",0
mil2_str
	.string	"BUCKS",0
min_str
	.string	"MINNESOTA",0
min2_str
	.string	"T'WOLVES",0
new_str
	.string	"NEW JERSEY",0
new2_str
	.string	"NETS",0
ney_str
	.string	"NEW YORK",0
ney2_str
	.string	"KNICKS",0
orl_str
	.string	"ORLANDO",0
orl2_str
	.string	"MAGIC",0
phi_str
	.string	"PHILADELPHIA",0
phi2_str
	.string	"76ERS",0
pho_str
	.string	"PHOENIX",0
pho2_str
	.string	"SUNS",0
por_str
	.string	"PORTLAND",0
por2_str
	.string	"TRAILBLZRS",0
sac_str
	.string	"SACRAMENTO",0
sac2_str
	.string	"KINGS",0
san_str
	.string	"SAN ANTONIO",0
san2_str
	.string	"SPURS",0
sea_str
	.string	"SEATTLE",0
sea2_str
	.string	"SONICS",0
uta_str
	.string	"UTAH",0
uta2_str
	.string	"JAZZ",0
tor_str
	.string	"TORONTO",0
tor2_str
	.string	"RAPTORS",0
van_str
	.string	"VANCOUVER",0
van2_str
	.string	"GRIZZLIES",0
was_str
	.string	"WASHINGTON",0
was2_str
	.string	"BULLETS",0
	.even



;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
logos
	.long	T_HAWKS		; 0 ATLANTA	(124)
	.long	T_CELTS		; 1 BOSTON
	.long	T_HORS		; 2 CHARLOTTE
	.long	T_BULLS		; 3 CHICAGO
	.long	T_CAVS		; 4 CLEVELAND
	.long	T_MAVS		; 5 DALLAS
	.long	T_NUGS		; 6 DENVER
;DJT Start
	.long	T_PISS_N	; 7 DETROIT
;DJT End
	.long	T_WARS		; 8 GOLDEN STATE
	.long	T_ROCKS		; 9 HOUSTON
	.long	T_PACER		;10 INDIANA
;FIXX!!!
	.long	T_LAKS		;12 LOS ANGELES (LAKERS)
	.long	T_CLIPS		;11 LOS ANGELES (CLIPPERS)
;FIXX!!!
	.long	T_HEAT		;13 MIAMI
	.long	T_BUCKS		;14 MILWAUKEE
;DJT Start
	.long	T_TWOLV_N	;15 MINNESOTA
;DJT End
	.long	T_NETS		;16 NEW JERSEY
	.long	T_KNIKS		;17 NEW YORK
	.long	T_MAGIC		;18 ORLANDO
	.long	T_76RS		;19 PHILADELPHIA
	.long	T_SUNS		;20 PHOENIX
	.long	T_BLAZ		;21 PORTLAND
	.long	T_KINGS		;22 SACRAMENTO
	.long	T_SPURS		;23 SAN ANTONIO
	.long	T_SONICS	;24 SEATTLE
	.long	T_RAPT		;25 TORONTO
;DJT Start
	.long	T_JAZZ_N	;26 UTAH
;DJT End
	.long	T_GRIZZ		;27 VANCOUVER
	.long	T_BULTS		;28 WASHINGTON	(150)
;FIX!!! Defeated all teams special logo
	.long	T_BULTS		; Special team

;-----------------------------------------------------------------------------
;    This TABLE has the following format: ptr. to city name img, team number
;
; Its used for the CURSOR control on the new team select screen
;-----------------------------------------------------------------------------
	LW	city_tor,_TOR
	LW	city_uta,_UTA
	LW	city_van,_VAN
	LW	city_was,_WAS
city_table_start
	LW	city_atl,_ATL
	LW	city_bos,_BOS
	LW	city_cha,_CHA
	LW	city_chi,_CHI
	LW	city_cle,_CLE
	LW	city_dal,_DAL
	LW	city_den,_DEN
	LW	city_det,_DET
	LW	city_gol,_GOL
	LW	city_hou,_HOU
	LW	city_ind,_IND
	LW	city_lac,_LAC
	LW	city_lal,_LAL
;;	LW	city_los,_LOS
	LW	city_mia,_MI
	LW	city_mil,_MIL
	LW	city_min,_MIN
	LW	city_nej,_NJ
	LW	city_ney,_NY
	LW	city_orl,_ORL
	LW	city_phi,_PHI
	LW	city_pho,_PHX
	LW	city_por,_POR
	LW	city_sac,_SAC
	LW	city_san,_SAN
	LW	city_sea,_SEA
	LW	city_tor,_TOR
	LW	city_uta,_UTA
	LW	city_van,_VAN
	LW	city_was,_WAS
city_table_end
	LW	city_atl,_ATL
	LW	city_bos,_BOS
	LW	city_cha,_CHA
	LW	city_chi,_CHI
	LW	city_cle,_CLE
	LW	city_dal,_DAL
	LW	city_den,_DEN
city_table_end2

	
********NOTE***************************************************************
*  IF this table is messed with, 'name_sort' table must be updated as well
*     and vice versa
********NOTE***************************************************************
;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
player_attribs
;
; LAST TWO ATTRIBUTES ARE NOW IGNORED
;

;DJT Start
;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;00 ATLANTA HAWKS

	.word  09,02,07,00
	.word  09,01,07,09	;MOOKIE BLAYLOCK	6'1"	185 reg 

	.word  06,09,04,08
	.word  05,10,03,07	;DIKEMBE MUTOMBO	7'2"	245 reg

	.word  07,05,08,05
	.word  05,02,04,06	;STEVE SMITH		6'8"	208 reg

	.word  07,06,07,03
	.word  05,05,05,08	;CHRISTIAN LAETTNER	6'11"	235 reg

	.word  07,04,06,06
	.word  04,05,04,02	;KEN NORMAN		6'8"	223 reg

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;01 BOSTON CELTICS

	.word  08,02,05,07 
	.word  07,01,05,02	;DEE BROWN		6'1"	161 reg
;new
	.word  06,07,07,05
	.word  03,07,06,01	;STEVE HAMER		_______________

	.word  09,01,09,01
	.word  07,01,06,05	;DANA BARROS		5'11"	165 reg

	.word  07,08,07,07
	.word  07,09,01,06	;DINO RADJA		6'11"	225 thin 

	.word  05,09,07,05
	.word  08,05,07,07	;RICK FOX		6'7"	231 reg

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;02 CHARLOTTE HORNETS

	.word  07,05,10,05
	.word  06,02,02,09	;GLEN RICE		6'8"	220 reg

	.word  06,09,06,05
	.word  03,03,04,06	;ANTHONY MASON		6'7"	250 fat

	.word  05,08,04,04
	.word  05,09,06,02	;VLADE DIVAC		7'1"	260 thin

	.word  03,08,04,04
	.word  02,07,03,02	;GEORGE ZIDEK		_______________

	.word  08,02,07,01
	.word  08,01,04,07	;DELL CURRY		6'5"	200 thin

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;03 CHICAGO BULLS

	.word  08,06,08,09
	.word  09,08,07,08	;SCOTTIE PIPPEN		6'7"	225 thin

	.word  07,09,01,04
	.word  05,07,04,03	;DENNIS RODMAN		6'8"	210 thin

	.word  07,05,07,06
	.word  07,05,08,10	;TONI KUKOC		6'11"	230 ex thin

	.word  05,08,05,03
	.word  02,07,06,02	;LUC LONGLEY		7'2"	265 fat

	.word  06,02,09,00
	.word  06,01,04,08	;STEVE KERR		_______________

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;04 CLEVELAND CAVALIERS

	.word  06,08,06,06
	.word  03,06,04,07	;TYRONE HILL		6'9"	245 reg

	.word  07,05,07,03
	.word  04,05,04,02	;CHRIS MILLS		6'6"	216 fat

	.word  08,05,07,01
	.word  08,04,07,02	;BOBBY PHILLS		6'5"	217 reg

	.word  09,02,08,01
	.word  08,01,07,09	;TERRELL BRANDON	6'0"	180 thin

	.word  04,07,07,02
	.word  05,02,05,08	;DANNY FERRY		6'10"	245 reg

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;05 DALLAS MAVERICKS

	.word  09,04,04,05
	.word  06,06,08,08	;JASON KIDD		_______________

	.word  06,05,06,01
	.word  07,01,05,05	;DEREK HARPER		6'4"	206 reg

	.word  07,04,07,05
	.word  05,04,05,07	;JIM JACKSON		6'6"	220 reg

	.word  04,08,03,07
	.word  01,06,03,03	;ERIC MONTROSS		_______________

	.word  08,03,09,08
	.word  04,07,05,09	;JAMAL MASHBURN		6'8"	240 thin

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;06 DENVER NUGGETS

	.word  07,01,06,07
	.word  05,07,03,07	;ANTONIO McDYESS	_______________

	.word  04,05,08,01
	.word  08,01,02,07	;SARUNAS MARCIULIONIS	6'5"	215 reg

	.word  07,04,06,01
	.word  09,04,09,04	;MARK JACKSON		6'3"	192 fat

	.word  07,06,08,02
	.word  06,01,05,08	;DALE ELLIS		6'7"	215 reg
;kill
	.word  00,00,00,00
	.word  00,00,00,00

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;07 DETROIT PISTONS

	.word  09,05,08,08
	.word  08,05,08,09	;GRANT HILL		_______________
;new
;;	.word  07,03,08,03
;;	.word  07,05,06,02	;RON RILEY		_______________

	.word  06,04,08,00
	.word  06,01,08,09	;JOE DUMARS		6'3"	195 thin

	.word  07,09,05,07
	.word  04,07,05,02	;OTIS THORPE		6'10"	246 reg

	.word  08,03,05,07
	.word  06,02,04,08	;STACEY AUGMON		6'8"	205 thin
;kill
	.word  00,00,00,00
	.word  00,00,00,00

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;08 GOLDEN STATE WARRIORS

	.word  09,04,08,08
	.word  07,02,04,08	;LATRELL SPREWELL	6'5"	190 ex thin

	.word  04,06,05,07
	.word  03,05,03,02	;JON KONCAK		7'0"	250 reg

	.word  07,07,07,09
	.word  07,08,02,03	;JOE SMITH		_______________

	.word  04,05,09,02
	.word  08,04,07,08	;CHRIS MULLIN		6'7"	215 reg
;kill
	.word  00,00,00,00
	.word  00,00,00,00

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;09 HOUSTON ROCKETS

	.word  07,10,07,08
	.word  07,10,07,07	;HAKEEM OLAJUWON	7'0"	255 reg
;new
	.word  04,09,04,06
	.word  02,08,04,02	;OTHELLA HARRINGTON	_______________

	.word  07,03,08,09
	.word  08,02,08,08	;CLYDE DREXLER		6'7"	222 thin

	.word  05,09,05,07
	.word  04,04,01,04	;KEVIN WILLIS		7'0"	240 reg
;kill (MAYBE!!!)
;Kenny Smith
	.word  06,04,06,01
	.word  07,01,07,04	;KENNY SMITH		_______________

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;10 INDIANA PACERS
;LOOK!!!
	.word  07,04,09,06
	.word  06,05,05,10	;REGGIE MILLER		6'7"	185 ex thin
;new
	.word  04,08,07,07
	.word  03,07,04,02	;ERICK DAMPIER		_______________

	.word  09,04,06,06
	.word  08,06,08,09	;JALEN ROSE		_______________

	.word  06,09,07,03
	.word  04,06,02,09	;RIK SMITS		7'4"	265 ex thin

	.word  05,06,04,06
	.word  05,08,02,02	;DALE DAVIS		6'11"	230 reg

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;11 L.A. CLIPPERS

	.word  05,07,07,06
	.word  06,06,01,08	;LOY VAUGHT		6'9"	240 reg

	.word  06,08,05,05
	.word  02,03,02,05	;RODNEY ROGERS		_______________

	.word  08,05,06,05
	.word  08,04,06,09	;LAMOND MURRAY		_______________

	.word  08,01,04,01
	.word  08,01,08,02	;POOH RICHARDS		_______________

	.word  08,05,06,09
	.word  06,04,05,08	;BRENT BARRY		_______________

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;12 L.A. LAKERS

	.word  10,02,07,01
	.word  06,01,08,09	;NICK VAN EXEL		6'1"	170 ex thin

	.word  08,03,09,07
	.word  08,02,02,08	;CEDRIC CEBALLOS	6'7"	220 thin

	.word  07,04,08,01
	.word  04,03,04,09	;BYRON SCOTT		6'4"	235 fat

	.word  06,05,05,06
	.word  08,09,01,03	;ELDON CAMPBELL		6'11"	230 ex thin

	.word  08,04,07,05
	.word  04,07,08,02	;EDDIE JONES		_______________

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;13 MIAMI HEAT

	.word  08,10,06,09
	.word  04,09,03,07	;ALONZO MOURNING	6'10"	240 reg

	.word  09,05,07,00
	.word  08,01,08,06	;TIM HARDAWAY		6'0"	195 reg

	.word  05,05,08,02
	.word  04,05,05,04	;SASHA DANILOVIC	_______________
;kill
	.word  00,00,00,00
	.word  00,00,00,00
;kill
	.word  00,00,00,00
	.word  00,00,00,00

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;14 MILWAUKEE BUCKS

	.word  08,05,07,08
	.word  05,07,04,06	;VIN BAKER		6'11"	234 thin
;new
	.word  09,02,08,06
	.word  06,02,05,08	;RAY ALLEN		_______________

	.word  06,08,05,06
	.word  04,09,02,04	;ANDREW LANG		6'11"	235 reg

	.word  07,07,09,06
	.word  07,02,04,08	;GLENN ROBINSON		_______________

	.word  09,01,06,00
	.word  07,01,07,09	;SHAWN RESPERT		_______________

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;15 MINNESOTA TIMBERWOLVES

	.word  07,06,07,05
	.word  09,07,06,03	;TOM GUGLIOTTA		6'10"	240 reg
;new
	.word  08,04,08,05
	.word  07,03,06,03	;STEPHON MARBURY	_______________

	.word  08,02,05,08
	.word  05,08,04,03	;KEVIN GARNETT		_______________
;kill
	.word  00,00,00,00
	.word  00,00,00,00
;kill
	.word  00,00,00,00
	.word  00,00,00,00

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;16 NEW JERSEY NETS

	.word  08,02,06,05
	.word  07,05,07,03	;KENDALL GILL		6'5"	200 thin
;new
	.word  06,06,07,07
	.word  03,07,05,02	;KERRY KITTLES		_______________

	.word  09,03,06,00
	.word  09,00,09,02	;ROBERT PACK		6'2"	180 thin

	.word  05,03,05,08
	.word  04,10,03,04	;SHAWN BRADLEY		7'6"	248 ex thin

	.word  08,04,05,06
	.word  09,05,05,08	;ED O'BANNON		_______________

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;17 NEW YORK KNICKS

	.word  06,10,07,08
	.word  04,10,02,08	;PATRICK EWING		7'0"	240 reg
;new
	.word  05,07,07,06
	.word  04,07,05,02	;JOHN WALLACE		_______________

	.word  07,08,07,08
	.word  04,05,07,08	;LARRY JOHNSON		6'7"	250 fat

	.word  09,05,08,02
	.word  07,02,08,08	;JOHN STARKS		6'5"	185 thin

	.word  08,01,10,02
	.word  04,03,05,07	;ALAN HOUSTON		6'6"	200 thin

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;18 ORLANDO MAGIC

	.word  10,04,08,08
	.word  08,07,08,10	;ANFERNEE HARDAWAY	6'7"	200 ex thin

	.word  05,08,05,03
	.word  03,07,04,04	;RONY SEIKALY		6'11"	252 reg

	.word  06,08,05,06
	.word  04,08,04,04	;HORACE GRANT		6'10"	220 reg

	.word  07,04,08,03
	.word  08,04,04,04	;NICK ANDERSON		6'6"	205 reg

	.word  07,03,09,03
	.word  04,04,05,04	;DENNIS SCOTT		6'8"	229 reg

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;19 PHILADELPHIA  76ers
;new
	.word  09,03,09,00
	.word  09,01,07,06	;ALLEN IVERSON		_______________
;new
;;	.word  06,05,08,06
;;	.word  06,04,07,02	;RYAN MINOR		_______________

	.word  08,04,07,08
	.word  05,03,05,07	;JERRY STACKHOUSE	_______________

	.word  05,08,07,06
	.word  03,05,03,02	;DERRICK COLEMAN	6'10"	260 fat

	.word  05,06,06,06
	.word  04,06,05,07	;CLARENCE WEATHERSPOON	6'7"	240 fat
;kill
	.word  00,00,00,00
	.word  00,00,00,00

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;20 PHOENIX SUNS

	.word  09,02,08,02
	.word  08,03,08,09	;KEVIN JOHNSON		6'1"	190 ex thin

	.word  04,08,08,06
	.word  04,06,05,07	;WAYMAN TISDALE		6'9"	260 fat

	.word  05,06,05,07
	.word  04,05,03,06	;DANNY MANNING		6'10"	234 reg

	.word  08,06,06,08
	.word  07,08,05,09	;ROBERT HORRY		6'10"	220 thin

	.word  09,01,06,01
	.word  04,01,06,02	;SAM CASSELL		6'3"	195 thin

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;21 PORTLAND TRAILBLAZERS

	.word  08,07,06,06
	.word  06,07,02,08	;CLIFF ROBINSON		6'10"	225 thin

	.word  07,04,05,09
	.word  04,01,02,06	;ISIAH RIDER		6'5"	215 thin

	.word  04,09,06,05
	.word  03,07,02,04	;ARVYDAS SABONIS	_______________

	.word  10,03,06,00
	.word  08,03,09,06	;KENNY ANDERSON		6'1"	168 ex thin 

	.word  09,02,05,00
	.word  06,01,08,08	;RANDOLPH CHILDRESS	_______________

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;22 SACRAMENTO KINGS

	.word  07,06,07,06
	.word  04,02,07,06	;BILLY OWENS		6'9"	220 reg

	.word  08,02,08,00
	.word  08,01,08,09	;MAHMOUD ABDUL-RAUF	6'1"	168 ex thin

	.word  07,07,08,02
	.word  09,01,06,08	;MITCH RICHMOND		6'5"	215 reg

	.word  05,06,05,06
	.word  02,09,01,06	;BRIAN GRANT		_______________

	.word  10,01,06,00
	.word  08,00,08,04	;TYUS EDNEY		_______________

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;23 SAN ANTONIO SPURS

	.word  08,04,08,07
	.word  04,05,02,08	;SEAN ELLIOTT		6'8"	215 thin

	.word  08,09,08,06
	.word  05,10,04,06	;DAVID ROBINSON		7'1"	235 reg

	.word  07,04,08,03
	.word  05,03,06,04	;VERNON MAXWELL		6'4"	190 thin

	.word  10,01,05,00
	.word  08,01,09,02	;AVERY JOHNSON		5'11"	175 ex thin

	.word  07,03,06,01
	.word  07,01,03,02	;VINNY DEL NEGRO	6'4"	200 thin

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;24 SEATTLE SUPERSONICS

	.word  08,07,08,10
	.word  06,09,03,07	;SHAWN KEMP		6'10"	245 reg

	.word  10,03,07,00
	.word  10,02,08,08	;GARY PAYTON		6'4"	190 ex thin

	.word  05,06,08,05
	.word  02,04,04,02	;DETLEF SCHREMPF	6'10"	230 thin

	.word  06,03,07,00
	.word  06,04,05,07	;HERSEY HAWKINS		6'3"	190 thin

	.word  07,03,04,04
	.word  04,04,06,04	;SHERELL FORD		6'6"	235 thin

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;25 TORONTO RAPTORS

	.word  06,08,05,05
	.word  06,04,05,01	;CARLOS ROGERS		_______________
;new
	.word  07,07,08,08
	.word  04,09,05,07	;MARCUS CAMBY		_______________

	.word  10,01,07,00
	.word  08,01,09,08	;DAMON STOUDAMIRE	_______________

	.word  05,08,04,07
	.word  04,06,03,03	;POPEYE JONES		6'8"	250 reg

	.word  08,06,07,07
	.word  05,08,06,03	;WALT WILLIAMS		6'8"	230 reg

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;26 UTAH JAZZ

	.word  07,02,08,00
	.word  10,01,10,08	;JOHN STOCKTON		6'1"	175 ex thin
        
	.word  07,10,08,08
	.word  08,05,06,07	;KARL MALONE		6'9"	256 fat

	.word  05,05,07,02
	.word  07,02,05,06	;JEFF HORNACEK		6'4"	190 reg

	.word  05,06,07,05
	.word  08,04,04,02	;CHRIS MORRIS		6'8"	220 reg
;kill
	.word  00,00,00,00
	.word  00,00,00,00

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;27 VANCOUVER GRIZZLIES

	.word  08,04,05,01
	.word  07,02,07,02	;GREG ANTHONY		6'2"	185 ex thin

	.word  07,06,07,04
	.word  08,05,03,07	;BLUE EDWARDS		6'4"	228 reg

	.word  05,10,06,04
	.word  05,08,02,02	;BRYANT REEVES		_______________
;kill
	.word  00,00,00,00
	.word  00,00,00,00
;kill
	.word  00,00,00,00
	.word  00,00,00,00

;Speed, Power, Shoot, Dunk
;Steal, Block, Pass ability, Clutch

;28 WASHINGTON BULLETS

	.word  08,03,07,00
	.word  07,01,10,06	;ROD STRICKLAND		6'3"	185 reg

	.word  08,08,08,08
	.word  06,04,06,07	;CHRIS WEBBER		6'10"	260 fat

	.word  07,07,08,06
	.word  05,03,04,06	;JUWAN HOWARD		_______________

	.word  04,09,05,02
	.word  03,09,01,04	;GHEORGHE MURESAN	7'7"	315 thin

	.word  07,05,06,06
	.word  06,02,02,08	;CALBERT CHEANEY	6'7"	209 reg
;DJT End

;FIX!!!
;Move these to where they should go (If anywhere!)
;Special super star secret guests
;
;;ATL
;	.word  06,04,05,06
;	.word  05,08,04,03	 ;ALAN HENDERSON     ____________
;
;;G.S
;	.word  06,05,05,05
;	.word  06,04,05,05	 ;BIMBO COLES        6'2"  185 reg
;
;;ATL
;	.word  05,08,05,06
;	.word  03,06,01,04	 ;SEAN ROOKS         6'10" 260  reg
;
;;N.Y.
;	.word  07,02,06,05
;	.word  04,06,05,07	 ;WILLIE ANDERSON     6'8" 200 reg
;
;;ORL
;	.word  05,06,05,06
;	.word  03,06,04,05	 ;KENNY GATTISON    6'8" 252  fat
;
;;L.A.
;	.word  08,04,07,05
;	.word  04,07,08,02	 ;EDDIE JONES          ________________
;
;
;;TOR
;	.word  05,05,04,07
;	.word  04,07,04,04	 ;SHARONE WRIGHT         ______________



********NOTE**************************************************************
*  IF this table is messed with, 'player_attribs' must be updated as well
*     and vice versa
********NOTE**************************************************************
;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
;DJT Start
	.ref	ALLEN,CAMBY,DAMPIER,HAMER,HRNGTON,IVERSON,KITTLES
	.ref	MARBURY,MINOR,RILEY,WALLACE

name_sort
 .long	BLAYLOCK,MUTUMBO,SSMITH,LAETTNER,KNORMAN		;00 HAWKS
 .long	BROWN, HAMER ,BARROS,RADJA,FOX			;new	;01 CELTICS
 .long	RICE,MASON,DIVAC,ZIDEK,CURRY				;02 HORNETS
 .long	PIPPEN,RODMAN,KUKOC,LONGLEY,KERR			;03 BULLS
 .long	THILL,CMILLS,PHILLS,BRANDON,FERRY			;04 CAVALIERS
 .long	KIDD,HARPER_D,JACK,MONTROSS,MASH			;05 MAVERICKS
 .long	MCDYESS,MARCIULO,MJACKSON,DELLIS, DELLIS	;kill	;06 NUGGETS
 .long	GHILL,DUMARS,THORPE,AUGMON, RILEY 		;kill:new ;07 PISTONS
 .long	SPREWELL,KONCAK,JSMITH,MULLIN, MULLIN		;kill	;08 WARRIORS
 .long	OLAJUWON, HRNGTON ,DREXLER,WILLIS, WILLIS	;new,kill ;09 ROCKETS
 .long	MILLER, DAMPIER ,ROSE,SMITS,DDAVIS		;new	;10 PACERS
 .long	VAUGHT,RROGERS,LMURRAY,PRICHARD,BBARRY			;11 CLIPPERS
 .long	VANEXEL,CEBALLOS,SCOTT,CAMPBELL,EJONES			;12 LAKERS
 .long	MOURN,THARDAWAY,DANILOVI, DANILOVI , DANILOVI	;kill,kill ;13 HEAT
 .long	BAKER, ALLEN ,LANG,GROBINSO,RESPERT		;new	;14 BUCKS
 .long	GUGLI2, MARBURY ,GARNETT, GARNETT , GARNETT	;new,kill,kill ;15 TIMBERWOLVES
 .long	GILL, KITTLES ,PACK,BRADLEY,OBANNON		;new	;16 NETS
 .long	EWING, WALLACE ,JOHNSN_L,STARKS,HOUSTON		;new	;17 KNICKS
 .long	AHARDAWAY,SEIKALY,GRANT_HC,NANDERSON,DSCOTT		;18 MAGIC
 .long	IVERSON ,STACKHOU,COLEMAN,WEATHSPN, MINOR 	;new,kill:new ;19 76ers
 .long	KJOHNSON,TISDALE,MANNING,HORRY,CASSELL			;20 SUNS
 .long	CROBINSON,RIDER,SABONIS,KANDERSON,CHILDRES		;21 TRAILBLAZERS
 .long	BOWENS,ABDULRAU,RICH,BGRANT,EDNEY			;22 KINGS
 .long	ELLIOT2,DROBINSON,VMAXWELL,AJOHNSON,DELNEGRO		;23 SPURS
 .long	KEMP,PAYTON,SCHREMPF,HAWKINS,SFORD			;24 SUPERSONICS
 .long	CROGERS, CAMBY ,STOUDAMI,PJONES,WWILLIAM	;new	;25 RAPTORS
 .long	STOCKTON,MALONE_K,HORNACEK,CMORRIS, CMORRIS	;kill	;26 JAZZ
 .long	ANTHONY,EDWARDS,BREEVES, BREEVES , BREEVES	;kill,kill ;27 GRIZZLIES
 .long	STRICKLA,WEBBER,JHOWARD,MURESAN,CHEANEY			;28 BULLETS
 .long	0

;Removed
;MCCLOUD,TMILLS,SMITH,MCKEE2,CHAPMAN,BENJAMIN,DOUGLAS,WEBB
;GILLIAM,KEDWARDS,OAKLEY,RUFFIN,WPERSON,FINLEY,BWILLIAM,PERSON
;ROBERTSON,OMILLER,TMURRAY,BENOIT,SCOTT,EMURDOCK
;DJT End

	.if	HEADCK
;This show the player name on scrn for debugging
 SUBR	show_name

	move	a10,a0
	andi	03,a0
	sll	4,a0
	addi	xtbl,a0
	move	*a0,a0
	sll	16,a0

	movi	[200,0],a1			;y val
	move	a10,a2
	sll	5,a2
	addi	name_sort,a2
	move	*a2,a2,L
	movi	07ff0H,a3			;z pos
	movi	DMAWNZ|M_SCRNREL,a4		;DMA flags
	clr	a5				;object ID
	clr	a6				;x vel
	clr	a7				;y vel
	calla	BEGINOBJ2
	DIE

xtbl	.word	57,148,251,342
	.endif

;-----------------------------------------------------------------------------
; THIS table contains the MAX number of squads per team
;
;		***NOTE*** if change this table...must also update 
;			'player_names' and 'player_heads'
;-----------------------------------------------------------------------------
team_sqaud_cnts
;DJT Start
	.word	20	;ATLANTA
	.word	20	;BOSTON
	.word	20	;CHARLOTTE
	.word	20	;CHICAGO
	.word	20	;CLEVELAND
	.word	20	;DALLAS
	.word	12	;DENVER
	.word	12 ;20	;DETROIT
	.word	12	;GOLDEN STATE
	.word	12	;HOUSTON
	.word	20	;INDIANA
	.word	20	;L.A. CLIPPERS
	.word	20	;L.A. LAKERS
	.word	6	;MIAMI
	.word	20	;MILWAUKEE
	.word	6	;MINNESOTTA
	.word	20	;NEW JERSEY
	.word	20	;NEW YORK
	.word	20	;ORLANDO
	.word	12 ;20	;PHILADELPHIA
	.word	20	;PHOENIX
	.word	20	;PORTLAND
	.word	20	;SACRAMENTO
	.word	20	;SAN ANTONIO
	.word	20	;SEATTLE
	.word	20	;TORONTO
	.word	12	;UTAH
	.word	6	;VANCOUVER
	.word	20	;WASHINGTON

;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
our_names
	.long	JAPPLE		;00 JEFF JOHNSON
	.long	DIVITA		;01 SAL DIVITA
	.long	TURMELL		;02 TURMELL
	.long	THOMPS		;03 THOMPSON
	.long	GEER		;04 GEER 
	.long	CARLTON		;05 CARLTON
	.long	HEDRICK		;06 HEDRICK
	.long	HEY		;07 JOHN HEY
	.long	AIRMOR		;08 AIR MORRIS
	.long	BARDO		;09 STEVE BARDO
	.long	MINIFE		;10 MINIFEE
	.long	MARTIN		;11 MARTINEZ
	.long	PESINA		;12 PESINA
	.long	LIPTAK		;13 LIPTAK
	.long	FERRIER		;14 EDDIE
	.long	VINIK		;15 MIKE V.
	.long	RIVETT		;16 JAMIE R.
	.long	EHRLICH		;17 NICK ERICH
	.long	ROOT		;18 JOHN ROOT
	.long	MEDNICK		;19 C. MEDNICK
	.long	ROAN		;20 DAN R.
	.long	FITZ		;21 PAT F.
	.long	BOON		;22 ED BOOM
	.long	TOBIAS		;23 JOHN TOBIAS
	.long	OURSLER		;24 SHERIDAN OURSLER
	.long	AIRMOR		;25 JASON S.
	.long	QUINN		;26 QUINN
	.long	PERRY		;27 PERRY from "FRIENDS"
	.long	FUNK		;28 NEIL FUNK
	.long	MDOC		;29 MDOC
	.long	FUNK		;30 BUD
	.long	MURESAN		;31 MARIUS
	.long	MUNDAY		;32 MUNDAY
	.long	NORTH		;33 NORTH
	.long	AMRICH		;34 AMRICH 
	.long	JIGGETTS	;35 JIGGETS
	.long	ZIRIN		;36 ZIRIN
	.long	HBETT		;37 HEITH BETTLEMAN
	.long	MBETT		;38 MATT BETTLEMAN
;DJT Start
	.long	FUNK		;39 KEVIN DAY
;DJT End

;Superstar special guests
	.long	PIPPEN
	.long	RODMAN
	.long	JOHNSN_L
	.long	RICE
	.long	KIDD
	.long	MUTUMBO
	.long	GHILL
	.long	OLAJUWON
	.long	MILLER
	.long	SMITS
	.long	MOURN
	.long	GROBINSO
	.long	EWING
	.long	STARKS
	.long	AHARDAWAY
	.long	GRANT_HC
	.long	STACKHOU
	.long	CROBINSON
	.long	DROBINSON
	.long	ELLIOT2
	.long	KEMP
	.long	MALONE_K
	.long	WEBBER
	.long	MURESAN

;New Superstar special guests removed from teams
	.long	MCCLOUD
	.long	TMILLS
	.long	SMITH
	.long	MCKEE2
	.long	CHAPMAN
	.long	BENJAMIN
	.long	DOUGLAS
	.long	WEBB
	.long	GILLIAM
	.long	KEDWARDS
	.long	OAKLEY
	.long	RUFFIN
	.long	WPERSON
	.long	FINLEY
	.long	BWILLIAM
	.long	PERSON
	.long	ROBERTSON
	.long	OMILLER
	.long	TMURRAY
	.long	BENOIT
	.long	SCOTT
	.long	EMURDOCK
;DJT End


;-----------------------------------------------------------------------------
; This table contains:
;
; 1) Design team and company worker BIG heads
;	  'used with SPECIAL_HEADS' variable
;-----------------------------------------------------------------------------
our_heads
	.long	JEF_MUG		;0  JEFF JOHNSON
	.long	SAL_MUG		;1  SAL DIVITA
	.long	TUR_MUG		;2  TURMELL
	.long	DAN_MUG		;3  THOMPSON
	.long	EUG_MUG		;4  GEER 
	.long	JMC_MUG		;5  CARLTON
	.long	JEN_MUG		;6  HEDRICK
	.long	HEY_MUG		;7  JOHN HEY
	.long	WIL_MUG		;8  AIR MORRIS
	.long	BAR_MUG		;9  STEVE BARDO
	.long	MIN_MUG		;10 MINIFEE
	.long	MARTY_MUG	;11 MARTINEZ
	.long	CARL_MUG	;12 PESINA
	.long	SHN_MUG		;13 LIPTAK
	.long	EDD_MUG		;14 EDDIE
	.long	MXV_MUG		;15 MIKE V.
	.long	JAM_MUG		;16 JAMIE R.
	.long	NIK_MUG		;17 NICK ERICH
	.long	ROT_MUG		;18 JOHN ROOT
	.long	CAR_MUG		;19 C. MEDNICK
	.long	ROH_MUG		;20 DAN ROAN ?
	.long	PAT_MUG		;21 PAT F.
	.long	BOO_MUG		;22 BOON
	.long	TOB_MUG		;23 TOBIAS
	.long	OUR_MUG		;24 OURSLER
	.long	JAS_MUG		;25 JASON S.
	.long	QUI_MUG		;26 QUINN
	.long	PER_MUG		;27 M. PERRY
	.long	NEI_MUG		;28 NEIL FUNK
	.long	MDOC_MUG	;29 MDOC
	.long	BUD_MUG		;30 BUD
	.long	OLD		;31 MARIUS
	.long	MUN_MUG		;32 MUNDAY
	.long	NOR_MUG		;33 NORTH
	.long	AMR_MUG		;34 AMRICH 
	.long	JIG_MUG		;35 JIGGETS
;DJT Start
	.long	JON_MUG		;36 ZIRIN
	.long	HEI_MUG		;37 HEITH BETTLEMAN
	.long	MAT_MUG		;38 MATT BETTLEMAN
	.long	BAL_MUG		;39 KEVIN DAY

;Superstar special guests
	.long	PIP_CHI
	.long	ROD_CHI
	.long	JON_CHA
	.long	RCE_CHA
	.long	KID_DAL
	.long	MUT_DEN
	.long	HIL_DET
	.long	OLA_HOU
	.long	MIL_IND
	.long	SMI_IND
	.long	MOU_MIA
	.long	ROB_MLW
	.long	EWG_NEY
	.long	STA_NEY
	.long	HAR_ORL
	.long	GRT_ORL
	.long	STA_PHL
	.long	ROB_PRT
	.long	ROB_SAN
	.long	ELL_SAN
	.long	KMP_SEA
	.long	MLN_UTA
	.long	WEB_WAS
	.long	MUR_WAS

;New Superstar special guests removed from teams
	.long	MCC_DAL
	.long	MLS_DET
	.long	SMT_HOU
	.long	MCK_IND
	.long	CHP_MIA
	.long	BEN_MLW
	.long	DOU_MLW
	.long	WEB_MIN
	.long	GIL_NEJ
	.long	EDW_NEJ
	.long	OAK_NEY
	.long	RUF_PHL
	.long	PER_PHX
	.long	FIN_PHX
	.long	WIL_PRT
	.long	PRS_SAN
	.long	ROB_TOR
	.long	MIL_TOR
	.long	MUR_TOR
	.long	BEN_UTA
	.long	SCO_VAN
	.long	MUR_VAN

our_heads_end
	.long	SAL_MUG		;0		;repeat 1st 2 for wrap around
	.long	SAL_MUG		;1
our_heads_end2



	.end