" My status line
" It currently depends on my colorscheme of choice, badwolf.

" If you don't use badwolf, you'll need the highlighting group
" #InterestingWord1# for the buffer number highlighting

if exists('g:loaded_statusline')
  finish
endif
let g:loaded_statusline = 1

command! ForceStatusline call s:setActive()

" Automatically sets the statusline according to whether the buffer is selected
augroup Statusline
  au! Statusline
  au WinEnter,TabEnter,BufWinEnter,VimEnter * call <SID>setActive()
  au WinLeave,TabLeave,BufWinLeave * call <SID>setInactive()
augroup END


" We'll use the default status line when this returns 1
function! s:skip()
  if &ft ==? 'help'
    return 1
  endif
endfunction


" This is the definition of the status line for the active buffer
function! s:setActive()
  if s:skip()
    return
  endif

  setlocal statusline=
  setlocal statusline+=%#InterestingWord1#\ %-3.3n%*\     " buffer number
  setlocal statusline+=%{statusline#path()}               " file name
  setlocal statusline+=%h%m%r%w                           " flags
  setlocal statusline+=%=                                 " right align
  setlocal statusline+=%#normal#\ %{statusline#stats()}%* " file stats
  setlocal statusline+=\ \ %l:%v\                         " ruler
endfunction


" This is the definition of the status line for all inactive buffers
function! s:setInactive()
  if s:skip()
    return
  endif

  setlocal statusline=
  setlocal statusline+=\ %-3.3n\           " buffer number
  setlocal statusline+=%h%m%r%w            " flags
  setlocal statusline+=%{statusline#path()} " file name
endfunction


" Shows a short yet descriptive pathname of the file in the current buffer.
function! statusline#path()
  " Get the path of the file in the current buffer
  let l:path = expand('%:.')
  " Always show the path unix style
  let l:path = substitute(l:path,'\','/','g')
  " Shorten $HOME
  let l:path = substitute(l:path, '^\V' . $HOME, '~', '')
  " Apply all built in simplifications
  let l:path = simplify(l:path)

  if len(l:path) > 20
    let l:path = pathshorten(l:path)
  endif

  " Show a label for scratch buffers and the like
  if !strlen(l:path)
    let l:path = '[No Name]'
  endif

  return l:path
endfunction


" Collect statistics about the file/project
function! statusline#stats()
  let l:filestats = ''

  " Git statistics
  if exists('g:loaded_fugitive') && strlen(g:fugitive#head())
    let l:filestats .= g:fugitive#head() . ' '
  endif

  " Filetype or none
  if strlen(&filetype)
    let l:filestats .= &ft . ' '
  else
    let l:filestats .= 'none '
  endif

  " Show me if the file has a strange encoding
  if strlen(&fenc) && &fenc !=# 'utf-8'
    let l:filestats .= &fenc . ' '
  elseif &enc !=# 'utf-8'
    let l:filestats .= &enc . ' '
  endif

  " Show me if the file has strange line endings
  if strlen(&fileformat) && &fileformat !=# 'unix'
    let l:filestats .= &fileformat . ' '
  endif

  return l:filestats
endf
