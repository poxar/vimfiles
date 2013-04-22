let g:hs_highlight_delimiters = 1
let g:hs_highlight_boolean = 1
let g:hs_highlight_types = 1
let g:hs_highlight_more_types = 1
let g:hs_highlight_debug = 1

let g:haddock_browser = "firefox"

compiler ghc

setlocal omnifunc=necoghc#omnifunc

setlocal tabstop=8
setlocal expandtab
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal smarttab
setlocal shiftround
setlocal nojoinspaces
