
"
" vimrc
" Maintainer: Philipp Millar <philipp.millar@poxar.de>
"

" init {{{1
runtime bundle/vim-unbundle/unbundle.vim

set nocompatible
filetype plugin indent on
syntax enable
" settings {{{1
" basics {{{2
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
set cursorline
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

" completion {{{2
set omnifunc=syntaxcomplete#Complete
set wildmenu
set wildmode=longest:full,full
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png

if has('wildignorecase')
  set wildignorecase
endif

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
" plugin {{{1
" slimux - SLIME inspired tmux integration plugin for Vim {{{2
nnoremap <leader>R :SlimuxREPLSendLine<cr>
vnoremap <leader>R :SlimuxREPLSendSelection<cr>
nnoremap <leader>sp :SlimuxShellPrompt<cr>
nnoremap <leader>S :SlimuxShellLast<cr>

" fugitive - a Git wrapper so awesome, it should be illegal {{{2
" auto clean fugitive buffers
augroup fugitive-clean
    au! BufReadPost fugitive://* set bufhidden=delete
augroup END

" undotree - Display your undo history in a graph {{{2
nnoremap cog :UndotreeToggle<cr>

" fswitch - Vim plugin for switching between companion source files {{{2
nnoremap <A-o> :FSH<cr>
inoremap <A-o> <esc>:FSH<cr>

" UltiSnips - snippet engine {{{2
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
" don't auto select anything
let g:clang_auto_select      = 0
" open quickfix window on errors
let g:clang_complete_copen   = 1
" close preview window automatically
let g:clang_close_preview    = 1
" complete macros and constants
let g:clang_complete_macros  = 1
" complete patterns
let g:clang_complete_patters = 1

" LaTeX-BoX - Lightweight Toolbox for LaTeX {{{2
let g:LatexBox_autojump=1
let g:LatexBox_Folding=1
let g:LatexBox_latexmk_preview_continuously=1
let g:LatexBox_quickfix=2
let g:tex_flavor="latex"
if has('unix')
    let g:LatexBox_viewer="zathura"
endif

" easy-align - A simple Vim alignment plugin {{{2
vnoremap <silent> <Enter> :EasyAlign<Enter>
let g:easy_align_ignore_groups = ['Comment', 'String']

" neocomplete {{{2
let g:neocomplete#enable_at_startup       = 1
let g:neocomplete#enable_smart_case       = 1
let g:neocomplete#enable_fuzzy_completion = 1

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

" clang_complete {{{2
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1

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
  cnoremap w!! w !sudo tee % >/dev/null
endif

" expand %% to the path of the current file
cnoremap <expr> %% expand('%:p:h')


" visual stuff {{{2

" more visual buffer switching
nnoremap <leader>b :buffers<CR>:buffer<Space>

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
" cd
nnoremap <leader>ch :cd ~<cr>
" netrw
nnoremap <leader>E :Explore<cr>2j
nnoremap <leader>V :Vexplore<cr>2j

if has('win32')
  " edit
  nnoremap <leader>ea :edit ~\Documents\AutoHotkey.ahk<cr>

  " cd
  nnoremap <leader>cv :cd ~\vimfiles<cr>

  " notes
  nnoremap <leader>n :e ~/notes/

else " unix
  " edit
  nnoremap <leader>eu :edit ~/data/Dropbox/Uni/<cr>9j
  nnoremap <leader>ec :edit ~/.config/<cr>9j
  nnoremap <leader>exc :edit ~/.config/xchainkeys/xchainkeys.conf<cr>
  nnoremap <leader>exb :edit ~/.xbindkeysrc<cr>
  nnoremap <leader>ezz :edit ~/.zsh/<cr>9j
  nnoremap <leader>ezc :edit ~/.zshrc<cr>

  " cd
  nnoremap <leader>cc :cd ~/code/
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
" toggle colorcolumn at 81 {{{2
function! ToggleColorColumn()
  if(&cc == 0)
    set cc=81
    set fdm?
  else
    set cc=0
    set cc?
  endif
endfunc

nnoremap coC :call ToggleColorColumn()<cr>

" print some basic stats about the current file {{{2
" I like this way better than having a bloated statusline, packed with
" information I rarely need.
function! EchoFileInfo()
  let finfo=""

  let finfo=finfo.bufnr('%')
  let finfo=finfo."  "
  let finfo=finfo.(argidx()+1)."/".argc()

  let finfo=finfo."  ".&filetype
  let finfo=finfo."  ".&fileformat
  let finfo=finfo."  ".&fileencoding

  if exists('g:loaded_fugitive')
    let finfo=finfo."  "
    let finfo=finfo.fugitive#statusline()
  endif

  echo finfo
endfunction

command! Info call EchoFileInfo()
nnoremap <leader>i :Info<cr>
nnoremap <A-i>     :Info<cr>

" follow symlinks (for fugitive etc) {{{2
if !has("win32")
  function! s:FollowSymlink()
    let fname = resolve(expand('%:p'))
    bwipeout
    exec "edit " . fname
  endfunction
  command! FollowSymlink call s:FollowSymlink()
endif

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

