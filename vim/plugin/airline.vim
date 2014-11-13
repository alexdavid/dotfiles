let g:airline_enabled = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = '▶'
let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = '⮁'
let g:airline#extensions#tabline#left_alt_sep = ''

let g:airline_powerline_fonts = 1

" let g:airline_left_sep = '▶'
let g:airline_left_sep = ''
" let g:airline_right_sep='⮂'
let g:airline_right_sep = ''

let g:airline_symbols = {}
" let g:airline_symbols.branch = '⭠'
function! InitAirlineSections()
  "call airline#parts#define_accent('red', 'red')
  let g:airline_section_b = airline#section#create(['%f','%#__accent_red#%{&modified?"*":""}'])
  let g:airline_section_c = airline#section#create(['%#__accent_red#%{&readonly?"⭤":""}'])
  let g:airline_section_y = airline#section#create(['branch'])
  let g:airline_section_z = airline#section#create(['⭡ ','%l/%L',':','%c'])
endfunction
autocmd VimEnter * call InitAirlineSections()
