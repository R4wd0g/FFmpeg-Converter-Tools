rem ffmpeg.exe -i %~d1%~p1%~n1.mp4 -c:v copy -c:a copy %~d1%~p1%~n1.mp4
for %%i in (..\*.mkv) do (%~dp0..\..\bin\ffmpeg -i "%%i" -c:v copy -c:a copy "%%~dpni.mp4" && del "%%i")


