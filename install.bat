@echo off

echo.Perform installation operations^

setx GAMING_CENTER_ROOT "%cd%"

if not exist .\res\redist\python\python-3.7.0.exe (
 echo. Download Python installer...
 cscript /nologo update.js https://www.python.org/ftp/python/3.7.0/python-3.7.0.exe .\res\redist\python\python-3.7.0.exe
)

cmd /c "res\redist\python\install.bat"

echo.