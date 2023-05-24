@echo off
md c:\tmp
md c:\tmp\bb
load2.exe bb /P /di /fi /t=c:\tmp\bb /x /v
load2.exe bb2 /A /P /di /fi /t=c:\tmp\bb /x /v
load2.exe bb3 /A /P /di /fi /t=c:\tmp\bb /x /v
load2.exe bb4 /A /P /di /fi /t=c:\tmp\bb /x /v
load2.exe bb5 /A /P /di /fi /t=c:\tmp\bb /x /v
load2.exe bb6 /A /P /di /fi /t=c:\tmp\bb /x /v
load2.exe bb7 /A /P /di /fi /t=c:\tmp\bb /x /v
load2.exe bb8 /A /P /di /fi /t=c:\tmp\bb /x /v
load2.exe bbmug /A /P /di /fi /t=c:\tmp\bb /x /v
load2.exe bbpal /A /P /di /fi /t=c:\tmp\bb /x /v
load2.exe bbvda /A /P /di /fi /t=c:\tmp\bb /x /v
rem this cause dosbox to crash :(
rem load2.exe misc /A /P /di /fi /t=c:\tmp\bb /x /v