@ECHO OFF
SETLOCAL

REM -- Change to the directory of the executing batch file
CD "%~dp0"

REM -- Create local repo for cygwin
MD C:\cygwin_local
REM -- Configure our paths
SET SITE=http://mirror1.ku.ac.th/cygwin/
SET LOCALDIR=C:/cygwin_local
SET ROOTDIR=C:/cygwin

REM -- SET variable
SET Cygwin=01_cygwin
SET Sublime=02_sublime_text_build_4143_x64_setup.exe

 REM -- These are the packages we will install (in addition to the default packages)
SET PACKAGES=mintty,git
REM -- These are necessary for sage install, do not change. Any duplicates will be ignored.
SET PACKAGES=%PACKAGES%,wget,tar,gawk,bzip2
REM -- Install devel packge.
SET PACKAGES=%PACKAGES%,zip,unzip,make,automake,gcc-core,gcc-g++
 
REM -- Do it!
echo "*** INSTALLING DEFAULT PACKAGES"
"%~dp0\%Cygwin%" -B -A --quiet-mode --no-desktop --download --local-install --no-verify -s %SITE% -l "%LOCALDIR%" -R "%ROOTDIR%"
echo.
echo.
echo "*** INSTALLING CUSTOM PACKAGES"
"%~dp0\%Cygwin%" -B -A -q -d -D -L -X -s %SITE% -l "%LOCALDIR%" -R "%ROOTDIR%" -P %PACKAGES%

echo.
echo.
echo "cygwin installation updated"
echo " - %PACKAGES%"
echo.

REM "Installing sublime text"
ECHO "Installing Sublime Text 3"
"%~dp0\%Sublime%" /VERYSILENT /NORESTART /TASKS="contextentry"
COPY "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Sublime Text.lnk" "%UserProfile%\Desktop\"


REM "Setting config"
ROBOCOPY "%~dp0\03_APPDATA" %APPDATA% /s /XF desktop.ini

REM "build shortcut for sublime (run with control+shift+b)"
rmdir /s /q c:\bin
ROBOCOPY "%~dp0\04_bin_folder" c:\ /s /XF desktop.ini

REM "Add PATH"
CALL "%~dp0\05_setPATH.bat"

REM  "Creating a context menu to open with sublime text"
IF DEFINED ProgramFiles(x86) (
    ECHO "64bit"
    regedit /s "%~dp0\06_1_sublime_x64_context_menu.reg"
) ELSE (
    ECHO "32bit"
    regedit /s "%~dp0\06_1_sublime_x86_context_menu.reg"
)

REM  "Creating a context menu to start bash shell"
ECHO "Creating a context menu to start bash shell"
regedit /s "%~dp0\06_2_CygwinX86_bash_open_here_ENABLE.reg"

REM  Enable 'open command window here' shell extension
ECHO "Enable 'open command window here' shell extension"
regedit /s "%~dp0\06_3_Open_command_window_here_ENABLE.reg"
regedit /s "%~dp0\06_4_Open_PowerShell_here_ENABLE.reg"

c:\cygwin\bin\mintty.exe -h error -e "%~dp0/cygwinInit.sh"

ENDLOCAL

echo "Done"
PAUSE
EXIT /B 0
