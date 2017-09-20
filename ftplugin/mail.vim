setlocal textwidth=72

" a - automatic formatting
" w - format=flowed formatting
" n - recognize numbered lists
" setlocal formatoptions+=awn

" n - recognize numbered lists
" 1 - don't break after one-letter words
" 2 - allow hanging indents for paragraphs
setlocal formatoptions+=n12
setlocal autoindent

set comments+=n:\|
set comments+=n:%

setlocal spell
setlocal spelllang=de_20
