@echo off

echo.Perform installation operations

setx GAMING_CENTER_ROOT "%cd%"

cmd /c "res\redist\python\install.bat"
