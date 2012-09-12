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
call pathogen#infect()

" setup os-dependant variables and initialize vundle
if has("unix")
    let g:vimdir=$HOME."/.vim/"
else " running on windows
    let g:vimdir=$HOME."\\vimfiles\\"
endif
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
set hidden                 " allow hidden buffers
set modelines=2            " search for modelines
set clipboard=unnamed      " synchronize unnamed buffer and system clipboard
set pastetoggle=<F4>       " F4 toggles between paste and normal mode
set lazyredraw             " do not redraw while running macros

set wildmenu               " completion-menu
set wildmode=full          " Tab cycles between all matching choices
if has("unix")
    " ignore case in filenames
    set wildignorecase
endif
set backup                 " keep backups
set completeopt=menuone,preview
set ofu=syntaxcomplete#Complete
set complete=.,b,u,]

set shiftwidth=4           " use 4 blanks as indent
set autoindent             " automatic indenting
set smarttab               " use tab for indent levels at a blank line
set expandtab              " expand tabs with spaces
set nojoinspaces           " J(oin) doesn't add useless blanks
set whichwrap=""           " don't jump over linebounds
set backspace=indent,eol   " define behaviour of the backspace key

set ignorecase             " search is case insensitive,
set smartcase              " except when upper-case letters are used
set incsearch              " show search results immediately
set hlsearch               " highlight results
set gdefault               " reverse the meaning of /g in patterns

set langmenu=en_US.UTF-8
let $LANG = 'en_US.UTF-8'
set encoding=utf-8

" ignore certain files when tab-completing
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png

if has("win32")
    " show tabs and trailing spaces
    set listchars=tab:▸\ ,eol:¬
    set fileformats=dos,unix,mac
    set backupcopy=yes     " don't overwrite my hardlinks, please
    set autoread           " read changes automatically
    set background=light
else
    " show tabs and trailing spaces
    set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
    set showbreak=↪
    set fileformats=unix,dos,mac
    if has("gui_running")
        set background=light
    else
        set background=dark
    endif
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

" Solarized
let g:solarized_underline=0
let g:solarized_termcolors=256
let g:solarized_contrast="normal"
let g:solarized_visibility="high"
let g:solarized_diffmode="high"
let g:solarized_hitrail=1
colorscheme solarized

" NERDTree
let g:NERDTreeHijackNetrw=0
let g:NERDTreeShowBookmarks=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeWinPos="right"
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

nnoremap <localleader>ll :call SelectLanguage()<CR>
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
" use space for foldings
nnoremap <space> za
" quick make
nnoremap <leader>m  :make
nnoremap <leader>mm :make<cr><cr>
nnoremap <leader>mc :make clean<cr><cr>
" jump to tag in new split
nnoremap <leader>t :vsp<cr>:ene<cr>:tag<space>
" clear search highlight
nnoremap <leader><space> :nohlsearch<cr>
" center screen after certain motions
nnoremap n nzz
nnoremap } }zz
" ==============================================================================
" }}}
" insert mode {{{
" ==============================================================================
" leave insert mode quickly
inoremap jk <esc>

" some readline stuff
inoremap <C-a> <C-o>g0
inoremap <C-e> <C-o>g$

" omni-completion
inoremap <C-L> <C-X><C-O>
" ==============================================================================
" }}}
" window management {{{
" ==============================================================================
" simplify window-management
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" split windows quickly
nnoremap <leader>vs :vsplit<cr>
nnoremap <leader>ss :split<cr>
" kill buffer without closing the window/view
nnoremap <leader>bd :bp\|bd #<cr>

" cope
nnoremap <leader>co :botright cope<cr>
" location list
nnoremap <leader>lo :lopen<cr>
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
nnoremap <F10> :NERDTreeToggle<cr>
"        <F11> :Fullscreen<cr>
"        <F12> opens previews (LaTeX), Generates tags
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
    nnoremap <leader>n :e ~/.pim/notes<cr>
else
    nnoremap <leader>n :e ~\Dropbox\notes\<cr>
endif

" vimrc
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>esv :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" ftplugin
execute "nnoremap <leader>ef :edit ".g:vimdir."ftplugin"
execute "nnoremap <leader>esf :vsplit ".g:vimdir."ftplugin"
" ==============================================================================
" }}}
" plugins {{{
" Surround
nnoremap <leader>" ysiw"
nnoremap <leader>' ysiw'
nnoremap <leader>) ysiw)
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
