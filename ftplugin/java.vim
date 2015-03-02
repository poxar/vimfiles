let g:java_highlight_all=1
let g:java_highlight_debug=1
let g:java_highlight_java_lang_ids=1
let g:java_highlight_functions="style"
let g:java_minlines = 150

setlocal textwidth=80
setlocal shiftwidth=4
setlocal tabstop=4
setlocal makeprg=ant\ -find\ build.xml
setlocal errorformat=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
