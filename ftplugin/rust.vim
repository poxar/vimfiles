compiler cargo

nnoremap <leader>mm :Make build<cr>
nnoremap <leader>mt :Make! test<cr>

if executable('rusty-tags')
  set tags+=rusty-tags.vi
  set tags+=$RUST_SRC_PATH/tags
  augroup rustytags
    au! BufWrite *.rs :Start! rusty-tags vi
  augroup END
endif

let g:rust_fold = 0
let g:rust_bang_comment_leader = 1
let g:ftplugin_rust_source_path = $RUST_SRC_PATH

let g:racer_cmd = 'racer'
let g:racer_experimental_completer = 1

command! Todo vimgrep /TODO:\|FIXME:\|XXX:/j src/** | botright cope
command! Fixme vimgrep /FIXME:\|XXX:/j src/** | botright cope

if filereadable('Cargo.toml')
  let g:ale_linters = {'rust': ['cargo']}
else
  let g:ale_linters = {'rust': ['rustc']}
endif

let g:ctrlp_custom_ignore = {
  \ 'dir': 'target',
  \ 'file': '\v(Cargo\.lock|rusty-tags\.vi)$',
  \ }
