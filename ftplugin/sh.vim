setlocal keywordprg=:Man
nnoremap <buffer> ml<cr> :Dispatch -compiler=shellcheck<cr>

iabbrev <buffer> #! #!/bin/sh
      \<CR>set -eu
