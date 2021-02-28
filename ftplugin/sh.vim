setlocal keywordprg=:Man
nnoremap <buffer> ml<cr> :Dispatch shellcheck -f gcc %<cr>
nnoremap <buffer> ml<space> :Dispatch shellcheck -f gcc %<space>

iabbrev <buffer> #! #!/bin/sh
      \<CR>set -eu
