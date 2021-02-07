@echo off
SET THEFILE=f:\progra~1\pascal\peminj~1\peminj~1.exe
echo Linking %THEFILE%
c:\dev-pas\bin\ldw.exe  F:\PROGRA~1\Pascal\PEMINJ~1\rsrc.o -s   -b base.$$$ -o f:\progra~1\pascal\peminj~1\peminj~1.exe link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
