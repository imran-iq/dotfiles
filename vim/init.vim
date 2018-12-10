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
" set synmaxcol=200

" Whitespace behaviour
set expandtab        " expand tabs by default
set tabstop=4        " number of spaces a <Tab> character equals
set softtabstop=4    " number of spaces a <Tab> character equals (insert mode)
set shiftwidth=4     " number of spaces to use for indenting
set smarttab         " smart <Tab> behaviour at start of line
set copyindent       " copy indent structure when making new lines
set cino='(0'
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
Plug 'w0rp/ale'

"Language server support
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Aysnc auotcompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }

" Python jedi goodness
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Python syntax highlighting
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python' }

" Show function signature and inline doc.
Plug 'Shougo/echodoc.vim'

" Repeat plugin commands with .
Plug 'tpope/vim-repeat'

" Resize non active windows
Plug 'roman/golden-ratio'

" Never have to :set paste
Plug 'ConradIrwin/vim-bracketed-paste'

" Make non active windows dark
Plug 'blueyed/vim-diminactive'

" Easier manipulation of func args, text objects a, i,
Plug 'PeterRincker/vim-argumentative'

" Git and Github stuff
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" ys and cs for adding / changing surrounds
Plug 'tpope/vim-surround'

" gc for commenting out stuff, toggleable
Plug 'tpope/vim-commentary'

" Alignment stuff
Plug 'junegunn/vim-easy-align'

" Delicious fuzzy file finding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Because im too lazy to write my own status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

if g:os == "Darwin"
    " Dash plugin for mac
    Plug 'rizzatti/dash.vim'
endif

" Themes
Plug 'hzchirs/vim-material'
Plug 'w0ng/vim-hybrid'
Plug 'ayu-theme/ayu-vim'
Plug 'morhetz/gruvbox'
call plug#end()

" Theme config
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_invert_tabline = 1
let g:gruvbox_sign_column = 'bg0'
let ayucolor='mirage'
set background=dark

augroup WhiteSpaceHighlight
    autocmd!
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
augroup END

colorscheme gruvbox

" Airline config
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1

" Indent guides
let g:indentLine_char = '┆'
let g:indentLine_first_char = '┆'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_fileTypeExclude = ['help', 'man']

" Deoplete configuration
let g:deoplete#enable_at_startup = 1
set completeopt-=preview
set shortmess+=c

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<c-p>" : "\<S-Tab>"

" echodoc config
let g:echodoc#enable_at_startup = 1

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

" easy-align config

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

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

" Jedi (python)
let g:jedi#completions_enabled = 0
let g:jedi#use_splits_not_buffers = "right"

" Signify
let g:signify_vcs_list = ['git']

" Semshi
let g:semshi#error_sign = v:false
let g:semshi#mark_selected_nodes = 0

" typing a semi-colon starts command (normal mode)
nnoremap ; :

" Remove highlight from searches (normal mode)
nmap <silent> <Leader>/ :nohlsearch<CR>

" Highlight extra whitespace at the end of a line
match ExtraWhitespace /\v\s+$/
