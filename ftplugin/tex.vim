" easy environments
inoremap (( \eqref{
inoremap [[ \begin{
inoremap ]] <Plug>LatexCloseCurEnv

nnoremap g% <Plug>LatexBox_JumpToMatch

" folding
let g:tex_fold_enabled=1
set foldmethod=syntax
