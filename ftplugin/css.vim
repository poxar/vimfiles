setlocal omnifunc=csscomplete#CompleteCSS
setlocal keywordprg=devdocs\ css
nnoremap <buffer> ml<cr> :Dispatch -compiler=csslint<cr>
