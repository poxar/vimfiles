
"
" Plugin:      dated_notes.vim
" Description: simplify note taking, with dated notes
" Version:     0.1
" Last Change: 2015-03-23
" Maintainer:  Philipp Millar <philipp.millar@poxar.de>
"

if exists('loaded_dated_notes')
  finish
endif
let loaded_dated_notes = 1

if !exists('g:dated_notes_dir')
  let g:dated_notes_dir = expand('$HOME/.dated_notes')
endif

function s:edit_new_note()
  let s:date = strftime("%F")
  let s:note = g:dated_notes_dir . '/' . s:date . '.md'
  exec 'edit ' . s:note
endfunction

command! DNote call s:edit_new_note()
command! Dnote call s:edit_new_note()
