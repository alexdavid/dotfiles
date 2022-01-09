set rtp+=~/.config/nvim
set shell=bash
so ~/.config/nvim/shortcuts.vim
execute pathogen#infect()
so ~/.config/nvim/lsp.vim
so ~/.config/nvim/colorscheme.vim

syntax enable " Enable syntax highlighting
filetype plugin indent on

" General
set backspace=2           " Make backspace delete
set clipboard=unnamedplus " Make vim share clipboard with system
set linebreak
set startofline
set list
let &listchars='tab:» ,nbsp:␣,trail:·,precedes:←,extends:→'
let &showbreak='↪ '

" Tab indenting
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

" Appearance
set showtabline=2   " Always show tab bar
set laststatus=2    " Always show the statusline
set ttimeoutlen=50  " Set timeout length
set number          " Show line numbers
set title           " Display filename in title bar
set cursorline      " Adds highlighted line on current line
set cursorcolumn    " Adds highlighted line on current column
set scrolloff=1     " set minimum space between the cursor and window

" Searching
set hlsearch   " Highlight found searches
set ignorecase " Ignore case in searched
set smartcase  " Don't ignore case if searching with caps
set incsearch  " Incrementally search

" Splitting
set splitright
set splitbelow

" Misc
set nobackup          " Don't create backup files
set spelllang=en_us   " Set spell check language
set nowrap            " Disable line wrapping
set ttyfast
set autoread          " Read changes on a file when it is changed
set diffopt+=vertical " Force vimdiff to always open vertically

" Folding
set foldmethod=syntax
set foldlevel=99

" Only display cursorline on active pane
" From: http://stackoverflow.com/questions/12017331/how-can-i-make-vim-highlight-the-current-line-on-only-the-active-buffer
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline cursorcolumn
  au WinLeave * setlocal nocursorline nocursorcolumn
augroup END
