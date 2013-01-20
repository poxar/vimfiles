" easy environments
inoremap (( \eqref{
inoremap [[ \begin{
inoremap ]] \end{<esc>a<C-X><C-O><esc>O

nnoremap g% <Plug>LatexBox_JumpToMatch

inoremap "" "`"'<esc>hi

" folding
let g:tex_fold_enabled=0
source ~/.vim/plugin/tex-fold.vim
set foldmethod=expr
