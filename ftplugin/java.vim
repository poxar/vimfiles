" settings
setlocal noexpandtab
setlocal tabstop=4

setlocal makeprg=ant\ -find\ build.xml
setlocal efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#

" syntax
let java_mark_braces_in_parens_as_errors=1
let java_highlight_all=1
let java_highlight_debug=1
let java_highlight_java_lang_ids=1
let java_highlight_functions="style"
let java_minlines = 150
