" Alternate files
" Needs alt: https://github.com/uptech/alt

if executable('alt')
  " Run a given vim command on the results of alt from a given path.
  function! AltCommand(path, vim_command)
    let l:alternate = system("alt " . a:path)
    if empty(l:alternate)
      echo "No alternate file for " . a:path
    else
      exec a:vim_command . " " . l:alternate
    endif
  endfunction

  command! Alt call AltCommand(expand('%'), ':e')
  command! A call AltCommand(expand('%'), ':e')
endif
