@ECHO off

REM -- Check run with administrator privileges
NET SESSION >NUL 2>&1
IF NOT %errorLevel% == 0 (
    ECHO "ERROR: RUN AS ADMIN ONLY!!!"
    PAUSE
    EXIT /B 0
)

CD "%~dp0"
START "" "%~dp0\Resource\_installAll.bat"
START "" "%~dp0\Resource_Extra\_installAll_Extra.bat"
