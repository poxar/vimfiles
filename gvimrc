
"
" gvimrc
" Maintainer: Philipp Millar <philipp.millar@poxar.de>
"

" make the gui clean
set guioptions=cegi
set mousehide

" less doesn't work in gvim
" use more instead
set kp=man\ -P\ more

if has("unix")
  set guifont=DejaVu\ Sans\ Mono\ 11
else
  set guifont=Consolas:h11:cANSI
endif
