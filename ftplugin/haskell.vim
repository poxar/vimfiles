let g:hs_highlight_delimiters = 1
let g:hs_highlight_boolean = 1
let g:hs_highlight_types = 1
let g:hs_highlight_more_types = 1
let g:hs_highlight_debug = 1

let g:haddock_browser = "firefox"

compiler ghc

setlocal omnifunc=necoghc#omnifunc

setlocal expandtab
setlocal textwidth=79
