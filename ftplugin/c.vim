setlocal cindent

if executable('uctags') && filereadable('tags')
  augroup autotags
    au! BufWrite *.c exec "Start! uctags -R ."
    au! BufWrite *.h exec "Start! uctags -R ."
  augroup END
elseif executable('ctags') && filereadable('tags')
  augroup autotags
    au! BufWrite *.c exec "Start! ctags -R ."
    au! BufWrite *.h exec "Start! ctags -R ."
  augroup END
endif

iabbrev <buffer> once# #ifndef ONCE_<C-R>=toupper(expand('%:t'))<cr>
      \<cr>#define ONCE_<C-R>=toupper(expand('%:t'))<cr>
      \<cr>
      \<cr>#endif<up>

iabbrev <buffer> #i #include
iabbrev <buffer> fori for (int i = 0; i < ; ++i) {}<left>
