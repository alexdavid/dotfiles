let g:colorscheme_name = 'luna'
colorscheme luna-term
highlight Normal ctermbg=none


" Highlight trailing whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * match ExtraWhitespace /\s\+\%#\@<!$/
