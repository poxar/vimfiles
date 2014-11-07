
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

if version >= 703
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

set number
if version >= 703
  set relativenumber
endif

set linebreak
set foldlevelstart=100 " unfold everything in new files

if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
  set showbreak=↪
  set listchars=tab:⇥\ ,trail:·,extends:⇉,precedes:⇇,nbsp:␣
  set fillchars=fold:\ ,vert:│
else
  set listchars=tab:>-,trail:_,extends:>,precedes:<,nbsp:+
  let &showbreak='+++ '
  set fillchars=fold:\ ,vert:\|
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
set wildmode=longest:full,full
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
if isdirectory(expand(s:dir))
  if &directory =~# '^\.,'
    let &directory = expand(s:dir) . '/swap//,' . &directory
  endif
  if &backupdir =~# '^\.,'
    let &backupdir = expand(s:dir) . '/backup//,' . &backupdir
  endif
  if exists('+undodir') && &undodir =~# '^\.\%(,\|$\)'
    let &undodir = expand(s:dir) . '/undo//,' . &undodir
  endif
endif

set backup
set noswapfile

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

Plug 'arecarn/crunch'
Plug 'godlygeek/tabular'
Plug 'kurkale6ka/vim-pairs'
Plug 'michaeljsmith/vim-indent-object'
Plug 'sheerun/vim-polyglot'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/fish-syntax'
Plug 'vim-scripts/gtk-vim-syntax'

" slimux - SLIME inspired tmux integration plugin for Vim {{{2
Plug 'epeli/slimux'
nnoremap <leader>R :SlimuxREPLSendLine<cr>
vnoremap <leader>R :SlimuxREPLSendSelection<cr>
nnoremap <leader>sp :SlimuxShellPrompt<cr>
nnoremap <leader>sl :SlimuxShellLast<cr>
" fugitive - a Git wrapper so awesome, it should be illegal {{{2
Plug 'tpope/vim-fugitive'
" auto clean fugitive buffers
augroup fugitive-clean
  au! BufReadPost fugitive://* set bufhidden=delete
augroup END

" undotree - Display your undo history in a graph {{{2
Plug 'mbbill/undotree'
nnoremap cog :UndotreeToggle<cr>

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

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsListSnippets="<a-k>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<a-j>"
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

" neocomplete - Next generation of auto completion framework {{{2
Plug 'Shougo/neocomplete.vim'

let g:neocomplete#enable_at_startup       = 1
let g:neocomplete#enable_smart_case       = 1
let g:neocomplete#enable_fuzzy_completion = 1
let g:neocomplete#enable_omni_fallback    = 1

let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern          = '\*ku\*'

inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.objc =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.objcpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'


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
" end of plugin list {{{2
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

" cli editing
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" recall commands from history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" start a new change when deleting lines/words in insert mode
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Don't use Ex mode, use Q for formatting
vnoremap Q gw
nnoremap Q gwap

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

" select line minus indent
nnoremap vv ^vg_

" source
vnoremap <leader>S y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" simpler filename completion
inoremap <c-f> <c-x><c-f>

" list navigation
nnoremap <left>  :cprev<cr>zvzz
nnoremap <right> :cnext<cr>zvzz
nnoremap <up>    :lprev<cr>zvzz
nnoremap <down>  :lnext<cr>zvzz

" write file as root
if has("unix")
  cabbrev w!! w !sudo tee % >/dev/null
endif

" expand %% to the path of the current file
cabbrev <expr> %% expand('%:p:h')


" visual stuff {{{2

" more visual buffer switching
nnoremap <leader>b :buffers<CR>:buffer<Space>

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

