let s:real_vimrc=$HOME."/.config/nvim/vimrc"
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

exec "source ".s:real_vimrc

set guicursor=n-v:block,i-c-ci-ve:ver25,r-cr:hor20,o:hor50-oCursor,a:Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

" Make exiting terminal mode easier
tnoremap <Esc> <C-\><C-n>
tnoremap <M-[> <Esc>
tnoremap <M-Esc> <Esc>
tnoremap <C-W> <C-\><C-n><C-W>
tnoremap <C-W><leader> <C-\><C-n><C-W>:e #<cr>

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
