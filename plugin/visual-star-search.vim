" From http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html
" Original: https://github.com/nelstrom/vim-visual-star-search
"
" @s holds the escaped pattern without \V so you can simply do something like
" :s//<C-R>s
" This however overwrites the contents of @s

" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  norm! gv"sy
  let @s = substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @/ = '\V' . @s
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" recursively vimgrep for word under cursor or selection if you hit leader-star
nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
vmap <leader>* :<C-u>call <SID>VSetSearch('/')<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>

