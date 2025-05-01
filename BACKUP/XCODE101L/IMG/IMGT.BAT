cd myht\backup\xcode1~3\img
mkdir c:\tmp\htextra
loadw misc2 /t=c:\tmp\htextra /FI /E >haha
loadw misc3 /t=c:\tmp\htextra /FI /E >haha
rem shatter imgs
del c:\myht\backup\xcode1~3\shatter.tbl
copy c:\tmp\htextra\shatter.tbl c:\myht\backup\xcode1~3\shatter.tbl
rem storm and fence
del c:\myht\backup\xcode1~3\storm.tbl
copy c:\tmp\htextra\storm.tbl c:\myht\backup\xcode1~3\storm.tbl
rem benched players & coach anims
del c:\myht\backup\xcode1~3\crowd2.tbl
copy c:\tmp\htextra\crowd2.tbl c:\myht\backup\xcode1~3\crowd2.tbl
rem broken hoop angles
del c:\myht\backup\xcode1~3\hoop.tbl
copy c:\myht\backup\xcode1~3\hoop_a.tbl C:\myht\backup\xcode1~3\hoop.tbl
type c:\tmp\htextra\hoop2.tbl >> c:\myht\backup\xcode1~3\hoop.tbl
rem shang
del c:\myht\backup\xcode1~3\shang.tbl
copy c:\tmp\htextra\shang.tbl c:\myht\backup\xcode1~3\shang.tbl
pause
exit
