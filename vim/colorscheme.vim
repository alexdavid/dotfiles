if $ITERM_PROFILE == 'Dark'
  colorscheme luna-term
  let g:colorscheme_name = 'luna'
else
  colorscheme sol-term
  let g:colorscheme_name = 'sol'
endif

" Highlight trailing whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * match ExtraWhitespace /\s\+\%#\@<!$/
