highlight! link LspDiagnosticsUnderlineError SpellBad
highlight! link LspDiagnosticsSignError Error

colorscheme pencil
if has("gui_running")
else
  highlight Normal ctermbg=none
endif

" Update light/dark colors on boot and when receiving a USR1 signal
function! UpdateBackground()
  if filereadable(expand('~/.config/isdark'))
    set background=dark
  else
    set background=light
  endif
  redraw
endfunction
call UpdateBackground()
autocmd Signal SIGUSR1 call UpdateBackground()

" Highlight trailing whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * match ExtraWhitespace /\s\+\%#\@<!$/
