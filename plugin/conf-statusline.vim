" http://stackoverflow.com/a/5380230

function ColorStatusline()
    setlocal statusline=
    setlocal statusline +=%1*\ %n\ %*   "buffer number
    setlocal statusline +=%5*%{&ff}%*   "file format
    setlocal statusline +=%3*%y%*       "file type
    setlocal statusline +=%1*\ %{fugitive#statusline()}%*
    setlocal statusline +=%4*\ %<%f%*   "full path
    setlocal statusline +=%2*%m%*       "modified flag
    setlocal statusline +=%1*%=%5l%*    "current line
    setlocal statusline +=%2*/%L%*      "total lines
    setlocal statusline +=%1*%4c\ %*    "virtual column number
    setlocal statusline +=%2*0x%04B\ %* "character under cursor
endfunction

function MonoStatusline()
    setlocal statusline=
    setlocal statusline +=%6*\ %n\ %*   "buffer number
    setlocal statusline +=%6*%{&ff}%*   "file format
    setlocal statusline +=%6*%y%*       "file type
    setlocal statusline +=%6*\ %{fugitive#statusline()}%*
    setlocal statusline +=%6*\ %<%F%*   "full path
    setlocal statusline +=%6*%m%*       "modified flag
    setlocal statusline +=%6*%=%5l%*    "current line
    setlocal statusline +=%6*/%L%*      "total lines
    setlocal statusline +=%6*%4c\ %*    "virtual column number
    setlocal statusline +=%6*0x%04B\ %* "character under cursor
endfunction

augroup statusline
    au!
    au WinEnter * silent! exec ColorStatusline()
    au WinLeave * silent! exec MonoStatusline()
augroup END

exec ColorStatusline()
