set noshowmode

function! LightlineGitBranch()
  return "  " . fugitive#head() . " "
endfunction

let g:lightline = {
      \   'colorscheme': 'seoul256',
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
