let s:real_vimrc=$HOME."/.config/nvim/vimrc"

exec "source ".s:real_vimrc

set guicursor=n-v:block,i-c-ci-ve:ver25,r-cr:hor20,o:hor50-oCursor,a:Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

" Always allow window navigation
tnoremap <A-h> <C-\><C-n><C-w>h<C-l>
tnoremap <A-j> <C-\><C-n><C-w>j<C-l>
tnoremap <A-k> <C-\><C-n><C-w>k<C-l>
tnoremap <A-l> <C-\><C-n><C-w>l<C-l>
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Make exiting terminal mode easier
tnoremap <Esc> <C-\><C-n>
tnoremap <M-[> <Esc>
tnoremap <M-Esc> <Esc>

" Override vimrc shortcuts
exec "nnoremap <leader>sv :source ".s:real_vimrc."<cr>"
exec "nnoremap <leader>ev :edit ".s:real_vimrc."<cr>"
exec "nnoremap <leader>esv :vsplit ".s:real_vimrc."<cr>"

nnoremap <leader>sn :source $MYVIMRC<cr>
nnoremap <leader>en :edit $MYVIMRC<cr>
nnoremap <leader>esn :vsplit $MYVIMRC<cr>

unmap <leader>sg
unmap <leader>eg
unmap <leader>esg
