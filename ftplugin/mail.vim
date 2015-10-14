setlocal textwidth=72
setlocal fo+=aw

set comments+=n:\|
set comments+=n:%

setlocal spell
setlocal spelllang=de

function! s:Mail_Erase_Sig()
  " search for the signature pattern (takes into account signature delimiters
  " from broken mailers that forget the space after the two dashes)
  let l:i = 0
  while ((l:i <= line('$')) && (getline(l:i) !~# '^> *-- \=$'))
    let l:i = l:i + 1
  endwhile

  " if found, then
  if (l:i != line('$') + 1)
    " first, look for our own signature, to avoid deleting it
    let l:j = l:i
    while (l:j < line('$') && (getline(l:j + 1) !~# '^-- $'))
      let l:j = l:j + 1
    endwhile

    " second, search for the last non empty (non sig) line
    while ((l:i > 0) && (getline(l:i - 1) =~# '^\(>\s*\)*$'))
      let l:i = l:i - 1
    endwhile

    " third, delete those lines plus the signature
    exe ':'.l:i.','.l:j.'d'
  endif
endfunction

call s:Mail_Erase_Sig()
