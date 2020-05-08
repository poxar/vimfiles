setlocal omnifunc=htmlcomplete#CompleteTags

setlocal complete+=kspell " Complete from current spell checking
setlocal complete+=s " Complete from thesaurus

setlocal spelllang=en

iabbrev <buffer> ... …

setlocal textwidth=72
setlocal formatoptions=qrn2jo

" swap j/k/0/$ and gj/gk/g0/g$
" so the g variations work on physical lines and the default ones on display
" lines unless a count is given, then act normally
nnoremap <expr> j  (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> k  (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> gj (v:count == 0 ? 'j' : 'gj')
nnoremap <expr> gk (v:count == 0 ? 'k' : 'gk')
nnoremap g0 0
nnoremap 0 g0
nnoremap $ g$
nnoremap g$ $
