mkdir c:\tmp\hangtx
mkdir c:\tmp\hangtx\bb
mkdir c:\tmp\hangtx\bb2
mkdir c:\tmp\hangtx\bb3
mkdir c:\tmp\hangtx\bb4
mkdir c:\tmp\hangtx\bb5
mkdir c:\tmp\hangtx\bb6
mkdir c:\tmp\hangtx\bb7
mkdir c:\tmp\hangtx\bb8
mkdir c:\tmp\hangtx\bbmug
mkdir c:\tmp\hangtx\bbpal
mkdir c:\tmp\hangtx\bbmisc
mkdir c:\tmp\hangtx\bbvda
mkdir c:\tmp\hangtx\irw

:DOBB
load2 BB    /e /di /f=c:\tmp\hangtx\irw /t=c:\tmp\hangtx\bb /x /v
del   c:\tmp\hangtx\bb\imgtbl.asm
ren   c:\tmp\hangtx\bb\imgtbl.glo imgtbl1.glo
ren   c:\tmp\hangtx\bb\imgpal.asm imgpal1.asm
pause
:DOBB2
load2 BB2   /e /di /f=c:\tmp\hangtx\irw /t=c:\tmp\hangtx\bb2 /x /v
del   c:\tmp\hangtx\bb2\imgtbl.asm
ren   c:\tmp\hangtx\bb2\imgtbl.glo imgtbl2.glo
ren   c:\tmp\hangtx\bb2\imgpal.asm imgpal2.asm
pause
:DOBB3
load2 BB3   /e /di /f=c:\tmp\hangtx\irw /t=c:\tmp\hangtx\bb3 /x /v
del   c:\tmp\hangtx\bb3\imgtbl.asm
del   c:\tmp\hangtx\bb3\imgtbl.glo
ren   c:\tmp\hangtx\bb3\imgpal.asm imgpal3.asm
:DOBB4
load2 BB4   /e /di /f=c:\tmp\hangtx\irw /t=c:\tmp\hangtx\bb4 /x /v
ren   c:\tmp\hangtx\bb4\imgpal.asm imgpal4.asm

:DOBB5
load2 BB5   /e /di /f=c:\tmp\hangtx\irw /t=c:\tmp\hangtx\bb5 /x /v
del   c:\tmp\hangtx\bb5\imgtbl.asm
del   c:\tmp\hangtx\bb5\imgtbl.glo
ren   c:\tmp\hangtx\bb5\imgpal.asm imgpal5.asm

:DOBB6
load2 BB6   /e /di /f=c:\tmp\hangtx\irw /t=c:\tmp\hangtx\bb6 /x /v
del   c:\tmp\hangtx\bb6\imgtbl.asm
del   c:\tmp\hangtx\bb6\imgtbl.glo
ren   c:\tmp\hangtx\bb6\imgpal.asm imgpal6.asm

:DOBB7
load2 BB7   /e /di /f=c:\tmp\hangtx\irw /t=c:\tmp\hangtx\bb7 /x /v
del   c:\tmp\hangtx\bb7\imgtbl.asm
ren   c:\tmp\hangtx\bb7\bgndpal.asm bgndpal7.asm
ren   c:\tmp\hangtx\bb7\bgndtbl.asm bgndtbl7.asm
ren   c:\tmp\hangtx\bb7\bgndtbl.glo bgndtbl7.glo
ren   c:\tmp\hangtx\bb7\bgndequ.h   bgndequ7.h
ren   c:\tmp\hangtx\bb7\imgtbl.glo imgtbl7.glo
ren   c:\tmp\hangtx\bb7\imgpal.asm imgpal7.asm

:DOBB8
load2 BB8   /e /di /f=c:\tmp\hangtx\irw /t=c:\tmp\hangtx\bb8 /x /v
del   c:\tmp\hangtx\bb8\imgtbl.asm
del   c:\tmp\hangtx\bb8\imgtbl.glo
ren   c:\tmp\hangtx\bb8\imgpal.asm imgpal8.asm

:DOBBMUG
load2 BBMUG /e /di /f=c:\tmp\hangtx\irw /t=c:\tmp\hangtx\bbmug /x /v
del   c:\tmp\hangtx\bbmug\imgtbl.asm
ren   c:\tmp\hangtx\bbmug\imgtbl.glo imgtblm.glo
ren   c:\tmp\hangtx\bbmug\imgpal.asm imgpalm.asm

:DOBBPAL
load2 BBPAL /e /di /f=c:\tmp\hangtx\irw /t=c:\tmp\hangtx\bbpal /x /v
del   c:\tmp\hangtx\bbpal\imgtbl.asm
ren   c:\tmp\hangtx\bbpal\imgtbl.glo imgtblp.glo
ren   c:\tmp\hangtx\bbpal\imgpal.asm imgpalp.asm

:DOMISC
load2 MISC  /e /di /f=c:\tmp\hangtx\irw /t=c:\tmp\hangtx\bbmisc /x /v

:DOVDA
load2 BBVDA  /e /di /f=c:\tmp\hangtx\irw /t=c:\tmp\hangtx\bbvda /x /v

:END
echo.
echo Done.
