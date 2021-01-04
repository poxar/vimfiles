setlocal keywordprg=devdocs\ rust

if filereadable('Cargo.toml')
  compiler cargo

  nnoremap <buffer> m<cr> :Make check<cr>
  nnoremap <buffer> ml<cr> :Make clippy<cr>
  nnoremap <buffer> mc<cr> :Make clean<cr>
  nnoremap <buffer> mb<cr> :Make build<cr>
  nnoremap <buffer> mf<cr> :Make fmt<cr>
  nnoremap <buffer> mr<cr> :Make run<cr>
  nnoremap <buffer> mt<cr> :Make test<cr>
  nnoremap <buffer> md<cr> :Make doc<cr>
  nnoremap <buffer> mD<cr> :Termdebug target/debug/

  setlocal path+=./src
endif

if executable('racer')
  command! -buffer -nargs=* -count=0 RustDoc call racer#ShowDocumentation()
  setlocal keywordprg=:RustDoc
endif

let g:rust_fold = 0
let g:rust_bang_comment_leader = 1
let g:ftplugin_rust_source_path = $RUST_SRC_PATH

let g:rustfmt_autosoave = 1
let g:rustfmt_fail_silently = 0
