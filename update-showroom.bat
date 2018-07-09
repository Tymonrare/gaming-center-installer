@echo off

if exist ".\bin\showroom-type" (
	set /P sh_type=<.\bin\showroom-type
) else (
	set /P sh_type="Enter showroom type (xd-default for example): " %=%
)

if [%sh_type%] == [] (
	echo.Empty input: Skip install.
	exit /B
)

if "%sh_type%" == "none" (
	echo."None" type input: Skip install.
	echo.%sh_type%>.\bin\showroom-type
	exit /B
)

echo.Update showroom files:

:: Set vars
:: set download="https://drive.google.com/uc?export=download&id=1fEns2ae9QePDdoujNxxrGzy4M-DZE7aZ"
set download="http://d3i8w87ms3cidi.cloudfront.net/bin/showrooms/%sh_type%.7z"
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
	echo "Download error. Check type (%saveAs%) name and try again"
	pause
	exit /B
)

:: Check if file not archive
set /p file_data=<%saveAs%

echo."%file_data%" | findstr /C:"xml version" 1>nul
:: means it isn't xml file
if errorlevel 1 (
	:: Do not overwrite ini, copy rest
	%zipPath% x %saveAs% -aoa -r -o.\bin\showroom

	:: Delete downloaded file
	del %saveAs%

	echo.%sh_type%>.\bin\showroom-type
) else (
  echo.%sh_type% can't be downloaded
)