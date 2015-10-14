setlocal foldmethod=expr
setlocal wrap nolist linebreak

setlocal spell
setlocal spelllang=de

setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m

if filereadable('Makefile')
  setlocal makeprg=make
else
  exec "setlocal makeprg=make\\ -f\\ ~/.nvim/tools/latex.mk\\ " . substitute(bufname('%'),'tex$','pdf', '')
endif
