" plug {{{
call plug#begin(stdpath('data') . '/plugged')
Plug 'AndrewRadev/splitjoin.vim' " gJ to join, gS to split
Plug 'aliou/sql-heredoc.vim'
Plug 'alvan/vim-closetag'
Plug 'coderifous/textobj-word-column.vim' " ic,ac,iC,aC to manipulate columns
Plug 'editorconfig/editorconfig-vim'
Plug 'flazz/vim-colorschemes'
Plug 'jeanCarloMachado/vim-toop'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mhinz/vim-startify'
Plug 'mogelbrod/vim-jsonpath'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/echodoc.vim'
Plug 'timhwang21/vim-i18next'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'Valloric/MatchTagAlways'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'voldikss/vim-skylight'
Plug 'Yggdroot/indentLine'

Plug '/usr/local/opt/fzf'
" This must be at the end, as per docs
Plug 'ryanoasis/vim-devicons'
call plug#end()
" installation -- :source % :PlugInstall
" }}}
" Settings {{{
set mouse=a " enable mouse reporting
set nowrap
set sidescroll=1
set scrolloff=2 " min lines to keep above and below cursor
set updatetime=300 " default is 4000
set backspace=indent,eol,start
set autoread " reload files changed externally
set showcmd " show in progress commands
" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif
" skip backups and swp
set nobackup
set nowritebackup
set noswapfile
" disable arrow keys -- break bad habits
nnoremap <Left> :echo "No left for you!"<CR>
vnoremap <Left> :<C-u>echo "No left for you!"<CR>
nnoremap <Right> :echo "No right for you!"<CR>
vnoremap <Right> :<C-u>echo "No right for you!"<CR>
nnoremap <Down> :echo "No down for you!"<CR>
vnoremap <Down> :<C-u>echo "No down for you!"<CR>
nnoremap <Up> :echo "No up for you!"<CR>
vnoremap <Up> :<C-u>echo "No up for you!"<CR>
" Give some more memory for regex (default is 1000)
set mmp=5000
" Don't waste time redrawing when running macros etc.
set lazyredraw
" Better handling of movement commands when line wrap
noremap <expr> G &wrap ? "G$g0" : "G"
noremap <expr> 0 &wrap ? 'g0' : '0'
noremap <expr> $ &wrap ? "g$" : "$"
noremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <expr> k (v:count == 0 ? 'gk' : 'k')
" Visual mode improvements
" Fixed I/A
xnoremap <expr> I mode() ==# 'v' ? "\<c-v>I" : mode() ==# 'V' ? "\<c-v>^o^I" : "I"
xnoremap <expr> A mode() ==# 'v' ? "\<c-v>A" : mode() ==# 'V' ? "\<c-v>Oo$A" : "A"
" Keep selection when indenting
xnoremap < <gv
xnoremap > >gv
" Paste without overwriting default register (doesn't work with other registers)
xnoremap p pgvy
" Block Ex mode
nnoremap Q <Nop>
" }}}
" Function keys {{{
imap <silent> <F1> <Nop>
map <silent> <F1> :Startify<CR>
map <silent> <F2> :bprevious<CR>
map <silent> <F3> :bnext<CR>
" Close the current buffer and show previous without closing split
map <silent> <F4> :bn<bar>sp<bar>bp<bar>bd<CR>
" Close the current buffer and show next without closing split
map <silent> <F5> :bp<bar>sp<bar>bn<bar>bd<CR>
" Use `F7` and `F8` to navigate diagnostics
nmap <silent> <F7> <Plug>(coc-diagnostic-next)
nmap <silent> <F8> <Plug>(coc-diagnostic-prev)

" }}}
" Whitespace {{{
filetype plugin indent on " Indent settings by filetype
set autoindent
set expandtab
set lcs=tab:\»\ ,trail:·,nbsp:·
set list
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Add filetypes where whitespace should be trimmed
autocmd BufWritePre *.md %s/\s\+$//e

" }}}
" Display {{{
colorscheme monokai
" fix termguicolors for vimdiff
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
set background=dark
set colorcolumn=120
set cursorline
set number relativenumber
set noshowmode " don't show mode -- defer to powerline
set ruler
set title
set signcolumn=yes
set shortmess+=A " ignore .swp files

" enable folding in JSON
autocmd FileType json setl foldmethod=syntax
autocmd FileType yaml setl foldmethod=indent
autocmd FileType json,yaml normal zR

" }}}
" Custom highlighting {{{
" From: https://github.com/flazz/vim-colorschemes/blob/master/colors/Monokai.vim
" White="#f8f8f2"
" Black="#272822"
" Gray100="#f8f8f0"
" Gray200="#90908a"
" Gray300="#75715e"
" Gray400="#64645e"
" Gray500="#49483e"
" Gray600="#3c3d37"
" Gray700="#31322c"
" Magenta="#f92672"
" Red="#8b0807"
" Orange="#fd971f"
" Yellow="#e6db74"
" GreenLight="#a6e22e"
" GreenDark="#46830c"
" Purple="#ae81ff"
" Teal="#66d9ef"
" BlueLight="#204a87"
" BlueDark="#243955"

" UI elements
highlight CocFloating guibg=#3c3d37
highlight ColorColumn guifg=NONE guibg=#31322c gui=NONE
highlight CursorLine guibg=#31322c
highlight CursorLineNR guifg=#e6db74 guibg=#272822 gui=bold
highlight LineNr guifg=#64645e guibg=#272822
highlight SignColumn guibg=#272822
" visual selection color
highlight Visual guibg=#3c3d37
highlight VertSplit guifg=#3c3d37 guibg=#3c3d37
" for lines under last text line
highlight NonText guifg=#272822 guibg=#272822

" Syntax
highlight Comment gui=italic
" overwrite nvim colors for diff files
highlight diffAdded guifg=#a6e22e gui=italic
highlight diffRemoved guifg=#f92672 gui=italic
highlight diffChanged guifg=#66d9ef gui=italic
" GitGutter
highlight GitGutterAdd guifg=#a6e22e guibg=#272822
highlight GitGutterDelete guifg=#f92672 guibg=#272822
highlight GitGutterChange guifg=#66d9ef guibg=#272822

" identify syntax group under cursor
nmap <leader>hi :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" }}}
" Buffer configuration {{{
set hidden " hide buffers on switch instead of trying to close

" https://vim.fandom.com/wiki/Avoid_scrolling_when_switch_buffers
" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif
"}}}
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
" neovim only -- realtime search highlight
set inccommand=nosplit
" }}}
" Yank {{{
" Copy current file path to system clipboard
nnoremap <leader>p :let @+ = expand("%")<CR>
" }}}
" fzf {{{
nnoremap <C-p> :Files<CR>
nnoremap <leader>co :Commits<CR>
nnoremap <leader>b :Buffers<CR>
" gs = git status
nnoremap <leader>gs :GFiles?<CR>
" gl = git log
nnoremap <leader>gl :BCommits<CR>
" Augmenting Rg command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Rg  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Rg! - Start fzf in fullscreen and display the preview window above
" My muscle memory makes me type this
cabbrev Ag Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" }}}
" ale (linting) {{{
" let g:ale_sign_error = "🔺"
" let g:ale_sign_warning = "🔸"
" highlight ALEError ctermbg=237 cterm=underline
" highlight ALEWarning ctermbg=237 cterm=underline
" highlight ALEErrorSign ctermbg=237
" highlight ALEWarningSign ctermbg=237
" let g:ale_linters = {
" \  'javascript': ['eslint'],
" \  'typescript': ['tslint'],
" \}
" let g:ale_fix_on_save = 0 " delegate to coc
" let g:ale_lint_on_text_changed = 'normal' " only lint on change in normal mode
" let g:ale_lint_on_insert_leave = 1 " only lint on exit in insert mode
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
\  'typescript.tsx': 1,
\}
let g:mta_use_matchparen_group=0 " don't use same syntax as highlighting parens etc.
let g:mta_set_default_matchtag_color=0 " don't use default highlighting
highlight MatchTag gui=bold guibg=#3c3d37
" }}}
" vim-airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1
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
let g:startify_bookmarks = [
\ {'b': '~/.bashrc'},
\ {'c': '~/.config/nvim/coc-settings.json'},
\ {'K': '~/.config/kitty/kitty.conf'},
\ {'t': '~/.tmux.conf.local'},
\ {'v': '~/.vimrc'}
\]
let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 0
" }}}
" coc-explorer {{{
nmap <C-n> :CocCommand explorer<CR>
nmap <leader>n :CocCommand explorer<CR>

" }}}
" echodoc {{{
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu
" }}}
" indentLine {{{
let g:indentLine_char = '│'
" experimental high perf
let g:indentLine_faster = 1
" more subtle colors
let g:indentLine_color_term = 237
let g:indentLine_color_gui = '#3c3d37'
" disable for markup-type files
let g:indentLine_fileTypeExclude = ['startify', 'markdown', 'coc-explorer']
" }}}
" vim-abolish {{{
" Allow usage of text objects, e.g. criW
" nmap cr <Plug>(abolish-coerce)
" }}}
" vim-closetag {{{
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.jsx,*.tsx'
let g:closetag_xhtml_filenames = '*.jsx,*.tsx'
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1
" }}}
" vim-easyalign {{{
" align markdown tables on |
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
" }}}
" vim-i18next {{{
" specify Persona i18next file
autocmd BufRead,BufNewFile ~/Development/persona-web/*
\ let g:i18next_locale_path = 'app/assets/locales/translation.en-US.json'
nmap <silent> <leader>t :call i18next#echo_cursorline()<CR>
nmap <silent> gt :call i18next#goto_cursorline()<CR>
" }}}
" vim-jsonpath {{{
" Optionally copy path to a named register (* in this case) when calling :JsonPath
let g:jsonpath_register = '*'
" Define mappings for json buffers
au FileType json noremap <buffer> <silent> <leader>d :call jsonpath#echo()<CR>
au FileType json noremap <buffer> <silent> <leader>g :call jsonpath#goto()<CR>
" }}}
" vim-skylight {{{
" Open preview window and switch to it
nmap <leader>k :SkylightPreview<CR> <bar> :wincmd w<CR>
" }}}
" vim-test {{{
" Open tests in a new split
let test#strategy = "neovim"
" }}}
" coc.vim {{{
" Declare and install missing dependencies
let g:coc_global_extensions = [
    \ "coc-actions",
    \ "coc-css",
    \ "coc-eslint",
    \ "coc-explorer",
    \ "coc-git",
    \ "coc-highlight",
    \ "coc-html",
    \ "coc-jest",
    \ "coc-json",
    \ "coc-lists",
    \ "coc-pairs",
    \ "coc-prettier",
    \ "coc-solargraph",
    \ "coc-styled-components",
    \ "coc-svg",
    \ "coc-tslint-plugin",
    \ "coc-tsserver",
    \ "coc-vimlsp",
    \ "coc-yaml"
    \]

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

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

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
nnoremap <silent> <space>d  :<C-u>CocList diagnostics<cr>
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
" remap range format
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" coc-actions
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" coc-git
" show chunk diff at current position in floating window
nmap <leader>gd <Plug>(coc-git-chunkinfo)
" navigate chunks of current buffer
nmap [c <Plug>(coc-git-prevchunk)
nmap ]c <Plug>(coc-git-nextchunk)
" create text object for git chunks (inner chunk etc.)
omap ic <Plug>(coc-git-chunk-inner)
xmap ic <Plug>(coc-git-chunk-inner)
omap ac <Plug>(coc-git-chunk-outer)
xmap ac <Plug>(coc-git-chunk-outer)

" coc-jest
" Run jest for current file
command! -nargs=0 JestFile :call  CocAction('runCommand', 'jest.fileTest', ['%'])
nnoremap <leader>jf :call CocAction('runCommand', 'jest.fileTest', ['%'])<CR>

" Run jest for current test
command! -nargs=0 JestCurr :call  CocAction('runCommand', 'jest.singleTest')
nnoremap <leader>jc :call CocAction('runCommand', 'jest.singleTest')<CR>
" }}}
" Meta {{{
set modelines=1 " for page folding
" }}}
" vim: foldmethod=marker:foldlevel=0
