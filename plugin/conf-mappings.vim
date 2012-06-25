" vim:set sw=4 foldmethod=marker ft=vim expandtab:

"==
"
" mappings.vim
" mappings for vim
" Maintainer: Philipp Millar <philipp.millar@gmx.de>
"
"==

" basic {{{
" ==============================================================================
" leave insert mode quickly
inoremap jk <esc>
" Don't use Ex mode, use Q for formatting
vnoremap Q gq
nnoremap Q gqap
" make Y consistent with D and C
nnoremap Y y$
" swap ' and ` so 'a goes to line and column marked with ma
nnoremap ' `
nnoremap ` '
" use H L to go to the start/end of a line
nnoremap H g0
nnoremap L g$
" use return for foldings
nnoremap <cr> za

" simplify window-management
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" split windows quickly
nnoremap <leader>vs :vsplit<cr>
nnoremap <leader>ss :split<cr>

" cope
nnoremap <leader>co :botright cope<cr>
nnoremap <leader>cn :cn<cr>
nnoremap <leader>cp :cp<cr>
" location list
nnoremap <leader>lo :lopen<cr>
nnoremap <leader>ln :lnext<cr>
nnoremap <leader>lp :lprevious<cr>
" ==============================================================================
" }}}
" function keys {{{
" ==============================================================================
nnoremap  <F1> :set<space>spell!<space>\|<space>set<space>spell?<cr>
"         <F2> toggles foldmethod between marker and sytax
"         <F3> toggles number style
nnoremap  <F4> :set<space>paste!<space>\|<space>set<space>paste?<cr>
nnoremap  <F5> :nohlsearch<cr>
nnoremap  <F6> :set<space>list!<space>\|<space>set<space>list?<cr>
"         <F7> unbound
"         <F8> unbound
nnoremap  <F9> :GundoToggle<cr>
nnoremap <F10> :TlistToggle<cr>
nnoremap <F11> :NERDTreeToggle<cr>
"        <F12> opens previews (LaTeX)
" ==============================================================================
" }}}
" open, write and source special files {{{
" ==============================================================================
" write file as root
if has("unix")
    cnoremap w!! w !sudo tee % >/dev/null
endif

" open todo file
if has("unix")
    nnoremap <leader>t :e ~/data/Dropbox/todo/todo.txt<cr>
else
    nnoremap <leader>t :e ~/todo.txt<cr>
endif

" vimrc
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>esv :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" mappings.vim
execute "nnoremap <leader>em :edit ".g:vimdir."plugin/conf-mappings.vim<cr>"
execute "nnoremap <leader>evm :vsplit ".g:vimdir."plugin/conf-mappings.vim<cr>"
execute "nnoremap <leader>sm :source ".g:vimdir."plugin/conf-mappings.vim<cr>"
" abbrev.vim
execute "nnoremap <leader>ea :edit ".g:vimdir."plugin/conf-abbrev.vim<cr>"
execute "nnoremap <leader>eva :vsplit ".g:vimdir."plugin/conf-abbrev.vim<cr>"
execute "nnoremap <leader>sa :source ".g:vimdir."plugin/conf-abbrev.vim<cr>"
" ==============================================================================
" }}}
" plugins {{{
" Surround
nnoremap <localleader>" ysiw"
nnoremap <localleader>' ysiw'
nnoremap <localleader>) ysiw)
" }}}

