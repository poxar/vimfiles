
"
" vimrc
" Maintainer: Philipp Millar <philipp.millar@poxar.de>
"

" settings {{{1
" basics {{{2

filetype plugin indent on
syntax enable

set viminfo='200,s200,r/tmp
set history=1000
set tabpagemax=50

set nomodeline
set exrc
set secure

set lazyredraw
set hidden
set backspace=indent,eol,start
set virtualedit+=block

set nrformats-=octal
set encoding=utf-8
scriptencoding 'utf-8'

if has('unix')
  set path=**,.,/usr/include,,
else
  set path=**,.,,
endif

if has('cryptv')
  if has('patch-7.4.401')
    set cryptmethod=blowfish2
  elseif v:version >= 703
    set cryptmethod=blowfish
  endif
endif

set diffopt=filler,vertical

if has('patch-7.4.1649') && !has('nvim')
  packadd! matchit
else
  runtime! macros/matchit.vim
endif

" text formatting {{{2
set textwidth=80
if executable('par')
  set formatprg=par\ -w80
endif
set nojoinspaces
if v:version >= 704
  set formatoptions=qcrnlj
else
  set formatoptions=qcrnl
endif
set autoindent
set shiftround

" don't timeout on mappings {{{2
set notimeout
set ttimeout
set ttimeoutlen=10

" search and replace {{{2
set ignorecase
set smartcase
set hlsearch
set incsearch
set gdefault

if has('nvim-0.2.0')
  set inccommand=split
endif

if has('patch-7.4.941')
  set tagcase=followscs
endif

" display {{{2
if has('termguicolors')
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum
  set termguicolors
endif
colorscheme badwolf

set laststatus=2
set display+=lastline
set shortmess=atToOIc
set ruler
set showcmd
set visualbell

set scrolloff=1
set sidescrolloff=5

set showmatch
set matchpairs=(:),[:],{:},<:>
" don't search longer than 10ms for a matching character
let g:matchparen_insert_timeout=10

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

" Show linenumbers by default (change in ftplugin)
set number
" Show relative line numbers in active windows, where number is set
if v:version >= 703
  augroup relativenumber
    au!
    au WinEnter,TabEnter,BufWinEnter * call SetRelativeNumber()
    au WinLeave,TabLeave,BufWinLeave * call UnsetRelativeNumber()
  augroup END

  function! g:SetRelativeNumber()
    if &number
      set relativenumber
    endif
  endfunction

  function! g:UnsetRelativeNumber()
    if &relativenumber
      set norelativenumber
    endif
  endfunction
endif

set linebreak

" New Splits default to right, below
set splitright
set splitbelow

if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
  set showbreak=↪
  set listchars=tab:⇥\ ,trail:·,extends:⇉,precedes:⇇,nbsp:␣
  set fillchars=fold:\ ,vert:│
else
  set listchars=tab:>-,trail:_,extends:>,precedes:<,nbsp:+
  let &showbreak='+++ '
  set fillchars=fold:\ ,vert:\|
endif

if has('linebreak')
  set breakindent
  set breakindentopt=sbr
endif

" statusline {{{2
" command ForceStatusline {{{3
command! ForceStatusline call SetActiveStatusline()

augroup Statusline "{{{3
  au! Statusline
  au WinEnter,TabEnter,BufWinEnter,VimEnter * call SetActiveStatusline()
  au WinLeave,TabLeave,BufWinLeave * call SetInactiveStatusline()
augroup END

function! g:SkipStatusline() "{{{3
  if &ft ==? 'help'
    return 1
  endif
endfunction

function! g:SetActiveStatusline() "{{{3
  if g:SkipStatusline()
    return
  endif

  setlocal statusline=
  " TODO: This currently depends on the badwolf colorscheme
  setlocal statusline+=%#InterestingWord1#\ %-3.3n%*\    " buffer number
  setlocal statusline+=%{StatusLinePath()}               " file name
  setlocal statusline+=%h%m%r%w                          " flags
  setlocal statusline+=%=                                " right align
  setlocal statusline+=%#normal#\ %{StatusLineStats()}%* " file stats
  setlocal statusline+=\ \ %l:%v\                        " ruler
endfunction

function! g:SetInactiveStatusline() "{{{3
  if g:SkipStatusline()
    return
  endif

  setlocal statusline=
  setlocal statusline+=\ %-3.3n\           " buffer number
  setlocal statusline+=%h%m%r%w            " flags
  setlocal statusline+=%{StatusLinePath()} " file name
endfunction

function! g:StatusLinePath() " {{{3
  let l:path = expand('%:.')
  let l:path = substitute(l:path,'\','/','g')
  let l:path = substitute(l:path, '^\V' . $HOME, '~', '')
  let l:path = simplify(l:path)

  if len(l:path) > 30
    let l:path = pathshorten(l:path)
  endif

  if !strlen(l:path)
    let l:path = '[No Name]'
  endif

  return l:path
endfunction

function! g:StatusLineStats() "{{{3
  let l:filestats = ''

  if strlen(g:fugitive#head())
    let l:filestats .= g:fugitive#head() . ' '
  endif

  if strlen(&filetype)
    let l:filestats .= &ft . ' '
  else
    let l:filestats .= 'none '
  endif

  if strlen(&fenc) && &fenc !=# 'utf-8'
    let l:filestats .= &fenc . ' '
  elseif &enc !=# 'utf-8'
    let l:filestats .= &enc . ' '
  endif

  if strlen(&fileformat) && &fileformat !=# 'unix'
    let l:filestats .= &fileformat . ' '
  endif

  return l:filestats
endf

" colorcolumn and cursorline {{{2
" This maps coC to toggle the colorcolumn, but shows it only in the current
" buffer. Furthermore the cursorline is shown in the current buffer.
" toggle colorcolumn at textwidth + 1 {{{3
function! g:ToggleColorColumn()
  if exists('b:my_cc')
    setlocal colorcolumn=
    setlocal colorcolumn?
    unlet b:my_cc
  else
    setlocal colorcolumn=+1
    setlocal colorcolumn?
    let b:my_cc = 1
  endif
endfunc

nnoremap coC :call ToggleColorColumn()<cr>

augroup cursorlines "{{{3
  au! cursorlines
  au WinEnter,TabEnter,BufWinEnter,VimEnter * call SetupCursorLines()
  au WinLeave,TabLeave,BufWinLeave * call HideCursorLines()
augroup END

function! g:SetupCursorLines() "{{{3
  if &ft !=# 'help'
    setlocal cursorline

    if exists('b:my_cc')
      setlocal colorcolumn=+1
    endif
  endif
endfunction

function! g:HideCursorLines() "{{{3
  setlocal colorcolumn=""
  setlocal nocursorline
endfunction

" completion {{{2
set omnifunc=syntaxcomplete#Complete
set wildmenu
set wildmode=list:longest,full
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
set wildignorecase

if has('unix')
  set dictionary=/usr/share/dict/words
endif

" cscope {{{2
if has('cscope')
  set cscopeverbose
  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif
endif

" backup/swap/undo {{{2

let s:dir = has('win32') ? '$APPDATA/Vim' : match(system('uname'), 'Darwin') > -1 ? '~/Library/Vim' : empty($XDG_DATA_HOME) ? '~/.local/share/vim' : '$XDG_DATA_HOME/vim'

if !isdirectory(expand(s:dir))
  call mkdir(expand(s:dir))
endif
if !isdirectory(expand(s:dir) . '/swap/')
  call mkdir(expand(s:dir) . '/swap/')
endif
if !isdirectory(expand(s:dir) . '/backup/')
  call mkdir(expand(s:dir) . '/backup/')
endif
if !isdirectory(expand(s:dir) . '/undo/')
  call mkdir(expand(s:dir) . '/undo/')
endif

let &directory = expand(s:dir) . '/swap//,' . &directory
let &backupdir = expand(s:dir) . '/backup//,' . &backupdir

if exists('+undodir')
  let &undodir = expand(s:dir) . '/undo//,' . &undodir
endif

set backup
set swapfile

if exists('+undofile')
  set undofile
endif

" leader {{{2
let g:mapleader      = ' '
let g:maplocalleader = '\\'

" read man files in vim with :Man {{{2
if has('unix')
  runtime ftplugin/man.vim
endif

" use improved search tools if available {{{2

let s:rgcmd='--smart-case --vimgrep'
let s:agcmd='--smart-case --nocolor --nogroup --column'
let s:ackcmd='-H --smart-case --nocolor --nogroup --column'

if executable('rg')
  let &grepprg='rg '.s:rgcmd
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  let g:ackprg='rg '.s:rgcmd
elseif executable('sift')
  set grepprg=sift
  set grepformat=%f:%l:%c:%m,%f:%l:%m,%f:%l%m,%f\ \ %l%m
  let g:ackprg='sift'
elseif executable('ag')
  let &grepprg='ag '.s:agcmd
  let g:ackprg='ag '.s:agcmd
elseif executable('ack-grep')
  let &grepprg='ack-grep '.s:ackcmd
  let g:ackprg='ack-grep '.s:ackcmd
else
  let &grepprg='ack '.s:ackcmd
  let g:ackprg='ack '.s:ackcmd
endif

command! -nargs=+ -complete=file G grep! <args>

" plugins {{{1

" editorconfig/editorconfig-vim {{{2
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" romainl/vim-qf {{{2
let g:qf_mapping_ack_style = 1
nnoremap coq <Plug>QfCtoggle
nnoremap coL <Plug>QfLtoggle
nnoremap <leader>l <Plug>QfSwitch

" justinmk/vim-dirvish {{{2
augroup dirvish_events
  autocmd!

  " Enable fugitive in dirvish
  autocmd FileType dirvish call fugitive#detect(@%)

  " Map `gh` to hide dot-prefixed files.
  " To "toggle" this, just press `R` to reload.
  autocmd FileType dirvish nnoremap <buffer>
    \ gh :keeppatterns g@\v/\.[^\/]+/?$@d<cr>
augroup END

" godlygeek/tabular {{{2
nnoremap g= :Tabularize /
vnoremap g= :Tabularize /
nnoremap g\: :Tabularize /:\zs<cr>
vnoremap g\: :Tabularize /:\zs<cr>
nnoremap g\, :Tabularize /,\zs<cr>
vnoremap g\, :Tabularize /,\zs<cr>
nnoremap g\= :Tabularize /=<cr>
vnoremap g\= :Tabularize /=<cr>

" ctrlpvim/ctrlp.vim {{{2
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>t :CtrlPBufTag<cr>
nnoremap <leader>T :CtrlPTag<cr>

let g:ctrlp_extensions = ['tag', 'buffertag']

if executable('rg')
  let g:ctrlp_user_command = 'rg --files %s'
endif

" scrooloose/syntastic {{{2
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'

" tpope/vim-fugitive {{{2
" auto clean fugitive buffers
augroup fugitive_clean
  au! BufReadPost fugitive://* set bufhidden=delete
augroup END

" mbbill/undotree {{{2
nnoremap cog :UndotreeToggle<cr>

" haya14busa/incsearch.vim {{{2
" intelligently hide hlsearch
let g:incsearch#auto_nohlsearch = 1
" n goes down N goes up, no matter what
let g:incsearch#consistent_n_direction = 1
" hide search errors in :messages output
let g:incsearch#do_not_save_error_message_history = 1
" use verymagic by default
let g:incsearch#magic = '\v'

" activate plugin
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" SirVer/ultisnips {{{2
let g:snips_author='Philipp Millar'
let g:snips_author_email='philipp.millar@poxar.net'
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'snip']
let g:UltiSnipsNoPythonWarning = 1

let g:UltiSnipsJumpForwardTrigger = '<C-m>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

if has('win32')
  let g:UltiSnipsSnippetsDir='~/vimfiles/snip'
elseif has('neovim')
  let g:UltiSnipsSnippetsDir='~/.config/nvim/snip'
else
  let g:UltiSnipsSnippetsDir='~/.vim/snip'
endif

nnoremap <leader>ese :UltiSnipsEdit<cr>

" }}}2

" mappings {{{1
" fixes {{{2

" Make <F1> helpful
inoremap <F1> <F1>
nnoremap <F1> :help <C-R><C-W><CR>

" Fix Y
nnoremap Y :normal y$<cr>

" swap ' and ` so 'a goes to line and column marked with ma
nnoremap ' `
nnoremap ` '

" swap j/k/0/$ and gj/gk/g0/g$
" so the g variations work on physikal lines and the default ones on display
" lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap g0 0
nnoremap 0 g0
nnoremap $ g$
nnoremap g$ $

" cli editing
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" recall commands from history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" start a new change when deleting lines/words in insert mode
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Don't use Ex mode, use Q to repeat last :command
nnoremap Q @:

" open last/alternate buffer
nnoremap <leader><leader> <C-^>

" correct typos
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>


" enhancements {{{2
" leave insert mode quickly
inoremap jk <esc>

" simpler to type
nnoremap <BS> %

" vaporize: delete without overwriting the default register
nnoremap vd "_d
xnoremap x  "_d
nnoremap vD "_D

" quickly substitute word under the curser
nnoremap gs :%s/\<<C-r>=expand('<cword>')<CR>\>/

" select line minus indent
nnoremap vv ^vg_

" source
vnoremap <leader>S y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" simpler filename completion
inoremap <c-f> <c-x><c-f>

" write file as root
if has('unix')
  cabbrev w!! w !sudo tee % >/dev/null
endif

" expand %% to the path of the current file
cabbrev <expr> %% expand('%:p:h')

" simple math
noremap <leader>mm yypkA =<Esc>jOscale=2<Esc>:.,+1!bc -ql<CR>kJ

" visual stuff {{{2

" more visual buffer switching
nnoremap gb :ls<CR>:buffer<Space>
nnoremap gB :ls<CR>:sbuffer<Space>

" Use <C-L> to clear the highlighting of :set hlsearch
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" close all other folds and center this line
nnoremap z<space> zMzvzz


" quick edit/cd {{{2
" source
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>sg :source $MYGVIMRC<cr>
" edit
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>eg :edit $MYGVIMRC<cr>
nnoremap <leader>esv :vsplit $MYVIMRC<cr>
nnoremap <leader>esg :vsplit $MYGVIMRC<cr>

" open file in directory of current file
noremap <leader>e.  :edit   <C-R>=expand("%:p:h") . "/" <cr>
noremap <leader>es. :vsplit <C-R>=expand("%:p:h") . "/" <cr>
" cd to directory of current file
nnoremap <leader>c. :lcd %:p:h<cr>

if has('win32')
  " edit
  nnoremap <leader>ea :edit ~\Documents\AutoHotkey.ahk<cr>

  " cd
  nnoremap <leader>cv :cd ~\vimfiles<cr>

  " notes
  nnoremap <leader>n :e ~/notes/

else " unix
  " edit
  nnoremap <leader>ec :edit ~/.config/<cr>
  nnoremap <leader>exb :edit ~/.xbindkeysrc<cr>
  nnoremap <leader>ezz :edit ~/.zsh.d/<cr>
  nnoremap <leader>ezc :edit ~/.zshrc<cr>

  " cd
  nnoremap <leader>cc :cd ~/Developement/
  nnoremap <leader>cv :cd ~/.vim<cr>

  " notes
  nnoremap <leader>n :e ~/.notes/
endif


" macros {{{1
" indent next line to match current word
let @j='yiwy0opVr J'
" underline the current line
let @h='yyp0v$r='
let @u='yyp0v$r-'

" functions {{{1
" change the spell-language {{{2
set spelllang=en
if has('win32')
  set spellfile=~/vimfile/spell/en.utf-8.add
else
  set spellfile=~/.vim/spell/en.utf-8.add
endif
let g:spellst = ['en', 'de_20']
let g:langcnt = 0

function!  g:SelectLanguage()
  let g:langcnt = (g:langcnt+1) % len(g:spellst)
  let l:lang = g:spellst[g:langcnt]
  echo 'spelllang=' . l:lang
  exe 'set spelllang=' . l:lang
  if has('win32')
    exe 'set spellfile=~/vimfiles/spell/' . l:lang . '.utf-8.add'
  else
    exe 'set spellfile=~/.vim/spell/' . l:lang . '.utf-8.add'
  endif
endfunction

nnoremap coS :call SelectLanguage()<CR>
" scratchbuffer for messages {{{2
function! g:MessageWindow()
  new [Messages]
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal buflisted
  redir => l:messages_output
  silent messages
  redir END
  silent put=l:messages_output
endfunction

command! Messages call MessageWindow()

" make * search a visual selection {{{2
function! s:VSetSearch()
  let l:temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = l:temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

" toggle the last search pattern register between the last two search patterns {{{2

function! s:ToggleSearchPattern()
    let next_search_pattern_index = -1
    if @/ ==# histget('search', -1)
        let next_search_pattern_index = -2
    endif
    let @/ = histget('search', next_search_pattern_index)
endfunction

nnoremap <silent> <Leader>/ :<C-u>call <SID>ToggleSearchPattern()<CR>

" commands {{{1
" kill buffer without closing the window/view {{{2
command! Bkill bp\|bd #<cr>
" strip trailing whitespace {{{2
command! StripWhitespace normal mz:%s/\s\+$//<cr>:let @/=''<cr>`z
" diff the current buffer and the file it was loaded from {{{2
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" put files or snippets on sprunge.us {{{2
command! -range=% Sprunge :<line1>,<line2>write !curl -F "sprunge=<-" http://sprunge.us|xclip
" find and show todos {{{2
command! Note grep! \[Nn\]\[Oo\]\[Tt\]\[Ee\]: | botright cope
command! Todo grep! TODO:\\|FIXME:\\|XXX: | botright cope
command! Fixme grep! FIXME:\\|XXX: | botright cope
" edit current filetypeplugin {{{2
command! Ftedit execute ':edit ~/.vim/ftplugin/'.&ft.'.vim'

" substitute double words {{{2
command! DoubleWords /\(\<\S\+\>\)\(\_\s\+\<\1\>\)\+/

" pretty print json {{{2
command! JsonPP execute ':%!python -m json.tool'

" autocommands {{{1

augroup notes
  au! BufRead ~/.notes/* setlocal autoread
  au! BufRead ~/.notes/* setlocal autowrite
  au! BufRead ~/.notes/* setlocal autowriteall
augroup END

" force markdown on everything
augroup markdown
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
augroup END

" highlighting {{{1
" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
