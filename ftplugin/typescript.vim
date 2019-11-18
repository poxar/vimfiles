if filereadable('web/tags')
  setlocal tags+=web/tags
  setlocal tagrelative
endif

setlocal keywordprg=devdocs\ typescript
