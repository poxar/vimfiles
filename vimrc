" vim:set sw=4 foldmethod=marker ft=vim expandtab:

"
" vimrc
" global settings for vim
" Maintainer: Philipp Millar <philipp.millar@gmx.de>
"

"========================================================================="
"                                Settings                                 "
"========================================================================="
" vim {{{
set nocompatible

call pathogen#infect()

set langmenu=en_US.UTF-8
language en_US.UTF-8
set encoding=utf-8

filetype plugin indent on
syntax on

set directory=~/tmp
set viminfo='100,<1000,s200,h
set history=1000

set cursorline             " highlight the current line
set laststatus=2           " always show the status line
set ruler                  " show the cursor position all the time
set showmatch              " show matching parentheses
set lazyredraw             " do not redraw while running macros
set hidden                 " allow hidden buffers
set clipboard=unnamed      " synchronize unnamed buffer and system clipboard
set pastetoggle=<F4>       " F4 toggles between paste and normal mode
set nobackup               " don't use backups, use git instead
set nowritebackup          " seriously

set shiftwidth=4           " use 4 spaces as indent
set autoindent             " automatic indenting
set smartindent            " smart indenting
set smarttab               " use tab for indent levels at a blank line
set expandtab              " expand tabs with spaces
set nojoinspaces           " J(oin) doesn't add useless blanks
set backspace=indent,eol   " define behaviour of the backspace key

set ignorecase             " search is case insensitive,
set smartcase              " except when upper-case letters are used
set incsearch              " show search results immediately
set hlsearch               " highlight results
set gdefault               " reverse the meaning of /g in patterns

" tab completion with menu
set wildmenu
set wildmode=longest:full
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
set wildignorecase
" use omnicompletion
set ofu=syntaxcomplete#Complete
" characters for list
set listchars=tab:▸\ ,eol:¬,trail:·

" version dependent settings
if version >= 703
    set relativenumber         " show relative line numbers
    set cryptmethod=blowfish   " use blowfish to encrypt files
endif

" use persistent undo if possible
if has("persistent_undo")
    set undodir=~/.vimundo
    set undofile
endif
" }}}
" OS specific settings {{{
if has("unix")
    set fileformats=unix,dos,mac
    set wildignorecase " ignore case for tab completion
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

" Solarized
let g:solarized_underline=0
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
let g:solarized_diffmode="high"
let g:solarized_hitrail=1
" colorscheme solarized
colorscheme badwolf

" LaTeX-BoX
let g:LatexBox_viewer="zathura"
let g:LatexBox_autojump=1

" NeoComplCache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.go = '\.\w'
let g:neocomplcache_omni_patterns.java = '\%(\h\w*\|)\)\.'

" NeoSnippet
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
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
"        <F11> unbound
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

" put files or snippets on sprunge.us
command -range=% Sprunge :<line1>,<line2>write !curl -F "sprunge=<-" http://sprunge.us|xclip

" indent next line to match current word
let @j='yiwy0opVr J'
" underline the current line
let @h='yyp0v$r='
let @u='yyp0v$r-'
" ==============================================================================
"}}}
