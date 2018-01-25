" Make screen updates not laggy hopefully
set ttyfast
set lazyredraw

" Enable vim goodness
set nocompatible

syntax on
set number

" Use system clipboard
set clipboard=unnamed
set ruler

" Allow filetype specific goodness
filetype plugin indent on

" Install vim-plug if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'posva/vim-vue', { 'for' : 'vue' }
Plug 'airblade/vim-gitgutter'
Plug 'valloric/youcompleteme', { 'do' : './install.py --clang-completer' }

" Themes
Plug 'nanotech/jellybeans.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()
set background=dark
colorscheme jellybeans

" Color column at 80 characters
set colorcolumn=80

" Highlight extra whitespace at the end of a line
hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\v\s+$/
