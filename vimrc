
"
" vimrc
" Maintainer: Philipp Millar <philipp.millar@poxar.de>
"

" settings {{{1
" vim configuration directory {{{2

if has('win32')
  let g:vim_path='~/vimfiles'
elseif has('nvim')
  let g:vim_path='~/.config/nvim'
else
  let g:vim_path='~/.vim'
endif

let $PATH .= ':' . expand(g:vim_path . '/bin')

" basics {{{2

filetype plugin indent on
syntax enable

set viminfo=!,'200,s200,r/tmp,r/mnt
set history=1000

set nomodeline

set lazyredraw
set hidden
set backspace=indent,eol,start
set virtualedit+=block

set nrformats-=octal

set encoding=utf-8
scriptencoding 'utf-8'

set diffopt+=vertical

if has('patch-7.4.1649') && !has('nvim')
  packadd! matchit
else
  runtime! macros/matchit.vim
endif

" text formatting {{{2
set textwidth=80
if executable('par')
  set formatprg=par\ -w80
endif
set nojoinspaces
if v:version >= 704
  set formatoptions=qcrn2j
else
  set formatoptions=qcrn2
endif
set autoindent
set shiftround
set expandtab
set shiftwidth=2

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

if has('nvim-0.2.0')
  set inccommand=split
endif

if has('patch-7.4.941')
  set tagcase=followscs
endif

" display {{{2
if has('termguicolors')
  set termguicolors
endif
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

" Show wraparound with 'showbreak'
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

" completion {{{2
set omnifunc=syntaxcomplete#Complete
set wildmenu
set wildmode=list:longest,full
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
set wildignorecase

" backup/swap/undo {{{2

let s:dir =
      \ has('win32') ? '$APPDATA/Vim' :
      \ match(system('uname'), 'Darwin') > -1 ? '~/Library/Vim' :
      \ empty($XDG_DATA_HOME) ? '~/.local/share/vim' : '$XDG_DATA_HOME/vim'

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
if !has('nvim')
  let &viminfofile = expand(s:dir) . '/viminfo'
endif

if exists('+undodir')
  let &undodir = expand(s:dir) . '/undo//,' . &undodir
endif

set backup
set swapfile

if exists('+undofile')
  set undofile
endif

" leader {{{2
let g:mapleader      = ' '
let g:maplocalleader = '\\'

" read man files in vim with :Man {{{2
if has('unix')
  let g:ft_man_open_mode = 'vert'
  runtime ftplugin/man.vim
  set keywordprg=:Man
endif

" plugins {{{1

" editorconfig/editorconfig-vim {{{2
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" justinmk/vim-dirvish {{{2
let g:loaded_netrw = 1
augroup dirvish_events
  autocmd!

  " Map `gh` to hide dot-prefixed files.
  " To "toggle" this, just press `R` to reload.
  autocmd FileType dirvish nnoremap <buffer>
    \ gh :keeppatterns g@\v/\.[^\/]+/?$@d<cr>
augroup END

" godlygeek/tabular {{{2
nnoremap g= :Tabularize /
vnoremap g= :Tabularize /
nnoremap g\: :Tabularize /:\zs<cr>
vnoremap g\: :Tabularize /:\zs<cr>
nnoremap g\, :Tabularize /,\zs<cr>
vnoremap g\, :Tabularize /,\zs<cr>
nnoremap g\= :Tabularize /=<cr>
vnoremap g\= :Tabularize /=<cr>

" ctrlpvim/ctrlp.vim {{{2
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>t :CtrlPBufTag<cr>
nnoremap <leader>T :CtrlPTag<cr>
nnoremap <leader>n :CtrlP $NOTEDIR<cr>

let g:ctrlp_extensions = ['tag', 'buffertag']

if executable('rg')
  let g:ctrlp_user_command = 'rg --files %s'
endif

" w0rp/ale {{{2
let g:ale_open_list=0
let g:ale_list_window_size=5

let g:ale_sign_error='✗'
let g:ale_sign_warning='⇉'
let g:ale_sign_info='ℹ'
let g:ale_sign_style_error='●'
let g:ale_sign_style_warning='→'

let g:ale_haskell_ghc_options = '-dynamic'
let g:ale_linters = { 'scala': [], 'java': [] }

" tpope/vim-fugitive {{{2
" auto clean fugitive buffers
augroup fugitive_clean
  au! BufReadPost fugitive://* set bufhidden=delete
augroup END

" sjl/gundo.vim {{{2
nnoremap yog :GundoToggle<cr>

let g:gundo_preview_bottom = 1
let g:gundo_right = 1
let g:gundo_prefer_python3 = 1

" SirVer/ultisnips {{{2
let g:snips_author='Philipp Millar'
let g:snips_author_short='Philipp'
let g:snips_author_email='philipp.millar@poxar.net'
let g:UltiSnipsSnippetDirectories=['snip']
let g:UltiSnipsNoPythonWarning = 1

let g:UltiSnipsJumpForwardTrigger = '<C-m>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

let g:UltiSnipsSnippetsDir=g:vim_path.'/snip'
nnoremap <leader>ese :UltiSnipsEdit<cr>
command SnipEdit UltiSnipsEdit

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

" Don't use Ex mode, use Q to repeat last :command
nnoremap Q @:

" open last/alternate buffer
nnoremap <leader><leader> <C-^>


" enhancements {{{2
" leave insert mode quickly
inoremap jk <esc>

" vaporize: delete without overwriting the default register
nnoremap vd "_d
xnoremap x  "_d
nnoremap vD "_D

" quickly substitute word under the curser
nnoremap gS :%s/\<<C-r>=expand('<cword>')<CR>\>/

" select line minus indent
nnoremap vv ^vg_

" source
vnoremap <leader>S y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" simpler filename completion
inoremap <c-f> <c-x><c-f>

" write file as root
if has('unix')
  cabbrev w!! w !sudo tee % >/dev/null
endif

" expand %% to the path of the current file
cabbrev <expr> %% expand('%:p:h')

" simple math
noremap <leader>mm yypkA =<Esc>jOscale=2<Esc>:.,+1!bc -ql<CR>kJ

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

" local configuration
nnoremap <expr> <leader>el  ':edit '.g:vim_path.'/plugin/local.vim<cr>'
nnoremap <expr> <leader>esl ':edit '.g:vim_path.'/plugin/local.vim<cr>'
nnoremap <expr> <leader>ea  ':edit '.g:vim_path.'/autoload/local<cr>'
nnoremap <expr> <leader>esa ':edit '.g:vim_path.'/autoload/local<cr>'

" open file in directory of current file
noremap <leader>e.  :edit <C-R>=expand("%:p:h") . "/" <cr>
noremap <leader>es. :vsplit <C-R>=expand("%:p:h") . "/" <cr>
" cd to directory of current file
nnoremap <leader>c. :lcd %:p:h<cr>

" commands {{{1
" kill buffer without closing the window/view
command! Bkill bp\|bd #<cr>

" close all buffers except the current one
command! Bonly w | %bd | e# | bd#

" strip trailing whitespace
command! StripWhitespace normal mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" diff the current buffer and the file it was loaded from
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" find and show todos
command! -nargs=? Note grep! \[Nn\]\[Oo\]\[Tt\]\[Ee\]: <args> | botright cope
command! -nargs=? Todo grep! TODO:\\|FIXME:\\|XXX: <args> | botright cope
command! -nargs=? Fixme grep! FIXME:\\|XXX: <args> | botright cope

" edit current filetypeplugin
command! Ftedit execute ":edit ". g:vim_path ."/ftplugin/".&ft.".vim"

" find double words
command! DoubleWords /\(\<\S\+\>\)\(\_\s\+\<\1\>\)\+/

" pretty print
command! -range=% JsonPP :<line1>,<line2>!python -m json.tool
command! -range=% HtmlPP :<line1>,<line2>!pandoc --from=html --to=markdown | pandoc --from=markdown --to=html

" highlighting {{{1
" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
