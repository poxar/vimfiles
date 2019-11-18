function! AltDoc()
  if exists("b:altdoc")
    silent execute b:altdoc . " " . expand('<cword>')
  else
    echo "No alternate keywordprg"
  endif
endfunction

nnoremap gK :call AltDoc()<cr>
