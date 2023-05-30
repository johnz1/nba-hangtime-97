:DOVDA
load2 bbvda  /e /di /fi /tc /x /v
cd c:\hangtime\img

:END
rd c:\tmp\bb
if exist junkxxxx.* del junkxxxx.*
if exist l2temp     del l2temp
if exist *.~sm      del *.~sm
if exist *.~bl      del *.~bl
echo.
echo Done.
