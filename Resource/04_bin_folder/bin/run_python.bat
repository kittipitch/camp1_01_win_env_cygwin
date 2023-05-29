@echo off

REM Python3 cygwin
REM C:\cygwin\bin\mintty.exe -t %1 -h always -e python3 %1 %2
REM Python3 External
REM C:\cygwin\bin\mintty.exe -t %1 -h always -e /cygdrive/c/Python34/pythonw.exe %1 %2
REM Miniconda3
C:\cygwin\bin\mintty.exe -t %1 -h always -e /cygdrive/c/Miniconda3/pythonw.exe %1 %2

exit