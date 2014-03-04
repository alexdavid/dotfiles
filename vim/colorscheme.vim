" Sets the background based on the contents of ~/.config/colors
fun! RefreshBackground()
  execute "set background=".join(readfile($HOME."/.config/colors"))
endfun

" Update colors and refresh vim-airline for autocmd
fun! RefreshColors()
  call RefreshBackground()
  " Fix issue where airline doesn't refresh when changed by autocmd:
  AirlineTheme solarized
endfun

" Make sure colors are still up to date if the cursor hasn't moved in a while
autocmd CursorHold * call RefreshColors()

" Try to load solarized (this should only fail on initial install)
try
  colorscheme solarized
  call RefreshBackground()
catch
  colorscheme hybrid
  set background=dark
endtry

" Use more contrasty colors for vimdiff
let g:solarized_diffmode="high"
