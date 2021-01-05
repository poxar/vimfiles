setlocal omnifunc=javascriptcomplete#CompleteJS
setlocal keywordprg=devdocs\ js
nnoremap <buffer> ml<cr> :Dispatch -compiler=eslint<cr>
