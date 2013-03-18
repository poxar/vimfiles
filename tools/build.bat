@echo off

call "C:\Program Files (x86)\Microsoft Visual Studio 8\VC\vcvarsall.bat" x86

devenv D:\PITAS\HIBS_C2\C2.sln /build Release /project PITASShipInformationComponent /useenv
::devenv C2.sln /build Release /project PITASDatabaseComponent
::msbuild D:\PITAS\HIBS_C2\C2.sln /t:Build /p:Configuration=Release /nologo /v:q /p:GenerateFullPaths=true

call "C:\Users\pmillar.NT_RMKIEL\Desktop\copyover.bat"
