" Alternate files
" Needs alt: https://github.com/uptech/alt

if exists('loaded_alt')
  finish
endif
let loaded_alt = 1

function! s:Extensions(root, exts)
  for l:ext in a:exts
    let l:path = a:root . '.' . l:ext
    if filereadable(l:path)
      return l:path
    endif
  endfor

  return ''
endfunction

" Find alternative file for current file
function! AltCommand(vim_cmd)
  let l:alternate = ''
  let root = expand('%:p:r')
  let ext = expand('%:p:e')

  if (&filetype == 'c')
    if ('c' == ext)
      let l:alternate = root . '.h'
    elseif ('h' == ext)
      let l:alternate = s:Extensions(root, ['c', 'cpp'])
    endif
  elseif (&filetype == 'cpp')
    if ('c' == ext)
      let l:alternate = s:Extensions(root, ['h', 'hpp'])
    elseif ('cpp' == ext)
      let l:alternate = s:Extensions(root, ['h', 'hpp'])
    elseif ('hpp' == ext)
      let l:alternate = s:Extensions(root, ['cpp', 'c'])
    elseif ('h' == ext)
      let l:alternate = s:Extensions(root, ['cpp', 'c'])
    endif
  elseif (&filetype == 'markdown')
    let l:alternate = root . '.html'
  elseif (&filetype == 'html')
    let l:alternate = s:Extensions(root, ['md', 'markdown'])
  else
    if !executable('alt')
      echo "alt not installed"
      return
    endif

    let l:alternate = system("alt " . expand('%'))
  endif

  if filereadable(l:alternate)
    exec a:vim_cmd . " " . l:alternate
  else
    echo 'No alternate for ' . expand('%')
  endif
endfunction

command! Alt call AltCommand(':e')
command! A call AltCommand(':e')
