setlocal foldmethod=marker
setlocal foldlevelstart=0
setlocal foldlevel=0

setlocal keywordprg=:help

iabbrev <buffer> aug augroup my_group
      \<CR>au! event match command
      \<CR>augroup END
