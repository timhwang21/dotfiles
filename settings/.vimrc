" settings
set backspace=indent,eol,start
filetype plugin indent on

" display
colorscheme solarized
set background=dark
set colorcolumn=80
set cursorline
set number relativenumber
set ruler
set title
syntax on
hi CursorLineNR cterm=bold

" search
set gdefault
set hlsearch
set incsearch

" whitespace
set lcs=tab:\▸\ ,trail:·
set list
set tabstop=2

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

" plug
call plug#begin('~/.vim/plugged')
" place plugins here
" installation -- :source % :PlugInstall
Plug 'airblade/vim-gitgutter'
Plug 'flazz/vim-colorschemes'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
call plug#end()

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif
