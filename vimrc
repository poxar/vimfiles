
"###
"#
"# vimrc
"# global settings for vim
"# Maintainer: Philipp Millar <philipp.millar@gmx.de>
"#
"# Note: non-basic configuration lives under plugin/
"#
"###

" Initialization {{{
" ==============================================================================
set nocompatible " vim settings
filetype off     " needed for vundle

" setup os-dependant variables and initialize vundle
if has("unix")
    let g:vimdir=$HOME."/.vim/"
    set rtp+=~/.vim/bundle/vundle
    call vundle#rc()
else
    " running on windows
    let g:vimdir=$HOME."/vimfiles/"
    set rtp+=~/vimfiles/bundle/vundle
    call vundle#rc('$HOME/vimfiles/bundle/')
endif
Bundle 'gmarik/vundle'

Bundle 'Shougo/neocomplcache'
Bundle 'altercation/vim-colors-solarized'
Bundle 'git://gitorious.org/vim-gnupg/vim-gnupg.git'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'rygwdn/ultisnips'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'vim-pandoc/vim-pandoc'
Bundle 'vim-scripts/taglist.vim'
Bundle 'xolox/vim-notes'

let g:did_vundle_setup=1
" ==============================================================================
" }}}
" Settings
" ==============================================================================
" basic {{{
let &g:directory=g:vimdir.'tmp/swap'
let &g:backupdir=g:vimdir.'tmp/backup'
let &g:undodir=g:vimdir.'tmp/undo'
let &g:viminfo="'100,<1000,s100,h,n".g:vimdir."viminfo"

set backup               " keep backups
if has("win32")
    " don't overwrite my hardlinks, please
    " still overwrites symlinks for some reason
    set backupcopy=yes
endif
set undofile             " use a (persistent) undo file
set history=100          " save 100 entries for each history

set cryptmethod=blowfish " use blowfish to encrypt files
set autochdir            " change pwd automatically
set hidden               " allow hidden buffers
set modelines=2          " search for modelines
set clipboard=unnamed    " synchronize unnamed buffer and system clipboard
set pastetoggle=<F4>     " F4 toggles between paste and normal mode
set lazyredraw           " do not redraw while running macros

set wildmenu      " completion-menu
set wildmode=full " Tab cycles between all matching choices
" ignore certain files when tab-completing
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png

if has("win32")
    set fileformats=dos,unix,mac
    set autoread
else
    set fileformats=unix,dos,mac
endif

set langmenu=en_US.UTF-8
let $LANG = 'en_US.UTF-8'
"}}}
" ui {{{
filetype plugin indent on
syntax on
set cursorline     " highlight the current line
set title          " set console title
set laststatus=2   " always show the status line
set ruler          " show the cursor position all the time
set relativenumber " show relative line numbers
set showmode       " show the mode we're in
set showmatch      " show matching parentheses
set showcmd        " display incomplete commands
" show tabs and trailing spaces
set listchars=tab:>-,trail:-
"}}}
" gui {{{
if has("gui_running")
    set background=light

    " make the gui clean
    set guioptions-=T
    set guioptions-=R
    set guioptions-=r
    set guioptions-=L
    set guioptions-=l
    set guioptions-=b

    if has("unix")
        set guifont=DejaVu\ Sans\ Mono\ 10
    else
        set guifont=Consolas:h11:cANSI
    endif

    " I hate popups, use console messages instead
    set guioptions+=c
else
    set background=dark
endif
"}}}
" edit {{{
set shiftwidth=4           " use 4 blanks as indent
set autoindent             " automatic indenting
set smarttab               " use tab for indent levels at a blank line
set expandtab              " expand tabs with spaces
set nojoinspaces           " J(oin) doesn't add useless blanks
set whichwrap=""           " don't jump over linebounds
set backspace=indent,start " don't allow backspacing over eol in insert mode
"}}}
" search {{{
set ignorecase " search is case insensitive,
set smartcase  " except when upper-case letters are used
set incsearch  " show search results immediately
set hlsearch   " highlight results
" }}}
" ==============================================================================
" Misc {{{
" ==============================================================================
" read man files in vim with :Man
if has("unix")
    runtime ftplugin/man.vim
endif

" load skeleton files
augroup skeleton
    au!
    au BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e
augroup END

" indent next line to match current word
let @j='yiwy0opVr J'
" ==============================================================================
"}}}


" vim:set sw=4 foldmethod=marker ft=vim expandtab:
