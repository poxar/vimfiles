setlocal omnifunc=htmlcomplete#CompleteTags
setlocal keywordprg=open\ dash://html:\
nnoremap <buffer> ml<cr> :Dispatch -compiler=proselint<cr>
