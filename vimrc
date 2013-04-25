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

set viminfo='100,<1000,s200,h
set history=1000
set tabpagemax=50

set cursorline             " highlight the current line
set lazyredraw             " do not redraw while running macros
set hidden                 " allow hidden buffers
set clipboard=unnamed      " synchronize unnamed buffer and system clipboard
set pastetoggle=<F2>       " F4 toggles between paste and normal mode

set shiftwidth=2           " use 4 spaces as indent
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

" YCM
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

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

augroup numbers
  au! FocusLost   * :set number
  au! FocusGained * :set relativenumber

  au! InsertEnter * :set number
  au! InsertLeave * :set relativenumber
augroup END

" indent next line to match current word
let @j='yiwy0opVr J'
" underline the current line
let @h='yyp0v$r='
let @u='yyp0v$r-'
" ==============================================================================
"}}}
