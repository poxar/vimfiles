
"
" gvimrc
" Maintainer: Philipp Millar <philipp.millar@poxar.de>
"

" make the gui clean
set guioptions=cgi
set mousehide

" use more for man
set kp=man\ -P\ more
" but use less as a default
let $PAGER='less'

if has("unix")
  set guifont=DejaVu\ Sans\ Mono\ 11
else
  set guifont=Consolas:h11:cANSI
endif
