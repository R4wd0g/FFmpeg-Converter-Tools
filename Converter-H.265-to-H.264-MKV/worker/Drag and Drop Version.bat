@echo off

cd %~dp0
if not exist %~dp0..\..\bin\ffmpeg.exe (
	echo FFmpeg not found, downloading...
	timeout 3 >nul
	powershell -c "Import-Module BitsTransfer ; Start-BitsTransfer 'https://drive.usercontent.google.com/download?id=1SFIIYJSomDBGKfuICx1EkFDu-SxiDIRq&export=download&confirm=t&uuid=543c0d7f-eedf-4d1b-86c1-f9713c0f14b5' %~dp0..\..\bin\ffmpeg.exe"
	echo done!
	timeout 2 >nul
)

for %%i in (%*) do (%~dp0..\..\bin\ffmpeg -i %%i -map 0 -c:v libx264 -crf 18 -vf format=yuv420p -c:a copy -threads 2 "%%~dpni_H.264%%~xi" && del %%i && mv "%%~dpni_H.264%%~xi" %%i && %~dp0..\..\bin\ffmpeg -i %%i -c copy "%%~dpni_remux%%~xi" && del %%i && mv "%%~dpni_remux%%~xi" %%i) 