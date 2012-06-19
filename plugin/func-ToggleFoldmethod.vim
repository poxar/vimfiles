" change foldmethod

function! ToggleFoldmethod()
	if(&fdm == "marker")
		set fdm=syntax
                set fdm?
	else
		set fdm=marker
                set fdm?
	endif
endfunc

nnoremap <F2> :call ToggleFoldmethod()<cr>
