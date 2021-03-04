" Show relative line numbers in active windows, where number is set
if v:version >= 703
  augroup relativenumber
    au!
    au WinEnter,TabEnter,BufWinEnter,BufEnter,BufDelete,BufWipeout * call SetRelativeNumber()
    au WinLeave,TabLeave,BufWinLeave,BufLeave * call UnsetRelativeNumber()
  augroup END

  function! g:SetRelativeNumber()
    if &number
      set relativenumber
    endif
  endfunction

  function! g:UnsetRelativeNumber()
    if &relativenumber
      set norelativenumber
    endif
  endfunction
endif
