@echo off
cd %~dp0

echo current path is %cd%
echo.
echo u  - git pull for all bundles
echo g  - git clone for all bundles in bundles.txt
echo gv - download bundles from vim.org (needs wget)
echo *  - abort
echo.

set /p choice="Enter your choice: "
if "%choice%"=="u" goto update
if "%choice%"=="g" goto get
if "%choice%"=="gv" goto get_with_wget
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

:get_with_wget
wget.exe -O powerline.tar.gz http://www.vim.org/scripts/download_script.php?src_id=17546
wget.exe -O UltiSnips.tar.gz http://www.vim.org/scripts/download_script.php?src_id=18527
wget.exe -O vim-colors-solarized.zip http://www.vim.org/scripts/download_script.php?src_id=15285
wget.exe -O tabular.tar.gz http://www.vim.org/scripts/download_script.php?src_id=15091
wget.exe -O vim-indent-object.zip http://www.vim.org/scripts/download_script.php?src_id=12790
wget.exe -O ack.tar.gz http://www.vim.org/scripts/download_script.php?src_id=10433
wget.exe -O nerdtree.zip http://www.vim.org/scripts/download_script.php?src_id=17123
wget.exe -O gundo.zip http://www.vim.org/scripts/download_script.php?src_id=18081
wget.exe -O omnicppcomplete.zip http://www.vim.org/scripts/download_script.php?src_id=7722
wget.exe -O commentary.zip http://www.vim.org/scripts/download_script.php?src_id=16386
wget.exe -O fugitive.zip http://www.vim.org/scripts/download_script.php?src_id=15542
wget.exe -O ragtag.zip http://www.vim.org/scripts/download_script.php?src_id=12338
wget.exe -O repeat.vim http://www.vim.org/scripts/download_script.php?src_id=8206
wget.exe -O surround.zip http://www.vim.org/scripts/download_script.php?src_id=12566
wget.exe -O unimpaired.zip http://www.vim.org/scripts/download_script.php?src_id=12570
wget.exe -O gnupg.vim http://www.vim.org/scripts/download_script.php?src_id=18070
wget.exe -O vividchalk.vim http://www.vim.org/scripts/download_script.php?src_id=12437
echo.
echo.
echo Done. Now you have to manually set up correct paths/extract etc.
pause
