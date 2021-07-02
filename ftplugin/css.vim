setlocal omnifunc=csscomplete#CompleteCSS
setlocal keywordprg=open\ dash://css:\
nnoremap <buffer> ml<cr> :Dispatch -compiler=csslint<cr>
