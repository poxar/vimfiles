" spell checking

" function to change the spell-language
set spelllang=en
let spellst = ["en", "de"]
let langcnt = 0

function!  Sel_lang()
        let g:langcnt = (g:langcnt+1) % len(g:spellst)
        let lang = g:spellst[g:langcnt]
        echo "spelllang=" . lang
        exe "set spelllang=" . lang
endfunction

nnoremap <localleader>ll :call Sel_lang()<CR>
