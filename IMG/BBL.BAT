:DOBB
load2 BB    /e /di /fi /t=c:\tmp\bb /x /v
del   c:\tmp\bb\imgtbl.asm
ren   c:\tmp\bb\imgtbl.glo imgtbl1.glo
ren   c:\tmp\bb\imgpal.asm imgpal1.asm
pause
cd c:\hangtime\img
:DOBB2
load2 BB2   /e /di /fi /t=c:\tmp\bb /x /v
del   c:\tmp\bb\imgtbl.asm
ren   c:\tmp\bb\imgtbl.glo imgtbl2.glo
ren   c:\tmp\bb\imgpal.asm imgpal2.asm
pause
cd c:\hangtime\img
:DOBB3
load2 BB3   /e /di /fi /t=c:\tmp\bb /x /v
del   c:\tmp\bb\imgtbl.asm
del   c:\tmp\bb\imgtbl.glo
ren   c:\tmp\bb\imgpal.asm imgpal3.asm
cd c:\hangtime\img

:DOBB4
load2 BB4   /e /di /fi /t=c:\tmp\bb /x /v
ren   c:\tmp\bb\imgpal.asm imgpal4.asm
cd c:\hangtime\img

:DOBB5
load2 BB5   /e /di /fi /t=c:\tmp\bb /x /v
del   c:\tmp\bb\imgtbl.asm
del   c:\tmp\bb\imgtbl.glo
ren   c:\tmp\bb\imgpal.asm imgpal5.asm
cd c:\hangtime\img

:DOBB6
load2 BB6   /e /di /fi /t=c:\tmp\bb /x /v
del   c:\tmp\bb\imgtbl.asm
del   c:\tmp\bb\imgtbl.glo
ren   c:\tmp\bb\imgpal.asm imgpal6.asm
cd c:\hangtime\img

:DOBB7
load2 BB7   /e /di /fi /t=c:\tmp\bb /x /v
del   c:\tmp\bb\imgtbl.asm
ren   c:\tmp\bb\bgndpal.asm bgndpal7.asm
ren   c:\tmp\bb\bgndtbl.asm bgndtbl7.asm
ren   c:\tmp\bb\bgndtbl.glo bgndtbl7.glo
ren   c:\tmp\bb\bgndequ.h   bgndequ7.h
ren   c:\tmp\bb\imgtbl.glo imgtbl7.glo
ren   c:\tmp\bb\imgpal.asm imgpal7.asm
cd c:\hangtime\img

:DOBB8
load2 BB8   /e /di /fi /t=c:\tmp\bb /x /v
del   c:\tmp\bb\imgtbl.asm
del   c:\tmp\bb\imgtbl.glo
ren   c:\tmp\bb\imgpal.asm imgpal8.asm
cd c:\hangtime\img

:DOBBMUG
load2 BBMUG /e /di /fi /t=c:\tmp\bb /x /v
del   c:\tmp\bb\imgtbl.asm
ren   c:\tmp\bb\imgtbl.glo imgtblm.glo
ren   c:\tmp\bb\imgpal.asm imgpalm.asm
cd c:\hangtime\img

:DOBBPAL
load2 BBPAL /e /di /t=c:\tmp\bb /x /v
del   c:\tmp\bb\imgtbl.asm
ren   c:\tmp\bb\imgtbl.glo imgtblp.glo
ren   c:\tmp\bb\imgpal.asm imgpalp.asm
cd c:\hangtime\img

:DOMISC
load2 MISC  /e /di /fi /tc /x /v
cd c:\hangtime\img

:END
rd c:\tmp\bb
if exist junkxxxx.* del junkxxxx.*
if exist l2temp     del l2temp
if exist *.~sm      del *.~sm
if exist *.~bl      del *.~bl
echo.
echo Done.
