setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4

" OmniCppComplete
if has("win32")
    setlocal tags+=~\vimfiles\tags\stdcpp
    setlocal tags+=~\vimfiles\tags\stdqt
    compiler msbuild
else
    setlocal tags+=~/.vim/tags/stdcpp
    setlocal tags+=~/.vim/tags/stdqt
endif

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
setlocal completeopt=menuone,menu,longest,preview

inoremap <C-Space> <C-X><C-O>
