@echo off

REM Enable delayed variable expansion
setlocal enabledelayedexpansion

REM check for Perforce root folder, set var if exists
if not exist "C:\Program Files\Perforce\p4.exe" (
    echo Perforce CLI is not installed in Program Files folder
    goto Exit
) else (
set "perforcePath=C:\Program Files\Perforce"
)

REM Set the path to the Perforce installation directory
set "perforcePath=C:\Program Files\Perforce"

REM [change the address to desired one for script to run correctly]
set server=example.corp.loc:1222

REM Change directory to the Perforce installation directory
cd /d "%perforcePath%"

REM connect to required server. 
p4 set P4PORT=%server%
:auth_check
p4 login -s

REM Check the errorlevel to determine if the command was successful
if %errorlevel% equ 0 (
    goto success
) else (
    goto failure
)
:failure
echo An error occurred. Enter your credentials again.
REM Prompt the user for credentials
set /p "cred=Enter your short credentials: "
p4 set P4USER=!cred!
REM login
p4 -u !cred! login
goto auth_check

:success
echo Log-in executed successfully.

REM Prompt the user for the change version threshold
:revision
set /p "threshold=Enter the change version threshold: "
echo !threshold!> "%~dp0\revision.txt"
findstr /R "^[0-9]*$" "%~dp0\revision.txt"
if %errorlevel% equ 0 (
    REM Execute the Perforce command to get the changes and store the output in a text file
    p4 changes -l -e !threshold! > "%~dp0\commits_since_!threshold!.txt"
    del "%~dp0\revision.txt"
    REM Open the text file with the default text editor
    start "" "%~dp0\commits_since_!threshold!.txt"
    cd %~dp0
    python "%~dp0\commit_parser.py"
) else (
    echo Revision number is wrong. Enter only numbers.
    del "%~dp0\revision.txt"
    goto revision
)
pause
REM Exit the script
exit