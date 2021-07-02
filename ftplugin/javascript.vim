setlocal omnifunc=javascriptcomplete#CompleteJS
setlocal keywordprg=open\ dash://javascript:\
nnoremap <buffer> ml<cr> :Dispatch -compiler=eslint<cr>
