" settings
set backspace=indent,eol,start
filetype plugin indent on
set autochdir

" netrw
let g:netrw_liststyle=3 " always show tree view in :Ex
let g:netrw_banner=0

" display
colorscheme solarized
set background=dark
set colorcolumn=120
set cursorline
set number relativenumber
set noshowmode
set ruler
set title
syntax on
hi CursorLineNR cterm=bold

" search
set gdefault
set hlsearch
set incsearch

" ctrlp
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f'] " ignore git stuff

" whitespace
set lcs=tab:\▸\ ,trail:·
set list
set tabstop=2
set shiftwidth=0

" ale
let g:ale_sign_error = '▸'
let g:ale_sign_warning = '-'
let g:ale_fixers = {
\  'javascript': ['eslint'],
\}

" wildmenu
set wildmenu
set wildmode=longest:list,full

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_solarized_bg='dark'
let g:airline_theme='solarized'

" plug
call plug#begin('~/.vim/plugged')
" place plugins here
" installation -- :source % :PlugInstall
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'flazz/vim-colorschemes'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
call plug#end()

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" Split configuration
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright
