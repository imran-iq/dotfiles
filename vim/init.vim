" Detect which system we are on
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif


if g:os == "Darwin"
    let g:python_host_prog = '/usr/local/opt/python2/bin/python2'
    let g:python3_host_prog = '/usr/local/bin/python3'
endif

" Make screen updates not laggy hopefully
set ttyfast
set lazyredraw
" set regexpengine=1

let mapleader=" "  " space bar for leader

syntax on
set number
" Use system clipboard
set clipboard=unnamed
set ruler
set noshowmode
" Color column at 80 characters
set colorcolumn=80

" Max columns to apply syntax to
set synmaxcol=200

set wildmenu

" Whitespace behaviour
set expandtab        " expand tabs by default
set tabstop=4        " number of spaces a <Tab> character equals
set softtabstop=4    " number of spaces a <Tab> character equals (insert mode)
set shiftwidth=4     " number of spaces to use for indenting
set smarttab         " smart <Tab> behaviour at start of line
set copyindent       " copy indent structure when making new lines
set cino=(0
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

" Install vim-plug if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Syntax
Plug 'posva/vim-vue', { 'for' : 'vue' }

" Git stuff in the gutter, undo/stage changes
Plug 'mhinz/vim-signify'

" Show pretty line on indentation levels
Plug 'Yggdroot/indentLine'

" Indent level movment commands
Plug 'jeetsukumaran/vim-indentwise'

" Aysnc linting
Plug 'dense-analysis/ale'

" Python syntax highlighting
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python' }

Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Repeat plugin commands with .
Plug 'tpope/vim-repeat'

" Resize non active windows
Plug 'roman/golden-ratio'

" Never have to :set paste
Plug 'ConradIrwin/vim-bracketed-paste'

" Make non active windows dark
Plug 'blueyed/vim-diminactive'

" Git and Github stuff
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" ys and cs for adding / changing surrounds
Plug 'tpope/vim-surround'

" gc for commenting out stuff, toggleable
Plug 'tpope/vim-commentary'

" Delicious fuzzy file finding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Because im too lazy to write my own status line
Plug 'rbong/vim-crystalline'

if g:os == "Darwin"
    " Dash plugin for mac
    Plug 'rizzatti/dash.vim'
endif

" Themes
Plug 'morhetz/gruvbox'
call plug#end()

" Theme config
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_invert_tabline = 1
let g:gruvbox_sign_column = 'bg0'

set background=dark

augroup WhiteSpaceHighlight
    autocmd!
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
augroup END

colorscheme gruvbox

" Indent guides
let g:indentLine_char = '┆'
let g:indentLine_first_char = '┆'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_fileTypeExclude = ['help', 'man']

set completeopt-=preview
set shortmess+=c
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<c-p>" : "\<S-Tab>"

" ALE config
let g:ale_echo_msg_format = '[%linter%] %s [%severity%:%code%]'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['autopep8', 'isort'],
\   'javascript': ['eslint'],
\   'vue': ['eslint']
\}

let g:ale_python_autopep8_options = '--aggressive --ignore E501,E402'
let g:ale_python_flake8_options = '--max-complexity 10'
let g:ale_fix_on_save = 1

nmap <silent> <C-k> <Plug>(ale_previous_wrap)zz
nmap <silent> <C-j> <Plug>(ale_next_wrap)zz

" FZF
nnoremap <Leader>ft :Tags!<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fg :Rg<CR>
nnoremap <Leader>fm :Marks<CR>
nnoremap <Leader>ff :call fzf#run(fzf#wrap({ 'source': 'rg --hidden --glob "!.git" --files'}, 0))<CR>

" Crystalline
function! StatusLine(current, width)
  return (a:current ? crystalline#mode() . '%#Crystalline#' : '%#CrystallineInactive#')
        \ . ' %f%h%w%m%r '
        \ . (a:current ? '%#CrystallineFill# %{fugitive#head()} ' : '')
        \ . '%=' . (a:current ? '%#Crystalline# %{&paste?"PASTE ":""}%{&spell?"SPELL ":""}' . crystalline#mode_color() : '')
        \ . (a:width > 80 ? ' %{&ft}[%{&enc}][%{&ffs}] %l/%L %c%V %P ' : ' ')
endfunction

function! TabLine()
  let l:vimlabel = has("nvim") ?  " NVIM " : " VIM "
  return crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . l:vimlabel
endfunction

let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'gruvbox'

" Signify
let g:signify_vcs_list = ['git']

" Semshi
let g:semshi#error_sign = v:false
let g:semshi#mark_selected_nodes = 0

" Jedi
let g:jedi#completions_enabled = 0
let g:jedi#use_splits_not_buffers = "right"

" typing a semi-colon starts command (normal mode)
nnoremap ; :

" Remove highlight from searches (normal mode)
nmap <silent> <Leader>/ :nohlsearch<CR>

" Highlight extra whitespace at the end of a line
match ExtraWhitespace /\v\s+$/
