" plugins that are not (yet) configured

if exists("g:did_vundle_setup")
    " git integration
    Bundle 'tpope/vim-fugitive'

    " visualize the undo tree
    Bundle 'sjl/gundo.vim'

    " treat indents as text-objects
    Bundle 'michaeljsmith/vim-indent-object'

    " integrate gnupg encryption
    Bundle 'git://gitorious.org/vim-gnupg/vim-gnupg.git'

    " pandoc integration
    Bundle 'vim-pandoc/vim-pandoc'

    " improved completion (and autocomplete)
    Bundle 'Shougo/neocomplcache'

    " easy commenting
    Bundle 'scrooloose/nerdcommenter'
endif
