let mapleader = "\<space>"


" Tabs
nmap <silent> <leader>, :tabprevious<CR>
nmap <silent> <leader>. :tabnext<CR>
nmap <silent> <leader>n :tabnew<CR>

" Move tabs
nmap <silent> <leader>< :exec 'silent! tabm ' . (tabpagenr()-2)<CR>
nmap <silent> <leader>> :exec 'silent! tabm ' . tabpagenr()<CR>

" Indenting
vmap < <gv
vmap > >gv

" Vim diff and fugitive
fun! DiffUpdate()
  if &diff
    diffupdate
  endif
endfun

" Consistency
nmap Y y$

autocmd InsertLeave * call DiffUpdate()
noremap <leader>g :diffget 0 \| diffupdate<CR>
noremap <leader>p :diffput 0 \| diffupdate<CR>
nmap gk :Gitv --all<CR>:NERDTreeClose<CR>
nmap gd :Gdiff HEAD<CR><C-W>l:Gdiff<CR>
nmap gs :Gstatus<CR>:<CR><C-W>K
nmap gc :Gcommit<CR>:set spell<CR><C-W>Ki
nmap git :Git 

" Map ` to ~
noremap ` ~

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

" Add reverse J shortcut (useful for CoffeeScript)
map <silent> <leader>J kddpk==J

" Mark line
nmap <silent> m' m':execute 'match Search /\%'.line('.').'l/'<CR>

" Run q macro
map <silent> <leader>q @q

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
