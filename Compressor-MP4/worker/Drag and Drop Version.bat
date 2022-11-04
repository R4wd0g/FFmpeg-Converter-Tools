@echo off

cd %~dp0
if not exist %~dp0..\..\bin\ffmpeg.exe (
	echo FFmpeg not found, downloading...
	timeout 3 >nul
	powershell -c "Import-Module BitsTransfer ; Start-BitsTransfer 'https://drive.google.com/uc?export=download&id=1SFIIYJSomDBGKfuICx1EkFDu-SxiDIRq&confirm=t' %~dp0..\..\bin\ffmpeg.exe"
	echo done!
	timeout 2 >nul
)

for %%i in (%*) do (%~dp0..\..\bin\ffmpeg -i %%i -c:v libx265 -vtag hvc1 -c:a copy -threads 1 "%%~dpni_compressed.mp4" && del %%i && mv "%%~dpni_compressed.mp4" %%i) 