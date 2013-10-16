let mapleader = "\<space>"


" Tabs
nmap <silent> <c-i> :tabprevious<CR>
nmap <silent> <c-o> :tabnext<CR>
nmap <silent> <c-t> :tabnew<CR>

" Move tabs
nmap <silent> <leader><c-i> :exec 'silent! tabm ' . (tabpagenr()-2)<CR>
nmap <silent> <leader><c-o> :exec 'silent! tabm ' . tabpagenr()<CR>

" Indenting
vmap < <gv
vmap > >gv

" Vim diff and fugitive
fun! DiffUpdate()
  if &diff
    diffupdate
  endif
endfun

autocmd InsertLeave * call DiffUpdate()
noremap <leader>g :diffget\|diffupdate<CR>
noremap <leader>p :diffput\|diffupdate<CR>
nmap gk :Gitv --all<CR>:NERDTreeClose<CR>
nmap gd :Gdiff<CR>
nmap gs :Gstatus<CR>:<CR><C-W>K
nmap gc :Gcommit<CR>:set spell<CR><C-W>Ki

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

" Show Invisibles
map <silent> <leader>i :set list!<CR>

" Hide highlight
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>
map <silent> <C-@> :noh<CR>:match<CR>

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
