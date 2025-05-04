rem working with nbamht!
DCSEncoder.exe -o nbatest10.zip --stream-dir=.\input --patch .\ORIGROM\nba.zip rebuild.scr >rebuild.txt
rem DCSexplorer.exe -p nbatest10.zip >new_prog.txt
mkdir output
cd output
del *.u*
unzip ..\nbatest10.zip
pause
rem We're now overflowing into bigger romset, and the encoder names this file wrong!
rem we need to update MAME for this!
ren l1.0_nba_hangtime_u_6_music_spch.u5 *.u6
zip d:\mame\roms\nbamht.zip .\l1.0_*.u*
cd \mame
mame.exe nbamht -debug


