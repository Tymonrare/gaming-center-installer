@echo off

echo.Perform installation operations

set GAMING_CENTER_ROOT="%cd%"
setx GAMING_CENTER_ROOT "%cd%"

cmd /c "res\redist\python\install.bat"
