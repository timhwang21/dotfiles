" Settings {{{
set mouse=a " enable mouse reporting
set nowrap
set sidescroll=1
set updatetime=300 " default is 4000
set backspace=indent,eol,start
set autoread " reload files changed externally
set showcmd " show in progress commands
filetype plugin indent on " Indent settings by filetype
" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif
set nobackup
set nowritebackup
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
colorscheme monokai
set guifont=MesloLGMDZ_Nerd_Font:h12 " set font independently from terminal
set background=dark
set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey
set cursorline
set number relativenumber
set noshowmode
set ruler
set title
set signcolumn=yes
syntax on
hi CursorLineNR cterm=bold
set shortmess+=A " ignore .swp files
" }}}
" netrw {{{
let g:netrw_liststyle=3 " always show tree view in :Ex
let g:netrw_banner=0
" }}}
" Buffer configuration {{{
set hidden " hide buffers on switch instead of trying to close
autocmd WinEnter * if winnr('$') == 1 && &buftype == 'quickfix' | q | endif " exit if only buffer remaining is quickfix
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
let g:ctrlp_lazy_update = 1 " debounce search
" }}}
" ack {{{
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" }}}
" ale (linting) {{{
let g:ale_sign_error = "🚫"
let g:ale_sign_warning = "⚠️"
highlight ALEError ctermbg=237 cterm=underline
highlight ALEWarning ctermbg=237 cterm=underline
highlight ALEErrorSign ctermbg=237
highlight ALEWarningSign ctermbg=237
let g:ale_linters = {
\  'javascript': ['eslint'],
\  'typescript': ['tslint'],
\}
let g:ale_fixers = {
\  'javascript': ['prettier'],
\  'typescript': ['prettier'],
\  'css': ['prettier'],
\}
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'normal' " only lint on change in normal mode
let g:ale_lint_on_insert_leave = 1 " only lint on exit in insert mode
" }}}
" codi {{{
" Note that this assumes my dev env has 'esm' installed globally
let g:codi#interpreters = {
\  'javascript': {
\    'bin': ['node', '-r', 'esm'],
\  }
\}
let g:codi#aliases= {
\  'javascript.jsx': 'javascript',
\}
" }}}
" wildmenu {{{
set wildmenu
set wildmode=longest:list,full
" }}}
" MatchTagAlways {{{
let g:mta_filetypes = {
\  'html': 1,
\  'xml': 1,
\  'javascript.jsx': 1,
\}
" }}}
" vim-airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_solarized_bg='dark'
let g:airline_theme='base16_monokai'
" }}}
" startify {{{
" Disable cow :'(
let g:startify_custom_header = [
        \ '                 __                ',
        \ '         __  __ /\_\    ___ ___    ',
        \ '        /\ \/\ \\/\ \ /'' __` __`\ ',
        \ '        \ \ \_/ |\ \ \/\ \/\ \/\ \ ',
        \ '         \ \___/  \ \_\ \_\ \_\ \_\',
        \ '          \/__/    \/_/\/_/\/_/\/_/',
        \ '                                   ',
        \ ]
let g:startify_lists = [
\ { 'type': 'sessions',  'header': ['        Sessions']       },
\ { 'type': 'dir',       'header': ['        MRU '. getcwd()] },
\ { 'type': 'files',     'header': ['        MRU']            },
\ { 'type': 'bookmarks', 'header': ['        Bookmarks']      },
\ { 'type': 'commands',  'header': ['        Commands']       },
\ ]
" Change dir to Git root when opening file in different dir
let g:startify_change_to_vcs_root = 1
let g:startify_bookmarks = [ {'b': '~/.bashrc'}, {'v': '~/.vimrc'} ]
let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 0
" }}}
" nerdtree {{{
nmap <C-n> :NERDTreeFind<CR>

let NERDTreeShowHidden=2
" Inline menu with `m` shortcut
let NERDTreeMinimalMenu=1
" Hide help message, etc.
let NERDTreeMinimalUI=1
" Change current working directory based on root directory in NERDTree
let NERDTreeChDirMode=2
" Initial NERDTree width
let NERDTreeWinSize=36
" Close vim if only window left is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}
" echodoc {{{
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu
" }}}
" vista.vim {{{
let g:vista_sidebar_width = 36
let g:vista_echo_cursor_strategy = 'both'
let g:vista_default_executive = 'coc'
" }}}
" coc.vim {{{
" Settings almost directly copied from: https://github.com/neoclide/coc.nvim#example-vim-configuration
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> <F8> <Plug>(coc-diagnostic-prev)
nmap <silent> <F7> <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Overwrite K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor and show hint on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd CursorHold * silent call CocActionAsync('doHover')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" renap range format
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" }}}
" plug {{{
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json'
Plug 'flazz/vim-colorschemes'
Plug 'jiangmiao/auto-pairs'
Plug 'liuchengxu/vista.vim'
Plug 'metakirby5/codi.vim'
Plug 'mhinz/vim-startify'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/echodoc.vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'Valloric/MatchTagAlways'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'Xuyuanp/nerdtree-git-plugin'

" This must be at the end, as per docs
Plug 'ryanoasis/vim-devicons'
call plug#end()
" installation -- :source % :PlugInstall
" }}}
" Meta {{{
set modelines=1 " for page folding
" }}}
" vim: foldmethod=marker:foldlevel=0
