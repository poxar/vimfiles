function! g:ZSHFolds()
  let l:thisline = getline(v:lnum)
  if match(l:thisline, '() {$') >= 0
    return '>1'
  elseif match(l:thisline, '^}$') >= 0
    return '<1'
  else
    return '='
  endif
endfunction

setlocal foldmethod=expr
setlocal foldexpr=ZSHFolds()
