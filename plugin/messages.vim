" scratchbuffer for messages
function! s:MessageWindow()
  new [Messages]
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal buflisted
  redir => l:messages_output
  silent messages
  redir END
  silent put=l:messages_output
endfunction

command! Messages call <SID>MessageWindow()
