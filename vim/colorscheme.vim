" Force green/yellow/red colors for vimdiff
hi! DiffAdd    ctermfg=193 ctermbg=65
hi! DiffDelete ctermfg=234 ctermbg=9
hi! DiffChange ctermfg=0   ctermbg=3
hi! DiffText   ctermfg=234 ctermbg=11

" Highlight trailing whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * match ExtraWhitespace /\s\+\%#\@<!$/
