" toggle the last search pattern register between the last two search patterns

function! s:ToggleSearchPattern()
    let next_search_pattern_index = -1
    if @/ ==# histget('search', -1)
        let next_search_pattern_index = -2
    endif
    let @/ = histget('search', next_search_pattern_index)
endfunction

nnoremap <silent> <Leader>/ :<C-u>call <SID>ToggleSearchPattern()<CR>
