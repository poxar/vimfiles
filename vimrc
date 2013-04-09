" vim:set sw=2 foldmethod=marker ft=vim expandtab:

"
" vimrc
" global settings for vim
" Maintainer: Philipp Millar <philipp.millar@gmx.de>
"

"========================================================================="
"                                Settings                                 "
"========================================================================="
" vim {{{
call pathogen#infect()

set langmenu=en_US.UTF-8
language en_US.UTF-8
set encoding=utf-8

" (most) settings from sensible {{{
" see https://github.com/tpope/vim-sensible

if has('autocmd')
  filetype plugin indent on
endif
if has ('syntax') && !exists('g:syntax_on')
  syntax enable
endif

set autoindent             " automatic indenting
set bs=indent,eol,start    " define behaviour of the backspace key
set complete-=i
set showmatch              " show matching parentheses
set smarttab               " use tab for indent levels at a blank line

set nrformats-=octal       " ignore base 8
set shiftround             " Round indent to multiple of 'shiftwidth'

set ttimeout               " time out on mappings
set ttimeoutlen=50

set incsearch              " show search results immediately
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif
set laststatus=2           " always show the status line
set ruler                  " show the cursor position all the time
set showcmd                " show partial command in the cli
set wildmenu

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
  endif
endif

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

if !exists('g:netrw_list_hide')
  let g:netrw_list_hide = '^\.,\~$,^tags$'
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

let s:dir = has('win32') ? '~/Application Data/Vim' : match(system('uname'), "Darwin") > -1 ? '~/Library/Vim' : empty($XDG_DATA_HOME) ? '~/.local/share/vim' : '$XDG_DATA_HOME/vim'
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
if exists('+undofile')
  set undofile
endif
nnoremap & :&&<CR>
xnoremap & :&&<CR>
" }}}

set viminfo='100,<1000,s200,h
set history=1000
set tabpagemax=50

set cursorline             " highlight the current line
set lazyredraw             " do not redraw while running macros
set hidden                 " allow hidden buffers
set clipboard=unnamed      " synchronize unnamed buffer and system clipboard
set pastetoggle=<F2>       " F4 toggles between paste and normal mode

set shiftwidth=2           " use 4 spaces as indent
set smartindent            " smart indenting
set expandtab              " expand tabs with spaces
set nojoinspaces           " J(oin) doesn't add useless blanks

set ignorecase             " search is case insensitive,
set smartcase              " except when upper-case letters are used
set hlsearch               " highlight results
set gdefault               " reverse the meaning of /g in patterns

" tab completion with menu
set wildmode=longest:full
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
if has('wildignorecase')
  set wildignorecase
endif
" use omnicompletion
set ofu=syntaxcomplete#Complete

" version dependent settings
if version >= 703
  set relativenumber         " show relative line numbers
  set cryptmethod=blowfish   " use blowfish to encrypt files
endif
" }}}
" OS specific settings {{{
if has("unix")
  set fileformats=unix,dos,mac
  set background=dark
  if has('cscope')
    set cscopeverbose
    if has('quickfix')
      set cscopequickfix=s-,c-,d-,i-,t-,e-
    endif
  endif
elseif has("win32")
  set fileformats=dos,unix,mac
  set autoread " read changes automatically
endif "}}}
" gui settings {{{
if has("gui_running")
  set background=light

  " make the gui clean
  set guioptions=cegi

  if has("unix")
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
    let g:Powerline_symbols='fancy'
  else
    set guifont=Consolas_for_Powerline_FixedD:h11:cANSI
    let g:Powerline_symbols='fancy'
  endif
endif "}}}
" plugins {{{

" Snipmate
let g:snips_author="Philipp Millar"

" Gundo
nnoremap <leader>tu :GundoToggle<cr>

" Solarized
let g:solarized_underline=0
let g:solarized_termcolors=256
let g:solarized_diffmode="high"
"colorscheme solarized
colorscheme badwolf

" Gist
if has('unix')
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_show_privates = 1

" LaTeX-BoX
let g:LatexBox_viewer="zathura"
let g:LatexBox_autojump=1
"}}}

"========================================================================="
"                                Functions                                "
"========================================================================="
" SelectLanguage {{{
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

nnoremap <leader>tl :call SelectLanguage()<CR>
"}}}
" StripWhitespace {{{
function! StripWhitespace()
  exec ':%s/ \+$//gc'
endfunction

nnoremap <localleader>s<space> :call StripWhitespace()<cr>
"}}}
" ToggleFoldmethod {{{
function! ToggleFoldmethod()
  if(&fdm == "marker")
    set fdm=syntax
    set fdm?
  else
    set fdm=marker
    set fdm?
  endif
endfunc

nnoremap <leader>tf :call ToggleFoldmethod()<cr>
"}}}
" ToggleNumberMode {{{
function! ToggleNumberMode()
  if(&rnu == 1)
    set nu
  else
    set rnu
  endif
endfunc

nnoremap <leader>tn :call ToggleNumberMode()<cr>
"}}}

"========================================================================="
"                                Commands                                 "
"========================================================================="
" DiffOrig {{{
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" }}}
" Sprunge {{{
" put files or snippets on sprunge.us
command! -range=% Sprunge :<line1>,<line2>write !curl -F "sprunge=<-" http://sprunge.us|xclip
"}}}

"========================================================================="
"                                Mappings                                 "
"========================================================================="
" basic {{{
" ==============================================================================
" Don't use Ex mode, use Q for formatting
vnoremap Q gq
nnoremap Q gqap
" make Y consistent with D and C
nnoremap Y y$
" swap ' and ` so 'a goes to line and column marked with ma
nnoremap ' `
nnoremap ` '
" use space for foldings
nnoremap <space> za
" quick make
nnoremap <leader>m  :make
nnoremap <leader>mm :make<cr><cr>
nnoremap <leader>mc :make clean<cr><cr>
" jump to tag in new split
nnoremap <leader>tt :vsp<cr>:ene<cr>:tag<space>
" toggle some settings
nnoremap  <leader>ts :set<space>spell!<space>\|<space>set<space>spell?<cr>
nnoremap  <leader>tli :set<space>list!<space>\|<space>set<space>list?<cr>
" ==============================================================================
" }}}
" insert mode {{{
" ==============================================================================
" leave insert mode quickly
inoremap jk <esc>
" ==============================================================================
" }}}
" visual mode {{{
" ==============================================================================
" retain selection in vm when indenting blocks
vnoremap < <gv
vnoremap > >gv
" ==============================================================================
" }}}
" window management {{{
" ==============================================================================
" kill buffer without closing the window/view
nnoremap <leader>bd :bp\|bd #<cr>

" cope
nnoremap <leader>co :botright cope<cr>
" location list
nnoremap <leader>lo :lopen<cr>
" ==============================================================================
" }}}
" open, write and source special files {{{
" ==============================================================================
" write file as root
if has("unix")
  cnoremap w!! w !sudo tee % >/dev/null
endif

" open notes directory
if has("unix")
  nnoremap <leader>n :e ~/data/Dropbox/notes/
elseif has("win32")
  nnoremap <leader>n :e ~\Dropbox\notes\
endif

" vimrc
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>esv :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" ==============================================================================
" }}}
" abbreviations {{{
" the look of disapproval (and friends)
iabbrev ldis ಠ_ಠ
iabbrev lsad ಥ_ಥ
iabbrev lhap ಥ‿ಥ

cabbr <expr> %% expand('%:p:h')
" }}}

"========================================================================="
"                                  Misc                                   "
"========================================================================="
"{{{
" read man files in vim with :Man
if has("unix")
  runtime ftplugin/man.vim
endif

" load skeleton files
augroup skeleton
  au!
  if has("unix")
    au BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e
  elseif has("win32")
    au BufNewFile * silent! 0r ~/vimfiles/skel/tmpl.%:e
  endif
augroup END

" indent next line to match current word
let @j='yiwy0opVr J'
" underline the current line
let @h='yyp0v$r='
let @u='yyp0v$r-'
" ==============================================================================
"}}}
