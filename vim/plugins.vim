so ~/.config/vim/plug.vim/plug.vim
call plug#begin('~/.config/vim/plug.vim/data')

Plug 'alexdavid/nerdtree_icons'
Plug 'alexdavid/vim-min-git-status'
Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'bruno-/vim-husk'
Plug 'christoomey/vim-tmux-navigator'
Plug 'digitaltoad/vim-jade'
Plug 'elzr/vim-json'
Plug 'ervandew/supertab'
Plug 'gkz/vim-ls'
Plug 'jiangmiao/auto-pairs'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'kchmck/vim-coffee-script'
Plug 'kien/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'rking/ag.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/L9'
Plug 'vim-scripts/jQuery'
Plug 'wavded/vim-stylus'


if filereadable(expand('~/.vimrc.plugins'))
  source ~/.vimrc.plugins
endif

call plug#end()
