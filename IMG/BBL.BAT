mkdir c:\tmp\hangtx
mkdir c:\tmp\hangtx\bb
mkdir c:\tmp\hangtx\bb2
mkdir c:\tmp\hangtx\bb3
mkdir c:\tmp\hangtx\bb4
mkdir c:\tmp\hangtx\bb5

:DOBB
load2 BB    /e /di /fi /t=c:\tmp\hangtx\bb /x /v
del   c:\tmp\hangtx\bb\imgtbl.asm
ren   c:\tmp\hangtx\bb\imgtbl.glo imgtbl1.glo
ren   c:\tmp\hangtx\bb\imgpal.asm imgpal1.asm
pause
:DOBB2
load2 BB2   /e /di /fi /t=c:\tmp\hangtx\bb2 /x /v
del   c:\tmp\hangtx\bb2\imgtbl.asm
ren   c:\tmp\hangtx\bb2\imgtbl.glo imgtbl2.glo
ren   c:\tmp\hangtx\bb2\imgpal.asm imgpal2.asm
pause
:DOBB3
load2 BB3   /e /di /fi /t=c:\tmp\hangtx\bb3 /x /v
del   c:\tmp\hangt\bb3\imgtbl.asm
del   c:\tmp\hangt\bb3\imgtbl.glo
ren   c:\tmp\hangt\bb3\imgpal.asm imgpal3.asm
:DOBB4
load2 BB4   /e /di /fi /t=c:\tmp\hangtx /x /v
ren   c:\tmp\hangtx\imgpal.asm imgpal4.asm

:DOBB5
load2 BB5   /e /di /fi /t=c:\tmp\bb /x /v
del   c:\tmp\hangtx\imgtbl.asm
del   c:\tmp\hangtx\imgtbl.glo
ren   c:\tmp\hangtx\imgpal.asm imgpal5.asm

:DOBB6
load2 BB6   /e /di /fi /t=c:\tmp\bb /x /v
del   c:\tmp\hangt\imgtbl.asm
del   c:\tmp\hangt\imgtbl.glo
ren   c:\tmp\hangt\imgpal.asm imgpal6.asm

:DOBB7
load2 BB7   /e /di /fi /t=c:\tmp\bb /x /v
del   c:\tmp\hangtx\imgtbl.asm
ren   c:\tmp\hangtx\bgndpal.asm bgndpal7.asm
ren   c:\tmp\hangtx\bgndtbl.asm bgndtbl7.asm
ren   c:\tmp\hangtx\bgndtbl.glo bgndtbl7.glo
ren   c:\tmp\hangtx\bgndequ.h   bgndequ7.h
ren   c:\tmp\hangtx\imgtbl.glo imgtbl7.glo
ren   c:\tmp\hangtx\imgpal.asm imgpal7.asm

:DOBB8
load2 BB8   /e /di /fi /t=c:\tmp\bb /x /v
del   c:\tmp\hangtx\imgtbl.asm
del   c:\tmp\hangtx\imgtbl.glo
ren   c:\tmp\hangtx\imgpal.asm imgpal8.asm

:DOBBMUG
load2 BBMUG /e /di /fi /t=c:\tmp\bb /x /v
del   c:\tmp\hangtx\imgtbl.asm
ren   c:\tmp\hangtx\imgtbl.glo imgtblm.glo
ren   c:\tmp\hangtx\imgpal.asm imgpalm.asm

:DOBBPAL
load2 BBPAL /e /di /t=c:\tmp\bb /x /v
del   c:\tmp\hangtx\imgtbl.asm
ren   c:\tmp\hangtx\imgtbl.glo imgtblp.glo
ren   c:\tmp\hangtx\imgpal.asm imgpalp.asm

:DOMISC
load2 MISC  /e /di /fi /tc /x /v

:END
rd c:\tmp\bb
if exist junkxxxx.* del junkxxxx.*
if exist l2temp     del l2temp
if exist *.~sm      del *.~sm
if exist *.~bl      del *.~bl
echo.
echo Done.
