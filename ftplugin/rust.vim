if filereadable('Cargo.toml')
  compiler cargo

  nnoremap <buffer> m<cr>  :Dispatch cargo check<cr>
  nnoremap <buffer> mb<cr> :Dispatch cargo build<cr>
  nnoremap <buffer> mr<cr> :Dispatch cargo run<cr>
  nnoremap <buffer> mt<cr> :Dispatch! cargo test<cr>
endif

if executable('rusty-tags') && filereadable('Cargo.toml')
  setlocal tags+=rusty-tags.vi
  setlocal tags+=$RUST_SRC_PATH/rusty-tags.vi

  augroup autotags
    au! BufWrite *.rs exec "Start! rusty-tags vi"
  augroup END
elseif executable('ctags') && filereadable('tags')
  augroup autotags
    au! BufWrite *.rs exec "Start! ctags src"
  augroup END
endif

let g:rust_fold = 0
let g:rust_bang_comment_leader = 1
let g:ftplugin_rust_source_path = $RUST_SRC_PATH

let g:rustfmt_autosoave = 1
let g:rustfmt_fail_silently = 0
