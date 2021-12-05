@echo off
setlocal enableextensions
pushd "%~dp0"

CALL :GETPARENT PARENT
IF /I "%PARENT%" == "powershell" goto :ISPOWERSHELL
IF /I "%PARENT%" == "pwsh" goto :ISPOWERSHELL

if ERRORLEVEL 1 goto error 

goto :build 

:build 

call npm run dev

call cargo build -p %*

call robocopy /e ".\resources" ".\target\debug"
call robocopy /e ".\resources" ".\target\release"

call cargo run -p %*

if ERRORLEVEL 1 goto error
goto :EOF 

:ISPOWERSHELL 

echo POWERSHELL DETECTED

goto :build 

:error 
echo Error Occured.
pause
goto :EOF

:GETPARENT
SET "PSCMD=$ppid=$pid;while($i++ -lt 3 -and ($ppid=(Get-CimInstance Win32_Process -Filter ('ProcessID='+$ppid)).ParentProcessID)) {}; (Get-Process -EA Ignore -ID $ppid).Name"
for /f "tokens=*" %%i in ('powershell -noprofile -command "%PSCMD%"') do SET %1=%%i
goto :EOF
