/*	Game linker command file					*/
/*-e WARMSET*/			/* entry point of program		*/
-e init_prog			/* entry point of program		*/
-f 0xFFFF			/* fill unspecified memory with value	*/
-o BB.out	/* specify output file			*/
/*-m BB.map	/* map file				*/
-s				/* kill the symbol table		*/

ADJUST.OBJ		/* TEST MENUS ADJUSTMENT CODE */
AUDIT.OBJ		/* audits and adjustments handling */
TEST.OBJ		/* test program */
DIAG.OBJ		/* SYSTEM DIAGNOSTICS CODE */
MENU.OBJ		/* test menus */
HSTD.OBJ		/* robo high-score-to-date management */

MEMORY				/* set up memory for sdb board */
{
 SCRATCH	: org = 0x01000000,	len = 0x3f7300
 SCRATCHTV	: org = 0x013f7300,	len = 0x8d00
 ROM		: org = 0xFF800000,	len = 0x7F6F00
 ROMTV		: org = 0xFFFF6F00,	len = 0x8D00
 TRAP31		: org = 0xFFFFFC00,	len = 0x400
 IROM		: org = 0x02000000,	len = 0x400000
}

SECTIONS			/* linker sections directive */
{
	VECTORS: {} > TRAP31
	IMAGES:  {} > IROM
	GROUP:
	      {
	        shit: {}
	        SHIT: {}
	      } > ROMTV
	GROUP:
	      {
	        STACK: {}
	        PRCBSS: {}
	        OBJBSS: {}
	       .BSS: {}
	       .bss: {}
	      } > SCRATCH

	.text:	{}	> ROM
	.TEXT:	{}	> ROM
	.data:	{}	> ROM
	.DATA:	{}	> ROM
        img_tbl: {}	> ROM
}

