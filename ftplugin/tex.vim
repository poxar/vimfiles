" settings for building LaTeX documents
setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m

" use the local makefile if it exists
" the global one otherwise
if filereadable('Makefile')
  setlocal makeprg=make
else
  exec "setlocal makeprg=make\\ -f\\ ~/.vim/tools/latex.mk\\ " . substitute(bufname("%"),"tex$","pdf", "")
endif

" open a preview with <F11>
map <F11> :!zathura %<.pdf &>/dev/null &<CR>

" build the document when saving
au BufWritePost *.tex make

" comment line with leader-c
nnoremap <buffer> <localleader>c I%<esc>
