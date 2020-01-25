function! CustomNetrwMap()
  nmap <buffer> h -
  nmap <buffer> l <CR>
  nmap <buffer> s o
  nmap <silent> <buffer> R :e<CR>
  nmap <silent> <buffer> r :e<CR>

  " Netrw overrides <C-l>, this sets it back to MoveToRight
  nmap <silent> <buffer> <C-l> :MoveToRight<CR>
endfunction

augroup FILETYPES
  autocmd FileType netrw call CustomNetrwMap()
augroup END
