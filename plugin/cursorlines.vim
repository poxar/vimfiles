" only diplay cursorlines in active window

augroup cursorlines
  au! cursorlines
  au WinEnter,TabEnter,BufWinEnter,VimEnter * call SetupCursorLines()
  au WinLeave,TabLeave,BufWinLeave * call HideCursorLines()
augroup END

function! g:SetupCursorLines()
  if &ft !=# 'help'
    setlocal cursorline

    if exists('b:my_cc')
      setlocal colorcolumn=+1
    endif
  endif
endfunction

function! g:HideCursorLines()
  setlocal colorcolumn=""
  setlocal nocursorline
endfunction
