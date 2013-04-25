
"
" vimrc
" Maintainer: Philipp Millar <philipp.millar@gmail.com>
"

" vim settings {{{
" most configuration is done by vim-sensible from tpope

" load plugin management
call pathogen#infect()

" i can afford a big viminfo
set viminfo='100,<1000,s200,h

set cursorline        " highlight the current line
set lazyredraw        " do not redraw while running macros
set hidden            " allow hidden buffers
set clipboard=unnamed " synchronize unnamed buffer and system clipboard

set shiftwidth=2      " use 2 spaces as indent
set expandtab         " expand tabs with spaces
set nojoinspaces      " J(oin) doesn't double space

set ignorecase        " search is case insensitive,
set smartcase         " except when upper-case letters are used
set hlsearch          " highlight results
set gdefault          " reverse the meaning of /g in patterns

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

" cscope
if has('cscope')
  set cscopeverbose
  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif
endif
" }}}
" gui settings {{{
if has("gui_running")
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
" plugin settings {{{
" read man files in vim with :Man
if has("unix")
  runtime ftplugin/man.vim
endif

" Snipmate
let g:snips_author="Philipp Millar"

" Gundo
nnoremap cog :GundoToggle<cr>

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

if has('unix')
  " LaTeX-BoX
  let g:LatexBox_viewer="zathura"
  let g:LatexBox_autojump=1
endif
"}}}

" mappings {{{
" Don't use Ex mode, use Q for formatting
vnoremap Q gq
nnoremap Q gqap
" swap ' and ` so 'a goes to line and column marked with ma
nnoremap ' `
nnoremap ` '
" use space for foldings
nnoremap <space> za
" quick make
nnoremap <leader>m  :make
nnoremap <leader>mm :make<cr><cr>
nnoremap <leader>mc :make clean<cr><cr>

" leave insert mode quickly
inoremap jk <esc>

" kill buffer without closing the window/view
nnoremap <leader>bd :bp\|bd #<cr>
" open quickfix list
nnoremap <leader>co :botright cope<cr>
" location list
nnoremap <leader>lo :lopen<cr>

" vimrc
nnoremap <leader>ev  :edit   $MYVIMRC<cr>
nnoremap <leader>esv :vsplit $MYVIMRC<cr>
nnoremap <leader>sv  :source $MYVIMRC<cr>

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

" indent next line to match current word
let @j='yiwy0opVr J'
" underline the current line
let @h='yyp0v$r='
let @u='yyp0v$r-'
" }}}
" abbreviations {{{
" the look of disapproval (and friends)
iabbrev ldis ಠ_ಠ
iabbrev lsad ಥ_ಥ
iabbrev lhap ಥ‿ಥ

" expand %% to the path of the current file
cabbrev <expr> %% expand('%:p:h')
" }}}

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

" command DiffOrig {{{
" diff the current buffer and the file it was loaded from
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" }}}
" command Sprunge {{{
" put files or snippets on sprunge.us
command! -range=% Sprunge :<line1>,<line2>write !curl -F "sprunge=<-" http://sprunge.us|xclip
"}}}

" auto numbering {{{
" change the numbering style, according to mode and focus
augroup numbers
  au! FocusLost   * :set number
  au! FocusGained * :set relativenumber

  au! InsertEnter * :set number
  au! InsertLeave * :set relativenumber
augroup END
" }}}

" vim:set sw=2 foldmethod=marker ft=vim expandtab:
