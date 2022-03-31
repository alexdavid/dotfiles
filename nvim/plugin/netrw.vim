" Netrw directory of current file and position cursor over current file
function! FileBrowser()
  let parentDir = fnameescape(expand('%:h'))
  if parentDir == ''
    let parentDir = getcwd()
  endif
  let parentDir = parentDir . '/'
  let fileName = escape(expand('%:t'), '\"')
  exec 'E ' . parentDir
  call search('^' . fileName . '\*\?$', 'cw')
endfunction
map <silent> <leader>n :call FileBrowser()<CR>

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
