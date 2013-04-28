" easy environments
imap <buffer> [[ 		\begin{
imap <buffer> ]]		<Plug>LatexCloseCurEnv
nmap <buffer> <F5>		<Plug>LatexChangeEnv
vmap <buffer> <F7>		<Plug>LatexWrapSelection
vmap <buffer> <S-F7>		<Plug>LatexEnvWrapSelection
imap <buffer> (( 		\eqref{

nnoremap g% <Plug>LatexBox_JumpToMatch

inoremap "" "`"'<esc>hi

" folding
let g:LatexBox_Folding=1

" OmniCompletion
inoremap <C-Space> <C-X><C-O>
