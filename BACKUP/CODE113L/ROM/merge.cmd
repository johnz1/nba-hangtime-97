@echo off
copy /b ht113f8.0 + ht113fc.0  l1.3_nba_hangtime_u_54_game_rom.u54
copy /b ht113f8.1 + ht113fc.1  l1.3_nba_hangtime_u_63_game_rom.u63
del *.0 *.1
rem uncomment and add orig roms to build flat merged bin.
c:\bin\far\srec_cat -o ROM_MINE.bin -binary l1.3_nba_hangtime_u_54_game_rom.u54 -binary -unsplit 2 0 l1.3_nba_hangtime_u_63_game_rom.u63 -binary -unsplit 2 1
