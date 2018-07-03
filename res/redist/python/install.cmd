::
: Y.CMD - Test if pattern in string
: P1 - the pattern
: P2 - the string to check
::
@echo off

FOR /F "tokens=* USEBACKQ" %%F IN (`python -V`) DO (
SET var=%%F
)

echo.%var% | findstr /C:"Python" 1>nul

if errorlevel 1 (
  .\python-3.7.0.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
) ELSE (
  echo. %var% already installed
)