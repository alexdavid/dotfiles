so ~/.config/vim/plug.vim/plug.vim
call plug#begin('~/.config/vim/plug.vim/data')

Plug 'airblade/vim-gitgutter'
Plug 'alexdavid/vim-min-git-status'
Plug 'bruno-/vim-husk'
Plug 'dracula/vim'
Plug 'ervandew/supertab'
Plug 'gkz/vim-ls'
Plug 'godlygeek/tabular'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'kevgo/tertestrial-vim'
Plug 'kien/ctrlp.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/L9'
Plug 'wavded/vim-stylus'

Plug 'fatih/vim-go'
Plug 'hashivim/vim-terraform'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'quentindecock/vim-cucumber-align-pipes'



if filereadable(expand('~/.vimrc.plugins'))
  source ~/.vimrc.plugins
endif

call plug#end()
