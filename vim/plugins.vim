so ~/.config/vim/plug.vim/plug.vim
call plug#begin('~/.config/vim/plug.vim/data')

Plug 'airblade/vim-gitgutter'
Plug 'alexdavid/nerdtree_icons'
Plug 'alexdavid/vim-min-git-status'
Plug 'altercation/vim-colors-solarized'
Plug 'bruno-/vim-husk'
Plug 'christoomey/vim-tmux-navigator'
Plug 'digitaltoad/vim-jade'
Plug 'elzr/vim-json'
Plug 'ervandew/supertab'
Plug 'gkz/vim-ls'
Plug 'godlygeek/tabular'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'kchmck/vim-coffee-script'
Plug 'kevgo/tertestrial-vim'
Plug 'kien/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'notpratheek/vim-luna'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'quentindecock/vim-cucumber-align-pipes'
Plug 'rking/ag.vim'
Plug 'slim-template/vim-slim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/L9'
Plug 'wavded/vim-stylus'


if filereadable(expand('~/.vimrc.plugins'))
  source ~/.vimrc.plugins
endif

call plug#end()
