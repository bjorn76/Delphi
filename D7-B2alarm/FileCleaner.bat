@echo off
echo Do you want to DELETE delphi compiler generated files? 
echo * * * pres ctrl+c to exit batch job * * *
echo (This batch job will delete some files in this folder and in all
echo sub folders) 
echo =================================================================
pause
del *.~ddp /s
del *.bak /s
del *.dsk /s
del *.exe /s /p
del *.pas~ /S
del *.~bpg /s
del *.~df /s
del *.~dp /s
del *.~dpk
del *.~dsk /s
del *.~pa /s
del *.~tlb /s
del *.~txt /s
del *.~dti /s
del *.~todo /s
del *.dcu
echo end.
@echo on
pause