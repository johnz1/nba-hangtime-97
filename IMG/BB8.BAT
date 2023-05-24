:DOBB8
load2 BB8   /e /di /fi /t=c:\tmp\bb /x /v
del  >nul c:\tmp\bb\imgtbl.asm
del  >nul c:\tmp\bb\imgtbl.glo
ren  >nul c:\tmp\bb\imgpal.asm imgpal8.asm
move >nul /Y ~bbltmp\*.* .
if "%~bblall%"=="0" goto END
