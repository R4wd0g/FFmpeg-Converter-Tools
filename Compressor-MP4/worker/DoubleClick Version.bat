rem ffmpeg.exe -i %~d1%~p1%~n1.mp4 -c:v copy -c:a copy %~d1%~p1%~n1.mp4
for %%i in (..\*.mp4) do (%~dp0..\..\bin\ffmpeg -i "%%i" -c:v libx265 -vtag hvc1 -c:a copy "%%~dpni_compressed.mp4" && del "%%i" && mv "%%~dpni_compressed.mp4" "%%i")
