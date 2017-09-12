let g:rehash256 = 1

" settings
set backspace=indent,eol,start

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
set lcs=tab:▸▸,trail:·
set list
set tabstop=2

" wildmenu
set wildmenu
set wildmode=longest:list,full

" vim-airline
let g:airline#extensions#tabline#enabled = 1
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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
