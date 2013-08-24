
"
" plugins.vimrc
" configuration of vim plugins
" Maintainer: Philipp Millar <philipp.millar@gmail.com>
"

if has('vim_starting')
  if has('win32')
    set runtimepath+=~\vimfiles\neobundle.vim
  else
    set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif
endif

if has('win32')
  call neobundle#rc(expand('~\vimfiles\bundle'))
else
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

" Ultimate Vim package manager
NeoBundle 'Shougo/neobundle.vim'

" plugins {{{
" easily search for, substitute, and abbreviate multiple variants of a word
NeoBundle 'tpope/vim-abolish'
" comment stuff out
NeoBundle 'tpope/vim-commentary'
" enable repeating supported plugin maps with .
NeoBundle 'tpope/vim-repeat'
" quoting/parenthesizing made simple
NeoBundle 'tpope/vim-surround'
" pairs of handy bracket mappings
NeoBundle 'tpope/vim-unimpaired'
" Vim plug for switching between companion source files
NeoBundle 'derekwyatt/vim-fswitch'
" Vim script for text filtering and alignment
NeoBundle 'godlygeek/tabular'
" text object for lines at the same indent level.
NeoBundle 'michaeljsmith/vim-indent-object'
" Vim plugin for the Perl module / CLI script 'ack'
NeoBundle 'mileszs/ack.vim'
" Start a * or # search from a visual block
NeoBundle 'nelstrom/vim-visual-star-search'
" This script implements transparent editing of gpg encrypted files
NeoBundle 'jamessan/vim-gnupg'

" a Git wrapper so awesome, it should be illegal
NeoBundle 'tpope/vim-fugitive'
" auto-clean fugitive buffers
augroup fugitive-clean
  au! BufReadPost fugitive://* set bufhidden=delete
augroup END

" Graph your Vim undo tree in style
NeoBundle 'sjl/gundo.vim'
" gundo settings
nnoremap cog :GundoToggle<cr>
let g:gundo_preview_bottom = 1
" }}}
" Unite {{{
" Unite and create user interfaces
NeoBundle 'Shougo/unite.vim'
" outline source for unite.vim
NeoBundle 'Shougo/unite-outline'

" settings
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
nnoremap <leader>b :<C-u>Unite -buffer-name=buffer
      \ -start-insert buffer<cr>
" notes
nnoremap <leader>n :<C-u>Unite -buffer-name=notes
      \ -start-insert file:~/.notes<cr>
nnoremap <leader>N :e ~/.notes/

" unite-outline
" outline
nnoremap <leader>o :<C-u>Unite -buffer-name=outline
      \ -start-insert outline<cr>
"}}}
" completion/snippets {{{

" wisely add end in ruby, endfunction/endif/more in vim script, etc
NeoBundle 'tpope/vim-endwise'

if has('python')
  " This is an implementation of TextMates Snippets for the Vim Text Editor.
  NeoBundle 'SirVer/ultisnips'

  let g:UltiSnipsEditSplit = "horizontal"
  let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets"]
endif

if has('unix')
  " Vim plugin that uses clang for completing C/C++ code.
  NeoBundleLazy 'Rip-Rip/clang_complete'
  " clang_complete settings {{{2
  augroup clangcomplete
    au! FileType c,cpp NeoBundleSource clang_complete
  augroup END

  " don't select anything
  let g:clang_auto_select      = 0
  " open quickfix window on errors
  let g:clang_complete_copen   = 1
  " close preview window automatically
  let g:clang_close_preview    = 1
  " complete macros and constants
  let g:clang_complete_macros  = 1
  " complete patterns
  let g:clang_complete_patters = 1
  " }}}2
elseif
  " provides C/C++ completion thanks to a ctags database
  NeoBundleLazy 'OmniCppComplete'
  " OmniCppComplete settings {{{2
  augroup omnicppcomplete
    au! FileType cpp NeoBundleSource OmniCppComplete
    au! FileType cpp setlocal omnifunc=omni#cpp#complete#Main
  augroup END

  let OmniCpp_NamespaceSearch = 1
  let OmniCpp_GlobalScopeSearch = 1
  let OmniCpp_ShowAccess = 1
  let OmniCpp_LocalSearchDecl = 1 " brace may be everywhere
  let OmniCpp_SelectFirstItem = 1 " just insert it already!
  let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
  let OmniCpp_MayCompleteDot = 1 " autocomplete after .
  let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
  let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
  let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
  " automatically open and close the popup menu / preview window
  au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
  set completeopt=menuone,menu,longest,preview
  " }}}2
endif
"}}}
" syntax/languages {{{

" Vim Markdown runtime files
NeoBundle 'tpope/vim-markdown'
" Syntax highlighting for GLib, Gtk+, Xlib, Gimp, Gnome, and more.
NeoBundle 'vim-scripts/gtk-vim-syntax'
" Haskell indent file
NeoBundle 'vim-scripts/indenthaskell.vim'
" Vim plugin for Io language
NeoBundle 'xhr/vim-io'
" Vim plugin for Todo.txt
NeoBundle 'freitass/todo.txt-vim'

" Lightweight Toolbox for LaTeX
NeoBundleLazy 'LaTeX-Box-Team/LaTeX-Box'
" LaTeX-BoX settings {{{2
augroup latexbox_settings
    au! FileType latex,tex NeoBundleSource LaTeX-Box
augroup END
let g:LatexBox_autojump=1
let g:LatexBox_Folding=1
if has('unix')
  let g:LatexBox_viewer="zathura"
endif
" }}}2
" }}}

filetype plugin indent on
NeoBundleCheck

" vim:set sw=2 foldmethod=marker ft=vim expandtab:
