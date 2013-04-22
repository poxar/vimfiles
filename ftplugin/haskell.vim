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

let s:width = 80

function! HaskellModuleSection(...)
    let name = 0 < a:0 ? a:1 : inputdialog("Section name: ")

    return  repeat('-', s:width) . "\n"
    \       . "--  " . name . "\n"
    \       . "\n"

endfunction

function! HaskellModuleHeader(...)
    let name = 0 < a:0 ? a:1 : inputdialog("Module: ")
    let note = 1 < a:0 ? a:2 : inputdialog("Note: ")
    let description = 2 < a:0 ? a:3 : inputdialog("Describe this module: ")

    return  repeat('-', s:width) . "\n"
    \       . "-- | \n"
    \       . "-- Module      : " . name . "\n"
    \       . "-- Note        : " . note . "\n"
    \       . "-- \n"
    \       . "-- " . description . "\n"
    \       . "-- \n"
    \       . repeat('-', s:width) . "\n"
    \       . "\n"

endfunction

nnoremap <silent> --s "=HaskellModuleSection()<cr>gp
nnoremap <silent> --h "=HaskellModuleHeader()<cr>:0put =<cr>
