" Disable built-in mappings (overwrites gd shortcut)
let g:go_def_mapping_enabled = 0

" Run GoImports before save
function! Run_go_imports()
  silent exec "!goimports -w %"
  e
endfunction
autocmd BufWritePost /*.go call Run_go_imports()
