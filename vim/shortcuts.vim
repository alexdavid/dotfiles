let mapleader = "\<space>"


" Tabs
nmap <silent> <leader>, :tabprevious<CR>
nmap <silent> <leader>. :tabnext<CR>
nmap <silent> <leader>n :tabnew<CR>

" Move tabs
nmap <silent> <leader>< :exec 'silent! tabm ' . (tabpagenr()-2)<CR>
nmap <silent> <leader>> :exec 'silent! tabm ' . tabpagenr()<CR>

" Function Resize - resizes split panes like tmux does:
" When focus is on the last pane it reverses resizing
fun! Resize(direction, scalar, notLastCommand, lastCommand)
  let startWinnr = winnr()
  exec "normal! " . a:direction
  if winnr() == startWinnr
    " We are on the last pane use lastCommand
    exec "normal! " . a:scalar . "" . a:lastCommand
  else
    exec startWinnr . "wincmd w"
    " We are not on the last pane use notLastCommand
    exec "normal! " . a:scalar . "" . a:notLastCommand
  endif
endfun

nmap <leader>h :call Resize('l', 1, '<', '>')<CR>
nmap <leader>l :call Resize('l', 1, '>', '<')<CR>
nmap <leader>j :call Resize('j', 1, '+', '-')<CR>
nmap <leader>k :call Resize('j', 1, '-', '+')<CR>

nmap <leader>H :call Resize('l', 10, '<', '>')<CR>
nmap <leader>L :call Resize('l', 10, '>', '<')<CR>
nmap <leader>J :call Resize('j', 10, '+', '-')<CR>
nmap <leader>K :call Resize('j', 10, '-', '+')<CR>

" Quickfix list mappings
autocmd BufReadPost quickfix nnoremap <buffer> s <C-W><CR><C-w>K
autocmd BufReadPost quickfix nnoremap <buffer> v <C-w><CR><C-w>H<C-W>b<C-W>J<C-W>t
autocmd BufReadPost quickfix nnoremap <buffer> t <C-w><CR><C-w>T
autocmd BufReadPost quickfix nnoremap <buffer> T <C-w><CR><C-w>TgT<C-W><C-W>

" Indenting
vmap < <gv
vmap > >gv

" Consistency
nmap Y y$

" Vim diff
fun! DiffUpdate()
  if &diff
    diffupdate
  endif
endfun
autocmd InsertLeave * call DiffUpdate()
noremap <leader>g :diffget \| diffupdate<CR>
noremap <leader>p :diffput \| diffupdate<CR>

" Git/fugitive shortcuts
nmap gk :Gitv --all<CR>:NERDTreeClose<CR>
nmap gd :Gdiff<CR>
nmap g3d :Gdiff HEAD<CR><C-W>l:Gdiff<CR>
nmap gs :Gministatus<CR>
nmap gc :Gcommit<CR>:set spell<CR><C-W>Ki
nmap git :Git 
" Find merge conflicts
nmap gmc /\v^[<=>\|]{7}.*$<CR>

" Toggle Spell Checking
map <silent> <leader>s :set spell!<CR>

" NERDTree
map <silent> <leader>t :NERDTreeTabsToggle<CR>
let g:NERDTreeMapJumpNextSibling="<C-n>"
let g:NERDTreeMapJumpPrevSibling="<C-p>"
let g:NERDTreeMapOpenSplit="s"
let g:NERDTreeMapOpenVSplit="v"

" Ctrl-p
let g:ctrlp_map = '<leader>o'

" TComment
let g:tcommentMapLeaderOp1 = ''
let g:tcommentMapLeaderOp2 = ''

" Hide highlight
map <silent> <leader><space> :noh<CR>:match<CR>

" Mark line
nmap <silent> m' m':execute 'match Search /\%'.line('.').'l/'<CR>

" Run q macro
map <silent> <leader>q @q

" Use vim keybindings when running a command
nmap <silent> <leader>; q:i

" Tab number shortcuts
nnoremap <silent> <Leader>1        :tabnext 1<CR>
nnoremap <silent> <Leader>2        :tabnext 2<CR>
nnoremap <silent> <Leader>3        :tabnext 3<CR>
nnoremap <silent> <Leader>4        :tabnext 4<CR>
nnoremap <silent> <Leader>5        :tabnext 5<CR>
nnoremap <silent> <Leader>6        :tabnext 6<CR>
nnoremap <silent> <Leader>7        :tabnext 7<CR>
nnoremap <silent> <Leader>8        :tabnext 8<CR>
nnoremap <silent> <Leader>9        :tabnext 9<CR>
