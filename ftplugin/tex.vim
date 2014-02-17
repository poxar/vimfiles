normal! zM

setlocal wrap nolist linebreak
setlocal formatoptions-=j
setlocal formatoptions+=t
setlocal formatoptions+=w
setlocal formatoptions+=a
setlocal foldtext=TexFoldText()

setlocal spell
set spelllang=de

function! TexFoldText()
    let l:line = matchstr(getline(v:foldstart),'^\S\{-}{\zs.\{-}\ze}')

    " Preamble
    if getline(v:foldstart) =~ '\s*\\documentclass'
      let l:title = "Preamble"
      let l:newline = '['.string(v:foldend-v:foldstart).' lines] '.l:title
    else
      let l:newline = '['.string(v:foldend-v:foldstart).' lines] '.l:line
    endif

    return l:newline
endfunction
