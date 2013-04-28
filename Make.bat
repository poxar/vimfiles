@echo off

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
git submodule foreach git pull origin master
exit

:initialize
mkdir %APPDATA%\Vim
mkdir %APPDATA%\Vim\backup
mkdir %APPDATA%\Vim\swap
mkdir %APPDATA%\Vim\undo
git submodule init
git submodule update
exit
