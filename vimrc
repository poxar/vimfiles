
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
set list              " show stray characters (have a look at sensible.vim)

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
" plugin settings {{{
" read man files in vim with :Man
if has("unix")
  runtime ftplugin/man.vim
endif

" Snipmate
let g:snips_author="Philipp Millar"

" Gundo
nnoremap cog :GundoToggle<cr>
let g:gundo_preview_bottom = 1

" LaTeX-BoX
let g:LatexBox_autojump=1
if has('unix')
  let g:LatexBox_viewer="zathura"
endif

" Unite
" enable yank history tracking
let g:unite_source_history_yank_enable = 1

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
endfunction

" fuzzy matching
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" combined most important sources
nnoremap <leader>j :<C-u>Unite -no-split -buffer-name=all
      \ -start-insert file file_mru buffer bookmark<cr>
" only files
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files
      \ -start-insert file<cr>
" recursive files
nnoremap <leader>F :<C-u>Unite -no-split -buffer-name=files
      \ -start-insert file_rec<cr>
" mru files
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru
      \ -start-insert file_mru<cr>
" yank history
nnoremap <leader>y :<C-u>Unite -buffer-name=yank
      \ history/yank<cr>
" buffers
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer
      \ -start-insert buffer<cr>
" notes
nnoremap <leader>n :<C-u>Unite -no-split -buffer-name=notes
      \ -start-insert file:~/.notes<cr>
nnoremap <leader>N :e ~/.notes/

" unite-outline
" outline
nnoremap <leader>o :<C-u>Unite -buffer-name=outline
      \ outline<cr>
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

" start a new change when deleting lines/words in insert mode
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

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

" auto-clean fugitive buffers {{{
augroup fugitive-clean
  au! BufReadPost fugitive://* set bufhidden=delete
augroup END
" }}}
" local vim settings {{{
"
" I mainly use this for project specific settings like so
"
" augroup project
"   au! BufRead,BufNewFile /path/to/project/* :source /path/to/project/.vimrc
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
