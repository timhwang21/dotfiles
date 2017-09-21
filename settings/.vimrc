" Settings {{{
set backspace=indent,eol,start
filetype plugin indent on " Indent settings by fieltype
set autochdir " Dynamically change directories
" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif
" }}}
" netrw {{{
let g:netrw_liststyle=3 " always show tree view in :Ex
let g:netrw_banner=0
" }}}
" Whitespace {{{
set autoindent
set expandtab
set lcs=tab:\▸\ ,trail:·
set list
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Add filetypes where whitespace should be trimmed
autocmd BufWritePre *.md %s/\s\+$//e

" }}}
" Display {{{
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
" }}}
" Split configuration {{{
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright
" }}}
" Search {{{
set gdefault
set hlsearch
set incsearch
" }}}
" ctrlp {{{
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f'] " ignore git stuff
" }}}
" ack {{{
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" }}}
" ale (linting) {{{
let g:ale_sign_error = '▸'
let g:ale_sign_warning = '-'
let g:ale_fixers = {
\  'javascript': ['eslint'],
\}
" }}}
" wildmenu {{{
set wildmenu
set wildmode=longest:list,full
" }}}
" vim-airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_solarized_bg='dark'
let g:airline_theme='solarized'
" }}}
" plug {{{
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'elzr/vim-json'
Plug 'flazz/vim-colorschemes'
Plug 'mileszs/ack.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
call plug#end()
" installation -- :source % :PlugInstall
" }}}
" Meta {{{
set modelines=1 " for page folding
" }}}
" vim: foldmethod=marker:foldlevel=0
