" Vim compiler file
" Compiler: MsBuild

if exists("current_compiler")
    finish
endif

let current_compiler = "msbuild"

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
    command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet errorformat=1>%f(%l)\ :\ %m
CompilerSet makeprg=~\vimfiles\tools\build.bat
