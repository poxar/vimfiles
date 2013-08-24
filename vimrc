
"
" vimrc
" Maintainer: Philipp Millar <philipp.millar@gmail.com>
"

" plugin management {{{
if has('win32')
  source ~\vimfiles\plugins.vimrc
  nnoremap <leader>ep  :edit   ~\vimfiles\plugins.vimrc<cr>
  nnoremap <leader>esp :vsplit ~\vimfiles\plugins.vimrc<cr>
else
  source ~/.vim/plugins.vimrc
  nnoremap <leader>ep  :edit   ~/.vim/plugins.vimrc<cr>
  nnoremap <leader>esp :vsplit ~/.vim/plugins.vimrc<cr>
endif
" }}}
" vim settings {{{
" most configuration is done by vim-sensible from tpope

" i can afford a big viminfo
set viminfo='100,<1000,s200,h

set cursorline        " highlight the current line
set lazyredraw        " do not redraw while running macros
set hidden            " allow hidden buffers
set clipboard=unnamed " synchronize unnamed buffer and system clipboard

set shiftwidth=4      " use 4 spaces as indent
set expandtab         " expand tabs with spaces
set nojoinspaces      " J(oin) doesn't double space
set textwidth=80      " all files are 80 chars wide

set ignorecase        " search is case insensitive,
set smartcase         " except when upper-case letters are used
set hlsearch          " highlight results
set gdefault          " reverse the meaning of /g in patterns
set list              " show stray characters (have a look at sensible.vim)

set nomodeline        " disable modelines
set exrc              " read per directory vimrcs
set secure            " be secure when doing so

let mapleader      = " "
let maplocalleader = "\\"

" tab completion with menu
set wildmode=longest:full,full
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
if has('wildignorecase')
  set wildignorecase
endif

" use omnicompletion
set ofu=syntaxcomplete#Complete

" colorscheme
colorscheme badwolf

" version dependent settings
if version >= 703
  set relativenumber         " show relative line numbers
  set cryptmethod=blowfish   " use blowfish to encrypt files
else
  set number
endif

" cscope
if has('cscope')
  set cscopeverbose
  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif
endif

" read man files in vim with :Man
if has("unix")
  runtime ftplugin/man.vim
endif

" syntax highlighting
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
" }}}
" directory settings {{{
" this used to be set by vim-sensible
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
if exists('+undofile')
  set undofile
endif
" }}}
" gui settings {{{
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
endif "}}}
" filetype settings {{{
augroup c_settings
  au! FileType c setlocal cindent
augroup END

augroup cpp_settings
    au! Filetype cpp cindent
    au! Filetype cpp setlocal textwidth=120
augroup END

augroup gitcommit_settings
    au! Filetype gitcommit setlocal spell
    au! Filetype gitcommit setlocal spelllang=en
augroup END

augroup haskell_settings
    au! Filetype haskell setlocal softtabstop=4
augroup END

augroup help_settings
    au! Filetype help setlocal statusline=%<%h\ %f%=%l\ %P
augroup END

augroup java_settings
    au! Filetype java setlocal noexpandtab
    au! Filetype java setlocal tabstop=4
    au! Filetype java setlocal textwidth=120
    au! Filetype java setlocal makeprg=ant\ -find\ build.xml
    au! Filetype java setlocal efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
augroup END

augroup mail_settings
    au! Filetype mail setlocal textwidth=72
    au! Filetype mail setlocal spell
    au! Filetype mail setlocal spelllang=de
augroup END

augroup snippets_settings
    au! Filetype snippets setlocal noexpandtab
augroup END

augroup vim_settings
    au! Filetype vim setlocal fdm=marker
augroup END
" }}}

" mappings {{{
" Don't use Ex mode, use Q for formatting
vnoremap Q gq
nnoremap Q gqap
" swap ' and ` so 'a goes to line and column marked with ma
nnoremap ' `
nnoremap ` '
" open last/alternate buffer
nnoremap <leader><leader> <C-^>
" quick make
nnoremap <leader>m  :make
nnoremap <leader>mm :make<cr><cr>
nnoremap <leader>mc :make clean<cr><cr>

" start a new change when deleting lines/words in insert mode
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" sessions
nnoremap <Leader>ms :mksession ~/.vim/sessions/
nnoremap <Leader>ls :source ~/.vim/sessions/

" leave insert mode quickly
inoremap jk <esc>

" kill buffer without closing the window/view
nnoremap <leader>bd :bp\|bd #<cr>
" open quickfix list
nnoremap <leader>co :botright cope<cr>
" location list
nnoremap <leader>lo :lopen<cr>

" vimrc
if has('win32')
  nnoremap <leader>ev  :edit   ~\vimfiles\vimrc<cr>
  nnoremap <leader>esv :vsplit ~\vimfiles\vimrc<cr>
  nnoremap <leader>sv  :source ~\vimfiles\vimrc<cr>
else
  nnoremap <leader>ev  :edit   ~/.vim/vimrc<cr>
  nnoremap <leader>esv :vsplit ~/.vim/vimrc<cr>
  nnoremap <leader>sv  :source ~/.vim/vimrc<cr>
endif

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
" func EchoFileInfo {{{
" this prints some basic stats about the current file
" I like this way better than having a bloated statusline, packed with
" information I rarely need.
function! EchoFileInfo()
  let finfo=""

  let finfo=finfo."(".bufnr('%').")"
  let finfo=finfo."(".(argidx()+1)."/".argc().")"

  let finfo=finfo."  "
  let finfo=finfo."[".&filetype."]"
  let finfo=finfo."[".&fileformat."]"
  let finfo=finfo."[".&fileencoding."]"

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
