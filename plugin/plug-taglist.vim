" browse ctags visually

if exists("g:did_vundle_setup")

    Bundle 'vim-scripts/taglist.vim'

    let Tlist_Compact_Format = 1
    let Tlist_Exit_OnlyWindow = 1
    let Tlist_File_Fold_Auto_Close = 0

    if has("win32")
        let Tlist_Ctags_Cmd = 'C:\Program Files (x86)\ctags58\ctags.exe'
    else
        let Tlist_Ctags_Cmd = '/usr/bin/ctags'
    endif

endif
