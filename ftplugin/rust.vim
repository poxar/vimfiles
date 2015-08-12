nnoremap <leader>mm :Dispatch cargo build<cr>
nnoremap <leader>mt :Dispatch cargo test<cr>

if executable("rusty-tags")
  set tags+=rusty-tags.vi
  autocmd BufWrite *.rs :Start! rusty-tags vi
endif
