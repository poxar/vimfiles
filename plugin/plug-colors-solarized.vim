" pwetty colors

if exists("g:did_vundle_setup")

    let g:solarized_underline=0
    let g:solarized_termcolors=256
    let g:solarized_contrast="high"
    let g:solarized_visibility="high"
    let g:solarized_diffmode="high"
    let g:solarized_hitrail=1

    colorscheme solarized

    " colors for the statusline
    hi User1 guifg=#eea040 ctermfg=215 guibg=#222222 ctermbg=235
    hi User2 guifg=#dd3333 ctermfg=167 guibg=#222222 ctermbg=235
    hi User3 guifg=#ff66ff ctermfg=207 guibg=#222222 ctermbg=235
    hi User4 guifg=#a0ee40 ctermfg=155 guibg=#222222 ctermbg=235
    hi User5 guifg=#eeee40 ctermfg=227 guibg=#222222 ctermbg=235
    hi User6 guifg=bg guibg=fg ctermfg=bg ctermbg=fg

endif
