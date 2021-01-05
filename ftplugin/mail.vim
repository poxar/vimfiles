setlocal textwidth=72

" 1 - don't break after one-letter words
" 2 - allow hanging indents for paragraphs
" a - automatic formatting
" n - recognize numbered lists
" t - Auto-wrap using textwidth
" w - trailing whitespace for paragraphs
setlocal formatoptions=12antw
setlocal autoindent

setlocal comments+=n:\|
setlocal comments+=n:%

compiler proselint
nnoremap <buffer> ml<cr> :Dispatch -compiler=proselint<cr>

setlocal spell
setlocal spelllang=de_20

iabbrev <buffer> p Philipp
iabbrev <buffer> pm Philipp Millar

iabbrev <buffer> cheers Cheers,
iabbrev <buffer> regards Kind regards,
iabbrev <buffer> ty, Thank you in advance,

iabbrev <buffer> sgdh Sehr geehrte Damen und Herren,

iabbrev <buffer> mfg Mit freundlichen Grüßen,
iabbrev <buffer> lg Liebe Grüße,
iabbrev <buffer> bg Beste Grüße,
