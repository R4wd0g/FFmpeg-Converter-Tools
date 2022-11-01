rem ffmpeg.exe -i %~d1%~p1%~n1.mp4 -c:v copy -c:a copy %~d1%~p1%~n1.mp4
for %%i in (%*) do (%~dp0..\..\bin\ffmpeg -i %%i -acodec pcm_s16le -ac 1 -ar 16000 "%%~dpni.wav" && del "%%~dpni.mp3")