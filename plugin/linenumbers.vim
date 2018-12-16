" Show linenumbers by default (change in ftplugin)
set number

" Show relative line numbers in active windows, where number is set
if v:version >= 703
  augroup relativenumber
    au!
    au WinEnter,TabEnter,BufWinEnter * call SetRelativeNumber()
    au WinLeave,TabLeave,BufWinLeave * call UnsetRelativeNumber()
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
