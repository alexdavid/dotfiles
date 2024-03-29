let g:ctrlp_map = '<leader>o'

" Don't incluse .class files in ctrlp search
set wildignore+=*.class

" Follow Symbolic Links with CTRL-P
let g:ctrlp_follow_symlinks = 1

" If you have the silver searcher, have CTRL-P use it.
if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")': ['<c-n>'],
  \ 'PrtSelectMove("k")': ['<c-p>'],
  \ 'PrtHistory(-1)':       [],
  \ 'PrtHistory(1)':        [],
  \ }
