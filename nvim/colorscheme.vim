colorscheme pencil
if has("gui_running")
else
  highlight Normal ctermbg=none
endif


" Highlight trailing whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * match ExtraWhitespace /\s\+\%#\@<!$/
