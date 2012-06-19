" easy notetaking in vim
" have a look at my zsh functions to interact with the notes from within zsh

if exists("g:did_vundle_setup")
    if has("win32")
        let g:notes_directory='D:\data\Dropbox\notes'
    else
        let g:notes_directory = '~/.pim/notes'
    endif

    nmap <localleader>n :Note<Space>
endif
