@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "FFMPEG=%~dp0..\bin\ffmpeg.exe"
if not exist "%FFMPEG%" (
	echo FFmpeg nao encontrado, baixando...
	timeout 3 >nul
	powershell -c "Import-Module BitsTransfer ; Start-BitsTransfer 'https://drive.google.com/uc?export=download&id=1SFIIYJSomDBGKfuICx1EkFDu-SxiDIRq&confirm=t' '%FFMPEG%'"
	echo pronto!
	timeout 2 >nul
)

set "interval=%~n0"
set "interval=!interval:____= !"
for /f "tokens=1,2 delims= " %%a in ("!interval!") do (
	set "startRaw=%%a"
	set "endRaw=%%b"
)

if not defined startRaw (
	echo Nome do arquivo invalido. Use HH-MM-SS____HH-MM-SS
	exit /b 1
)
if not defined endRaw (
	echo Nome do arquivo invalido. Use HH-MM-SS____HH-MM-SS
	exit /b 1
)

set "start=!startRaw:-=:!"
set "end=!endRaw:-=:!"

call :ValidateTime "!startRaw!" startSec
if errorlevel 1 exit /b 1
call :ValidateTime "!endRaw!" endSec
if errorlevel 1 exit /b 1

if !endSec! LEQ !startSec! (
	echo Intervalo invalido. O tempo final deve ser maior que o inicial.
	exit /b 1
)

set /a total=0
for %%i in (%*) do set /a total+=1
if !total! EQU 0 (
	echo Nenhum arquivo informado. Arraste um ou mais arquivos para este .bat.
	exit /b 1
)

set /a current=0

for %%i in (%*) do (
	set /a current+=1
	echo Processando !current!/!total!: %%~nxi
	call :GetUniqueOutput "%%~fi"
	"%FFMPEG%" -ss !start! -to !end! -i "%%~fi" -c copy "!uniqueOut!"
)

endlocal
exit /b 0

:ValidateTime
set "timeText=%~1"
set "outVar=%~2"
for /f "tokens=1-3 delims=-" %%h in ("%timeText%") do (
	set "hh=%%h"
	set "mm=%%i"
	set "ss=%%j"
)

if not defined hh (
	echo Formato de tempo invalido: %timeText%. Use HH-MM-SS
	exit /b 1
)
if not defined mm (
	echo Formato de tempo invalido: %timeText%. Use HH-MM-SS
	exit /b 1
)
if not defined ss (
	echo Formato de tempo invalido: %timeText%. Use HH-MM-SS
	exit /b 1
)

for /f "delims=0123456789" %%a in ("%hh%") do (
	echo Valor de tempo invalido: %timeText%. Use apenas digitos.
	exit /b 1
)
for /f "delims=0123456789" %%a in ("%mm%") do (
	echo Valor de tempo invalido: %timeText%. Use apenas digitos.
	exit /b 1
)
for /f "delims=0123456789" %%a in ("%ss%") do (
	echo Valor de tempo invalido: %timeText%. Use apenas digitos.
	exit /b 1
)

set /a h=1%hh%-100
set /a m=1%mm%-100
set /a s=1%ss%-100

if %m% GEQ 60 (
	echo Valor de tempo invalido: %timeText%. Minutos devem ser 00-59.
	exit /b 1
)
if %s% GEQ 60 (
	echo Valor de tempo invalido: %timeText%. Segundos devem ser 00-59.
	exit /b 1
)
if %h% LSS 0 (
	echo Valor de tempo invalido: %timeText%. Horas devem ser 00 ou mais.
	exit /b 1
)

set /a totalSec=h*3600+m*60+s
set "%outVar%=%totalSec%"
exit /b 0

:GetUniqueOutput
set "dir=%~dp1"
set "name=%~n1"
set "ext=%~x1"
set "NAME_TO_CLEAN=%name%"
for /f "usebackq delims=" %%a in (`powershell -NoProfile -Command "$n=$env:NAME_TO_CLEAN; if ($n -match '^(.*)-cut(-\\d+)?$') { $matches[1] } else { $n }"`) do set "cleanName=%%a"
set "base=%dir%%cleanName%"
set "candidate=!base!-cut!ext!"
if not exist "!candidate!" (
	set "uniqueOut=!candidate!"
	exit /b 0
)
set /a idx=1
:UniqueLoop
set "candidate=!base!-cut-!idx!!ext!"
if exist "!candidate!" (
	set /a idx+=1
	goto UniqueLoop
)
set "uniqueOut=!candidate!"
exit /b 0
