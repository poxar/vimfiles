
"
" gvimrc
" Maintainer: Philipp Millar <philipp.millar@poxar.de>
"

" make the gui clean
set guioptions=cgi
set mousehide
set mousemodel=popup_setpos

" cursor shape
set guicursor=
  \n-v:block,
  \i-c-ci-ve:ver25,
  \r-cr:hor20,
  \o:hor50-oCursor,
  \sm:block,
  \a:Cursor/lCursor-blinkon0

" use more for man
set kp=man\ -P\ more
" but use less as a default
let $PAGER='less'

if has("unix")
  set guifont=Inconsolata\ 13
else
  set guifont=Consolas:h11:cANSI
endif
