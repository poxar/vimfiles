let g:syntastic_typescript_checkers = ['tslint']

if filereadable('web/tags')
  setlocal tags=web/tags
  setlocal tagrelative
endif
