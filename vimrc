
"
" vimrc
" Maintainer: Philipp Millar <philipp.millar@poxar.de>
"

" settings {{{1
" basics {{{2

set nocompatible
filetype plugin indent on
syntax enable

set viminfo='100,<1000,s200,h
set history=1000
set tabpagemax=50

set nomodeline
set exrc
set secure

set lazyredraw
set hidden
set backspace=indent,eol,start
set virtualedit+=block

set nrformats-=octal
set encoding=utf-8

if has("unix")
  set path=**,.,/usr/include,,
else
  set path=**,.,,
endif

if version >= 703 && has("cryptv")
  set cryptmethod=blowfish
endif

set diffopt=filler,vertical

runtime! macros/matchit.vim

" text formatting {{{2
set textwidth=80
if executable("par")
  set formatprg=par\ -w80
endif
set nojoinspaces
if version >= 704
  set formatoptions=qcrnlj
else
  set formatoptions=qcrnl
endif
set autoindent
set shiftround

" don't timeout on mappings {{{2
set notimeout
set ttimeout
set ttimeoutlen=10

" search and replace {{{2
set ignorecase
set smartcase
set hlsearch
set incsearch
set gdefault

" display {{{2
colorscheme badwolf

set laststatus=2
set display+=lastline
set shortmess=atToOIc
set ruler
set showcmd
set visualbell

set scrolloff=1
set sidescrolloff=5

set showmatch
set matchpairs=(:),[:],{:},<:>
" don't search longer than 10ms for a matching character
let g:matchparen_insert_timeout=10

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

" Show linenumbers by default (change in ftplugin)
set number
" Show relative line numbers in active windows, where number is set
if version >= 703
  augroup relativenumber
    au!
    au WinEnter,TabEnter,BufWinEnter * call SetRelativeNumber()
    au WinLeave,TabLeave,BufWinLeave * call UnsetRelativeNumber()
  augroup END

  function! SetRelativeNumber()
    if &number
      set relativenumber
    endif
  endfunction

  function! UnsetRelativeNumber()
    if &relativenumber
      set norelativenumber
    endif
  endfunction
endif

set linebreak

" New Splits default to right, below
set splitright
set splitbelow

if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
  set showbreak=↪
  set listchars=tab:⇥\ ,trail:·,extends:⇉,precedes:⇇,nbsp:␣
  set fillchars=fold:\ ,vert:│
else
  set listchars=tab:>-,trail:_,extends:>,precedes:<,nbsp:+
  let &showbreak='+++ '
  set fillchars=fold:\ ,vert:\|
endif

if has('linebreak')
  set breakindent
  set breakindentopt=sbr
endif

" statusline {{{2
" command ForceStatusline {{{3
command! ForceStatusline call SetActiveStatusline()

augroup Statusline "{{{3
  au! Statusline
  au WinEnter,TabEnter,BufWinEnter,VimEnter * call SetActiveStatusline()
  au WinLeave,TabLeave,BufWinLeave * call SetInactiveStatusline()
augroup END

function! SkipStatusline() "{{{3
  if &ft == 'help'
    return 1
  endif
endfunction

function! SetActiveStatusline() "{{{3
  if SkipStatusline()
    return
  endif

  setlocal statusline=
  " TODO: This currently depends on the badwolf colorscheme
  setlocal statusline+=%#InterestingWord1#\ %-3.3n%*\    " buffer number
  setlocal statusline+=%{StatusLinePath()}               " file name
  setlocal statusline+=%h%m%r%w                          " flags
  setlocal statusline+=%=                                " right align
  setlocal statusline+=%#normal#\ %{StatusLineStats()}%* " file stats
  setlocal statusline+=\ \ %l:%v\                        " ruler
endfunction

function! SetInactiveStatusline() "{{{3
  if SkipStatusline()
    return
  endif

  setlocal statusline=
  setlocal statusline+=\ %-3.3n\           " buffer number
  setlocal statusline+=%h%m%r%w            " flags
  setlocal statusline+=%{StatusLinePath()} " file name
endfunction

function! StatusLinePath()                        " {{{3
  let l:path = expand('%:.')
  let l:path = substitute(l:path,'\','/','g')
  let l:path = substitute(l:path, '^\V' . $HOME, '~', '')
  let l:path = simplify(l:path)

  if len(l:path) > 30
    let l:path = pathshorten(l:path)
  endif

  if !strlen(l:path)
    let l:path = '[No Name]'
  endif

  return l:path
endfunction

function! StatusLineStats() "{{{3
  let l:filestats = ''

  if strlen(fugitive#head())
    let l:filestats .= fugitive#head() . ' '
  endif

  if strlen(&filetype)
    let l:filestats .= &ft . ' '
  else
    let l:filestats .= 'none '
  endif

  if strlen(&fenc) && &fenc != 'utf-8'
    let l:filestats .= &fenc . ' '
  elseif &enc != 'utf-8'
    let l:filestats .= &enc . ' '
  endif

  if strlen(&fileformat) && &fileformat != 'unix'
    let l:filestats .= &fileformat . ' '
  endif

  return l:filestats
endf

" colorcolumn and cursorline {{{2
" This maps coC to toggle the colorcolumn, but shows it only in the current
" buffer. Furthermore the cursorline is shown in the current buffer.
" toggle colorcolumn at textwidth + 1 {{{3
function! ToggleColorColumn()
  if exists("b:my_cc")
    setlocal colorcolumn=
    setlocal colorcolumn?
    unlet b:my_cc
  else
    setlocal colorcolumn=+1
    setlocal colorcolumn?
    let b:my_cc = 1
  endif
endfunc

nnoremap coC :call ToggleColorColumn()<cr>

augroup cursorlines "{{{3
  au! cursorlines
  au WinEnter,TabEnter,BufWinEnter,VimEnter * call SetupCursorLines()
  au WinLeave,TabLeave,BufWinLeave * call HideCursorLines()
augroup END

function! SetupCursorLines() "{{{3
  if &ft != 'help'
    setlocal cursorline

    if exists("b:my_cc")
      setlocal colorcolumn=+1
    endif
  endif
endfunction

function! HideCursorLines() "{{{3
  setlocal colorcolumn=""
  setlocal nocursorline
endfunction

" completion {{{2
set omnifunc=syntaxcomplete#Complete
set wildmenu
set wildmode=list:longest,full
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
set wildignorecase

if has('unix')
  set dictionary=/usr/share/dict/words
endif

" cscope {{{2
if has('cscope')
  set cscopeverbose
  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif
endif

" backup/swap/undo {{{2

let s:dir = has('win32') ? '$APPDATA/Vim' : match(system('uname'), "Darwin") > -1 ? '~/Library/Vim' : empty($XDG_DATA_HOME) ? '~/.local/share/vim' : '$XDG_DATA_HOME/vim'

if !isdirectory(expand(s:dir))
  call mkdir(expand(s:dir))
endif
if !isdirectory(expand(s:dir) . '/swap/')
  call mkdir(expand(s:dir) . '/swap/')
endif
if !isdirectory(expand(s:dir) . '/backup/')
  call mkdir(expand(s:dir) . '/backup/')
endif
if !isdirectory(expand(s:dir) . '/undo/')
  call mkdir(expand(s:dir) . '/undo/')
endif

let &directory = expand(s:dir) . '/swap//,' . &directory
let &backupdir = expand(s:dir) . '/backup//,' . &backupdir

if exists('+undodir')
  let &undodir = expand(s:dir) . '/undo//,' . &undodir
endif

set backup
set swapfile

if exists('+undofile')
  set undofile
endif

" leader {{{2
let mapleader      = " "
let maplocalleader = "\\"

" read man files in vim with :Man {{{2
if has("unix")
  runtime ftplugin/man.vim
endif
" plugins {{{1

call plug#begin('~/.vim/bundle')

" normal commands - plugins that add or enhance normal mode commands {{{2
" cx{motion} - text exchange operator
Plug 'tommcdo/vim-exchange'
" gc{motion} - comment stuff out
Plug 'tpope/vim-commentary'
" . - enable repeating supported plugin maps with
Plug 'tpope/vim-repeat'
" CTRL-A/CTRL-X - increment dates, times, numbers and more
Plug 'tpope/vim-speeddating'
" ys{motion}{surrounding} - quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
" ]{something} - pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'
" - - hop up to the directory listing and seek to the file you just came from
Plug 'tpope/vim-vinegar'
" characterize.vim: Unicode character metadata
Plug 'tpope/vim-characterize'
" clipboard mappings the way I like them
Plug 'poxar/vim-clipbored'

" text objects - plugins that add or enhance text objects {{{2
" Punctuation text objects: ci/ da; vi@ yiq da<space> ...
Plug 'kurkale6ka/vim-pairs'
" text object representing lines of code at the same indent level
Plug 'michaeljsmith/vim-indent-object'

" runtime files - plugins that add language support {{{2
" sheerun/vim-polyglot
Plug 'sheerun/vim-polyglot'
" Vim files for editing Salt files
Plug 'saltstack/salt-vim'
" Repository for Jinja support in vim.
Plug 'mitsuhiko/vim-jinja'
" A set of vim syntax files for highlighting various Html templating languages
Plug 'pbrisbin/vim-syntax-shakespeare'
" Additional Vim syntax highlighting for C++ (including C++11/14) 
Plug 'octol/vim-cpp-enhanced-highlight'
" Haskell indent file
Plug 'vim-scripts/indenthaskell.vim'
" Improved Git support
Plug 'tpope/vim-git'
" Runtime files for tmux
Plug 'tmux-plugins/vim-tmux'

" automation - plugins that automate common tasks {{{2
" heuristically set shiftwidth, expandtab, etc
Plug 'tpope/vim-sleuth'
" (semi-) automatic session file creation
Plug 'tpope/vim-obsession'
" automatic endings like if else
Plug 'tpope/vim-endwise'
" project configuration
Plug 'tpope/vim-projectionist'
" A simple way to create, edit and save files and parent directories
Plug 'duggiefresh/vim-easydir'
" Plugin for transparent editing of gpg encrypted files.
Plug 'vim-scripts/gnupg.vim'
" Make terminal vim and tmux work better together.
Plug 'tmux-plugins/vim-tmux-focus-events'

" command line - plugins that add new or enhance existing commands {{{2
" An easier way to perform calculations inside Vim
Plug 'arecarn/crunch'
" text filtering and alignment
Plug 'godlygeek/tabular'
" Vim plugin for the Perl module / CLI script 'ack'
Plug 'mileszs/ack.vim'
" populating the argument list from the files in the quickfix list
Plug 'nelstrom/vim-qargs'
" easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'
" asynchronous build and test dispatcher
Plug 'tpope/vim-dispatch'
" a vim plugin for vim plugins
Plug 'tpope/vim-scriptease'
" Quick Google lookup directly from Vim
Plug 'szw/vim-g'
" tmux basics
Plug 'tpope/vim-tbone'
" Plugin to create and use a scratch Vim buffer
Plug 'vim-scripts/scratch.vim'
"}}}2

" ruby - runtime and tools support for ruby {{{2
" Lightweight support for Ruby's Bundler
Plug 'tpope/vim-bundler'
" it's like rails.vim without the rails
Plug 'tpope/vim-rake'
" Minimal rbenv support
Plug 'tpope/vim-rbenv'
" Refactoring tool for Ruby in vim
Plug 'ecomba/vim-ruby-refactoring'
" }}}2
" clojure - runtime and tools support for clojure {{{2
" A rainbow parentheses plugin for Clojure, Common Lisp & Scheme.
Plug 'raymond-w-ko/vim-niji'
" Clojure REPL support
Plug 'tpope/vim-fireplace'
" static support for Leiningen
Plug 'tpope/vim-salve'
" Set 'path' from the Java class path
Plug 'tpope/vim-classpath'
" Meikel Brandmeyer's excellent Clojure runtime files
Plug 'guns/vim-clojure-static'
" A Vim plugin for Clojure's Eastwood linter
Plug 'venantius/vim-eastwood'
" Precision Editing for S-expressions
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
" A Vim plugin for cljfmt, the Clojure formatting tool.
Plug 'venantius/vim-cljfmt'
" }}}2
" python - runtime and tools support for python {{{2
" Vim python-mode. PyLint, Rope, Pydoc, breakpoints from box.
Plug 'klen/python-mode'
" Using the jedi autocompletion library for VIM.
Plug 'davidhalter/jedi-vim'
" }}}2

" vimoutliner - Work fast, think well. {{{2
Plug 'vimoutliner/vimoutliner'

" tagbar - show an outline using ctags {{{2
Plug 'majutsushi/tagbar'
nnoremap coT :TagbarToggle<cr>

" ctrlp.vim - Fuzzy file, buffer, mru, tag, etc finder. {{{2
Plug 'ctrlpvim/ctrlp.vim'
nnoremap <leader>b :CtrlPBuffer<cr>

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
        \ --ignore .git
        \ --ignore .svn
        \ --ignore .hg
        \ --ignore .DS_Store
        \ --ignore "**/*.pyc"
        \ -g ""'
endif

" syntastic - Syntax checking hacks for vim {{{2
Plug 'scrooloose/syntastic'

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'

" fugitive - a Git wrapper so awesome, it should be illegal {{{2
Plug 'tpope/vim-fugitive'
" rhubarb.vim: GitHub extension for fugitive.vim 
Plug 'tpope/vim-rhubarb'
" auto clean fugitive buffers
augroup fugitive-clean
  au! BufReadPost fugitive://* set bufhidden=delete
augroup END

" undotree - Display your undo history in a graph {{{2
Plug 'mbbill/undotree'
nnoremap cog :UndotreeToggle<cr>

" incsearch.vim - Improved incremental searching for Vim {{{2
Plug 'haya14busa/incsearch.vim'
" intelligently hide hlsearch
let g:incsearch#auto_nohlsearch = 1
" n goes down N goes up, no matter what
let g:incsearch#consistent_n_direction = 1
" hide search errors in :messages output
let g:incsearch#do_not_save_error_message_history = 1
" use verymagic by default
let g:incsearch#magic = '\v'
" activate plugin
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)zMzvzz
map N  <Plug>(incsearch-nohl-N)zMzvzz
map *  <Plug>(incsearch-nohl-*)zMzvzz
map #  <Plug>(incsearch-nohl-#)zMzvzz
map g* <Plug>(incsearch-nohl-g*)zMzvzz
map g# <Plug>(incsearch-nohl-g#)zMzvzz

" fswitch - Vim plugin for switching between companion source files {{{2
Plug 'derekwyatt/vim-fswitch'
nnoremap <A-o> :FSH<cr>
inoremap <A-o> <esc>:FSH<cr>

" UltiSnips - snippet engine {{{2
Plug 'SirVer/ultisnips'
" some default snippets
Plug 'honza/vim-snippets'

let g:snips_author="Philipp Millar"
let g:snips_author_email="philipp.millar@poxar.de"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "snip"]
let g:UltiSnipsNoPythonWarning = 1

if has("win32")
  let g:UltiSnipsSnippetsDir="~/vimfiles/snip"
else
  let g:UltiSnipsSnippetsDir="~/.vim/snip"
endif

nnoremap <leader>ese :UltiSnipsEdit<cr>

" clang_complete - Vim plugin that uses clang for completing C/C++ code. {{{2
Plug 'Rip-Rip/clang_complete'

let g:clang_auto_select      = 0
let g:clang_complete_auto    = 0
let g:clang_complete_copen   = 1
let g:clang_close_preview    = 1
let g:clang_complete_macros  = 1
let g:clang_complete_patters = 1
let g:clang_use_library      = 1

" ack.vim {{{2
let s:ackcmd='-H --smart-case --nocolor --nogroup --column'
let s:agcmd='--smart-case --nocolor --nogroup --column'
if executable('ag')
  let g:ackprg='ag '.s:agcmd
elseif executable('ack-grep')
  let g:ackprg='ack-grep '.s:ackcmd
else
  let g:ackprg='ack '.s:ackcmd
endif

" dragvisuals - drag visual selections {{{2
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS = 1

" }}}2

call plug#end()

" mappings {{{1
" fixes {{{2

" Make <F1> helpful
inoremap <F1> <F1>
nnoremap <F1> :help <C-R><C-W><CR>

" Fix Y
nnoremap Y :normal y$<cr>

" swap ' and ` so 'a goes to line and column marked with ma
nnoremap ' `
nnoremap ` '

" swap j/k/0/$ and gj/gk/g0/g$
" so the g variations work on physikal lines and the default ones on display
" lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap g0 0
nnoremap 0 g0
nnoremap $ g$
nnoremap g$ $

" cli editing
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" recall commands from history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" start a new change when deleting lines/words in insert mode
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Don't use Ex mode, use Q to repeat last :command
nnoremap Q @:

" open last/alternate buffer
nnoremap <leader><leader> <C-^>

" correct typos
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>


" enhancements {{{2
" leave insert mode quickly
inoremap jk <esc>

" simpler to type
nnoremap <BS> %

" vaporize: delete without overwriting the default register
nnoremap vd "_d
xnoremap x  "_d
nnoremap vD "_D

" quickly substitute word under the curser
nnoremap gs :%s/\<<C-r>=expand('<cword>')<CR>\>/

" select line minus indent
nnoremap vv ^vg_

" source
vnoremap <leader>S y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" simpler filename completion
inoremap <c-f> <c-x><c-f>

" write file as root
if has("unix")
  cabbrev w!! w !sudo tee % >/dev/null
endif

" expand %% to the path of the current file
cabbrev <expr> %% expand('%:p:h')

" visual stuff {{{2

" more visual buffer switching
nnoremap gb :ls<CR>:buffer<Space>
nnoremap gB :ls<CR>:sbuffer<Space>

" Use <C-L> to clear the highlighting of :set hlsearch
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" close all other folds and center this line
nnoremap z<space> zMzvzz


" quick edit/cd {{{2
" source
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>sg :source $MYGVIMRC<cr>
" edit
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>eg :edit $MYGVIMRC<cr>
nnoremap <leader>esv :vsplit $MYVIMRC<cr>
nnoremap <leader>esg :vsplit $MYGVIMRC<cr>

" open file in directory of current file
noremap <leader>e.  :edit   <C-R>=expand("%:p:h") . "/" <cr>
noremap <leader>es. :vsplit <C-R>=expand("%:p:h") . "/" <cr>
" cd to directory of current file
nnoremap <leader>c. :lcd %:p:h<cr>

if has('win32')
  " edit
  nnoremap <leader>ea :edit ~\Documents\AutoHotkey.ahk<cr>

  " cd
  nnoremap <leader>cv :cd ~\vimfiles<cr>

  " notes
  nnoremap <leader>n :e ~/notes/

else " unix
  " edit
  nnoremap <leader>ec :edit ~/.config/<cr>
  nnoremap <leader>exb :edit ~/.xbindkeysrc<cr>
  nnoremap <leader>ezz :edit ~/.zsh.d/<cr>
  nnoremap <leader>ezc :edit ~/.zshrc<cr>

  " cd
  nnoremap <leader>cc :cd ~/Developement/
  nnoremap <leader>cv :cd ~/.vim<cr>

  " notes
  nnoremap <leader>n :e ~/.notes/
endif


" macros {{{1
" indent next line to match current word
let @j='yiwy0opVr J'
" underline the current line
let @h='yyp0v$r='
let @u='yyp0v$r-'

" functions {{{1
" change the spell-language {{{2
set spelllang=en
if has('win32')
  set spellfile=~/vimfile/spell/en.utf-8.add
else
  set spellfile=~/.vim/spell/en.utf-8.add
endif
let spellst = ["en", "de"]
let langcnt = 0

function!  SelectLanguage()
  let g:langcnt = (g:langcnt+1) % len(g:spellst)
  let lang = g:spellst[g:langcnt]
  echo "spelllang=" . lang
  exe "set spelllang=" . lang
  if has('win32')
    exe "set spellfile=~/vimfiles/spell/" . lang . ".utf-8.add"
  else
    exe "set spellfile=~/.vim/spell/" . lang . ".utf-8.add"
  endif
endfunction

nnoremap coS :call SelectLanguage()<CR>
" scratchbuffer for messages {{{2
function! MessageWindow()
  new [Messages]
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal buflisted
  redir => messages_output
  silent messages
  redir END
  silent put=messages_output
endfunction

command! Messages call MessageWindow()

" make * search a visual selection {{{2
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>
" commands {{{1
" kill buffer without closing the window/view {{{2
command! Bkill bp\|bd #<cr>
" strip trailing whitespace {{{2
command! StripWhitespace normal mz:%s/\s\+$//<cr>:let @/=''<cr>`z
" diff the current buffer and the file it was loaded from {{{2
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" put files or snippets on sprunge.us {{{2
command! -range=% Sprunge :<line1>,<line2>write !curl -F "sprunge=<-" http://sprunge.us|xclip
" find and show todos {{{2
command! Todo vimgrep /TODO:\|FIXME:\|XXX:/j ** | botright cope
" edit current filetypeplugin {{{2
command! Ftedit execute ':edit ~/.vim/ftplugin/'.&ft.'.vim'

" substitute double words {{{2
command! DoubleWords /\(\<\S\+\>\)\(\_\s\+\<\1\>\)\+/

" autocommands {{{1

augroup notes
  au! BufRead ~/.notes/* setlocal autoread
  au! BufRead ~/.notes/* setlocal autowrite
  au! BufRead ~/.notes/* setlocal autowriteall
augroup END

" force markdown on everything
augroup markdown
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
augroup END

" custom highlights {{{1
" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
