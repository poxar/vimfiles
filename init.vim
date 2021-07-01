
"
" init.vim
" Maintainer: Philipp Millar <philipp.millar@poxar.net>
"

" Settings {{{1
let $PATH .= ':' . expand(stdpath('config') . '/bin')
set shada=!,'200,s20,h
set undofile
set nomodeline

set hidden
set virtualedit=block

let g:mapleader      = ' '
let g:maplocalleader = '\\'

" Text formatting
set textwidth=80
set nojoinspaces
set formatoptions=qcrn2j
set shiftround
set expandtab
set shiftwidth=2

" Search and replace
set ignorecase
set smartcase
set gdefault
set inccommand=nosplit
set tagcase=followscs

" Display
set showmatch
set matchpairs+=<:>
let g:matchparen_insert_timeout=10

set number
set relativenumber

set showbreak=↪
set listchars=tab:⇥\ ,trail:·,extends:⇉,precedes:⇇,nbsp:␣
set fillchars=fold:\ ,vert:│
set breakindent
set breakindentopt=sbr

set diffopt+=vertical
set scrolloff=1
set sidescrolloff=5
set linebreak
set splitright
set splitbelow

set shortmess=atToOIc
set notimeout
set lazyredraw
set termguicolors
set guicursor+=a:Cursor
colorscheme badwolf

" Highlight git conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Completion
set omnifunc=syntaxcomplete#Complete
set wildmode=longest:full
set wildignorecase

" Plugins {{{1

" man.vim {{{2
let $MANWIDTH = 80
let g:man_hardwrap = 1

" termdebug {{{2
let g:termdebug_wide=161

" vim-dirvish {{{2
let g:loaded_netrw = 1

" vim-fugitive {{{2
nnoremap <buffer> <leader>df :diffget //2<cr>
nnoremap <buffer> <leader>dj :diffget //3<cr>

" ctrlp.vim {{{2
let g:ctrlp_extensions = ['tag', 'buffertag']

nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>t :CtrlPBufTag<cr>
nnoremap <leader>T :CtrlPTag<cr>
nnoremap <leader>n :CtrlP $NOTEDIR<cr>

if executable('rg')
  let g:ctrlp_user_command = 'rg --files %s'
endif

" tabular {{{2
nnoremap g= :Tabularize /
vnoremap g= :Tabularize /
nnoremap g\: :Tabularize /:\zs<cr>
vnoremap g\: :Tabularize /:\zs<cr>
nnoremap g\, :Tabularize /,\zs<cr>
vnoremap g\, :Tabularize /,\zs<cr>
nnoremap g\= :Tabularize /=<cr>
vnoremap g\= :Tabularize /=<cr>

" gundo.vim {{{2
nnoremap yog :GundoToggle<cr>

let g:gundo_preview_bottom = 1
let g:gundo_right = 1
let g:gundo_prefer_python3 = 1

" ultisnips {{{2

command! Snipedit UltiSnipsEdit
let g:UltiSnipsJumpForwardTrigger = "<c-n>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"

" lsp {{{2
let g:lsp_diagnostics_enabled = 0
let g:lsp_fold_enabled = 0

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete

  nmap <buffer> <C-]> <Plug>(lsp-definition)

  nmap <buffer> gd <plug>(lsp-peek-declaration)
  nmap <buffer> gD <plug>(lsp-peek-definition)
  nmap <buffer> gr <plug>(lsp-references)
endfunction

augroup lsp_install
  au!
  " call s:on_lsp_buffer_enabled only for languages that have the server registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" See https://langserver.org/ for lsp implementations

if executable('clangd')
  augroup lsp_setup_clangd
    au! User lsp_setup call lsp#register_server({
          \ 'name': 'clangd',
          \ 'cmd': {server_info->['clangd']},
          \ 'whitelist': ['c', 'cpp'],
          \ })
  augroup END
endif

if executable('rls')
  augroup lsp_setup_rls
    au! User lsp_setup call lsp#register_server({
          \ 'name': 'rls',
          \ 'cmd': {server_info->['rls']},
          \ 'whitelist': ['rust', 'rustdoc'],
          \ })
  augroup END
endif

if executable('pyls')
  augroup lsp_setup_pyls
    au! User lsp_setup call lsp#register_server({
          \ 'name': 'pyls',
          \ 'cmd': {server_info->['pyls']},
          \ 'whitelist': ['python'],
          \ })
  augroup END
endif

if executable('vala-language-server')
  augroup lsp_setup_vala
    au! User lsp_setup call lsp#register_server({
          \ 'name': 'vala-language-server',
          \ 'cmd': {server_info->['vala-language-server']},
          \ 'whitelist': ['vala'],
          \ })
  augroup END
endif

" Mappings {{{1

inoremap jk <esc>
inoremap <c-f> <c-x><c-f>

nnoremap Y :normal y$<cr>

nnoremap ' `
nnoremap ` '

nnoremap <leader>f :find<space>
nnoremap <silent> <c-l> :nohlsearch<cr><c-l>

" Start a new change (undo point) when deleting lines/words in insert mode
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Don't use Ex mode, use Q to repeat last :command
nnoremap Q @:

" Allow some typos in omni completion
inoremap <c-x>o <c-x><c-o>
inoremap <c-x>n <c-x><c-o>
inoremap <c-x><c-n> <c-x><c-o>

" Open last/alternate buffer
nnoremap <c-w><leader> <c-^>

" Substitute word under the curser
nnoremap gS :%s/\<<c-r>=expand('<cword>')<cr>\>/

" Source line or selection
vnoremap <leader>S y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" When you forget to sudoedit
cabbrev w!! w !sudo tee % >/dev/null

" Edit and reload configuration
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>esv :vsplit $MYVIMRC<cr>

" Operate on the directory of the current file
nnoremap <leader>e.  :edit <C-R>=expand("%:p:h") . "/" <cr>
nnoremap <leader>es. :vsplit <C-R>=expand("%:p:h") . "/" <cr>
nnoremap <leader>c.  :lcd %:p:h<cr>
cabbrev <expr> %% expand('%:p:h')

" Close quickfix and location list windows
nnoremap <leader>q :cclose<cr>:lclose<cr>

" Commands {{{1

" Strip trailing whitespace
command! StripWhitespace normal mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" find and show todos
command! -nargs=? Note grep! \[Nn\]\[Oo\]\[Tt\]\[Ee\]: <args> | botright cope
command! -nargs=? Todo grep! TODO:\\|FIXME:\\|XXX: <args> | botright cope
command! -nargs=? Fixme grep! FIXME:\\|XXX: <args> | botright cope

" edit current filetypeplugin
command! Ftedit execute ":edit ". stdpath('config') ."/ftplugin/".&ft.".vim"

" pretty print
command! -range=% JsonPP :<line1>,<line2>!python -m json.tool
command! -range=% HtmlPP :<line1>,<line2>!pandoc --from=html --to=markdown | pandoc --from=markdown --to=html

" Abbreviations {{{1
iabbrev (C) ©
iabbrev ldis ಠ_ಠ
iabbrev shrg ¯\_(ツ)_/¯
