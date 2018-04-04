let g:python_host_prog = '/usr/local/opt/python2/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" Make screen updates not laggy hopefully
set ttyfast
set lazyredraw
set regexpengine=1

" Enable vim goodness
set nocompatible

syntax on
set number

" Use system clipboard
set clipboard=unnamed
set ruler

" Color column at 80 characters
set colorcolumn=80

" Max columns to apply syntax to
set synmaxcol=200

" Whitespace behaviour
set expandtab        " expand tabs by default
set tabstop=4        " number of spaces a <Tab> character equals
set softtabstop=4    " number of spaces a <Tab> character equals (insert mode)
set shiftwidth=4     " number of spaces to use for indenting
set smartindent      " smart autoindent on new lines
set smarttab         " smart <Tab> behaviour at start of line
set copyindent       " copy indent structure when making new lines

" Backups, swaps, and temps
set nobackup
set noswapfile

set hidden
set nowrap
set autowrite " write file on buffer switch
set autoread
" True color support
set termguicolors

" Use ripgrep for grep command
set grepprg=rg\ --vimgrep

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
Plug 'Yggdroot/indentLine'
Plug 'w0rp/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'tpope/vim-repeat'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'roman/golden-ratio'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'blueyed/vim-diminactive'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'PeterRincker/vim-argumentative'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Themes
Plug 'vim-airline/vim-airline-themes'
Plug 'nanotech/jellybeans.vim'
Plug 'junegunn/seoul256.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

let g:seoul256_background = 233
let g:seoul256_srgb = 1

set background=dark
colorscheme jellybeans

" Indent guides
let g:indentLine_char = '┆'
let g:indentLine_first_char = '┆'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_fileTypeExclude = ['help', 'man']
" Deoplete configuration
let g:deoplete#enable_at_startup = 1
set completeopt-=preview

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<c-p>" : "\<S-Tab>"

let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Ale keybindings
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:airline_powerline_fonts = 1
let g:airline_theme='jellybeans'
let g:airline#extensions#tabline#enabled = 1

" FZF
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <Leader>ft :Tags!<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fg :Rg!<CR>
nnoremap <Leader>fm :Marks<CR>
nnoremap <Leader>ff :call fzf#run(fzf#wrap('files', { 'source': 'rg -g "" --files', 'down': '40%' }, 1))<CR>

" Highlight extra whitespace at the end of a line
hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\v\s+$/
