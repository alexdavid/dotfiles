let g:RHUBARB_TOKEN = substitute(system('get-hub-token'), '\n', '', '')

autocmd FileType gitcommit inoremap <buffer> @ @<c-x><c-o><c-p>
autocmd FileType gitcommit inoremap <buffer> # #<c-x><c-o><c-p>
