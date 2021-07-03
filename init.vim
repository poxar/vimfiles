
"
" init.vim
" Maintainer: Philipp Millar <philipp.millar@poxar.net>
"

" Settings {{{1
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

" Highlight yanked area
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=250, on_visual=true}

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

lua << EOF
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>m', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>l', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "mf<cr>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local servers =
    { "clangd"
    , "rust_analyzer"
    , "pyright"
    , "hls"
    , "elmls"
    , "tsserver"
    , "phpactor"
    , "vala_ls"
    }

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF

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

" Close all temporary windows (quickfix, locationlist, preview)
nnoremap <leader>q :pclose\|cclose\|lclose<cr>

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
