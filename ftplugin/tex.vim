setlocal foldlevelstart=0
setlocal foldlevel=0
setlocal foldmethod=expr

setlocal wrap nolist linebreak

nnoremap Q gqap

setlocal spell
set spelllang=de

if exists(g:neocomplete#enable_at_startup)
  NeoCompleteLock
endif
