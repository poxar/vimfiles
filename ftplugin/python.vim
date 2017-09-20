" PEP8 settings
setlocal textwidth=79  " lines longer than 79 columns will be broken
setlocal shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
setlocal tabstop=4     " a hard TAB displays as 4 columns
setlocal expandtab     " insert spaces when hitting TABs
setlocal softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
setlocal shiftround    " round indent to multiple of 'shiftwidth'
setlocal autoindent    " align the new line indent with the previous line


" completion
setlocal omnifunc=pythoncomplete#Complete

" linting
let g:syntastic_python_checkers = ['python', 'pylint']

" Python Mode
" Deactivate rope (use jedi)
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

" Disable Linting (done by syntastic)
let g:pymode_lint = 0
let g:pymode_lint_write = 0

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>B'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0
