setlocal omnifunc=htmlcomplete#CompleteTags
setlocal keywordprg=devdocs\ html
nnoremap <buffer> ml<cr> :Dispatch -compiler=proselint<cr>
