" change/add/whatever surroundings easily

if exists("g:did_vundle_setup")

    Bundle 'tpope/vim-surround'

    nnoremap <localleader>" ysiw"
    nnoremap <localleader>' ysiw'
    nnoremap <localleader>) ysiw)

endif
