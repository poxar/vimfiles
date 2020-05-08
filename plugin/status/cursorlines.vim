" only diplay cursorlines in active window

augroup cursorlines
  au! cursorlines
  au WinEnter,TabEnter,BufWinEnter,BufEnter,BufDelete,BufWipeout * call SetupCursorLines()
  au WinLeave,TabLeave,BufWinLeave,BufLeave * call HideCursorLines()
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
