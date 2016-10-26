@echo off
echo Do you want to DELETE delphi compiler generated files? 
echo * * * pres ctrl+c to exit batch job * * *
echo (This batch job will delete some files in this folder and in all
echo sub folders) 
echo =================================================================
pause
del *.bak /s
del *.dcu /s
del *.dsk /s /p
del *.exe /s /p
del *.pas~ /s
del *.~pas /s
del *.~bpg /s
del *.~df /s
del *.~dfm /s
del *.~dp /s
del *.~dpr /s
del *.~dpk
del *.~dsk /s
del *.~pa /s
del *.~tlb /s
del *.~txt /s
del *.~ddp /s
echo end.
@echo on
pause