" Disable built-in mappings (overwrites gd shortcut)
let g:go_def_mapping_enabled = 0

" Run GoImports before save
autocmd BufWritePre *.go GoImports
