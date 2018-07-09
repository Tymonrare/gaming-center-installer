@echo off

cmd /c "install.bat"

echo.Update app files:

:: Set vars
:: set download="https://drive.google.com/uc?export=download&id=1fEns2ae9QePDdoujNxxrGzy4M-DZE7aZ"
set download="http://d3i8w87ms3cidi.cloudfront.net/bin/win/GamingCenter-bin.7z"
set saveAs=cache
set zipPath=".\res\7za.exe"

:: Clear old file
if exist ./%saveAs% (
	del %saveAs%
)

echo. Downloading recent version..

:: Download
cscript /nologo res\download.js %download% ./%saveAs%

:: Print error if not downloaded
if not exist ./%saveAs% (
	echo "Download error, try again"
	pause
	break
)

:: Backup old one
xcopy .\bin .\_backup\ /s /e /y

:: Clear old .ini duples
del /s /q .\bin\*_1.ini

:: Do not overwrite ini, copy rest
%zipPath% x %saveAs% -aoa -xr!*.ini
%zipPath% x %saveAs% -aou *.ini -r

:: Delete downloaded file
del %saveAs%

pause