let mapleader = "\<space>"

" Buffer/Split/Tab management
nmap <silent> <leader>t :tab split<CR>
nmap <silent> <leader>s :split<CR>
nmap <silent> <leader>v :vsplit<CR>
nmap <silent> <leader>T :tabnew<CR>
nmap <silent> <leader>S :new<CR>
nmap <silent> <leader>V :vnew<CR>
nmap <silent> <leader>x :bd<CR>
nmap <silent> <leader>, :tabprevious<CR>
nmap <silent> <leader>. :tabnext<CR>
nmap <silent> <leader>< :exec 'silent! tabm ' . (tabpagenr()-2)<CR>
nmap <silent> <leader>> :exec 'silent! tabm ' . tabpagenr()<CR>

nmap <silent> <leader>h <C-w><
nmap <silent> <leader>l <C-w>>
nmap <silent> <leader>j <C-w>+
nmap <silent> <leader>k <C-w>-

nmap <silent> <leader>H 10<C-w><
nmap <silent> <leader>L 10<C-w>>
nmap <silent> <leader>J 10<C-w>+
nmap <silent> <leader>K 10<C-w>-

function! s:moveToPane(direction)
  let oldnr = winnr()
  execute 'wincmd ' . a:direction
  if oldnr == winnr()
    call system('select-pane ' . a:direction)
  endif
endfunction

command! MoveToLeft call s:moveToPane('h')
command! MoveToDown call s:moveToPane('j')
command! MoveToUp call s:moveToPane('k')
command! MoveToRight call s:moveToPane('l')
nnoremap <silent> <C-h> :MoveToLeft<cr>
nnoremap <silent> <C-j> :MoveToDown<cr>
nnoremap <silent> <C-k> :MoveToUp<cr>
nnoremap <silent> <C-l> :MoveToRight<cr>

function! s:toggle_zoom()
  if exists('t:winrestcmd')
    exec t:winrestcmd
    unlet t:winrestcmd
  else
    let t:winrestcmd = winrestcmd()
    vert resize | resize
  end
endfunction
command! Zoom call s:toggle_zoom()
nnoremap <silent> <leader><enter> :Zoom<cr>

" Quickfix list mappings
autocmd BufReadPost quickfix nnoremap <buffer> s <C-W><CR><C-w>K
autocmd BufReadPost quickfix nnoremap <buffer> v <C-w><CR><C-w>H<C-W>b<C-W>J<C-W>t
autocmd BufReadPost quickfix nnoremap <buffer> t <C-w><CR><C-w>T
autocmd BufReadPost quickfix nnoremap <buffer> T <C-w><CR><C-w>TgT<C-W><C-W>
nnoremap <silent> cn :cnext<cr>
nnoremap <silent> cp :cprevious<cr>

" Indenting
vmap < <gv
vmap > >gv
nmap > >>
nmap < <<

" Consistency
nmap Y y$

" Prevent paste in visual mode from copying text
xnoremap p pgvy
xnoremap P Pgvy

" visual sort
vmap s :sort<CR>

" Vim diff
fun! DiffUpdate()
  if &diff
    diffupdate
  endif
endfun
autocmd InsertLeave * call DiffUpdate()
noremap <leader>g :diffget \| diffupdate<CR>
noremap <leader>p :diffput \| diffupdate<CR>
fun! ToggleDiffWhiteSpace()
  if &diffopt =~ 'iwhite'
    set diffopt-=iwhite
  else
    set diffopt+=iwhite
  endif
endfun
noremap <leader>w :call ToggleDiffWhiteSpace()<CR>

" Git/fugitive shortcuts
nmap gd :Gdiff<CR>
nmap gs :Gministatus<CR>:wincmd K<CR>
nmap gc :Gcommit<CR>:set spell<CR><C-W>Ki
nmap git :!git<Space>
" Find merge conflicts
nmap gmc /\v^[<=>\|]{7}.*$<CR>

" Hide highlight
map <silent> <leader><space> :noh<CR>:match<CR>

" Mark line
nmap <silent> mm mm:execute 'match Search /\%'.line('.').'l/'<CR>

" Run q macro
nmap <silent> <leader>q @q
vmap <silent> <leader>q :norm! @q<CR>

" Use vim keybindings when running a command
nmap <silent> <leader>; q:i
