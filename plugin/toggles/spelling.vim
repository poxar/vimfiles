" change the spell-language
set spelllang=en
exec 'set spellfile=' . g:vim_path . '/spell/en.utf-8.add'
let g:spellst = ['en', 'de_20']
let g:langcnt = 0

function! s:SelectLanguage()
  let g:langcnt = (g:langcnt+1) % len(g:spellst)
  let l:lang = g:spellst[g:langcnt]
  echo 'spelllang=' . l:lang
  exe 'set spelllang=' . l:lang
  exe 'set spellfile=' . g:vim_path . '/spell/' . l:lang . '.utf-8.add'
endfunction

nnoremap yoS :call <SID>SelectLanguage()<CR>
