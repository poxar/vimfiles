" where do you want to save sessions?
let s:dir = has('win32') ? '$APPDATA/Vim' : match(system('uname'), "Darwin") > -1 ? '~/Library/Vim' : empty($XDG_DATA_HOME) ? '~/.local/share/vim' : '$XDG_DATA_HOME/vim'
if isdirectory(expand(s:dir))
    let g:session_dir = expand(s:dir)."/sessions"
else
    finish
endif

" Saves the session to session dir. Creates session dir if it doesn't
" yet exist. Sessions are named after servername paameter
function! SaveSession()

    " get the server (session) name
    let s = v:servername

    " don't create a session file, if no special servername was provided
    if s =~ "GVIM.*"
        return
    endif

    " create session dir if needed
    if !isdirectory(g:session_dir)
        call mkdir(g:session_dir, "p")
    endif

    " save session using the server name
    execute "mksession! ".g:session_dir."/".s.".session.vim"
endfunc

" Open a saved session if there were no file-names passed as arguments
" The session opened is based on servername (session name). If there
" is no session for this server, none will be opened
function! OpenSession()

    " check if file names were passed as arguments
    if argc() == 0

        let sn = v:servername
        let file = g:session_dir."/".sn.".session.vim"

        " if session file exists, load it
        if filereadable(file)
            execute "source ".file
        endif
    endif
endfunc

augroup vimsession
    au! VimEnter * nested call OpenSession()
    au! VimLeave * call SaveSession()
augroup END
