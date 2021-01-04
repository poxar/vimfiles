" only diplay cursorlines in active window

augroup cursorlines
  au! cursorlines
  au WinEnter,TabEnter,BufWinEnter,BufEnter,BufDelete,BufWipeout * call SetupCursorLines()
  au WinLeave,TabLeave,BufWinLeave,BufLeave * call HideCursorLines()
  au OptionSet diff call SetupCursorLines()
  au DiffUpdated * call SetupCursorLines()
augroup END

function! g:SetupCursorLines()
  if &ft !=# 'help' && !&diff
    setlocal cursorline

    if exists('b:my_cc')
      setlocal colorcolumn=+1
    endif
  else
    set colorcolumn=""
    set nocursorline
  endif
endfunction

function! g:HideCursorLines()
  set colorcolumn=""
  set nocursorline
endfunction
