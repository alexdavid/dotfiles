function! CustomNetrwMap()
  nmap <buffer> h -
  nmap <buffer> l <CR>
  nmap <buffer> s o
  nmap <silent> <buffer> R :e<CR>
  nmap <silent> <buffer> r :e<CR>

  " Netrw overrides <C-l>, this sets it back to MoveToRight
  nmap <silent> <buffer> <C-l> :MoveToRight<CR>
endfunction

" Disable left click opens files in netrw
let g:netrw_mousemaps=0

augroup FILETYPES
  autocmd FileType netrw call CustomNetrwMap()
augroup END
