setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal cindent

" OmniCppComplete
if has("win32")
    setlocal tags+=~\vimfiles\tags\stdcpp
else
    setlocal tags+=~/.vim/tags/stdcpp
endif

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1      " autocomplete after .
let OmniCpp_MayCompleteArrow = 1    " autocomplete after ->
let OmniCpp_MayCompleteScope = 1    " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

inoremap <C-Space> <C-X><C-O>
