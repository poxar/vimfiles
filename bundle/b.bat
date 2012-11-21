@echo off
cd %~dp0

echo current path is %cd%
echo.
echo u  - git pull for all bundles
echo g  - git clone for all bundles in bundles.txt
echo *  - abort
echo.

set /p choice="Enter your choice: "
if "%choice%"=="u" goto update
if "%choice%"=="g" goto get
exit

:update
for /d %%X in ("*") do (
        pushd %%X
        git pull
        popd)
exit

:get
for /f "tokens=1" %%i in (bundles.txt) do git clone %%i
exit
