
"###
"#
"# conf-commands.vim
"# user defined commands
"# Maintainer: Philipp Millar <philipp.millar@gmx.de>
"#
"###

" DiffOrig {{{
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" }}}


" vim:set sw=4 foldmethod=marker ft=vim expandtab:
