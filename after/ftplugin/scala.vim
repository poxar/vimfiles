if isdirectory('.bloop')
  compiler bloop

  " I somehow have to override the compiler every time because Dispatch seems to
  " pull 'root' into makeprg for some reason which breaks consecutive calls to
  " `:Make root`.
  nnoremap <buffer> m<cr>  :compiler bloop<cr>:Make root<cr>
  nnoremap <buffer> mt<cr> :compiler bloop<cr>:Make root-test<cr>
endif
