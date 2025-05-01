rem working with nbamht!
DCSEncoder.exe -o nbatest10.zip --stream-dir=.\input --patch .\ORIGROM\nba.zip rebuild.scr >rebuild.txt
rem DCSexplorer.exe -p nbatest10.zip >new_prog.txt
mkdir output
cd output
del *.u*
unzip ..\nbatest10.zip
pause
zip d:\mame\roms\nbamht.zip .\l1.0_*.u*
cd \mame
mame.exe nbamht -debug


