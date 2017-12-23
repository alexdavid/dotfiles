let g:colorscheme_name = 'luna'
if has("gui_running")
  colorscheme luna
else
  colorscheme luna-term
  highlight Normal ctermbg=none
endif


" Highlight trailing whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * match ExtraWhitespace /\s\+\%#\@<!$/
