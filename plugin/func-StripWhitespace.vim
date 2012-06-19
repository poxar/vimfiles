" strip whitespace

function! StripWhitespace()
        exec ':%s/ \+$//gc'
endfunction

nnoremap <localleader>s :call StripWhitespace()<cr>
