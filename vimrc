" vim:set sw=4 foldmethod=marker ft=vim expandtab:

"
" vimrc
" global settings for vim
" Maintainer: Philipp Millar <philipp.millar@gmx.de>
"

"========================================================================="
"                                Settings                                 "
"========================================================================="
" init {{{
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
"}}}
" bundles {{{
Bundle 'gmarik/vundle'

Bundle 'Lokaltog/vim-powerline'
Bundle 'Shougo/neocomplcache'
Bundle 'git://gitorious.org/vim-gnupg/vim-gnupg.git'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'scrooloose/nerdcommenter'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'vim-pandoc/vim-pandoc'
Bundle 'UltiSnips'
Bundle 'vim-scripts/taglist.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/nerdtree'
"}}}
" vim {{{
filetype plugin indent on
syntax on

let &g:directory=g:vimdir.'tmp/swap'
let &g:backupdir=g:vimdir.'tmp/backup'
let &g:undodir=g:vimdir.'tmp/undo'
let &g:viminfo="'100,<1000,s100,h,n".g:vimdir."viminfo"

set cursorline             " highlight the current line
set title                  " set console title
set laststatus=2           " always show the status line
set ruler                  " show the cursor position all the time
set relativenumber         " show relative line numbers
set showmode               " show the mode we're in
set showmatch              " show matching parentheses
set showcmd                " display incomplete commands

set undofile               " use a (persistent) undo file
set history=100            " save 100 entries for each history

set cryptmethod=blowfish   " use blowfish to encrypt files
set autochdir              " change pwd automatically
set hidden                 " allow hidden buffers
set modelines=2            " search for modelines
set clipboard=unnamed      " synchronize unnamed buffer and system clipboard
set pastetoggle=<F4>       " F4 toggles between paste and normal mode
set lazyredraw             " do not redraw while running macros

set wildmenu               " completion-menu
set wildmode=full          " Tab cycles between all matching choices
set backup                 " keep backups

set shiftwidth=4           " use 4 blanks as indent
set autoindent             " automatic indenting
set smarttab               " use tab for indent levels at a blank line
set expandtab              " expand tabs with spaces
set nojoinspaces           " J(oin) doesn't add useless blanks
set whichwrap=""           " don't jump over linebounds
set backspace=indent,start " don't allow backspacing over eol in insert mode

set ignorecase             " search is case insensitive,
set smartcase              " except when upper-case letters are used
set incsearch              " show search results immediately
set hlsearch               " highlight results

set langmenu=en_US.UTF-8
let $LANG = 'en_US.UTF-8'
set encoding=utf-8

" ignore certain files when tab-completing
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
" show tabs and trailing spaces
set listchars=tab:>-,trail:-

if has("win32")
    set fileformats=dos,unix,mac
    set backupcopy=yes     " don't overwrite my hardlinks, please
    set autoread           " read changes automatically
    set background=light
else
    set fileformats=unix,dos,mac
    set background=dark
endif

" gui settings
if has("gui_running")

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
endif
" }}}
" plugins {{{

" UltiSnips
let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets"]

" TagList
if has("win32")
    let Tlist_Ctags_Cmd = 'C:\Program Files (x86)\ctags58\ctags.exe'
else
    let Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 0

" Solarized
let g:solarized_underline=0
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
let g:solarized_diffmode="high"
let g:solarized_hitrail=1
colorscheme solarized

" NERDTree
let g:NERDTreeHijackNetrw=0
let g:NERDTreeShowBookmarks=1
let g:NERDTreeMinimalUI=1
"}}}

"========================================================================="
"                                Functions                                "
"========================================================================="
" BufClose {{{
" Don't close view, when deleting a buffer
" http://amix.dk/vim/vimrc.html

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

nnoremap <localleader>bd :Bclose<cr>
"}}}
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

nnoremap <localleader>ll :call SelectLanguage()<CR>
"}}}
" StripWhitespace {{{
function! StripWhitespace()
        exec ':%s/ \+$//gc'
endfunction

nnoremap <localleader>s :call StripWhitespace()<cr>
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

nnoremap <F2> :call ToggleFoldmethod()<cr>
"}}}
" ToggleNumberMode {{{
function! ToggleNumberMode()
        if(&rnu == 1)
                set nu
        else
                set rnu
        endif
endfunc

nnoremap <F3> :call ToggleNumberMode()<cr>
"}}}

"========================================================================="
"                                Commands                                 "
"========================================================================="
" DiffOrig {{{
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" }}}

"========================================================================="
"                                Mappings                                 "
"========================================================================="
" basic {{{
" ==============================================================================
" leave insert mode quickly
inoremap jk <esc>
" Don't use Ex mode, use Q for formatting
vnoremap Q gq
nnoremap Q gqap
" make Y consistent with D and C
nnoremap Y y$
" swap ' and ` so 'a goes to line and column marked with ma
nnoremap ' `
nnoremap ` '
" use H L to go to the start/end of a line
nnoremap H g0
nnoremap L g$
" use return for foldings
nnoremap <cr> za

" simplify window-management
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" split windows quickly
nnoremap <leader>vs :vsplit<cr>
nnoremap <leader>ss :split<cr>

" cope
nnoremap <leader>co :botright cope<cr>
nnoremap <leader>cn :cn<cr>
nnoremap <leader>cp :cp<cr>
" location list
nnoremap <leader>lo :lopen<cr>
nnoremap <leader>ln :lnext<cr>
nnoremap <leader>lp :lprevious<cr>
" ==============================================================================
" }}}
" function keys {{{
" ==============================================================================
nnoremap  <F1> :set<space>spell!<space>\|<space>set<space>spell?<cr>
"         <F2> toggles foldmethod between marker and sytax
"         <F3> toggles number style
nnoremap  <F4> :set<space>paste!<space>\|<space>set<space>paste?<cr>
nnoremap  <F5> :nohlsearch<cr>
nnoremap  <F6> :set<space>list!<space>\|<space>set<space>list?<cr>
"         <F7> unbound
"         <F8> unbound
nnoremap  <F9> :GundoToggle<cr>
nnoremap <F10> :TlistToggle<cr>
nnoremap <F11> :NERDTreeToggle<cr>
"        <F12> opens previews (LaTeX)
" ==============================================================================
" }}}
" open, write and source special files {{{
" ==============================================================================
" write file as root
if has("unix")
    cnoremap w!! w !sudo tee % >/dev/null
endif

" open todo file
if has("unix")
    nnoremap <leader>t :e ~/data/Dropbox/todo/todo.txt<cr>
else
    nnoremap <leader>t :e ~/todo.txt<cr>
endif
" open notes directory
if has("unix")
    nnoremap <leader>n :e ~/.pim/notes<cr>
else
    nnoremap <leader>n :e D:\data\Dropbox\notes<cr>
endif

" vimrc
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>esv :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" ==============================================================================
" }}}
" plugins {{{
" Surround
nnoremap <localleader>" ysiw"
nnoremap <localleader>' ysiw'
nnoremap <localleader>) ysiw)
" }}}
" abbreviations {{{
" the look of disapproval (and friends)
iabbrev ldis ಠ_ಠ
iabbrev lsad ಥ_ಥ
iabbrev lhap ಥ‿ಥ
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
    au BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e
augroup END

" indent next line to match current word
let @j='yiwy0opVr J'
" ==============================================================================
"}}}

