set noshowmode

function! LightlineGitBranch()
  return "  " . fugitive#head() . " "
endfunction

let g:lightline = {
      \   'colorscheme': 'PaperColor',
      \   'active': {
      \     'left': [
      \        [ 'mode' ],
      \        [ 'filename', 'readonly' ],
      \     ],
      \     'right': [
      \        [ 'lineinfo' ],
      \        [ 'gitbranch' ],
      \        [ 'fileformat', 'fileencoding', 'filetype' ],
      \     ],
      \   },
      \   'component_function': {
      \     'gitbranch': 'LightlineGitBranch'
      \   },
      \ }

function! LightlineUpdate()
  if lightline#colorscheme#background() ==# 'light'
    let g:lightline#colorscheme#PaperColor#palette = g:lightline#colorscheme#PaperColor_light#palette
  else
    let g:lightline#colorscheme#PaperColor#palette = g:lightline#colorscheme#PaperColor_dark#palette
  endif
  call lightline#enable()
  redraw
endfunction
autocmd Signal SIGUSR1 call LightlineUpdate()
