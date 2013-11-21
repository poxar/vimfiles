
"
" vimrc
" Maintainer: Philipp Millar <philipp.millar@poxar.de>
"

" init {{{
runtime bundle/vim-unbundle/unbundle.vim

filetype plugin indent on
syntax enable
" }}}
" settings {{{
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
" }}}2
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
" }}}2
" don't timeout on mappings {{{2
set notimeout
set ttimeout
set ttimeoutlen=10
" }}}2
" search and replace {{{2
set ignorecase
set smartcase
set hlsearch
set incsearch
set gdefault
" }}}2
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

if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
  set showbreak=↪
  set listchars=tab:⇥\ ,trail:·,extends:⇉,precedes:⇇,nbsp:␣
  set fillchars=fold:\ ,vert:│
else
  set listchars=tab:>-,trail:_,extends:>,precedes:<,nbsp:+
  let &showbreak='+++ '
  set fillchars=fold:\ ,vert:\|
endif
" }}}2
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
" }}}2
" cscope {{{2
if has('cscope')
  set cscopeverbose
  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif
endif
" }}}2
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
" }}}2
" gvim {{{2
if has("gui_running")
  " make the gui clean
  set guioptions=cegi
  set mousehide
  " less doesn't work in gvim
  set kp=man\ -P\ more

  if has("unix")
    set guifont=DejaVu\ Sans\ Mono\ 11
  else
    set guifont=Consolas:h11:cANSI
  endif
endif
" }}}2

let mapleader      = " "
let maplocalleader = "\\"

" read man files in vim with :Man or K
if has("unix")
  runtime ftplugin/man.vim
  nnoremap K :Man <C-r><C-w><cr>
endif
" }}}
" filetype {{{
" syntax highlighting {{{2
" haskell
let g:hs_highlight_delimiters = 1
let g:hs_highlight_boolean = 1
let g:hs_highlight_types = 1
let g:hs_highlight_more_types = 1
let g:hs_highlight_debug = 1
" java
let g:java_mark_braces_in_parens_as_errors=1
let g:java_highlight_all=1
let g:java_highlight_debug=1
let g:java_highlight_java_lang_ids=1
let g:java_highlight_functions="style"
let g:java_minlines = 150
" }}}2

augroup c_settings "{{{2
  au! FileType c setlocal cindent
augroup END "}}}2
augroup cpp_settings "{{{2
    au! Filetype cpp cindent
    au! Filetype cpp setlocal textwidth=120
augroup END "}}}2
augroup gitcommit_settings "{{{2
    au! Filetype gitcommit setlocal spell
    au! Filetype gitcommit setlocal spelllang=en
augroup END "}}}2
augroup haskell_settings "{{{2
    au! Filetype haskell setlocal softtabstop=4
augroup END "}}}2
augroup help_settings "{{{2
    au! Filetype help setlocal statusline=%<%h\ %f%=%l\ %P
augroup END "}}}2
augroup java_settings "{{{2
    au! Filetype java setlocal noexpandtab
    au! Filetype java setlocal tabstop=4
    au! Filetype java setlocal textwidth=120
    au! Filetype java setlocal makeprg=ant\ -find\ build.xml
    au! Filetype java setlocal efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
augroup END "}}}2
augroup mail_settings "{{{2
    au! Filetype mail setlocal textwidth=72
    au! Filetype mail setlocal spell
    au! Filetype mail setlocal spelllang=de
augroup END "}}}2
augroup snippets_settings "{{{2
    au! Filetype snippets setlocal noexpandtab
augroup END "}}}2
augroup vim_settings "{{{2
    au! Filetype vim setlocal fdm=marker
augroup END "}}}2
" }}}
" plugin {{{
" slimux - SLIME inspired tmux integration plugin for Vim {{{2
nnoremap <leader>R :SlimuxREPLSendLine<cr>
vnoremap <leader>R :SlimuxREPLSendSelection<cr>
nnoremap <leader>sp :SlimuxShellPrompt<cr>
nnoremap <leader>S :SlimuxShellLast<cr>
"}}}2
" dispatch - asynchronous build and test dispatcher {{{2
nnoremap <leader>m  :Make<space>
nnoremap <leader>mm :Make<cr>
nnoremap <leader>mc :Make clean<cr>
"}}}2
" fugitive - a Git wrapper so awesome, it should be illegal {{{2
" auto clean fugitive buffers
augroup fugitive-clean
    au! BufReadPost fugitive://* set bufhidden=delete
augroup END
" }}}2
" gundo - Graph your Vim undo tree in style {{{2
nnoremap cog :GundoToggle<cr>
let g:gundo_preview_bottom = 1
"}}}2
" fswitch - Vim plugin for switching between companion source files {{{2
nnoremap <A-o> :FSH<cr>
inoremap <A-o> <esc>:FSH<cr>
"}}}2
" UltiSnips - snippet engine {{{2
let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets"]

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsListSnippets="<a-k>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<a-j>"
nnoremap <leader>ess :UltiSnipsEdit<cr>
"}}}2
" clang_complete - Vim plugin that uses clang for completing C/C++ code. {{{
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
"}}}2
" LaTeX-BoX - Lightweight Toolbox for LaTeX {{{2
let g:LatexBox_autojump=1
let g:LatexBox_Folding=1
if has('unix')
    let g:LatexBox_viewer="zathura"
endif
"}}}2
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
nnoremap <leader>F :<C-u>Unite file<cr>

nnoremap <leader>j :<C-u>Unite buffer<cr>
nnoremap <leader>J :<C-u>Unite jump<cr>

nnoremap <leader>k :<C-u>Unite bookmark<cr>
nnoremap <leader>K :<C-u>Unite file_mru<cr>

nnoremap <leader>p :<C-u>Unite history/yank register<cr>

command! Map Unite -no-start-insert mapping
command! Messages Unite -no-start-insert output:message

" notes
nnoremap <leader>n :<C-u>Unite file:~/.notes<cr>
nnoremap <leader>N :e ~/.notes/

" unite-outline
nnoremap <leader>o :<C-u>Unite outline<cr>
"}}}2
" dragvisuals - Vim global plugin for dragging virtual blocks {{{2
vmap <expr> <LEFT>  DVB_Drag('left')
vmap <expr> <RIGHT> DVB_Drag('right')
vmap <expr> <DOWN>  DVB_Drag('down')
vmap <expr> <UP>    DVB_Drag('up')
vmap <expr> D       DVB_Duplicate()
" }}}2
" yankring - Maintains a history of previous yanks, changes and deletes {{{2
" save the yankring in a sensible location
if isdirectory(expand(s:dir))
    let g:yankring_history_dir = expand(s:dir) . '/yank'
endif
" }}}2
" easy-align - A simple Vim alignment plugin {{{2
vnoremap <silent> <Enter> :EasyAlign<Enter>
let g:easy_align_ignore_groups = ['Comment', 'String']
" }}}2
" }}}

" mappings {{{
" Make <F1> helpful
inoremap <F1> <F1>
nnoremap <F1> :help <C-R><C-W><CR>

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Don't use Ex mode, use Q for formatting
vnoremap Q gq
nnoremap Q gqap

" swap ' and ` so 'a goes to line and column marked with ma
nnoremap ' `
nnoremap ` '

" open last/alternate buffer
nnoremap <leader><leader> <C-^>

" start a new change when deleting lines/words in insert mode
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" sessions
nnoremap <Leader>ms :mksession ~/.vim/sessions/
nnoremap <Leader>ls :source ~/.vim/sessions/

" leave insert mode quickly
inoremap jk <esc>

" Don't move on *
nnoremap * *<c-o>
" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv
" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" cli editing
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" strip trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z
" select what was just pasted
nnoremap <leader>V V`]
" select line minus indent
nnoremap vv ^vg_

" more visual buffer switching
nnoremap <leader>b :buffers<CR>:buffer<Space>
" kill buffer without closing the window/view
nnoremap <leader>db :bp\|bd #<cr>
" open quickfix list
nnoremap <leader>co :botright cope<cr>
" location list
nnoremap <leader>lo :lopen<cr>


" Source
vnoremap <leader>S y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" simpler filename completion
inoremap <c-f> <c-x><c-f>

" list navigation
nnoremap <left>  :cprev<cr>zvzz
nnoremap <right> :cnext<cr>zvzz
nnoremap <up>    :lprev<cr>zvzz
nnoremap <down>  :lnext<cr>zvzz

" Typos
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>

" write file as root
if has("unix")
  cnoremap w!! w !sudo tee % >/dev/null
endif

" indent whole file
nnoremap <leader>q gg=G<C-o><C-o>

" recall commands from history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" indent next line to match current word
let @j='yiwy0opVr J'
" underline the current line
let @h='yyp0v$r='
let @u='yyp0v$r-'

" expand %% to the path of the current file
cabbrev <expr> %% expand('%:p:h')

" close all other folds and center this line
nnoremap z<space> zMzvzz
" }}}
" quick edit/cd {{{
" edit
if has('win32')
  " source
  nnoremap <leader>sv  :source ~\vimfiles\vimrc<cr>

  " edit
  nnoremap <leader>ev  :edit   ~\vimfiles\vimrc<cr>
  nnoremap <leader>esv :vsplit ~\vimfiles\vimrc<cr>

  nnoremap <leader>ea :edit ~\Documents\AutoHotkey.ahk<cr>

  " cd
  nnoremap <leader>ch :cd ~<cr>
  nnoremap <leader>cv :cd ~\vimfiles<cr>
else
  " source
  nnoremap <leader>sv  :source ~/.vim/vimrc<cr>

  " edit
  nnoremap <leader>ev  :edit   ~/.vim/vimrc<cr>
  nnoremap <leader>esv :vsplit ~/.vim/vimrc<cr>

  nnoremap <leader>eu :edit ~/data/Dropbox/Uni/<cr>9j
  nnoremap <leader>ec :edit ~/.config/<cr>9j
  nnoremap <leader>exc :edit ~/.config/xchainkeys/xchainkeys.conf<cr>
  nnoremap <leader>exb :edit ~/.xbindkeysrc<cr>
  nnoremap <leader>ezz :edit ~/.zsh/<cr>9j
  nnoremap <leader>ezc :edit ~/.zshrc<cr>

  " cd
  nnoremap <leader>cc :cd ~/code/
  nnoremap <leader>ch :cd ~<cr>
  nnoremap <leader>cv :cd ~/.vim<cr>
endif
"}}}

" func SelectLanguage {{{
" function to change the spell-language
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
"}}}
" func ToggleFoldmethod {{{
function! ToggleFoldmethod()
  if(&fdm == "marker")
    set fdm=syntax
    set fdm?
  else
    set fdm=marker
    set fdm?
  endif
endfunc

nnoremap cof :call ToggleFoldmethod()<cr>
"}}}
" func ToggleColorColumn {{{
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
" }}}
" func EchoFileInfo {{{
" this prints some basic stats about the current file
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
"}}}
" func FollowSymlink {{{
" follow symlinks (for fugitive etc)
if !has("win32")
  function! s:FollowSymlink()
    let fname = resolve(expand('%:p'))
    bwipeout
    exec "edit " . fname
  endfunction
  command! FollowSymlink call s:FollowSymlink()
endif
" }}}

" command DiffOrig {{{
" diff the current buffer and the file it was loaded from
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" }}}
" command Sprunge {{{
" put files or snippets on sprunge.us
command! -range=% Sprunge :<line1>,<line2>write !curl -F "sprunge=<-" http://sprunge.us|xclip
"}}}
" command Todo {{{
" find and show todos
command! Todo vimgrep /TODO:\|FIXME:/j ** | botright cope
" }}}
