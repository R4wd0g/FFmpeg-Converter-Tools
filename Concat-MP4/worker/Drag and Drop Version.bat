rem ffmpeg.exe -i %~d1%~p1%~n1.mp4 -c:v copy -c:a copy %~d1%~p1%~n1.mp4

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

