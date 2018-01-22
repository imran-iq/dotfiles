set ttyfast
set lazyredraw
set nocompatible
syntax on
set number
set clipboard=unnamed
set ruler
filetype plugin indent on
" Install vim-plug if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'posva/vim-vue', { 'for' : 'vue' }
Plug 'altercation/vim-colors-solarized'
Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'valloric/youcompleteme', { 'do' : './install.py --clang-completer' }
call plug#end()
" set background=dark
colorscheme dracula

" Color column at 80 characters
set colorcolumn=80

" Highlight extra whitespace at the end of a line
hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\v\s+$/
