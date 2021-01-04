if executable('racer')
  command! -buffer -nargs=* -count=0 RustDoc call racer#ShowDocumentation()
  setlocal keywordprg=:RustDoc
endif
