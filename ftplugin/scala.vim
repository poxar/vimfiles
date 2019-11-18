setlocal textwidth=100
setlocal colorcolumn=+1

if filereadable('api/tags')
  setlocal tags+=api/tags
  setlocal tagrelative
endif

setlocal keywordprg=devdocs\ scala
