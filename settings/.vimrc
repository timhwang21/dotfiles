let g:molokai_original = 1
let g:rehash256 = 1
syntax on

" display
set colorcolumn=80
set cursorline
hi CursorLine cterm=NONE ctermbg=darkgray ctermfg=white guibg=Grey40
set number relativenumber
hi LineNr ctermfg=darkgray
set ruler
set title

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

" plug
call plug#begin('~/.vim/plugged')
" place plugins here
" installation -- :source % :PlugInstall
Plug 'airblade/vim-gitgutter'
call plug#end()
