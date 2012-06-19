" change linenumber mode

function! ToggleNumberMode()
	if(&rnu == 1)
		set nu
	else
		set rnu
	endif
endfunc

nnoremap <F3> :call ToggleNumberMode()<cr>
