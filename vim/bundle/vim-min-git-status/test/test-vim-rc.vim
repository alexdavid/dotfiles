" This file is used as the vimrc the feature tests use
"

" Use vim instead of vi - since we're not using an actual .vimrc this is required
set nocompatible

" Set the runtime path to the directory of the project
let &rtp = resolve(expand('<sfile>:p:h') . '/..')
