so ~/.config/vim/plug.vim/plug.vim
call plug#begin('~/.config/vim/plug.vim/data')

Plug 'alexdavid/nerdtree_icons'
Plug 'alexdavid/vim-min-git-status'
Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'bruno-/vim-husk'
Plug 'christoomey/vim-tmux-navigator'
Plug 'csscomb/vim-csscomb'
Plug 'derekwyatt/vim-scala'
Plug 'digitaltoad/vim-jade'
Plug 'edkolev/tmuxline.vim'
Plug 'elzr/vim-json'
Plug 'gkz/vim-ls'
Plug 'gre/play2vim'
Plug 'gregsexton/gitv'
Plug 'groenewege/vim-less'
Plug 'jiangmiao/auto-pairs'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'jsx/jsx.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'kien/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'mkitt/browser-refresh.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'rking/ag.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tsaleh/vim-supertab'
Plug 'vim-scripts/L9'
Plug 'vim-scripts/jQuery'
Plug 'wavded/vim-stylus'
Plug 'wting/rust.vim'


if filereadable(expand('~/.vimrc.plugins'))
  source ~/.vimrc.plugins
endif

call plug#end()
