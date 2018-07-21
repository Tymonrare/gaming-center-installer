@echo off

echo.Update app files:

:: Set vars
set saveAs=cache
set zipPath=".\res\7za.exe"

:: Clear old file
if exist ./%saveAs% (
	del %saveAs%
)

echo. Downloading recent version..

:: Download
python ./res/py/download-recent-bin.py https://d3i8w87ms3cidi.cloudfront.net bin/app/GamingCenter-win- %saveAs%

:: Print error if not downloaded
if not exist ./%saveAs% (
	echo "Download error, try again"
	pause
	exit /B
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