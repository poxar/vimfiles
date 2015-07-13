setlocal omnifunc=rubycomplete#Complete

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1

setlocal keywordprg=ri

" linting
let g:syntastic_ruby_checkers = ['mri', 'ruby-lint', 'rubocop']
