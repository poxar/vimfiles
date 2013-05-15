@echo off
cd %~dp0

echo.
echo u  - update all plugins
echo i  - initialize vim
echo *  - abort
echo.

set /p choice="Enter your choice: "
if "%choice%"=="u" goto update
if "%choice%"=="i" goto initialize
exit

:update
cd bundle
for /d %%X in ("*") do (
        pushd %%X
        git pull
        popd)
quit
exit

:initialize
mkdir %APPDATA%\Vim
mkdir %APPDATA%\Vim\backup
mkdir %APPDATA%\Vim\swap
mkdir %APPDATA%\Vim\undo
for /f "tokens=1" %%i in (bundles.txt) do git clone https://github.com/%%i.git
exit
