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

" documentation
setlocal keywordprg=devdocs\ python

iabbrev <buffer> #! #!/usr/bin/env python3
iabbrev <buffer> init_ def __init__(self):
iabbrev <buffer> main_ if __name__ == "__main__":
      \<CR>main()
