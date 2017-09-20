nnoremap <leader>mm :Make build<cr>
nnoremap <leader>mt :Make! test<cr>

if executable('rusty-tags')
  set tags+=rusty-tags.vi
  set tags+=$RUST_SRC_PATH/tags
  augroup rustytags
    au! BufWrite *.rs :Start! rusty-tags vi
  augroup END
endif

" if filereadable('Cargo.toml')
"   augroup rustcompile
"     au! BufWrite *.rs :compiler cargo
"     au! BufWrite *.rs :Make build
"   augroup END
" endif

let g:rust_fold = 0
let g:rust_bang_comment_leader = 1
let g:ftplugin_rust_source_path = '/usr/src/rust/src/'

let g:racer_cmd = 'racer'
let $RUST_SRC_PATH = '/usr/src/rust/src'
let g:racer_experimental_completer = 1

compiler cargo

command! Todo vimgrep /TODO:\|FIXME:\|XXX:/j src/** | botright cope
command! Fixme vimgrep /FIXME:\|XXX:/j src/** | botright cope

let g:syntastic_rust_checkers = ['rustc']

let g:ctrlp_custom_ignore = {
  \ 'dir': 'target',
  \ 'file': '\v(Cargo\.lock|rusty-tags\.vi)$',
  \ }
