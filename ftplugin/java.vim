let g:java_mark_braces_in_parens_as_errors=1
let g:java_highlight_all=1
let g:java_highlight_debug=1
let g:java_highlight_java_lang_ids=1
let g:java_highlight_functions="style"
let g:java_minlines = 150

setlocal noexpandtab
setlocal tabstop=4
setlocal textwidth=120
setlocal makeprg=ant\ -find\ build.xml
setlocal efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#