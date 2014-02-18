
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
set smarttab
set backspace=indent,eol,start
set clipboard=unnamedplus
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
set shiftwidth=2
set expandtab
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

" dispatch - asynchronous build and test dispatcher {{{2
nnoremap <leader>m  :Make<space>
nnoremap <leader>mm :Make<cr>
nnoremap <leader>mc :Make clean<cr>

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
let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets"]

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsListSnippets="<a-k>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<a-j>"
nnoremap <leader>ess :UltiSnipsEdit<cr>

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

" Unite - Unite and create user interfaces {{{2
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
    " Enable navigation with control-j and control-k in insert mode
    imap <buffer> <C-j> <Plug>(unite_select_next_line)
    imap <buffer> <C-k> <Plug>(unite_select_previous_line)
    " cli style delete
    imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
endfunction

" fuzzy matching
call unite#filters#matcher_default#use(['matcher_fuzzy'])

nnoremap <leader>f :<C-u>Unite file_rec<cr>
nnoremap <leader>F :<C-u>Unite file_mru<cr>

nnoremap <leader>j :<C-u>Unite buffer<cr>
nnoremap <leader>J :<C-u>Unite jump<cr>

nnoremap <leader>p :<C-u>Unite history/yank register<cr>

command! Map Unite -no-start-insert mapping
command! Messages Unite -no-start-insert output:message

" notes
nnoremap <leader>n :<C-u>Unite file:~/.notes<cr>
nnoremap <leader>N :e ~/.notes/

" unite-outline
nnoremap <leader>o :<C-u>Unite outline<cr>

" dragvisuals - Vim global plugin for dragging virtual blocks {{{2
vmap <expr> <LEFT>  DVB_Drag('left')
vmap <expr> <RIGHT> DVB_Drag('right')
vmap <expr> <DOWN>  DVB_Drag('down')
vmap <expr> <UP>    DVB_Drag('up')
vmap <expr> D       DVB_Duplicate()

" easy-align - A simple Vim alignment plugin {{{2
vnoremap <silent> <Enter> :EasyAlign<Enter>
let g:easy_align_ignore_groups = ['Comment', 'String']

" obsession - Continuously updated session files {{{2
" sessions
nnoremap <Leader>ms :Obsession .<cr>
nnoremap <Leader>ls :source ./Session.vim<cr>

" ref - Integrated reference viewer {{{2
nnoremap gK :Ref man <C-r><C-w><cr>

" mappings {{{1
" TODO: this needs to be grouped somehow
" Fixes {{{2
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

" open last/alternate buffer {{{2
nnoremap <leader><leader> <C-^>

" Don't use Ex mode, use Q for formatting {{{2
vnoremap Q gw
nnoremap Q gwap

" Use <C-L> to clear the highlighting of :set hlsearch. {{{2
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" start a new change when deleting lines/words in insert mode {{{2
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" leave insert mode quickly {{{2
inoremap jk <esc>

" Don't move on * {{{2
nnoremap * *<c-o>
" Keep search matches in the middle of the window. {{{2
nnoremap n nzzzv
nnoremap N Nzzzv
" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" strip trailing whitespace {{{2
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z
" select what was just pasted {{{2
nnoremap <leader>V V`]
" select line minus indent {{{2
nnoremap vv ^vg_

" more visual buffer switching {{{2
nnoremap <leader>b :buffers<CR>:buffer<Space>
" kill buffer without closing the window/view {{{2
nnoremap <leader>db :bp\|bd #<cr>
" open quickfix list {{{2
nnoremap <leader>co :botright cope<cr>
" open location list {{{2
nnoremap <leader>lo :lopen<cr>

" source {{{2
vnoremap <leader>S y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" simpler filename completion {{{2
inoremap <c-f> <c-x><c-f>

" list navigation {{{2
nnoremap <left>  :cprev<cr>zvzz
nnoremap <right> :cnext<cr>zvzz
nnoremap <up>    :lprev<cr>zvzz
nnoremap <down>  :lnext<cr>zvzz

" correct typos {{{2
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>

" write file as root {{{2
if has("unix")
  cnoremap w!! w !sudo tee % >/dev/null
endif

" indent next line to match current word {{{2
let @j='yiwy0opVr J'
" underline the current line {{{2
let @h='yyp0v$r='
let @u='yyp0v$r-'

" expand %% to the path of the current file {{{2
cnoremap <expr> %% expand('%:p:h')

" close all other folds and center this line {{{2
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
endif

" functions {{{1
" change the spell-language {{{2
set spelllang=en
let spellst = ["en", "de"]
let langcnt = 0

function!  SelectLanguage()
  let g:langcnt = (g:langcnt+1) % len(g:spellst)
  let lang = g:spellst[g:langcnt]
  echo "spelllang=" . lang
  exe "set spelllang=" . lang
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

" commands {{{1
" diff the current buffer and the file it was loaded from {{{2
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" put files or snippets on sprunge.us {{{2
command! -range=% Sprunge :<line1>,<line2>write !curl -F "sprunge=<-" http://sprunge.us|xclip
" find and show todos {{{2
command! Todo vimgrep /TODO:\|FIXME:\|XXX:/j ** | botright cope
" edit current filetypeplugin {{{2
command! Ftedit exe ':edit ~/.vim/ftplugin/'.&ft.'.vim'

" scratchpad {{{1
nnoremap gV `[v`]
