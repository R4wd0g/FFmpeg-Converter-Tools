@echo off

if not exist %~dp0..\..\bin\ffmpeg.exe (
	echo FFmpeg not found, downloading...
	timeout 3 >nul
	powershell -c "Import-Module BitsTransfer ; Start-BitsTransfer 'https://drive.usercontent.google.com/download?id=1SFIIYJSomDBGKfuICx1EkFDu-SxiDIRq&export=download&confirm=t&uuid=543c0d7f-eedf-4d1b-86c1-f9713c0f14b5' %~dp0..\..\bin\ffmpeg.exe"
	echo done!
	timeout 2 >nul
)

FOR /F "tokens=*" %%g IN ('ver ^| findstr /i "10\.0\."') do (SET winver="%%g")

if defined winver (
	chcp 65001
) else (
	chcp 1252
)

for %%i in (%*) do (echo file '%%i' >> feedlistTemp.txt)

powershell -c (gc feedlistTemp.txt) -replace '\"', '' | sort | Set-content feedlist.txt
del feedlistTemp.txt
%~dp0..\..\bin\ffmpeg -safe 0 -f concat -i feedlist.txt -c copy merged.mp4 & del feedlist.txt & exit

