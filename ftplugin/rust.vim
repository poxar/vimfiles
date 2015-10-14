nnoremap <leader>mm :Dispatch cargo build<cr>
nnoremap <leader>mt :Dispatch cargo test<cr>

if executable('rusty-tags')
  set tags+=rusty-tags.vi
  augroup rustytags
    au! BufWrite *.rs :Start! rusty-tags vi
  augroup END
endif

command! Todo vimgrep /TODO:\|FIXME:\|XXX:/j src/** | botright cope
