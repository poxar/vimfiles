
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

set kp=man\ -P\ more  " less doesn't work in gvim

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
  set mousehide

  if has("unix")
    set guifont=DejaVu\ Sans\ Mono\ 11
  else
    set guifont=Consolas_FixedD:h11:cANSI
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

" indent whole file
nnoremap <leader>q gg=G<C-o><C-o>

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
  let finfo=finfo."(".argidx()."/".argc().")"

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

" command DiffOrig {{{
" diff the current buffer and the file it was loaded from
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" }}}
" command Sprunge {{{
" put files or snippets on sprunge.us
command! -range=% Sprunge :<line1>,<line2>write !curl -F "sprunge=<-" http://sprunge.us|xclip
"}}}

" auto numbering {{{
" change the numbering style, according to mode
augroup numbers
  au! InsertEnter * :set number
  au! InsertLeave * :set relativenumber
augroup END
" }}}
" local vim settings {{{
"
" I mainly use this for project specific settings like so
"
" augroup project
"   au! BufRead,BufNewFile /path/to/project/* :Sauce project
" augroup END
"
if filereadable($HOME . "/.local.vimrc")
  so ~/.local.vimrc
endif

nnoremap <leader>el  :edit   ~/.local.vimrc<cr>
nnoremap <leader>esl :vsplit ~/.local.vimrc<cr>
nnoremap <leader>sl  :source ~/.local.vimrc<cr>
" }}}

" vim:set sw=2 foldmethod=marker ft=vim expandtab:
