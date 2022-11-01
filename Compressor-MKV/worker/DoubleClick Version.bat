rem ffmpeg.exe -i %~d1%~p1%~n1.mkv -c:v copy -c:a copy %~d1%~p1%~n1.mkv
for %%i in (..\*.mkv) do (%~dp0..\..\bin\ffmpeg -i "%%i" -c:v libx265 -vtag hvc1 -c:a copy "%%~dpni_compressed.mkv" && del "%%i" && mv "%%~dpni_compressed.mkv" "%%i")
