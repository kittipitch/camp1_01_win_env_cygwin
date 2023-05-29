@ECHO off
SET TEMP_PATH=%PATH%

REM Append C:\cygwin\bin and C:\bin
SET toAdd=C:\msys2\mingw64\bin
CALL "%~dp0\inPath" toAdd
IF ERRORLEVEL==1 SET TEMP_PATH="%TEMP_PATH%;%toAdd%"

SET toAdd=C:\bin
CALL "%~dp0\inPath" toAdd
IF ERRORLEVEL==1 SET TEMP_PATH="%TEMP_PATH%;%toAdd%"


set TEMP_PATH=%TEMP_PATH:"=%
REM echo %TEMP_PATH%
SETX PATH "%TEMP_PATH%" /M
