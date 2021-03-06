
"
" gvimrc
" Maintainer: Philipp Millar <philipp.millar@poxar.de>
"

" make the gui clean, see 'guioptions'
set guioptions=cgiA
set mousehide
set mousemodel=popup_setpos
set mouse=""

" cursor shape
set guicursor=
  \n-v:block,
  \i-c-ci-ve:ver15,
  \r-cr:hor20,
  \o:hor50-oCursor,
  \sm:block,
  \a:Cursor/lCursor-blinkwait700-blinkon500-blinkoff350

" use more for man
set kp=man\ -P\ more
" but use less as a default
let $PAGER='less'

if has("gui_mac") || has("mac")
  set guifont=Inconsolata-Regular:h18
elseif has("unix")
  set guifont=Fira\ Code\ 11
else
  set guifont=Consolas:h11:cANSI
endif
