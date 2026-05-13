@echo off

cd %~dp0
if not exist %~dp0..\..\bin\ffmpeg.exe (
	echo FFmpeg not found, downloading...
	timeout 3 >nul
	powershell -c "Import-Module BitsTransfer ; Start-BitsTransfer 'https://drive.usercontent.google.com/download?id=1SFIIYJSomDBGKfuICx1EkFDu-SxiDIRq&export=download&confirm=t&uuid=543c0d7f-eedf-4d1b-86c1-f9713c0f14b5' %~dp0..\..\bin\ffmpeg.exe"
	echo done!
	timeout 2 >nul
)

for %%i in (..\.mkv) do (%~dp0..\..\bin\ffmpeg -i "%%i" -c:v copy -c:a copy "%%~dpni.mp4" && del "%%i" && %~dp0..\..\bin\ffmpeg -i "%%~dpni.mp4" -c copy "%%~dpni_remux.mp4" && del "%%~dpni.mp4" && mv "%%~dpni_remux.mp4" "%%~dpni.mp4")


